package com.keji09.model;

import com.keji09.model.role.UserEntity;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 商家（活动）实体
 */
@Entity
@Table(name = "inv_activity")
public class ActivityEntity implements Serializable {
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
	 * 名称
	 */
	@Column(name = "_name")
	private String name;
	/**
	 * 图片地址
	 */
	@Column(name = "_pic_url")
	private String picUrl;
	/**
	 * 名称
	 */
	@Column(name = "_url", length = 1000)
	private String url;
	/**
	 * 代号
	 */
	@Column(name = "_code")
	private String code;
	/**
	 * 平台手续费
	 */
	@Column(name = "_pt_fee")
	private Integer ptFee;
	/**
	 * 代理手续费
	 */
	@Column(name = "_ter_fee")
	private Integer terFee;
	/**
	 * 联系方式
	 */
	@Column(name = "_phone")
	private String phone;
	/**
	 * 账号
	 */
	@Column(name = "_userName", unique = true)
	private String userName;
	/**
	 * 密码
	 */
	@Column(name = "_password")
	private String password;
	/**
	 * 创建时间
	 */
	@Column(name = "_addTime")
	private Date addTime = new Date();
	
	/**
	 * 地址
	 */
	@Column(name = "_address")
	private String address;
	/**
	 * 介绍
	 */
	@Column(name = "_desc")
	private String desc;
	/**
	 * 状态（0.正常; -1.关闭; 13.已删除）
	 */
	@Column(name = "_status")
	private Integer status = 0;
	
	/**
	 * 到期时间
	 */
	@Column(name = "_overTime")
	private Date overTime;
	
	/**
	 * 余额
	 */
	@Column(name = "_money")
	private Float money = 0.0f;
	/**
	 * 冻结金额
	 */
	@Column(name = "_useMoney")
	private Float useMoney = 0.0f;
	/**
	 * 所属代理商
	 */
	@ManyToOne
	@JoinColumn(name = "_terpoint")
	private TerPointEntity terpoint;
	/**
	 * 所属用户
	 */
	@ManyToOne
	@JoinColumn(name = "act_user")
	private UserEntity user;
	/**
	 * 注册类型 0:代理商添加 1：自行注册
	 */
	@Column(name = "_categoryt")
	private Integer categoryt;
	
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
	
	public String getPicUrl() {
		return picUrl;
	}
	
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public Integer getPtFee() {
		return ptFee;
	}
	
	public void setPtFee(Integer ptFee) {
		this.ptFee = ptFee;
	}
	
	public Integer getTerFee() {
		return terFee;
	}
	
	public void setTerFee(Integer terFee) {
		this.terFee = terFee;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
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
	
	public Date getOverTime() {
		return overTime;
	}
	
	public void setOverTime(Date overTime) {
		this.overTime = overTime;
	}
	
	public Float getMoney() {
		return money;
	}
	
	public void setMoney(Float money) {
		this.money = money;
	}
	
	public Float getUseMoney() {
		return useMoney;
	}
	
	public void setUseMoney(Float useMoney) {
		this.useMoney = useMoney;
	}
	
	public TerPointEntity getTerpoint() {
		return terpoint;
	}
	
	public void setTerpoint(TerPointEntity terpoint) {
		this.terpoint = terpoint;
	}
	
	public UserEntity getUser() {
		return user;
	}
	
	public void setUser(UserEntity user) {
		this.user = user;
	}
	
	public Integer getCategoryt() {
		return categoryt;
	}
	
	public void setCategoryt(Integer categoryt) {
		this.categoryt = categoryt;
	}
}