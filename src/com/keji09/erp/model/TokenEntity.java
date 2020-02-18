package com.keji09.erp.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * app登录令牌
 */
@Entity
@Table(name = "pdd_token")
public class TokenEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * 添加时间
	 */
	@Column(name = "_member_id")
	private String memberId;
	
	/**
	 * 添加时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();
	
	public TokenEntity() {
	}
	
	public TokenEntity(String memberId) {
		this.memberId = memberId;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getMemberId() {
		return memberId;
	}
	
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
}
