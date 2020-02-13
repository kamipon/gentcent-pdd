package com.keji09.erp.bean;

import com.keji09.erp.model.role.MenuEntity;


public class MenBean {
	//id编号
	private String id;
	//父节点
	private String parentId;
	//栏目名称
	private String name;
	//是否是父节点
	private Boolean isParent = true;
	
	public MenBean(MenuEntity entity){
		this.id = entity.getId();
		this.parentId = entity.getParent();
		this.name = entity.getName();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public MenBean(String id, String parentId, String name, Boolean isParent) {
		super();
		this.id = id;
		this.parentId = parentId;
		this.name = name;
		this.isParent = isParent;
	}
	
}
