package com.keji09.erp.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.keji09.erp.model.role.MenuEntity;
import com.keji09.erp.model.role.RoleEntity;
import com.keji09.erp.model.role.RoleMenuEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.role.UserMenuEntity;
import com.keji09.erp.model.role.UserRoleEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.HDaoUtils;

/**
 * 权限管理类
 * 
 * @author Administrator
 * 
 */
@Service
public class PermissionService extends XDAOSupport {
	
	/**
	 * 判断用户是否拥有传入角色
	 * @param user
	 * @param roleName
	 * @return
	 */
	public Boolean hasPermission(UserEntity user,String roleName){
		RoleEntity role=this.getRoleEntityDAO().findUnique(HDaoUtils.eq("roleName", roleName).toCondition());
		Boolean bool=this.getUserRoleEntityDAO().exist(HDaoUtils.eq("user", user.getId()).andEq("role", role.getId()).toCondition());
		return bool;
	}
	
	/**
	 * 修复角色菜单
	 */
	public Boolean repairUserRole() {
		
		List<UserRoleEntity> list = getUserRoleEntityDAO().listAll();
		
		for(int i = 0;i<list.size();i++) {
			UserRoleEntity ure = list.get(i);
			setRole(ure.getUser(),new String[]{ure.getRole().getId()});
		}
		
		return true;
	}
	
	/**
	 * 为用户设置角色
	 * @param userId 用户id
	 * @param roleId 角色id数组，如果添加新角色并且保留原来角色，需要将所有角色id以数组形式传过来
	 * @return 
	 */
	public Boolean setRole(String userId,String[] roleId){
		UserEntity ue=this.getUserEntityDAO().get(userId);
		if(ue!=null){
			//先将用户的原有角色删除
			List<UserRoleEntity> ures= this.getUserRoleEntityDAO().list(HDaoUtils.eq("user", userId).toCondition());
			for(UserRoleEntity ure:ures){
				this.getUserRoleEntityDAO().remove(ure);
				//获取角色下的所有操作,将用户对应的操作删除
				List<RoleMenuEntity> roleMenu=this.getRoleMenuEntityDAO().list(HDaoUtils.eq("role", ure.getRole().getId()).toCondition());
				for(RoleMenuEntity rme:roleMenu){
					List<UserMenuEntity> umes=this.getUserMenuEntityDAO().list(HDaoUtils.eq("user", ue.getId()).andEq("menu.id", rme.getMenu()).toCondition());
					for(UserMenuEntity ume:umes){
						this.getUserMenuEntityDAO().remove(ume);
					}
				}
			}
			Map<String,MenuEntity> map=new HashMap<String,MenuEntity>();
			//添加新的角色
			for(String role:roleId){
				RoleEntity r=this.getRoleEntityDAO().get(role);
				UserRoleEntity ur=new UserRoleEntity();
				ur.setUser(ue.getId());
				ur.setRole(r);
				this.getUserRoleEntityDAO().create(ur);
				//获取角色下的所有操作
				List<RoleMenuEntity> roleMenu=this.getRoleMenuEntityDAO().list(HDaoUtils.eq("role", r.getId()).toCondition());
				List<MenuEntity> menus=new ArrayList<MenuEntity>();
				for(RoleMenuEntity rme:roleMenu){
					MenuEntity menu=this.getMenuEntityDAO().get(rme.getMenu());
					rme.setCode(menu.getCode());
					getRoleMenuEntityDAO().update(rme);
					menus.add(menu);
				}
				for(MenuEntity me:menus){
					map.put(me.getId(), me);
				}
			}
			//给用户绑定操作
			for (Map.Entry<String, MenuEntity> entry:map.entrySet()) {
				UserMenuEntity ume=new UserMenuEntity();
				ume.setUser(ue.getId());
				ume.setMenu(entry.getValue());
				ume.setCode(entry.getValue().getCode());
				this.getUserMenuEntityDAO().create(ume);
			}
		}else{
			return false;
		}
		return true;
	}

	/**
	 * 获取用户绑定的角色
	 * @param userId
	 * @return
	 */
	public List<RoleEntity> getBindRole(String userId){
		List<RoleEntity> result=new ArrayList<RoleEntity>();
		List<UserRoleEntity> ures= this.getUserRoleEntityDAO().list(HDaoUtils.eq("user", userId).toCondition());
		for(UserRoleEntity ure:ures){
			result.add(ure.getRole());
		}
		return result;
	}
	
}
