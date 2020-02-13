package com.keji09.erp.controller;

import com.keji09.develop.sms.DySMSSend;
import com.keji09.erp.bean.ActivityBean;
import com.keji09.erp.model.*;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.service.PermissionService;
import com.keji09.erp.utils.Constants;
import com.keji09.erp.utils.DateUtil2;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 活动管理器
 * */
@Controller
@RequestMapping(value="/activity")
public class ActivityController extends XDAOSupport{
	@Autowired
	PermissionService permissionService;
	@Autowired
	JdbcTemplate jdbcTemplate;
	/**
	 * 添加商家
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(
		@RequestParam(value="name")String name,
		@RequestParam(value="phone")String phone,
		@RequestParam(value="userName")String userName,
		@RequestParam(value="password")String password,
		@RequestParam(value="province", required = false)String province,
		@RequestParam(value="city", required = false)String city,
		@RequestParam(value="address",required=false)String address,
		@RequestParam(value="desc",required=false)String desc,
		@RequestParam(value="overTime",required=false)String overTime,
		
		
		@RequestParam(value="picUrl", required = false)String picUrl,
		@RequestParam(value="title", required = false)String title,
		@RequestParam(value="url", required = false)String url,
		@RequestParam(value="type", required = false)String type,
		@RequestParam(value="muban", required = false)String muban,
		@RequestParam(value="hx",required=false)String hx_password,
		HttpServletRequest request,ModelMap map){
		try {
			ActivityEntity entity = new ActivityEntity();
			UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
			TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
			int num=this.getActivityEntityDAO().count(HDaoUtils.eq("terpoint", ter).andEq("type", 1).toCondition());
			if(type.equals("1")){
				if(ter.getActivityNum()-num<=0){
					map.put("flag", false);
					map.put("msg","您可以添加的正式商家数量达到上限，请联系管理员！");
					return map;
				}
			}
			UserEntity user1 = new UserEntity();
				user1.setUserName(userName);
				user1.setPassword(password);
				user1.setPhone(phone);
				user1.setStatus(1);
				user1.setAddTime(new Date());
				user1.setRoleName(this.getRoleEntityDAO().get("3"));
				this.getUserEntityDAO().create(user1);
				
				entity.setName(name);
				entity.setProvince(province);
				entity.setCity(city);
				entity.setPhone(phone);
				entity.setAddress(address);
				entity.setDesc(desc);
				entity.setCategoryt(0);
				entity.setUser(user1);
				entity.setPtFee(ter.getPtFee());
				entity.setTerFee(ter.getTerFee());
//				entity.setHx_password(hx_password);
//				entity.setPicUrl(picUrl);
//				entity.setTitle(title);
//				entity.setType(Integer.parseInt(type));
//				entity.setUrl(url);
//				entity.setContent(this.getContentEntityDao().get(muban));
				if(overTime!=null){
					entity.setOverTime(DateUtil2.parseDateTime(overTime));
				}
			entity.setTerpoint(ter);
			//给新增的商家设置商家角色
			permissionService.setRole(user1.getId(), new String[]{"3"});
			this.getActivityEntityDAO().create(entity);
			map.put("flag", true);
			map.put("msg","添加成功");
		} catch (Exception e) {
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg","添加失败，账号已被其他代理创建");
		}
		return map;
	}
	/**
	 * 商家自行注册
	 */
	@RequestMapping(value="/register",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addActivity(
		@RequestParam(value="phone")String userName,
		@RequestParam(value="password")String password,
		@RequestParam(value="captcha")String captcha,HttpServletRequest request,ModelMap map){
		try{
			Object temp = request.getSession().getAttribute("captcha");
			if (temp == null) {
				map.put("flag", false);
				map.put("msg", "验证码错误！");
				return map;
			}  else if (!temp.toString().equals(captcha)) {
				map.put("flag", false);
				map.put("msg", "验证码错误！");
				return map;
			}else {
				UserEntity user=this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userName).toCondition());
					if(user!=null){
						map.put("flag", false);
						map.put("msg", "您使用的账号已被注册");
					}else{
						
						ActivityEntity entity = new ActivityEntity();
						UserEntity user1 = new UserEntity();
						user1.setUserName(userName);
						user1.setPassword(password);
						user1.setStatus(1);
						user1.setAddTime(new Date());
						this.getUserEntityDAO().create(user1);
						entity.setUser(user1);
						entity.setPhone(userName);
						entity.setCategoryt(1);
						permissionService.setRole(user1.getId(), new String[]{"3"});
						this.getActivityEntityDAO().create(entity);
						map.put("flag", true);
						map.put("msg","注册成功");
					}
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("flag", false);
			map.put("msg","注册失败");
		}
		return map;
	}
	/**
	 * 删除活动信息
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> del(@PathVariable(value="id") String id,ModelMap map){
		map.clear();
		ActivityEntity activityEntity = this.getActivityEntityDAO().get(id);
		if(activityEntity.getMoney()>0.0f){
			map.put("msg", "删除失败!,该商家还有余额！");
			map.put("flag", false);
			return map;
		}
		try {
			UserEntity user = activityEntity.getUser();
			this.getActivityEntityDAO().remove(activityEntity);
			if(user!=null){
				this.getUserEntityDAO().remove(user);
			}
			map.put("msg", "删除成功");
			map.put("flag", true);
		} catch (Exception e) {
			// TODO: handle exception
			map.put("msg", "删除失败");
			map.put("flag", false);
		}
		 
		return map;
	}
	/**
	 * 去到活动添加页面
	 */
	@RequestMapping(value="addActivity",method=RequestMethod.GET)
	public String add( HttpServletRequest request,ModelMap map){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		if(user == null){
			return "login";
		}
		TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		if(ter!=null){
			map.put("ter", ter);
			map.put("terpoint", ter);
		}else{
			return "login";
		}
		return "manager/activity_add";
	}
		/**
		 * 去到活动修改页面
		 * @throws ParseException 
		 */
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String money(@PathVariable(value="id") String id,HttpServletRequest request,ModelMap map) throws ParseException{
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
			if(user == null){
				return "login";
			} 
		TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
			if(ter!=null){
				map.put("ter", ter);
			}
		String over = "";
		ActivityEntity entity = this.getActivityEntityDAO().get(id);
		if(entity.getOverTime()!=null){
			String da = entity.getOverTime().toString();
			over = da.substring(0,da.length()-2);
		}
		map.put("activity", entity);
		map.put("over", over);
		String url;
		if(user.getId().equals("1")){
			url="manager/activity_update_admin";
		}else{
			url="manager/activity_update";
		}
		return url;
	}
	
	/**
	 * 代理商修改活动信息
	 */
	@RequestMapping(value="change",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> change(
		@RequestParam(value="id")String id,
		@RequestParam(value="name")String name,
		@RequestParam(value="phone")String phone,
		@RequestParam(value="address",required=false)String address,
		@RequestParam(value="desc",required=false)String desc,
		@RequestParam(value="overTime",required=false)String overTime,
		
		
		@RequestParam(value="picUrl", required = false)String picUrl,
		@RequestParam(value="title", required = false)String title,
		@RequestParam(value="url", required = false)String url,
		@RequestParam(value="type", required = false)Integer type,
		@RequestParam(value="muban", required = false)String muban,
		@RequestParam(value="hx",required=false)String hx_password,
		HttpServletRequest request,ModelMap map
		){
			map.clear();
			UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
			TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
//			if(type==1){
//				int num=this.getActivityEntityDAO().count(HDaoUtils.eq("terpoint", ter).andEq("type", 1).toCondition());
//				if(ter.getActivityNum()-num<=0){
//					map.put("flag", false);
//					map.put("msg","您可以添加的正式商家数量达到上限，请联系管理员！");
//					return map;
//				}
//			}
			try{
				ActivityEntity entity = this.getActivityEntityDAO().get(id);
				entity.setName(name);
				entity.setPhone(phone);
				entity.setAddress(address);
				entity.setDesc(desc);
				entity.setOverTime(DateUtil2.parseDateTime(overTime));
//				entity.setPicUrl(picUrl);
//				entity.setTitle(title);
//				entity.setUrl(url);
//				entity.setHx_password(hx_password);
//				entity.setType(type);
//				entity.setContent(this.getContentEntityDao().get(muban));
				this.getActivityEntityDAO().update(entity);
				map.put("flag", true);
			    map.put("msg","修改成功");
			}catch (Exception e) {
				// TODO: handle exception
				map.put("flag", false);
			    map.put("msg","修改失败");
			}
		return map;
			}
	/**
	 * admin修改活动信息
	 */
	@RequestMapping(value="changes",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> changes(
		@RequestParam(value="id")String id,
		@RequestParam(value="name")String name,
		@RequestParam(value="phone")String phone,
		@RequestParam(value="address",required=false)String address,
		@RequestParam(value="desc",required=false)String desc,
		@RequestParam(value="overTime",required=false)String overTime,
		@RequestParam(value="picUrl", required = false)String picUrl,
		@RequestParam(value="title", required = false)String title,
		@RequestParam(value="url", required = false)String url,
		@RequestParam(value="type", required = false)Integer type,
		@RequestParam(value="muban", required = false)String muban,
		@RequestParam(value="zfb", required = false)String zfb,
		@RequestParam(value="zfbname", required = false)String zfbname,
		@RequestParam(value="password", required = false)String password,
		@RequestParam(value="hx",required=false)String hx_password,
		HttpServletRequest request,ModelMap map
		){
			map.clear();
			UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
			TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
//			if(type==1){
//				int num=this.getActivityEntityDAO().count(HDaoUtils.eq("terpoint", ter).andEq("type", 1).toCondition());
//				if(ter.getActivityNum()-num<=0){
//					map.put("flag", false);
//					map.put("msg","您可以添加的正式商家数量达到上限，请联系管理员！");
//					return map;
//				}
//			}
			try{
				ActivityEntity entity = this.getActivityEntityDAO().get(id);
				entity.setName(name);
				entity.setPhone(phone);
				entity.setAddress(address);
				entity.setDesc(desc);
				entity.setOverTime(DateUtil2.parseDateTime(overTime));
				entity.setZfb(zfb);
				entity.setZfbname(zfbname);
//				entity.setPicUrl(picUrl);
//				entity.setTitle(title);
//				entity.setUrl(url);
//				entity.setHx_password(hx_password);
//				entity.setType(type);
//				entity.setContent(this.getContentEntityDao().get(muban));
				entity.getUser().setPassword(password);
				this.getUserEntityDAO().update(entity.getUser());
				this.getActivityEntityDAO().update(entity);
				map.put("flag", true);
			    map.put("msg","修改成功");
			}catch (Exception e) {
				// TODO: handle exception
				map.put("flag", false);
			    map.put("msg","修改失败");
			}
		return map;
			}
	/**
	 * 商家修改个人信息
	 */
	@RequestMapping(value="details",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> details(
		@RequestParam(value="id")String id,
		@RequestParam(value="name")String name,
		@RequestParam(value="picUrl", required = false)String picUrl,
//		@RequestParam(value="weixin")String weixin,
		@RequestParam(value="title", required = false)String title,
		@RequestParam(value="url", required = false)String url,
		@RequestParam(value="phone", required = false)String phone,
		@RequestParam(value="isaddress", required = false)String isaddress,
		@RequestParam(value="muban", required = false)String muban,
		@RequestParam(value="redName", required = false)String redName,
		@RequestParam(value="pattern", required = false)String pattern,
		@RequestParam(value="saveType", required = false)String saveType,
		@RequestParam(value="hx",required=false)String hx_password,
		@RequestParam(value="address",required=false)String address,
		@RequestParam(value="desc",required=false)String desc,
		@RequestParam(value="zfb",required=false)String zfb,
		@RequestParam(value="zfbname",required=false)String zfbname,
		HttpServletRequest request,ModelMap map
		){
		map.clear();
			try{
				ActivityEntity entity = this.getActivityEntityDAO().get(id);
				if(entity.getUser().getPassword().equals(hx_password)){
					map.put("flag", false);
				    map.put("msg","修改失败,商品密码不能与账号密码相同");
				    return map;
				}
				entity.setName(name);
				entity.setPhone(phone);
				entity.setAddress(address);
				entity.setDesc(desc);
				entity.setZfb(zfb);
				entity.setZfbname(zfbname);
//				entity.setPicUrl(picUrl);
//				entity.setTitle(title);
//				entity.setWeixin(weixin);
//				entity.setUrl(url);
//				entity.setRedName(redName);
//				entity.setHx_password(hx_password);
//				entity.setIsaddress(Integer.parseInt(isaddress));
//				entity.setContent(this.getContentEntityDao().get(muban));
//				entity.setPattern(Integer.valueOf(pattern));
//				entity.setSaveType(Integer.valueOf(saveType));
				this.getActivityEntityDAO().update(entity);
				map.put("flag", true);
			    map.put("msg","修改成功");
			}catch (Exception e) {
				// TODO: handle exception
				map.put("flag", false);
			    map.put("msg","修改失败");
			}
		return map;
			}
	/**
	 * 代理商设置活动是否可以重复领取
	 */
	@RequestMapping(value="boolean",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> kaiqi(
			@RequestParam(value="boolean") boolean isConfirm,
			@RequestParam(value="id") String id,
									ModelMap map
			){
		ActivityEntity activityEntity = this.getActivityEntityDAO().get(id);
		try {
			if(isConfirm){
				activityEntity.setIsBoolean(false);
				map.put("flag", true);
			    map.put("msg","关闭成功");
			}else{
			
				activityEntity.setIsBoolean(true);
				map.put("flag", true);
			    map.put("msg","开启成功");
			}
			this.getActivityEntityDAO().update(activityEntity);
			
		} catch (Exception e) {
			// TODO: handle exception
			map.put("flag", false);
		    map.put("msg","开启失败");
		}
		return map;
												
		
			}

	/**
	 * 商家个人资料展示
	 */
	@RequestMapping(value="details",method=RequestMethod.GET)
	public String person(HttpServletRequest request,ModelMap map){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		TerPointEntity ter = act.getTerpoint();
		boolean flag = false;
		List<Map<String,String>> urlList = new ArrayList<Map<String,String>>();
		map.put("flag", flag);
		map.put("urlList", urlList);
		map.put("activity", act);
		return "manager/activity_details";
	}
	/**
	 * 商家开发者模式
	 */
	@RequestMapping(value="develop",method=RequestMethod.GET)
	public String develop(HttpServletRequest request,ModelMap map){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		map.put("activity", act);
		return "manager/activity_develop";
	}
	/**
	 * 重置appsecret
	 */
	@RequestMapping(value="reset",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> reset(HttpServletRequest request,ModelMap map){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		try {
			String appsecret = java.util.UUID.randomUUID().toString();
			appsecret = appsecret.replaceAll("-", "");
			act.setAppsecret(appsecret);
			this.getActivityEntityDAO().update(act);
			map.put("activity", act);
			map.put("flag", true);
			map.put("msg", "重置成功");
		} catch (Exception e) {
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg", "重置失败");
		}
		return map;
	}
	/**
	 * 保存开发者信息
	 */
	@RequestMapping(value="saveDevelop",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> save(
			@RequestParam(value="id") String id,
			@RequestParam(value="appId") String appId,
			@RequestParam(value="appsecret") String appsecret,
			HttpServletRequest request,ModelMap map){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		try {
			act.setAppsecret(appsecret);
			act.setAppId(appId);
			this.getActivityEntityDAO().update(act);
			map.put("flag", true);
			map.put("msg", "保存成功");
		} catch (Exception e) {
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg", "保存失败");
		}
		return map;
	}
	/**
	 * 去到商家余额管理
	 */
	@RequestMapping(value="money",method=RequestMethod.GET)
	public String money(@RequestParam(value="id") String id,
									ModelMap map
			){
		ActivityEntity entity = this.getActivityEntityDAO().get(id);
		DecimalFormat df = new DecimalFormat("#.00");
		map.put("activity", entity);
		return "manager/activity_money";
	}
	@RequestMapping(value="isAuthorization",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> isAuthorization(HttpServletRequest request,ModelMap map,String id){
		System.out.println(id);
		WechartActivityConfigEntity wace = this.getWechartActivityConfigEntityDAO().findUnique(HDaoUtils.eq("activity", id).andEq("isAuth", true).toCondition());
		if(wace==null){
			map.put("flag", false);
		}else{
			map.put("flag", true);
			map.put("type", wace.getServiceTypeInfo());
		}
		return map;
	}
	
	//查询所有商家(活动)
	@RequestMapping(value="selectAllAc")
	public String selectAllActivity(ModelMap map,
		@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
		@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
		@RequestParam(value="name",required=false)String name,
		@RequestParam(value ="userName",required=false)String userName,
		@RequestParam(value ="tid",required=false)String tid
		){
		PaginationList<ActivityEntity> list = null;
		if(tid!=null&&!tid.equals("")){
			list = this.getActivityEntityDAO().list(HDaoUtils.eq("terpoint.id",tid).toCondition(),pageIndex, pageSize, Order.desc("addTime"));
		}else if(name!=null&&!name.equals("")){
			if(userName!=null&&!userName.equals("")){
				UserEntity ue = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userName).toCondition());
				list = this.getActivityEntityDAO().list(HDaoUtils.like("name", name).andEq("user",ue).toCondition(),pageIndex, pageSize, Order.desc("addTime"));
			}else{
				list = this.getActivityEntityDAO().list(HDaoUtils.like("name", name).toCondition(),pageIndex, pageSize, Order.desc("addTime"));
			}
		}else{
			if(userName!=null&&!userName.equals("")){
				UserEntity ue = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userName).toCondition());
				list = this.getActivityEntityDAO().list(HDaoUtils.eq("user",ue).toCondition(),pageIndex, pageSize, Order.desc("addTime"));
			}else{
				list = this.getActivityEntityDAO().list(pageIndex, pageSize, Order.asc("overTime"));
			}
		}
		UserEntity user = null;
		List<ActivityBean> acList = new ArrayList<ActivityBean>();
		for (ActivityEntity activityEntity : list.getItems()) {
			user = activityEntity.getUser();
			ActivityBean ab = new ActivityBean(activityEntity);
			ab.setUserName(user.getUserName());
			acList.add(ab);
		}
		map.put("list", acList);
		map.put("total", list.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(list.getTotalCount()/ pageSize.doubleValue()));
		return "manager/allactivity_list";
	}
	
	//查询所有商家(活动)
	//修改商家手续费设置
	@RequestMapping(value="selectAllAcFee")
	public String selectAllAcFee(ModelMap map,
		@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
		@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
		@RequestParam(value ="tid",required=false)String tid
		){
		PaginationList<ActivityEntity> list = null;
		list = this.getActivityEntityDAO().list(HDaoUtils.eq("terpoint.id",tid).toCondition(),pageIndex, pageSize, Order.desc("addTime"));
		map.put("list", list.getItems());
		map.put("total", list.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(list.getTotalCount()/ pageSize.doubleValue()));
		return "manager/allactivity_list_fee";
	}
	
	//设置商家的手续费
	@RequestMapping(value="set_fee",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> set_fee(HttpServletRequest request,ModelMap map,
			@RequestParam(value="id") String id,
			@RequestParam(value="ptFee") Integer ptFee,
			@RequestParam(value="terFee") Integer terFee
			){
		ActivityEntity ac = this.getActivityEntityDAO().get(id);
		if(ac==null){
			map.put("flag", false);
			map.put("msg", "报错有误，请刷新后重试！");
			return map;
		}
		ac.setPtFee(ptFee);
		ac.setTerFee(terFee);
		this.getActivityEntityDAO().update(ac);
		map.put("flag", true);
		map.put("msg", "保存成功");
		return map;
	}
	
	
}
