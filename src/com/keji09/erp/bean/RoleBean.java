package com.keji09.erp.bean;

import com.keji09.erp.model.role.RoleEntity;

public class RoleBean {
	
	private String id;
	
	private String roleName;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getRoleName() {
		return roleName;
	}
	
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	public RoleBean(RoleEntity role) {
		this.id = role.getId();
		this.roleName = role.getRoleName();
	}
}
