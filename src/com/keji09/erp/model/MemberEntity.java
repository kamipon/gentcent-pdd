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
@Table(name = "pdd_member")
public class MemberEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * shotID
	 */
	@Column(name = "_shot_id", unique = true)
	private String shotId = RandomStringUtils.randomAlphanumeric(6);
	
	/**
	 * 我的上级的shotId
	 */
	@Column(name = "_sup_shot_id")
	private String supShotId;
	
	/**
	 * 用户名(手机号)
	 */
	@Column(name = "u_username", unique = true)
	private String username;
	
	/**
	 * 密码
	 */
	@Column(name = "u_password")
	private String password;
	
	/**
	 * 昵称
	 */
	@Column(name = "u_nick")
	private String nick;
	
	/**
	 * 真实姓名
	 */
	@Column(name = "u_real_name")
	private String realName;
	
	/**
	 * 性别（0.女，1.男）
	 */
	@Column(name = "u_sex")
	private Integer sex = 1;
	
	/**
	 * 最后登录日期
	 */
	@Column(name = "u_login_last_time")
	private Date loginLastTime;
	
	/**
	 * 状态(0,禁用; 1,启用;)
	 */
	@Column(name = "u_status")
	private Integer status = 1;
	
	/**
	 * 头像地址
	 */
	@Column(name = "u_pic_url")
	private String picUrl;
	
	/**
	 * 新增时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();
	
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
	 * 所属代理的id
	 */
	@Column(name = "_terpoint_id")
	private String terpointId;
	
	/**
	 * 所属商户
	 */
	@ManyToOne
	@JoinColumn(name = "_activity")
	private ActivityEntity activity;
	
	/**
	 * ip
	 *
	 * @return
	 */
	@Column(name = "_ip")
	private String ip;
	
	/**
	 * 推广人数
	 */
	@Column(name = "_prom_num")
	private Integer promNum = 0;
	
	/**
	 * 备注
	 */
	@Column(name = "_desc")
	private String desc;
	
	/**
	 * 推广位
	 */
	@Column(name = "_pid")
	private String pid;
	
	/**
	 * 红包派项目的id
	 */
	@Column(name = "_red_id", unique = true)
	private String redId;
	
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getShotId() {
		return shotId;
	}
	
	public void setShotId(String shotId) {
		this.shotId = shotId;
	}
	
	public String getSupShotId() {
		return supShotId;
	}
	
	public void setSupShotId(String supShotId) {
		this.supShotId = supShotId;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String userName) {
		this.username = userName;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getNick() {
		return nick;
	}
	
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	public String getRealName() {
		return realName;
	}
	
	public void setRealName(String realName) {
		this.realName = realName;
	}
	
	public Integer getSex() {
		return sex;
	}
	
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	
	public Date getLoginLastTime() {
		return loginLastTime;
	}
	
	public void setLoginLastTime(Date loginLastTime) {
		this.loginLastTime = loginLastTime;
	}
	
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public String getPicUrl() {
		return picUrl;
	}
	
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
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
	
	public String getTerpointId() {
		return terpointId;
	}
	
	public void setTerpointId(String terpointId) {
		this.terpointId = terpointId;
	}
	
	public ActivityEntity getActivity() {
		return activity;
	}
	
	public void setActivity(ActivityEntity activity) {
		this.activity = activity;
	}
	
	public String getIp() {
		return ip;
	}
	
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	public Integer getPromNum() {
		return promNum;
	}
	
	public void setPromNum(Integer promNum) {
		this.promNum = promNum;
	}
	
	public String getDesc() {
		return desc;
	}
	
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	public String getPid() {
		return pid;
	}
	
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	public String getRedId() {
		return redId;
	}
	
	public void setRedId(String redId) {
		this.redId = redId;
	}
}
