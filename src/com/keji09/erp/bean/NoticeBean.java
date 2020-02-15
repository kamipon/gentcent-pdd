package com.keji09.erp.bean;

import com.keji09.model.NoticeEntity;

import java.util.Date;

public class NoticeBean {
	
	public NoticeBean(NoticeEntity entity) {
		this.id = entity.getId();
		this.title = entity.getTitle();
		this.url = entity.getUrl();
		this.addTime = entity.getAddTime();
	}
	
	private String id;
	
	private String title;
	
	private String url;
	
	private Date addTime;
	
	private Boolean isRead = false;
	
	public String getTitle() {
		return title;
	}
	
	public String getUrl() {
		return url;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public Boolean getIsRead() {
		return isRead;
	}
	
	public void setIsRead(Boolean isRead) {
		this.isRead = isRead;
	}
	
	public String getId() {
		return id;
	}
}
