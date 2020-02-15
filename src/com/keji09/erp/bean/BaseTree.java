package com.keji09.erp.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * Tree基本模型
 */
public class BaseTree {
	/**
	 * 对象id
	 */
	private String id;
	/**
	 * 父id
	 */
	private String parentId;
	/**
	 * 对象名称
	 */
	private String name;
	/**
	 * 排序
	 */
	private Integer order = 1000;
	/**
	 * 是否是父节点
	 */
	private Boolean isParent;
	
	private List<BaseTree> children = new ArrayList<BaseTree>();
	
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
	
	public List<BaseTree> getChildren() {
		return children;
	}
	
	public void setChildren(List<BaseTree> children) {
		this.children = children;
	}
	
	public Integer getOrder() {
		return order;
	}
	
	public void setOrder(Integer order) {
		this.order = order;
	}
	
	
}
