package com.keji09.erp.bean;

import com.keji09.erp.model.ActivityEntity;

import java.util.Date;

public class ActivityBean {
	private String id;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 图片地址
	 */
	private String picUrl;
	/**
	 * 联系方式
	 */
	private String phone;
	/**
	 * 账号
	 */
	private String userName;
	/**
	 * 状态（0.正常; -1.关闭; 13.已删除）
	 */
	private Integer status = 0;
	/**
	 * 余额
	 */
	private Integer money = 0;
	/**
	 * 投放金额
	 */
	private Float toufangMoney = 0.0f;
	
	/**
	 * 消耗金额
	 */
	private Float xiaohaoMoney = 0.0f;
	
	/**
	 * 余额
	 */
	private Float restMoney = 0.0f;
	
	private Boolean isOverTime;
	
	private ActivityEntity activity;
	
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public Float getXiaohaoMoney() {
		return xiaohaoMoney;
	}
	
	public void setXiaohaoMoney(Float xiaohaoMoney) {
		this.xiaohaoMoney = xiaohaoMoney;
	}
	
	public Float getRestMoney() {
		return restMoney;
	}
	
	public void setRestMoney(Float restMoney) {
		this.restMoney = restMoney;
	}
	
	public String getName() {
		return activity.getName();
	}
	
	public String getPhone() {
		return activity.getUser().getPhone();
	}
	
	public String getUserName() {
		return activity.getUser().getUsername();
	}
	
	public Integer getStatus() {
		return activity.getStatus();
	}
	
	public Integer getMoney() {
		return activity.getMoney();
	}
	
	public ActivityEntity getActivity() {
		return activity;
	}
	
	public ActivityBean(ActivityEntity activity) {
		this.activity = activity;
		if (activity.getOverTime() != null) {
			if (activity.getOverTime().getTime() - new Date().getTime() < 0) {
				isOverTime = true;
			} else {
				isOverTime = false;
			}
		} else {
			isOverTime = false;
		}
	}
	
	public String getPicUrl() {
		return activity.getUser().getPicUrl();
	}
	
	public String getId() {
		return activity.getId();
	}
	
	public Float getToufangMoney() {
		return toufangMoney;
	}
	
	public void setToufangMoney(Float toufangMoney) {
		this.toufangMoney = toufangMoney;
	}
	
	public Boolean getIsOverTime() {
		return isOverTime;
	}
	
	
}
