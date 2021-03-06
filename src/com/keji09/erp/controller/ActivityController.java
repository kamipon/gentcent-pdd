package com.keji09.erp.controller;

import com.keji09.erp.bean.ActivityBean;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.service.PermissionService;
import com.keji09.erp.utils.DateUtil2;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * 活动管理器
 */
@Controller
@RequestMapping(value = "/activity")
public class ActivityController extends XDAOSupport {
	
	@Autowired
	PermissionService permissionService;
	@Autowired
	SessionFactory sessionFactory;
	
	//查询商家 TODO
	@RequestMapping(method = RequestMethod.GET)
	public String list(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "userName", required = false) String userName,
			@RequestParam(value = "tid", required = false) String tid
			, ModelMap map) {
		PaginationList<ActivityEntity> list = null;
		if (tid != null && !tid.equals("")) {
			list = this.getActivityEntityDAO().list(HDaoUtils.eq("terpoint.id", tid).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
		} else if (name != null && !name.equals("")) {
			if (userName != null && !userName.equals("")) {
				UserEntity ue = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userName).toCondition());
				list = this.getActivityEntityDAO().list(HDaoUtils.like("name", name).andEq("user", ue).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			} else {
				list = this.getActivityEntityDAO().list(HDaoUtils.like("name", name).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			}
		} else {
			if (userName != null && !userName.equals("")) {
				UserEntity ue = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userName).toCondition());
				list = this.getActivityEntityDAO().list(HDaoUtils.eq("user", ue).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			} else {
				list = this.getActivityEntityDAO().list(pageIndex, pageSize, Order.asc("overTime"));
			}
		}
		UserEntity user = null;
		List<ActivityBean> acList = new ArrayList<ActivityBean>();
		for (ActivityEntity activityEntity : list.getItems()) {
			user = activityEntity.getUser();
			ActivityBean ab = new ActivityBean(activityEntity);
			ab.setUserName(user.getUsername());
			acList.add(ab);
		}
		map.put("list", acList);
		map.put("total", list.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(list.getTotalCount() / pageSize.doubleValue()));
		return "manager/activity_list";
	}
	
	//查询所有商家(admin) TODO
	@RequestMapping(value = "admin", method = RequestMethod.GET)
	public String allList(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "userName", required = false) String userName,
			@RequestParam(value = "tid", required = false) String tid
			, ModelMap map) {
		PaginationList<ActivityEntity> list = null;
		if (tid != null && !tid.equals("")) {
			list = this.getActivityEntityDAO().list(HDaoUtils.eq("terpoint.id", tid).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
		} else if (name != null && !name.equals("")) {
			if (userName != null && !userName.equals("")) {
				UserEntity ue = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userName).toCondition());
				list = this.getActivityEntityDAO().list(HDaoUtils.like("name", name).andEq("user", ue).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			} else {
				list = this.getActivityEntityDAO().list(HDaoUtils.like("name", name).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			}
		} else {
			if (userName != null && !userName.equals("")) {
				UserEntity ue = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", userName).toCondition());
				list = this.getActivityEntityDAO().list(HDaoUtils.eq("user", ue).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			} else {
				list = this.getActivityEntityDAO().list(pageIndex, pageSize, Order.asc("overTime"));
			}
		}
		UserEntity user = null;
		List<ActivityBean> acList = new ArrayList<ActivityBean>();
		for (ActivityEntity activityEntity : list.getItems()) {
			user = activityEntity.getUser();
			ActivityBean ab = new ActivityBean(activityEntity);
			ab.setUserName(user.getUsername());
			acList.add(ab);
		}
		map.put("list", acList);
		map.put("total", list.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(list.getTotalCount() / pageSize.doubleValue()));
		return "manager/allactivity_list";
	}
	
	/**
	 * 去到活动添加页面
	 */
	@RequestMapping(value = "addActivity", method = RequestMethod.GET)
	public String add(HttpServletRequest request, ModelMap map) {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		if (user == null) {
			return "login";
		}
		TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		if (ter != null) {
			map.put("ter", ter);
			map.put("terpoint", ter);
		} else {
			return "login";
		}
		return "manager/activity_add";
	}

	/**
	 * 修改商家
	 */
	@RequestMapping(value = "updateActivity/{id}", method = RequestMethod.GET)
	public String updateActivity(
			@PathVariable(value = "id") String id,
			HttpServletRequest request, ModelMap map) {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		if (user == null) {
			return "login";
		}
		ActivityEntity activity = this.getActivityEntityDAO().get(id);
		map.put("activity",activity);
		return "manager/activity_update";
	}
	
	/**
	 * 添加商家
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Object add(
			@RequestParam(value = "name") String name,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "userName") String userName,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "dividend") Integer dividend,
			@RequestParam(value = "desc", required = false) String desc,
			@RequestParam(value = "overTime", required = false) String overTime,
			@RequestParam(value = "picUrl", required = false) String picUrl,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "url", required = false) String url,
			@RequestParam(value = "muban", required = false) String muban,
			@RequestParam(value = "hx", required = false) String hx_password,
			HttpServletRequest request, ModelMap map) {
		Session session = sessionFactory.getCurrentSession();
		Transaction transaction = session.getTransaction();
		try {
			transaction.begin();
			ActivityEntity entity = new ActivityEntity();
			UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
			TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
			int num = this.getActivityEntityDAO().count(HDaoUtils.eq("terpoint", ter).toCondition());
			if (ter.getActivityNum() - num <= 0) {
				map.put("flag", false);
				map.put("msg", "您可以添加的正式商家数量达到上限，请联系管理员！");
				return map;
			}
			UserEntity user1 = new UserEntity();
			user1.setUsername(userName);
			user1.setPassword(password);
			user1.setPhone(phone);
			user1.setStatus(1);
			user1.setAddTime(new Date());
			user1.setRoleName(this.getRoleEntityDAO().get("3"));
			this.getUserEntityDAO().create(user1);
			entity.setDividend(dividend);
			entity.setName(name);
			entity.setDesc(desc);
			entity.setCategoryt(0);
			entity.setUser(user1);
			if (overTime != null) {
				entity.setOverTime(DateUtil2.parseDateTime(overTime));
			}
			entity.setTerpoint(ter);
			//给新增的商家设置商家角色
			permissionService.setRole(user1.getId(), new String[]{"3"});
			this.getActivityEntityDAO().create(entity);
			transaction.commit();

			map.put("flag", true);
			map.put("msg", "添加成功");
		} catch (Exception e) {
			transaction.rollback();
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg", "添加失败，账号已被其他代理创建");
		}
		return map;
	}

	/**
	 * 修改
	 */
	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Object update(
			@PathVariable(value = "id") String id,
			@RequestParam(value = "name") String name,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "desc", required = false) String desc,
			@RequestParam(value = "dividend") Integer dividend,
			@RequestParam(value = "overTime", required = false) String overTime,
			HttpServletRequest request, ModelMap map) {
		Session session = sessionFactory.getCurrentSession();
		Transaction transaction = session.getTransaction();
		try {
			transaction.begin();
			ActivityEntity entity = this.getActivityEntityDAO().get(id);

			UserEntity user1 = entity.getUser();
			user1.setPhone(phone);
			this.getUserEntityDAO().update(user1);
			entity.setName(name);
			entity.setDesc(desc);
			entity.setDividend(dividend);
			if (overTime != null) {
				entity.setOverTime(DateUtil2.parseDateTime(overTime));
			}
			this.getActivityEntityDAO().update(entity);
			transaction.commit();
			map.put("flag", true);
			map.put("msg", "修改成功");
		} catch (Exception e) {
			transaction.rollback();
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg", "修改失败!");
		}
		return map;
	}

	/**
	 * 冻结
	 */
	@RequestMapping(value = "/frozen/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Object update(
			@PathVariable(value = "id") String id,
			HttpServletRequest request, ModelMap map) {
		Session session = sessionFactory.getCurrentSession();
		Transaction transaction = session.getTransaction();
		try {
			transaction.begin();
			ActivityEntity entity = this.getActivityEntityDAO().get(id);
			entity.setStatus(1);
			this.getActivityEntityDAO().update(entity);
			transaction.commit();
			map.put("flag", true);
			map.put("msg", "操作成功!");
		} catch (Exception e) {
			transaction.rollback();
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg", "操作失败!");
		}
		return map;
	}
	@RequestMapping(value = "/thaw/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Object thaw(
			@PathVariable(value = "id") String id,
			HttpServletRequest request, ModelMap map) {
		Session session = sessionFactory.getCurrentSession();
		Transaction transaction = session.getTransaction();
		try {
			transaction.begin();
			ActivityEntity entity = this.getActivityEntityDAO().get(id);
			entity.setStatus(0);
			this.getActivityEntityDAO().update(entity);
			transaction.commit();
			map.put("flag", true);
			map.put("msg", "操作成功!");
		} catch (Exception e) {
			transaction.rollback();
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg", "操作失败!");
		}
		return map;
	}

}
