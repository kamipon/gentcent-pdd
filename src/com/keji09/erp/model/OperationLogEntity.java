package com.keji09.erp.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "inv_operation_log")
public class OperationLogEntity implements Serializable {
	/**
	 * 操作日志
	 */
	private static final long serialVersionUID = 1L;
	
	public static String OPERATIONLOG_USERNAME = "username";
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * 操作用户
	 */
	@Column(name = "_userName")
	private String userName;
	
	/**
	 * 操作者opid
	 */
	@Column(name = "_openId")
	private String openId;
	
	/**
	 * 操作者昵称
	 */
	@Column(name = "_nick")
	private String nick;
	
	/**
	 * 内容
	 */
	@Column(name = "_content", length = 16777216)
	private String content;
	
	/**
	 * 操作时间
	 */
	@Column(name = "_addTime")
	private Date addTime = new Date();
	
	/**
	 * 最后登录时间
	 */
	@Column(name = "_loglTime")
	private Date loglTime = new Date();
	
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public Date getLoglTime() {
		return loglTime;
	}
	
	public void setLoglTime(Date loglTime) {
		this.loglTime = loglTime;
	}
	
	public String getOpenId() {
		return openId;
	}
	
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	
	public String getNick() {
		return nick;
	}
	
	public void setNick(String nick) {
		this.nick = nick;
	}
	
}
