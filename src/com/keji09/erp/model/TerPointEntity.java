package com.keji09.erp.model;

import com.keji09.erp.model.role.UserEntity;
import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 代理商（商家）实体
 */
@Entity
@Table(name = "inv_terpoint")
public class TerPointEntity implements Serializable {
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
	 * shotID
	 */
	@Column(name = "_shot_id", unique = true)
	private String shotId = RandomStringUtils.randomNumeric(7);
	/**
	 * 名称
	 */
	@Column(name = "_name")
	private String name;
	/**
	 * 介绍
	 */
	@Column(name = "_desc")
	private String desc;
	/**
	 * 状态（0.正常; 1.关闭; 13.已删除）
	 */
	@Column(name = "_status")
	private Integer status = 0;
	/**
	 * 余额
	 */
	@Column(name = "_money")
	private Integer money = 0;
	/**
	 * 冻结金额
	 */
	@Column(name = "_frozen_money")
	private Integer frozenMoney = 0;
	/**
	 * 所属用户
	 */
	@ManyToOne
	@JoinColumn(name = "_user")
	private UserEntity user;
	/**
	 * 代理商能添加活动的数量
	 */
	@Column(name = "_activity_num")
	private Integer activityNum;
	/**
	 * 创建时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();
	
	/**
	 * 到期时间
	 */
	@Column(name = "_over_time")
	private Date overTime;
	
	
	public String getShotId() {
		return shotId;
	}
	
	public void setShotId(String shotId) {
		this.shotId = shotId;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getDesc() {
		return desc;
	}
	
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getMoney() {
		return money;
	}
	
	public void setMoney(Integer money) {
		this.money = money;
	}
	
	public Integer getFrozenMoney() {
		return frozenMoney;
	}
	
	public void setFrozenMoney(Integer frozenMoney) {
		this.frozenMoney = frozenMoney;
	}
	
	public UserEntity getUser() {
		return user;
	}
	
	public void setUser(UserEntity user) {
		this.user = user;
	}
	
	public Integer getActivityNum() {
		return activityNum;
	}
	
	public void setActivityNum(Integer activityNum) {
		this.activityNum = activityNum;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public Date getOverTime() {
		return overTime;
	}
	
	public void setOverTime(Date overTime) {
		this.overTime = overTime;
	}
}