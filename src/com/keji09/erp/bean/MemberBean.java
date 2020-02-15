package com.keji09.erp.bean;

import com.keji09.model.MemberEntity;

public class MemberBean {
	/**
	 * 管理员member
	 */
	private MemberEntity member;
	/**
	 * 是否禁用
	 */
	private Integer disable;
	
	public MemberBean() {
	}
	
	/**
	 * @return the member
	 */
	public MemberEntity getMember() {
		return member;
	}
	
	/**
	 * @param member the member to set
	 */
	public void setMember(MemberEntity member) {
		this.member = member;
	}
	
	/**
	 * @return the disable
	 */
	public Integer getDisable() {
		return disable;
	}
	
	/**
	 * @param disable the disable to set
	 */
	public void setDisable(Integer disable) {
		this.disable = disable;
	}
	
}
