package com.keji09.weixin.bean;

import java.util.Date;

/**
 * 充值提现记录
 * @author Administrator
 */
public class AccountRecorBean {
	
	/**
	 * 所属用户ID
	 */
	private String memberId;
	
	/**
	 * 类型(充值,提现)
	 */
	private String type;
	
	/**
	 * 充值提现金额
	 */
	private Float money;
	
	/**
	 * 提交时间
	 */
	private Date addTime;
	
	/**
	 * 状态（成功、审核中、失败、已取消,已扣款）
	 */
	private String status;

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Float getMoney() {
		return money;
	}

	public void setMoney(Float money) {
		this.money = money;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
