package com.keji09.erp.bean.red;

import java.util.Date;

/**
 * @author zuozhi
 * @since 2020-02-24
 */
public class RedMemberBean {
	/**
	 * Id
	 */
	private String Id;
	/**
	 * openId
	 */
	private String openId;
	/**
	 * shotId
	 */
	private String shotId;
	/**
	 * 名称
	 */
	private String nick;
	/**
	 * 真实姓名
	 */
	private String realName;
	/**
	 * 创建时间
	 */
	private Date addTime;
	/**
	 * 账号（手机号）
	 */
	private String username;
	/**
	 * 性别（1:男，2:女）
	 */
	private Integer sex;
	/**
	 * 头像
	 */
	private String picUrl;
	/**
	 * 地区
	 */
	private String city;
	/**
	 * 上级商家Id
	 */
	//TODO
	private String redActId = "40285581707b4e2701707b4f02c40002";
	
	
	public String getId() {
		return Id;
	}
	
	public void setId(String id) {
		Id = id;
	}
	
	public String getOpenId() {
		return openId;
	}
	
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	
	public String getShotId() {
		return shotId;
	}
	
	public void setShotId(String shotId) {
		this.shotId = shotId;
	}
	
	public String getNick() {
		return nick;
	}
	
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	public String getRealName() {
		return realName;
	}
	
	public void setRealName(String realName) {
		this.realName = realName;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public Integer getSex() {
		return sex;
	}
	
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	
	public String getPicUrl() {
		return picUrl;
	}
	
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getRedActId() {
		return redActId;
	}
	
	public void setRedActId(String redActId) {
		this.redActId = redActId;
	}
}
