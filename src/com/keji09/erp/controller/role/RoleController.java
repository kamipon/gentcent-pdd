package com.keji09.erp.controller.role;

import com.keji09.erp.bean.PageBean;
import com.keji09.erp.bean.RoleBean;
import com.keji09.erp.controller.BaseController;
import com.keji09.erp.model.role.RoleEntity;
import com.keji09.erp.service.PermissionService;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.HibernateDAO;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Criterion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色控制器
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {
	
	@Autowired
	PermissionService permissionService;
	
	@SuppressWarnings("unchecked")
	@Override
	public <T> HibernateDAO<T> getHibernateDAO() {
		return (HibernateDAO<T>) getRoleEntityDAO();
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String query(RoleEntity bean, PageBean page, ModelMap map, HttpServletRequest req, @RequestParam(value = "roleName", required = false) String roleName) {
		//查询条件
		Exp<Criterion> exp = HDaoUtils.notEmpty("id");
		if (StringUtils.isNotEmpty(bean.getId())) {
			exp.andEq("id", bean.getId());
		}
		if (roleName != null && !"".equals(roleName)) {
			exp.andLike("roleName", roleName);
		}
		//设置分页
		queryPage(page, map, exp);
		map.put("roleName", roleName);
		return "manager/role_list";
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String queryById(@PathVariable(value = "id") String id, ModelMap map, HttpServletRequest req, HttpServletResponse resp) {
		queryById(id, map);
		return "manager/role_update";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(RoleEntity bean, ModelMap map, HttpServletRequest req, HttpServletResponse resp) {
		bean.setType("custom");
		add(bean, map);
		return map;
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> update(@PathVariable(value = "id") String id, RoleEntity bean, ModelMap map, HttpServletRequest req, HttpServletResponse resp) {
		RoleEntity re = this.getRoleEntityDAO().get(id);
		re.setRoleName(bean.getRoleName());
		update(re, map);
		return map;
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> delete(@PathVariable(value = "id") String id, ModelMap map, HttpServletRequest req, HttpServletResponse resp) {
		delete(id, map);
		return map;
	}
	
	@RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteByIds(String ids, ModelMap map, HttpServletRequest req, HttpServletResponse resp) {
		deleteByIds(ids, map);
		return map;
	}
	
	/**
	 * 前往选择(设置)角色页面,为用户设置角色
	 *
	 * @return
	 */
	@RequestMapping(value = "toCheck", method = RequestMethod.GET)
	public String checkRole(@RequestParam(value = "userId", required = false) String userId, ModelMap map) {
		List<RoleEntity> result = this.getRoleEntityDAO().listAll();
		map.put("list", result);
		map.put("userId", userId);
		return "manager/role_check";
	}
	
	/**
	 * 获取已绑定的角色
	 *
	 * @return
	 */
	@RequestMapping(value = "getBind", method = RequestMethod.GET)
	@ResponseBody
	public List<RoleEntity> getBindRole(@RequestParam(value = "userId", required = false) String userId, ModelMap map) {
		List<RoleEntity> result = permissionService.getBindRole(userId);
		return result;
	}
	
	/**
	 * 给用户绑定角色
	 *
	 * @return
	 */
	@RequestMapping(value = "setBind", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> setBindRole(@RequestParam(value = "userId", required = false) String userId,
										   @RequestParam(value = "roleId[]", required = false) String[] roleId, ModelMap map) {
		Map<String, Object> m = new HashMap<String, Object>();
		if (permissionService.setRole(userId, roleId)) {
			m.put("flag", true);
			m.put("msg", "绑定成功");
		} else {
			m.put("flag", false);
			m.put("msg", "绑定失败，用户不存在");
		}
		return m;
	}
	
	/**
	 * 角色列表
	 */
	@RequestMapping(value = "list")
	@ResponseBody
	public List<RoleBean> bean(HttpServletRequest request) throws ParseException {
		List<RoleEntity> role = this.getRoleEntityDAO().listAll();
		List<RoleBean> rolebean = new ArrayList<RoleBean>();
		for (int i = 0; i < role.size(); i++) {
			RoleEntity r = role.get(i);
			RoleBean rbean = new RoleBean(r);
			rolebean.add(rbean);
		}
		return rolebean;
	}
}