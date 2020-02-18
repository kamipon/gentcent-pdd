package com.keji09.erp.controller;


import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.role.UserRoleEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.service.PermissionService;
import com.keji09.erp.utils.DateUtil2;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * 代理商实体控制层
 *
 * @author Administrator
 */
@Controller
@RequestMapping(value = "/terPoint")
public class TerPointController extends XDAOSupport {
	
	@Autowired
	PermissionService permissionService;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	/**
	 * 初始化查询所有代理商
	 *
	 * @param map
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String findAll(@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
						  @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
						  @RequestParam(value = "name", required = false) String name,
						  @RequestParam(value = "username", required = false) String username,
						  HttpServletRequest request,
						  ModelMap map) {
		PaginationList<TerPointEntity> terPointList = null;
		UserEntity u = (UserEntity) request.getSession().getAttribute("loginUser");
		if ((StringUtils.isNotEmpty(name))) {
			if (StringUtils.isNotEmpty(username)) {
				UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("username", username).toCondition());
				terPointList = this.getTerPointEntityDAO().list(HDaoUtils.like("name", name).andEq("user", user).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			} else {
				terPointList = this.getTerPointEntityDAO().list(HDaoUtils.like("name", name).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			}
		} else {
			if (StringUtils.isNotEmpty(username)) {
				UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("username", username).toCondition());
				terPointList = this.getTerPointEntityDAO().list(HDaoUtils.eq("user", user).toCondition(), pageIndex, pageSize, Order.desc("addTime"));
			} else {
				terPointList = this.getTerPointEntityDAO().list(pageIndex, pageSize, Order.desc("addTime"));
			}
		}
		map.put("list", terPointList.getItems());
		map.put("total", terPointList.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(terPointList.getTotalCount() / pageSize.doubleValue()));
		return "manager/terpoint_list";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String toadd(HttpServletRequest request, ModelMap map) {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		UserRoleEntity ur = this.getUserRoleEntityDAO().findUnique(HDaoUtils.eq("user", user.getId()).toCondition());
		map.put("role", ur.getRole().getId());
		if (ur.getRole().getId().equals("2")) {
			TerPointEntity te = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
			map.put("terpoint", te);
		}
		return "manager/terpoint_add";
	}
	
	/**
	 * 添加代理商
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Object add(@RequestParam(value = "name") String name,
					  @RequestParam(value = "userName") String userName,
					  @RequestParam(value = "passWord") String passWord,
					  @RequestParam(value = "weixin", required = false) String weixin,
					  @RequestParam(value = "phone") String phone,
					  @RequestParam(value = "state", defaultValue = "0") String state,
					  @RequestParam(value = "overTime") String overTime,
					  @RequestParam(value = "activityNum") String activityNum, HttpServletRequest request, ModelMap map) {
		try {
			UserEntity user = new UserEntity();
			user.setUsername(userName);
			user.setPassword(passWord);
			user.setWeixin(weixin);
			user.setPhone(phone);
			user.setStatus(1);
			user.setAddTime(new Date());
			user.setRoleName(this.getRoleEntityDAO().get("2"));
			this.getUserEntityDAO().create(user);
			TerPointEntity entity = new TerPointEntity();
			entity.setName(name);
			entity.setStatus(Integer.valueOf(state));
			entity.setAddTime(new Date());
			entity.setUser(user);
			entity.setOverTime(DateUtil2.parseDateTime(overTime));
			entity.setActivityNum(Integer.parseInt(activityNum));
			this.getTerPointEntityDAO().create(entity);
			//给新增的代理商设置角色
			permissionService.setRole(user.getId(), new String[]{"2"});
			map.put("flag", true);
			map.put("msg", "添加成功");
		} catch (Exception e) {
			map.put("flag", false);
			map.put("msg", "添加失败");
		}
		return map;
	}
	
	
}
