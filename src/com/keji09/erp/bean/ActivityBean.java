package com.keji09.erp.bean;

import java.util.Date;

import com.keji09.erp.model.ActivityEntity;

public class ActivityBean {
	private String id;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 图片地址
	 */
	private String url;
	/**
	 * 图片地址
	 */
	private String picUrl;
	/**
	 * 标题
	 */
	private String title;
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
	private Integer status=0;
	/**
	 * 余额
	 */
	private Float money=0.0f;
	/**
	 * 活动的红包数量
	 * 
	 */
	private Integer num=0;
	/**
	 * 是否允许重复领取二维码
	 * 
	 */
	private Boolean isBoolean=false;
	/**
	 * 投放金额
	 */
	private Float toufangMoney=0.0f;
	
	/**
	 * 消耗金额
	 */
	private Float xiaohaoMoney=0.0f;
	
	/**
	 * 余额
	 */
	private Float restMoney=0.0f;
	
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
	public String getUrl() {
		return activity.getUrl();
	}
	public String getTitle() {
		return activity.getTitle();
	}
	public String getPhone() {
		return activity.getPhone();
	}
	public String getUserName() {
		return activity.getUser().getUserName();
	}
	public Integer getStatus() {
		return activity.getStatus();
	}
	public Float getMoney() {
		return activity.getMoney();
	}
	public Integer getNum() {
		return activity.getNum();
	}
	public ActivityEntity getActivity() {
		return activity;
	}
	
	public ActivityBean (ActivityEntity activity){
		this.activity=activity;
		if(activity.getOverTime()!=null){
			if(activity.getOverTime().getTime()- new Date().getTime()<0){
				isOverTime=true;
			}else{
				isOverTime=false;
			}
		}else{
			isOverTime=false;
		}
	}
	public String getPicUrl() {
		return activity.getPicUrl();
	}
	public String getId() {
		return activity.getId();
	}
	public Boolean getIsBoolean() {
		return activity.getIsBoolean();
	}
	public void setNum(Integer num) {
		this.num = num;
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
