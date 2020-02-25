package com.keji09.erp.bean.red;

import java.util.Date;

/**
 * @author zuozhi
 * @since 2020-02-24
 */
public class RedActivityBean {
	/**
	 * Id
	 */
	private String Id;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 手机号
	 */
	private String phone;
	/**
	 * 创建时间
	 */
	private Date addTime;
	/**
	 * 到期时间
	 */
	private Date overTime;
	/**
	 * 余额
	 */
	private Float money;
	/**
	 * 冻结金额
	 */
	private Float frozenMoney;
	/**
	 * 账号
	 */
	private String username;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * QQ
	 */
	private String qq;
	/**
	 * 微信
	 */
	private String weixin;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 地址
	 */
	private String address;
	/**
	 * 头像
	 */
	private String picUrl;
	/**
	 * 真实姓名
	 */
	private String realName;
	/**
	 * 红包派的代理Id
	 */
	private String redTerId;
	
	public String getId() {
		return Id;
	}
	
	public void setId(String id) {
		Id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public Date getOverTime() {
		return overTime;
	}
	
	public void setOverTime(Date overTime) {
		this.overTime = overTime;
	}
	
	public Float getMoney() {
		return money;
	}
	
	public void setMoney(Float money) {
		this.money = money;
	}
	
	public Float getFrozenMoney() {
		return frozenMoney;
	}
	
	public void setFrozenMoney(Float frozenMoney) {
		this.frozenMoney = frozenMoney;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getQq() {
		return qq;
	}
	
	public void setQq(String qq) {
		this.qq = qq;
	}
	
	public String getWeixin() {
		return weixin;
	}
	
	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getPicUrl() {
		return picUrl;
	}
	
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
	public String getRealName() {
		return realName;
	}
	
	public void setRealName(String realName) {
		this.realName = realName;
	}
	
	public String getRedTerId() {
		return redTerId;
	}
	
	public void setRedTerId(String redTerId) {
		this.redTerId = redTerId;
	}
}
