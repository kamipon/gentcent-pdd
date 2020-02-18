package com.keji09.erp.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 多多进宝推广位实体
 */
@Entity
@Table(name = "pdd_pid")
public class PddPidEntity implements Serializable {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	/***************************************** 主键id*****************************************/
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
/*****************************************具体字段*****************************************/
	/**
	 * 推广位创建时间
	 */
	@Column(name = "_pid", unique = true)
	private String pid;
	/**
	 * 推广位名称
	 */
	@Column(name = "_pid_name")
	private String pidName;
	/**
	 * 推广位创建时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();
	/**
	 * 所属用户Id
	 */
	@Column(name = "_member_id")
	private String memberId;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPid() {
		return pid;
	}
	
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	public String getPidName() {
		return pidName;
	}
	
	public void setPidName(String pidName) {
		this.pidName = pidName;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public String getMemberId() {
		return memberId;
	}
	
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
}