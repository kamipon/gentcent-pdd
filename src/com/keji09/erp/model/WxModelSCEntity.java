package com.keji09.erp.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 
 * 微信通知表
 * 模板消息
 */
@Entity
@Table(name = "inv_wxmodel_sc")
public class WxModelSCEntity implements Serializable {
	
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
	 * openId
	 */
	@Column(name="_openId")
	private String openId;
	
	/**
	 * 动态码
	 */
	@Column(name="_code")
	private String code;

	/**
	 * 动态码发送结果
	 */
	@Column(name="_result")
	private Integer result;
	
	/**
	 * 动态码等级（1.登录 2.红包设置金额）
	 */
	@Column(name="_level")
	private Integer level;
	
	/**
	 * 用户userName
	 */
	@Column(name="_userName")
	private String userName;
	
	/**
	 * 发送时间
	 */
	@Column(name="_date")
	private Date addTime = new Date();

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getResult() {
		return result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

}
