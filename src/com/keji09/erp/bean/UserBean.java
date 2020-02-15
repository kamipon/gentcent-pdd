package com.keji09.erp.bean;

import com.keji09.model.role.UserEntity;


public class UserBean {
	
	private UserEntity user;
	
	public UserBean(UserEntity user) {
		this.user = user;
	}
	
	public String getId() {
		return user.getId();
	}
	
	public String getRealName() {
		return user.getRealName();
	}
	
	public String getPicUrl() {
		return user.getPicUrl();
	}
}
