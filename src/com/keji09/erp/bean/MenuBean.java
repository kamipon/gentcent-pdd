package com.keji09.erp.bean;

import com.keji09.erp.model.role.MenuEntity;


public class MenuBean {
	
	// id
	private String id;
	// 父类目
	private String parent;
	// 父类目名称
	private String parentName = "";
	//模块显示名
	private String name;
	//类型
	private String type;
	//模块连接
	private String url;
	//模块排序
	private Integer order;
	
	private String leftCss;
	
	private String rightCss;
	
	public MenuBean(MenuEntity entity) {
		super();
		this.id = entity.getId();
		this.parent = entity.getParent();
		this.name = entity.getName();
		this.type = entity.getType();
		this.url = entity.getUrl();
		this.order = entity.getOrder();
		this.leftCss = entity.getLeftCss();
		this.rightCss = entity.getRightCss();
	}
	
	public String getLeftCss() {
		return leftCss;
	}
	
	public String getRightCss() {
		return rightCss;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getParent() {
		return parent;
	}
	
	public void setParent(String parent) {
		this.parent = parent;
	}
	
	public String getParentName() {
		return parentName;
	}
	
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public Integer getOrder() {
		return order;
	}
	
	public void setOrder(Integer order) {
		this.order = order;
	}
}
