package com.keji09.erp.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 小程序formId实体
 * @author Administrator
 *
 */
@Entity
@Table(name ="wx_formid")
public class FormIdEntity implements Serializable{

	/**
	 * Id
	 */
	private static final long serialVersionUID = 1L;
/***************************************** 主键id*****************************************/
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name="id",length = 32)
	private String id;

/*****************************************具体字段*****************************************/
	/**
	 * formId
	 */
	@Column(name="_formid")
    private String formId;
	
	/**
	 * 接受用户的OpenId
	 */
	@Column(name="_openid")
	private String openId;
	
	/**
	 * 代理Id
	 */
	@Column(name="_terpoint")
	private String terpoint;
	
	/**
	 * 添加时间
	 */
	@Column(name="_addTime")
	private Date addTime = new Date();

	public String getId() {
		return id;
	}

	public String getFormId() {
		return formId;
	}

	public String getOpenId() {
		return openId;
	}

	public String getTerpoint() {
		return terpoint;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setFormId(String formId) {
		this.formId = formId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public void setTerpoint(String terpoint) {
		this.terpoint = terpoint;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	
}
