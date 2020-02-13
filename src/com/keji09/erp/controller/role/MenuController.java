package com.keji09.erp.controller.role;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji09.erp.bean.MenBean;
import com.keji09.erp.bean.MenuBean;
import com.keji09.erp.model.role.MenuEntity;
import com.keji09.erp.model.role.RoleEntity;
import com.keji09.erp.model.role.RoleMenuEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.role.UserMenuEntity;
import com.keji09.erp.model.role.UserRoleEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.HDaoUtils;

/**
 * 菜单控制器
 */
@Controller
@RequestMapping("/menu")
public class MenuController extends XDAOSupport {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	/**
	 * 获取某个节点下的子节点，如果没有传父节点则取根节点
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET)
	@ResponseBody
	public List<MenBean> getRootNode(HttpServletRequest request,HttpServletResponse response,
			@RequestParam(value = "parentId",required = false)String parentId){
		List<MenuEntity> list = null;
		List<MenBean> menu = new ArrayList<MenBean>();
		if(parentId != null){
			list = this.getMenuEntityDAO().list(HDaoUtils.eq("parent",parentId).toCondition(),Order.asc("order"));
		}else{
			list = this.getMenuEntityDAO().list(HDaoUtils.isEmpty("parent").toCondition(),Order.asc("order"));
		}
		for(Iterator<MenuEntity> it = list.iterator();it.hasNext();){
			MenuEntity m = it.next();
			MenBean mb = new MenBean(m);
			Boolean isParent = this.getMenuEntityDAO().exist(HDaoUtils.eq("parent", m.getId()).toCondition());
			mb.setIsParent(isParent);
			menu.add(mb);
		}
		return menu;
	}

	/**
	 * 去新增，如果传父节点则添加子节点
	 */
	@RequestMapping(value="toadd",method=RequestMethod.GET)
	public String toAdd(@RequestParam(value="parentId",required=false) String parentId,ModelMap map,HttpServletRequest request){
		if(parentId!=null&&!"".equals(parentId)){
			MenuEntity parent=this.getMenuEntityDAO().get(parentId);
			if(parent!=null){
				map.put("parent",parent);
			}
		}
		return "manager/modular_add";
	}
	/**
	 * 添加菜单
	 */
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(
			@RequestParam(value="name",required=false) String name,
			@RequestParam(value="code",required=false) String code,
			@RequestParam(value="type",required=false) String type,
			@RequestParam(value="parent",required=false) String parent,
			@RequestParam(value="leftCss",required =false) String leftCss,
			@RequestParam(value="rightCss",required =false) String rightCss,
			@RequestParam(value="order",required=false) Integer order,
			@RequestParam(value="url",required=false) String url,HttpServletRequest request,ModelMap map){
		String msg = "添加失败";
		boolean flag = false;
		MenuEntity modular  = new MenuEntity();
		modular.setName(name);
		modular.setType(type);
		modular.setCode(code);
		if(parent!=null&&!"".equals(parent)){
			modular.setParent(parent);
		}else{
			modular.setParent(null);
		}
		modular.setLeftCss(leftCss);
		modular.setRightCss(rightCss);
		modular.setUrl(url);
		modular.setAddTime(new Date());
		modular.setOrder(order);
		this.getMenuEntityDAO().create(modular);
		msg = "添加成功";
		flag = true;
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}
	
	/**
	 *	获取菜单信息，用于修改
	 * @param request
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> data_list(HttpServletRequest request,@PathVariable(value = "id")String id){
		Map<String,Object> map = new HashMap<String,Object>();
		String msg = "";
		boolean flag = false;
		MenuEntity MenuEntity = this.getMenuEntityDAO().get(id);
		MenuBean bean = new MenuBean(MenuEntity);
		if(MenuEntity.getParent()!=null){
			MenuEntity parent=this.getMenuEntityDAO().get(MenuEntity.getParent());
			if(parent!=null){
				bean.setParentName(parent.getName());
			}
		}
		map.put("entity", bean);
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}
	/**
	 * 修改菜单
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> update(
			@PathVariable(value="id") String id,
			@RequestParam(value="name",required =false) String name,
			@RequestParam(value="code",required =false) String code,
			@RequestParam(value="type",required =false) String type,
			@RequestParam(value="parentId",required =false) String parent,
			@RequestParam(value="leftCss",required =false) String leftCss,
			@RequestParam(value="rightCss",required =false) String rightCss,
			@RequestParam(value="order",required =false) Integer order,
			@RequestParam(value="url",required =false) String url,HttpServletRequest request,ModelMap map){
		MenuEntity modular = this.getMenuEntityDAO().get(id);
		String msg="修改失败";
		boolean flag = false;
		if(modular!=null){
			modular.setName(name);
			modular.setType(type);
			modular.setCode(code);
			if(parent!=null&&!"".equals(parent)){
				modular.setParent(parent);
			}else{
				modular.setParent(null);
			}
			modular.setUrl(url);
			modular.setOrder(order);
			modular.setLeftCss(leftCss);
			modular.setRightCss(rightCss);
			this.getMenuEntityDAO().update(modular);
			msg="修改成功";
			flag = true;
		}
		map.put("item", modular);
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}

	/**
	 * 删除节点
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value="/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String,Object> delete_article(@PathVariable(value="id") String id,HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		String msg = "";
		boolean flag = false;
		MenuEntity MenuEntity = this.getMenuEntityDAO().get(id);
		Boolean f=this.getUserMenuEntityDAO().exist(HDaoUtils.eq("menu.id", MenuEntity.getId()).toCondition());
		if(f){
			map.put("msg", "有用户绑定该菜单！");
			return map;
		}
		if(MenuEntity != null){
			this.getMenuEntityDAO().remove(MenuEntity);
			flag = true;
		}else{
			msg = "菜单不存在,刷新重试";
		}
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}

	/**
	 * 修改排列顺序
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="update_order/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String,Object> update_order(HttpServletRequest request,HttpServletResponse response,@PathVariable(value = "id")String id,@RequestParam(value = "orderVal")Integer orderVal){
		Map<String,Object> map = new HashMap<String,Object>();
		boolean flag = false;
		String msg = "修改排序失败!";
		MenuEntity MenuEntity = this.getMenuEntityDAO().get(id);
		if(MenuEntity != null){
			MenuEntity.setOrder(Integer.valueOf(orderVal));
			this.getMenuEntityDAO().update(MenuEntity);
			msg = "修改排序成功!";
			flag = true;
		}
		map.put("flag", flag);
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 前往设置权限界面
	 * @return
	 */
	@RequestMapping(value="toMenu",method=RequestMethod.GET)
	public String toSetMenu(@RequestParam(value="userId",required=false)String userId,
			@RequestParam(value="type",required=false)String type,
			@RequestParam(value="roleId",required=false)String roleId,ModelMap map){
		if(userId!=null&&!"".equals(userId)){
			map.put("userId", userId);
		}
		if(roleId!=null&&!"".equals(roleId)){
			map.put("roleId", roleId);
		}
		if(type!=null&&!"".equals(type)){
			map.put("type", type);
		}
		return "manager/modular_permission";
	}
	
	/**
	 * 批量设置权限
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="plsetMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> plSetMenu(@RequestParam(value="userId",required=false)String userId,
			@RequestParam(value="roleId",required=false)String roleId,
			@RequestParam(value="menuIds[]",required=false)String[] menuIds,
			@RequestParam(value="menuIds_r[]",required=false)String[] menuIds_r
			){
		Map<String,Object> map = new HashMap<String,Object>();
		Boolean b=false;
		if(roleId!=null&&!"".equals(roleId)){
			RoleEntity role=this.getRoleEntityDAO().get(roleId);
			if(role==null){
				map.put("flag", false);
				map.put("msg", "角色不存在");
				return map;
			}
			//查询用户——角色关系
			List<UserRoleEntity> urlist = this.getUserRoleEntityDAO().list(HDaoUtils.eq("role",role).toCondition());
			//新增
			if(menuIds!=null){
				//数组转集合--新增菜单id
				List<String> add = Arrays.asList(menuIds);
				//插入
				final List<Object[]> insertParams = new ArrayList<Object[]>();
				//绑定新的角色操作关系
				for(String mid:add){
					MenuEntity menu = this.getMenuEntityDAO().get(mid);
					RoleMenuEntity rem=new RoleMenuEntity();
					rem.setRole(roleId);
					rem.setMenu(menu.getId());
					rem.setCode(menu.getCode());
					this.getRoleMenuEntityDAO().remove(rem);
					this.getRoleMenuEntityDAO().create(rem);
					//用户菜单新增
					for(UserRoleEntity userRoleEntity : urlist){
						boolean f = this.getUserMenuEntityDAO().exist(HDaoUtils.eq("menu.id",menu.getId()).andEq("user", userRoleEntity.getUser()).toCondition());
						if(f){
							continue;
						}
						Object[] attr = new Object[4];
						attr[0] = UUID.randomUUID().toString().replace("-", "");
						attr[1] = userRoleEntity.getUser();
						attr[2] = menu.getCode();
						attr[3] = menu.getId();
						insertParams.add(attr);
					}
				}
				//批量插入修改后的调用方式
				Long start = new Date().getTime();
				String sql = "INSERT INTO  sys_user_menu (id, _user, _code, _menu) VALUES(?,?,?,?)";
				jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
					public void setValues(PreparedStatement ps, int i)
							throws SQLException {
						Object[] args = insertParams.get(i);
						ps.setString(1, (String) args[0]);
						ps.setString(2, (String) args[1]);
						ps.setString(3, (String) args[2]);
						ps.setString(4, (String) args[3]);
					}
					public int getBatchSize() {
						return insertParams.size();
					}
				});
				Long end = new Date().getTime();
				System.out.println("插入数据耗费时间：---------" + (end - start) / 1000 + "秒");
			}
			//删除
			if(menuIds_r!=null){
				//待删除菜单id
				List<String> remove = Arrays.asList(menuIds_r);
				for(String mid:remove){
					List<RoleMenuEntity> rmList = this.getRoleMenuEntityDAO().list(HDaoUtils.eq("role",roleId).andEq("menu",mid).toCondition());
					if(rmList==null||rmList.size()==0){
						continue;
					}
					RoleMenuEntity rm = rmList.get(0);
					this.getRoleMenuEntityDAO().remove(rm);
					for(UserRoleEntity userRoleEntity : urlist){
						String userID = userRoleEntity.getUser();
						List<UserMenuEntity> umList = this.getUserMenuEntityDAO().list(HDaoUtils.eq("user",userID).andEq("menu.id", mid).toCondition());
						if(umList==null||umList.size()==0){
							continue;
						}
						UserMenuEntity um = umList.get(0);
						//remove实体，删除所有
						this.getUserMenuEntityDAO().remove(um);
					}
				}
			}
			b=true;
		}
		if(b){
			map.put("flag", true);
			map.put("msg", "绑定成功");
		}else{
			map.put("flag", false);
			map.put("msg", "绑定失败，没有绑定源");
		}
		return map;
	}
	/**
	 * 给用户或者角色设置权限
	 * @return
	 */
	@RequestMapping(value="setMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> setMenu(@RequestParam(value="userId",required=false)String userId,
			@RequestParam(value="roleId",required=false)String roleId,
			@RequestParam(value="menuIds[]")String[] menuIds){
		Map<String,Object> map = new HashMap<String,Object>();
		Boolean b=false;
		if(userId!=null&&!"".equals(userId)){
			UserEntity user=this.getUserEntityDAO().get(userId);
			if(user==null){
				map.put("flag", false);
				map.put("msg", "用户不存在");
				return map;
			}
			//先删除用户操作
			List<UserMenuEntity> list=this.getUserMenuEntityDAO().list(HDaoUtils.eq("user", userId).toCondition());
			for(UserMenuEntity ume:list){
				this.getUserMenuEntityDAO().remove(ume);
			}
			//绑定新的用户操作关系
			for(String menuId:menuIds){
				MenuEntity menu=this.getMenuEntityDAO().get(menuId);
				if(menu!=null){
					UserMenuEntity uem=new UserMenuEntity();
					uem.setUser(userId);
					uem.setMenu(menu);
					uem.setCode(menu.getCode());
					this.getUserMenuEntityDAO().create(uem);
				}
			}
			b=true;
		}
		if(roleId!=null&&!"".equals(roleId)){
			RoleEntity role=this.getRoleEntityDAO().get(roleId);
			if(role==null){
				map.put("flag", false);
				map.put("msg", "角色不存在");
				return map;
			}
			//先删除角色操作
			List<RoleMenuEntity> list=this.getRoleMenuEntityDAO().list(HDaoUtils.eq("role", roleId).toCondition());
			for(RoleMenuEntity rme:list){
				this.getRoleMenuEntityDAO().remove(rme);
			}
			//绑定新的角色操作关系
			for(String menuId:menuIds){
				MenuEntity menu=this.getMenuEntityDAO().get(menuId);
				if(menu!=null){
					RoleMenuEntity rem=new RoleMenuEntity();
					rem.setRole(roleId);
					rem.setMenu(menu.getId());
					rem.setCode(rem.getCode());
					this.getRoleMenuEntityDAO().create(rem);
				}
			}
			b=true;
		}
		if(b){
			map.put("flag", true);
			map.put("msg", "绑定成功");
		}else{
			map.put("flag", false);
			map.put("msg", "绑定失败，没有绑定源");
		}
		return map;
	}
	
	/**
	 * 获取用户或者角色下的所有操作
	 * @return
	 */
	@RequestMapping(value="getMenu",method=RequestMethod.GET)
	@ResponseBody
	public List<MenBean> getMenu(@RequestParam(value="userId",required=false)String userId,
			@RequestParam(value="roleId",required=false)String roleId){
		List<MenBean> list=new ArrayList<MenBean>();
		if(userId!=null&&!"".equals(userId)){
			List<UserMenuEntity> menus=this.getUserMenuEntityDAO().list(HDaoUtils.eq("user", userId).toCondition());
			for(UserMenuEntity uem:menus){
				MenBean mb = new MenBean(uem.getMenu());
				Boolean isParent = this.getMenuEntityDAO().exist(HDaoUtils.eq("parent", uem.getMenu().getId()).toCondition());
				mb.setIsParent(isParent);
				list.add(mb);
			}
			return list;
		}
		if(roleId!=null&&!"".equals(roleId)){
			List<RoleMenuEntity> menus=this.getRoleMenuEntityDAO().list(HDaoUtils.eq("role", roleId).toCondition());
			for(RoleMenuEntity rem:menus){
				MenuEntity me=this.getMenuEntityDAO().get(rem.getMenu());
				MenBean mb = new MenBean(me);
				Boolean isParent = this.getMenuEntityDAO().exist(HDaoUtils.eq("parent", me.getId()).toCondition());
				mb.setIsParent(isParent);
				list.add(mb);
			}
			return list;
		}
		return list;
	}

	/**
	 * 添加上级菜单
	 */
	@RequestMapping(value="content",method=RequestMethod.GET)
	public  String findna(
			@RequestParam(value = "pageIndex", defaultValue = "1")Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20")Integer pageSize,
			HttpServletRequest request,ModelMap map){
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		if(user==null){
			return "login";
		}
		return "manager/modular_father";
	}
}