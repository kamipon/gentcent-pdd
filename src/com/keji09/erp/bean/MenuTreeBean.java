package com.keji09.erp.bean;

import com.keji09.erp.model.role.MenuEntity;
import com.keji09.erp.model.role.UserMenuEntity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class MenuTreeBean extends BaseTree {
	
	/**
	 * 类型
	 */
	private String type;
	
	/**
	 * 地址
	 */
	private String url;
	
	/**
	 * 是否显示
	 */
	private Boolean display;
	
	/**
	 * 左css
	 */
	private String leftCss;
	
	/**
	 * 右css
	 */
	private String rightCss;
	
	/**
	 * 新增时间
	 */
	private Date addTime;
	
	public Boolean getDisplay() {
		return display;
	}
	
	public void setDisplay(Boolean display) {
		this.display = display;
	}
	
	public String getLeftCss() {
		return leftCss;
	}
	
	public void setLeftCss(String leftCss) {
		this.leftCss = leftCss;
	}
	
	public String getRightCss() {
		return rightCss;
	}
	
	public void setRightCss(String rightCss) {
		this.rightCss = rightCss;
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
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public static List<MenuTreeBean> transTree(List<UserMenuEntity> list) {
		List<MenuTreeBean> result = new ArrayList<MenuTreeBean>();
		
		for (int i = 0; i < list.size(); i++) {
			MenuEntity me = list.get(i).getMenu();
			
			MenuTreeBean tb = new MenuTreeBean();
			tb.setId(me.getId());
			tb.setParentId(me.getParent());
			tb.setName(me.getName());
			
			tb.setType(me.getType());
			tb.setUrl(me.getUrl());
			tb.setOrder(me.getOrder());
			tb.setAddTime(me.getAddTime());
			tb.setLeftCss(me.getLeftCss());
			tb.setRightCss(me.getRightCss());
			tb.setDisplay(me.getDisplay());
			
			result.add(tb);
		}
		
		return result;
	}
	
}
