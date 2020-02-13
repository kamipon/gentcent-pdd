package com.keji09.erp.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 
 * 微信通知表
 * 模板消息绑定用户信息
 */
@Entity
@Table(name = "inv_wxmodel_sms_binding")
public class WxModelSMSBindingEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * 通知模块外键
	 */
	@ManyToOne
	@JoinColumn(name="_wxmodel")
	private WxModelSMSEntity wxmodel;
	
	/**
	 * 通知人外键
	 */
	@ManyToOne
	@JoinColumn(name="_member")
	private MemberEntity member;
	
	/**
	 * 通知类型
	 * 0 关闭 1 开启
	 */
	@Column(name="_status")
	private Integer status;
	
	

	public MemberEntity getMember() {
		return member;
	}

	public void setMember(MemberEntity member) {
		this.member = member;
	}

	public WxModelSMSEntity getWxmodel() {
		return wxmodel;
	}

	public void setWxmodel(WxModelSMSEntity wxmodel) {
		this.wxmodel = wxmodel;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
}
