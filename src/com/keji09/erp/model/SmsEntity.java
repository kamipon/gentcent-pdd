package com.keji09.erp.model;

import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户表
 */
@Entity
@Table(name = "pdd_smsr")
public class SmsEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;

	/**
	 * 新增时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();

	@Column(name = "_code")
	private String code;

	@Column(name = "_phone")
	private String phone;

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
