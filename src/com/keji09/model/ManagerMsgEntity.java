package com.keji09.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 管理员通知帐号表
 */
@Entity
@Table(name = "inv_manager_msg")
public class ManagerMsgEntity implements Serializable {
	
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
	 * 管理员
	 */
	@ManyToOne
	@JoinColumn(name = "_member")
	private MemberEntity member;
	
	/**
	 * 新增时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();
	
	/**
	 * 状态 0:不发  1：发
	 */
	@Column(name = "_status")
	private Integer status = 0;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public MemberEntity getMember() {
		return member;
	}
	
	public void setMember(MemberEntity member) {
		this.member = member;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}
