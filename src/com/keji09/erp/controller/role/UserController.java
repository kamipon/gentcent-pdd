package com.keji09.erp.controller.role;


import com.keji09.erp.bean.UserBean;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.WxModelSCEntity;
import com.keji09.erp.model.role.RoleEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.role.UserRoleEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.service.PermissionService;
import com.keji09.erp.utils.DateUtil2;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 用户管理控制器
 *
 */
@Controller
@RequestMapping("/user")
public class UserController extends XDAOSupport{
	
	@Autowired
	PermissionService permissionService;
	
	/**
	 * 用户登陆
	 */
	@RequestMapping(value="/login",method = RequestMethod.POST)
	public String login(@RequestParam(value="username")String username,
						@RequestParam(value="password")String password,
						@RequestParam(value="phoneCode",required=false)String phoneCode,
						HttpServletRequest request,ModelMap map){
		HttpSession session=request.getSession();
		UserEntity user = this.getUserEntityDAO().findUnique("userName", username);
		if(user!=null&&user.getStatus()!=2){
			//用户名存在
			if(password.equals(user.getPassword())){
				request.getSession().setAttribute("userName",username);
				//登录则设置金额操作验证为false
				request.getSession().setAttribute("isTrue",false);
				String openId ="";
				//是否绑定微信
				List<MemberEntity> mbList = getMember(username, map);
				if(mbList!=null&&mbList.size()!=0){
					//如果绑定微信则需验证动态码
					if(phoneCode==null||phoneCode.equals("")){
						map.put("message", "请输入微信动态码");
						map.put("username", username);
						map.put("password", password);
						return "login";
					}
					//验证登录时动态码 	level 1-登录
					Map<String,Object> map1 = validate(1, phoneCode, request,map);
					openId = (String)request.getSession().getAttribute("openId");
					if(!(Boolean)map1.get("flag")){
						map.put("message", map1.get("message"));
						map.put("username", username);
						map.put("password", password);
						return "login";
					}
				}
				ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
				if(act!=null&&act.getOverTime()!=null&&act.getOverTime().getTime()- new Date().getTime()<0){
					map.put("message", "账户到期！");
				}else if(act!=null&&act.getStatus()==-1){
					map.put("message", "账户已被关闭，请联系管理员！");
				}else{
					session.setAttribute("loginUser", user);
					MemberEntity mb = this.getMemberEntityDAO().findUnique(HDaoUtils.eq("openId", openId).toCondition());
					String nick = "";
					if(mb!=null){
						nick = mb.getNick();
					}
					log(user.getUserName(), "用户登录",openId,nick);
					return "redirect:/visit/manager";
				}
			}else{
				ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).andEq("hx_password", password).toCondition());
				if(act!=null){
					map.put("act", act.getId());
					return "/manager/hx";
				}else{
					map.put("message", "登录密码错误！");
				}
			}
		}else{
			map.put("message", "账户不存在或已被冻结！");
		}
		return "login";
	}
	
	/**
	 * 退出
	 */
	@RequestMapping(value="logOut")
	public String logOut(HttpServletRequest request){
		request.getSession().removeAttribute("loginUser");
		request.getSession().removeAttribute("userName");
		request.getSession().removeAttribute("terpoint");
		request.getSession().removeAttribute("activity");
		request.getSession().removeAttribute("domain");
		request.getSession().removeAttribute("roleNames");
		request.getSession().removeAttribute("isTrue");
		request.getSession().removeAttribute("openId");
		return "login";
	}
	
	/**
	 * 修改密码
	 * @param oldpassword 旧密码
	 * @param newpassword 新密码
	 * @param request
	 * @return
	 */
	@RequestMapping(value="modifyPs") 
	@ResponseBody
	public Map<String, Object> modifyPassword(String oldpassword,String newpassword,
			HttpServletRequest request){
		UserEntity user=(UserEntity)request.getSession().getAttribute("loginUser");
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "修改失败";
		boolean flag = false;
		if(oldpassword.equals(user.getPassword())){
			user.setPassword(newpassword);
			this.getUserEntityDAO().update(user);
			msg = "修改成功";
			flag = true;
		}
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}
	
	
	/**
	 * 获取用户列表
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET)
	public String list(
			@RequestParam(value="username",required=false)String username,
			@RequestParam(value="pageIndex",defaultValue="1")Integer pageIndex,
			@RequestParam(value="pageSize",defaultValue="20")Integer pageSize,
			HttpServletRequest request,ModelMap mm){
		//TODO 角色判断待做，具体根据业务逻辑判断，目前查出所有用户
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		UserRoleEntity ure = this.getUserRoleEntityDAO().findUnique(HDaoUtils.eq("user", user.getId()).toCondition());
		RoleEntity role = ure.getRole();
		if(!role.getRoleName().equals("管理员")){
			return "404";
		}
		PaginationList<UserEntity> list=null;
		if(StringUtils.isNotEmpty(username)){
			list=this.getUserEntityDAO().list(HDaoUtils.like("userName", username).toCondition(),pageIndex,pageSize,Order.desc("addTime"));
			mm.put("username", username);
		}else{
			list=this.getUserEntityDAO().list(pageIndex,pageSize,Order.desc("addTime"));
		}
		mm.put("list", list.getItems());
		mm.put("total", list.getTotalCount());
		mm.put("pageIndex", pageIndex);
		mm.put("pageSize", pageSize);
		mm.put("totalPage", (int) Math.ceil(list.getTotalCount() / pageSize.doubleValue()));
		return "manager/user_list";
	}
	
	/**
	 * 修复角色菜单
	 */
	@RequestMapping(value="repairUserRole",method=RequestMethod.POST)
	public String repairUserRole(HttpServletRequest request,ModelMap mm){
		permissionService.repairUserRole();
		mm.put("message", "成功!");
		return list(null,1,20,request,mm);
	}
	
	/**
	 * 去修改用户信息
	 * */
	@RequestMapping(value="/topersonal",method=RequestMethod.GET)
	public String findByid(HttpServletRequest request,ModelMap map){
		UserEntity user=(UserEntity)request.getSession().getAttribute("loginUser");
		if(user!=null){
			map.put("user", user);
		}
		return "manager/personal";
	}
	
	/**
	 * 修改用户信息
	 * */
	@RequestMapping(value="modiUser",method=RequestMethod.POST) 
	@ResponseBody
	public Map<String, Object> modiUser(String picUrl,HttpServletRequest request){
		UserEntity user=(UserEntity)request.getSession().getAttribute("loginUser");
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "修改失败";
		boolean flag = false;
		if(user!=null){
			user.setPicUrl(picUrl);
			this.getUserEntityDAO().update(user);
			msg = "修改成功";
			flag = true;
		}
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}
	
	/**
	 * 添加用户
	 * */
	@RequestMapping(value="add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> add(
			@RequestParam(value = "userName")String userName,
			@RequestParam(value = "password")String password,
			@RequestParam(value = "realName")String realName,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "qq",required=false) String qq,
			@RequestParam(value = "sex")Integer sex,
			@RequestParam(value = "joinTime") String joinTime,
			HttpServletRequest request){
		Boolean flag=false;
		Map<String,Object> map=new HashMap<String, Object>();
		UserEntity user=(UserEntity)request.getSession().getAttribute("loginUser");
		UserEntity user2=new UserEntity();
		boolean f=this.getUserEntityDAO().exist(HDaoUtils.eq("userName",userName).toCondition());
		if(f){
			map.put("msg","用户名已存在!");
			return map;
		}
		user2.setUserName(userName);
		user2.setPassword(password);
		
		
		user2.setRealName(realName);
		user2.setSex(sex);
		user2.setJoinTime(DateUtil2.parseDateTime(joinTime));
		user2.setPhone(phone);
		user2.setQq(qq);
		user2.setStatus(1);
		user2.setAddTime(new Date());
		this.getUserEntityDAO().create(user2);
		log(user.getUserName(),"添加用户:"+user2.getUserName());
		flag=true;
		map.put("msg","添加成功！");
		map.put("flag",flag);
		return map;
	}
	
	/**
	 * 去修改
	 * */
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String findById(@PathVariable(value="id")String id,
			ModelMap map){
		UserEntity user=this.getUserEntityDAO().get(id);
		if(user==null){
			map.put("message", "用户不存在,请刷新重试!");
			return "redirect:/user";
		}
		map.put("user", user);
		return "manager/user_update";
	}
	
	/**
	 * 修改用户信息
	 * */
	@RequestMapping(value="/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String,Object> update(@PathVariable(value="id")String id,
			@RequestParam(value = "password")String password,
			@RequestParam(value = "realName")String realName,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "qq",required=false) String qq,
			@RequestParam(value = "sex")Integer sex,
			@RequestParam(value = "leaveTime") String leaveTime,
			@RequestParam(value = "status")Integer status,
			HttpServletRequest request,ModelMap map){
		String msg="修改失败";
		Boolean flag=false;
		UserEntity user=(UserEntity)request.getSession().getAttribute("loginUser");
		UserEntity user2=this.getUserEntityDAO().get(id);
		if(user2!=null){
			user2.setPassword(password);
			user2.setRealName(realName);
			user2.setPhone(phone);
			user2.setSex(sex);
			if(leaveTime!=null){
				user2.setLeaveTime(DateUtil2.parseDateTime(leaveTime));
			}
			user2.setStatus(status);
			user2.setQq(qq);
			this.getUserEntityDAO().update(user2);
			msg="修改成功！";
			flag=true;
		}
		log(user.getUserName(), "修改用户信息:"+user2.getUserName());
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}
	
	/**
	 * 用户列表
	 * */
	@RequestMapping(value="list")
	@ResponseBody
	public List<UserBean> bean(HttpServletRequest request)throws ParseException{
		List<UserEntity> user=this.getUserEntityDAO().listAll();
		List<UserBean> userbean=new ArrayList<UserBean>();
		for(int i=0;i<user.size();i++){
			UserEntity u=user.get(i);
			UserBean ubean= new UserBean(u);
			userbean.add(ubean);
		}
		return userbean;
	}
	
	/**
	 * 验证动态码
	 * @param level 动态码等级 1.登录 2.设置金额
	 * @param code 	动态码
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/validate",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> validate(
			@RequestParam(value="level")Integer level,
			@RequestParam(value="code")String code,HttpServletRequest request,ModelMap map){
		//账号
		String userName=(String)request.getSession().getAttribute("userName");
		PaginationList<WxModelSCEntity> list = this.getWxModelSCEntityDAO().list(HDaoUtils.eq("userName", userName).andEq("level", level).toCondition(),1,1,Order.desc("addTime"));
		code = code.trim();
		if (list==null|| list.getItems().size()==0) {
			map.put("flag",false);
			map.put("message", "请获取动态码!");
		}else{
			WxModelSCEntity record = list.getItems().get(0);
			Date addTime = record.getAddTime();
			Date now=new Date();
			long diff=now.getTime()-addTime.getTime();
			if (diff>=60*1000*5) {//五分钟
				map.put("flag", false);
				map.put("message", "动态码超时,请重新获取动态码!");
			}else{
				Date five = new Date(addTime.getTime()-5*60*1000);
				//验证码是否正确
				WxModelSCEntity wxmsc = this.getWxModelSCEntityDAO().findUnique(HDaoUtils.gt("addTime", five).andEq("userName", userName).andEq("code", code).toCondition());
				//验证通过
				if (wxmsc!=null) {
					//保存操作者openId
					request.getSession().setAttribute("openId", wxmsc.getOpenId());
					//保存状态
					switch (level) {
						//给红包设置金额验证
						case 2:
							request.getSession().setAttribute("isTrue", true);
							String nick = this.getMemberEntityDAO().findUnique(HDaoUtils.eq("openId", wxmsc.getOpenId()).toCondition()).getNick();
							//记录操作日志
							log(userName, "设置金额",wxmsc.getOpenId(),nick);
							break;
						default:
							break;
					}
					map.put("message", "验证通过！");
					map.put("flag", true);
				}else{
					map.put("flag", false);
					map.put("message", "动态码错误!");
				}
			}
		}
		return map ;
	}
	/**
	 * 点击获取动态码时，判断用户是否可以发送,是否超时,是否绑定微信号,账号密码是否正确
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/allow",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> allow(
			@RequestParam(value="userId")String userId,
			@RequestParam(value="userPwd",required=false)String userPwd,
			@RequestParam(value="level")Integer level,
			HttpServletRequest req) throws Exception{
		ModelMap map =new ModelMap();
		//验证账号
		UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userId).toCondition());
		if(user==null){
			map.put("flag", false);
			map.put("message", "用户不存在!");
			return map;
		}
		//先验证账号密码是否正确
		if(!StringUtils.isBlank(userPwd)){
			UserEntity user0 = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userId).andEq("password", userPwd).toCondition());
			if (user0==null){
				map.put("flag", false);
				map.put("message", "用户名或密码错误!");
				return map;
			}
		}
		//验证是否绑定微信号，并且获取MemberEntity
		List<MemberEntity> mbList = getMember(userId, map);
		if(mbList == null||mbList.size()==0){
			return map;
		}
		String openId = mbList.get(0).getOpenId();
		req.getSession().setAttribute("openId", openId);
		//验证是否超时
		PaginationList<WxModelSCEntity> list = this.getWxModelSCEntityDAO().list(HDaoUtils.eq("openId",openId ).andEq("level", level).andEq("userName", userId).toCondition(),1,1,Order.desc("addTime"));
		//通知title
		String title = "微信动态码";
		String userName = "";
		//代理
		TerPointEntity terpoint = this.getTerPointEntityDAO().findUnique("user",user);
		//商家
		ActivityEntity activity = this.getActivityEntityDAO().findUnique("user",user);
		if(terpoint!=null){
			userName = terpoint.getName();
		}
		if(activity!=null){
			userName = activity.getName();
		}
		switch (level) {
		case 1:
			title = "尊敬的【"+userName+"】您正在登录红包派后台，打死也不能告诉别人!";
			break;
		case 2:
			title = "尊敬的【"+userName+"】您正在给红包设置金额，打死也不能告诉别人!";
			break;

		default:
			break;
		}
		if (list!=null &&list.getItems().size()>0) {
			WxModelSCEntity record = list.getItems().get(0);
			Date addTime = record.getAddTime();
			Date now=new Date();
			long diff=now.getTime()-addTime.getTime();
			if (diff>0 && diff>=60*1000*5) {//5min
				//已超时可以再次发送动态码,给所有绑定了微信号的管理发动态码，动态码不同
				for (MemberEntity mb:mbList) {
					send(user.getUserName(),title,mb.getOpenId(), level, req, map);
				}
				map.put("flag", true);
				map.put("message", "动态码发送成功!");
			}else{
				map.put("flag", false);
				map.put("message", "动态码未过期，请勿重复获取!");
				System.out.println(record.getCode());
			}
			return map ;
		}
		//未使用过微信动态码
		for (MemberEntity mb:mbList) {
			send(user.getUserName(),title,mb.getOpenId(), level, req, map);
		}
		map.put("flag",true);
		map.put("message", "动态码发送成功!");
		return map ;
	}
	/**
	 * 是否显示获取动态码
	 */
	@RequestMapping(value="/isShow",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> isShow(
			@RequestParam(value="userId")String userId,
			HttpServletRequest req,ModelMap map) throws Exception{
		List<MemberEntity> mb = getMember(userId, map);
		return map ;
	}
	/**
	 * 发送验证码
	 * @param userName 用户
	 * @param title 消息头
	 * @param openId 微信openId
	 * @param level 动态码等级，1-登录，2-给红包设置金额
	 * @param req HttpServletRequest
	 * @param map ModelMap
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> send(String userName,String title,String openId,Integer level,HttpServletRequest req,ModelMap map) throws Exception{
		String code = getCode();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = sdf.format(new Date());
		WxModelSCEntity wxmsc = new WxModelSCEntity();
		wxmsc.setCode(code);
		wxmsc.setOpenId(openId);
		wxmsc.setLevel(level);
		wxmsc.setUserName(userName);
		this.getWxModelSCEntityDAO().create(wxmsc);
		System.out.println("消息头："+title);
		System.out.println("微信动态码:"+code);
		map.put("message", "动态码发送成功!");
		return map ;
	}
	/**
	 * 验证是否绑定微信,并获取MemberEntity
	 */
	public List<MemberEntity> getMember(String userId,ModelMap map){
		//验证是否绑定微信号
		List<MemberEntity> mb = new ArrayList<MemberEntity>();
		//验证账号
		UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userId).toCondition());
		if(user==null){
			map.put("flag", false);
			map.put("message", "用户不存在!");
			return mb;
		}
		//代理
		TerPointEntity terpoint = this.getTerPointEntityDAO().findUnique("user",user);
		//商家
		ActivityEntity activity = this.getActivityEntityDAO().findUnique("user",user);
		if(terpoint!=null){
			mb = this.getMemberEntityDAO().list(HDaoUtils.eq("terpoint",terpoint).toCondition());
		}
		if(activity!=null){
			Exp<Criterion> exp = HDaoUtils.eq("activity",activity);
			mb = this.getMemberEntityDAO().list(exp.toCondition());
		}
//		if(mb==null||mb.size()==0){
//			map.put("flag", false);
//			map.put("message", "暂未绑定微信号!");
//			return mb;
//		}
		map.put("flag", true);
		return mb;
	}
	//获取4位动态码
	public String getCode(){
		String code = "";
		//生成随机类
		Random random = new Random();
		// 取随机产生的验证码(4位数字)
		for (int i=0;i<4;i++){
			String rand=String.valueOf(random.nextInt(10));
			code+=rand;
		}
		return code;
	}
	
}
