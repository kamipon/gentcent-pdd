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
@Table(name = "pdd_wx_member")
public class WXMemberEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;

	/**
	 */
	@Column(name = "_openid", unique = true)
	private String openid ;

	/**
	 * 昵称
	 */
	@Column(name = "_nick_name")
	private String nickName;

	/**
	 * 性别
	 */
	@Column(name = "_gender")
	private Integer gender = 0;

	/**
	 * 头像
	 */
	@Column(name = "_avatarUrl")
	private String avatarUrl;
	
	/**
	 * 添加时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getAvatarUrl() {
		return avatarUrl;
	}

	public void setAvatarUrl(String avatarUrl) {
		this.avatarUrl = avatarUrl;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
}
