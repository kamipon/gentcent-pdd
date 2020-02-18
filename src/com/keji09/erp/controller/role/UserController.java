package com.keji09.erp.controller.role;


import com.keji09.erp.bean.UserBean;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.TerPointEntity;
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
import java.util.*;


/**
 * 用户管理控制器
 */
@Controller
@RequestMapping("/user")
public class UserController extends XDAOSupport {
	
	@Autowired
	PermissionService permissionService;
	
	/**
	 * 用户登陆
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam(value = "username") String username,
						@RequestParam(value = "password") String password,
						@RequestParam(value = "phoneCode", required = false) String phoneCode,
						HttpServletRequest request, ModelMap map) {
		HttpSession session = request.getSession();
		UserEntity user = this.getUserEntityDAO().findUnique("username", username);
		if (user != null && user.getStatus() != 2) {
			//用户名存在
			if (password.equals(user.getPassword())) {
				request.getSession().setAttribute("username", username);
				//登录则设置金额操作验证为false
				request.getSession().setAttribute("isTrue", false);
				String openId = "";
				ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
				if (act != null && act.getOverTime() != null && act.getOverTime().getTime() - new Date().getTime() < 0) {
					map.put("message", "账户到期！");
				} else if (act != null && act.getStatus() == -1) {
					map.put("message", "账户已被关闭，请联系管理员！");
				} else {
					session.setAttribute("loginUser", user);
					log(user.getUsername(), "用户登录", openId, "");
					return "redirect:/visit/manager";
				}
			} else {
				ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).andEq("hx_password", password).toCondition());
				if (act != null) {
					map.put("act", act.getId());
					return "/manager/hx";
				} else {
					map.put("message", "登录密码错误！");
				}
			}
		} else {
			map.put("message", "账户不存在或已被冻结！");
		}
		return "login";
	}
	
	/**
	 * 退出
	 */
	@RequestMapping(value = "logOut")
	public String logOut(HttpServletRequest request) {
		request.getSession().removeAttribute("loginUser");
		request.getSession().removeAttribute("username");
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
	 *
	 * @param oldpassword 旧密码
	 * @param newpassword 新密码
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "modifyPs")
	@ResponseBody
	public Map<String, Object> modifyPassword(String oldpassword, String newpassword,
											  HttpServletRequest request) {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "修改失败";
		boolean flag = false;
		if (oldpassword.equals(user.getPassword())) {
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
	 *
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String list(
			@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			HttpServletRequest request, ModelMap mm) {
		//TODO 角色判断待做，具体根据业务逻辑判断，目前查出所有用户
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		UserRoleEntity ure = this.getUserRoleEntityDAO().findUnique(HDaoUtils.eq("user", user.getId()).toCondition());
		RoleEntity role = ure.getRole();
		if (!role.getRoleName().equals("管理员")) {
			return "404";
		}
		PaginationList<UserEntity> list = null;
		if (StringUtils.isNotEmpty(username)) {
			list = this.getUserEntityDAO().list(HDaoUtils.like("username", username).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			mm.put("username", username);
		} else {
			list = this.getUserEntityDAO().list(pageIndex, pageSize, Order.desc("addTime"));
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
	@RequestMapping(value = "repairUserRole", method = RequestMethod.POST)
	public String repairUserRole(HttpServletRequest request, ModelMap mm) {
		permissionService.repairUserRole();
		mm.put("message", "成功!");
		return list(null, 1, 20, request, mm);
	}
	
	/**
	 * 去修改用户信息
	 */
	@RequestMapping(value = "/topersonal", method = RequestMethod.GET)
	public String findByid(HttpServletRequest request, ModelMap map) {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		if (user != null) {
			map.put("user", user);
		}
		return "manager/personal";
	}
	
	/**
	 * 修改用户信息
	 */
	@RequestMapping(value = "modiUser", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> modiUser(String picUrl, HttpServletRequest request) {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "修改失败";
		boolean flag = false;
		if (user != null) {
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
	 */
	@RequestMapping(value = "add", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(
			@RequestParam(value = "userName") String userName,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "realName") String realName,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "qq", required = false) String qq,
			@RequestParam(value = "sex") Integer sex,
			@RequestParam(value = "joinTime") String joinTime,
			HttpServletRequest request) {
		Boolean flag = false;
		Map<String, Object> map = new HashMap<String, Object>();
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		UserEntity user2 = new UserEntity();
		boolean f = this.getUserEntityDAO().exist(HDaoUtils.eq("username", userName).toCondition());
		if (f) {
			map.put("msg", "用户名已存在!");
			return map;
		}
		user2.setUsername(userName);
		user2.setPassword(password);
		
		
		user2.setRealName(realName);
		user2.setSex(sex);
		user2.setJoinTime(DateUtil2.parseDateTime(joinTime));
		user2.setPhone(phone);
		user2.setStatus(1);
		user2.setAddTime(new Date());
		this.getUserEntityDAO().create(user2);
		log(user.getUsername(), "添加用户:" + user2.getUsername());
		flag = true;
		map.put("msg", "添加成功！");
		map.put("flag", flag);
		return map;
	}
	
	/**
	 * 去修改
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String findById(@PathVariable(value = "id") String id,
						   ModelMap map) {
		UserEntity user = this.getUserEntityDAO().get(id);
		if (user == null) {
			map.put("message", "用户不存在,请刷新重试!");
			return "redirect:/user";
		}
		map.put("user", user);
		return "manager/user_update";
	}
	
	/**
	 * 修改用户信息
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> update(@PathVariable(value = "id") String id,
									  @RequestParam(value = "password") String password,
									  @RequestParam(value = "realName") String realName,
									  @RequestParam(value = "phone") String phone,
									  @RequestParam(value = "qq", required = false) String qq,
									  @RequestParam(value = "sex") Integer sex,
									  @RequestParam(value = "leaveTime") String leaveTime,
									  @RequestParam(value = "status") Integer status,
									  HttpServletRequest request, ModelMap map) {
		String msg = "修改失败";
		Boolean flag = false;
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		UserEntity user2 = this.getUserEntityDAO().get(id);
		if (user2 != null) {
			user2.setPassword(password);
			user2.setRealName(realName);
			user2.setPhone(phone);
			user2.setSex(sex);
			if (leaveTime != null) {
				user2.setLeaveTime(DateUtil2.parseDateTime(leaveTime));
			}
			user2.setStatus(status);
			this.getUserEntityDAO().update(user2);
			msg = "修改成功！";
			flag = true;
		}
		log(user.getUsername(), "修改用户信息:" + user2.getUsername());
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}
	
	/**
	 * 用户列表
	 */
	@RequestMapping(value = "list")
	@ResponseBody
	public List<UserBean> bean(HttpServletRequest request) throws ParseException {
		List<UserEntity> user = this.getUserEntityDAO().listAll();
		List<UserBean> userbean = new ArrayList<UserBean>();
		for (int i = 0; i < user.size(); i++) {
			UserEntity u = user.get(i);
			UserBean ubean = new UserBean(u);
			userbean.add(ubean);
		}
		return userbean;
	}
	
	/**
	 * 验证是否绑定微信,并获取MemberEntity
	 */
	public List<MemberEntity> getMember(String userId, ModelMap map) {
		//验证是否绑定微信号
		List<MemberEntity> mb = new ArrayList<MemberEntity>();
		//验证账号
		UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("username", userId).toCondition());
		if (user == null) {
			map.put("flag", false);
			map.put("message", "用户不存在!");
			return mb;
		}
		//代理
		TerPointEntity terpoint = this.getTerPointEntityDAO().findUnique("user", user);
		//商家
		ActivityEntity activity = this.getActivityEntityDAO().findUnique("user", user);
		if (terpoint != null) {
			mb = this.getMemberEntityDAO().list(HDaoUtils.eq("terpoint", terpoint).toCondition());
		}
		if (activity != null) {
			Exp<Criterion> exp = HDaoUtils.eq("activity", activity);
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
	public String getCode() {
		String code = "";
		//生成随机类
		Random random = new Random();
		// 取随机产生的验证码(4位数字)
		for (int i = 0; i < 4; i++) {
			String rand = String.valueOf(random.nextInt(10));
			code += rand;
		}
		return code;
	}
	
}
