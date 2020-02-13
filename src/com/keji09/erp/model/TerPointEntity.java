package com.keji09.erp.model;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.keji09.erp.model.role.UserEntity;

/**
 * 代理商（商家）实体
 */
@Entity
@Table(name = "_ter_point")
public class TerPointEntity implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
/***************************************** 主键id*****************************************/
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name="id",length = 32)
	private String id;
/*****************************************具体字段*****************************************/
	/**
	 * 店名
	 */
	@Column(name="_name")
	private String name;
	/**
	 * 用户名
	 */
	@Column(name="_user_name",unique=true)
	private String userName;
	/**
	 * 密码
	 */
	@Column(name="_password")
	private String password;
	/**
	 * 店招（招牌图片）
	 */
	@Column(name="_logo")
	private String logo;

	/**
	 * 绑定域名
	 */
	@Column(name="_host")
	private String host;
	
	/**
	 * 是否城市合伙人 1:是
	 */
	@Column(name="_partner")
	private Integer partner;
	
	/**
	 * 上级
	 */
	@Column(name="_higher")
	private String higher;

	/**
	 * 代号
	 */
	@Column(name="_code")
	private String code;
	/**
	 * 微信公众号
	 */
	@Column(name="_weixin")
	private String weixin;
	/**
	 * 营业时间
	 */
	@Column(name="_openTime")
	private String openTime;
	/**
	 * 联系方式
	 */
	@Column(name="_phone")
	private String phone;
	/**
	 * 所在省
	 */
	@Column(name="_province")
	private String province;
	/**
	 * 所在城市
	 */
	@Column(name="_city")
	private String city;

	/**
	 * 创建时间
	 */
	@Column(name="_addTime")
	private Date addTime=new Date();
	/**
	 * 经度
	 */
	@Column(name="_xCoordinate")
	private Double xCoordinate;
	/**
	 * 纬度
	 */
	@Column(name="_yCoordinate")
	private Double yCoordinate;
	/**
	 * 偏移量
	 */
	@Column(name="_offset")
	private Double offset;
	/**
	 * 地址
	 */
	@Column(name="_address")
	private String address;
	/**
	 * 乘车路线
	 */
	@Column(name="_path")
	private String path;
	/**
	 * 介绍
	 */
	@Column(name="_desc")
	private String desc;
	/**
	 * 状态（0.正常; 1.关闭; 13.已删除）
	 */
	@Column(name="_status")
	private Integer status=0;

	/**
	 * 到期时间
	 */
	@Column(name="_overTime")
	private Date overTime;
	
	/**
	 * 已使用金额
	 */
	@Column(name="_money_use")
	private Float moneyUse=0.0f;

	/**
	 * 余额
	 */
	@Column(name="_money")
	private Float money=0.0f;
	/**
	 * 所属用户
	 * 
	 */
	@ManyToOne
	@JoinColumn(name="ter_user")
	private UserEntity user;
	/**
	 * 是否启用电子二维码 1开启 0关闭
	 * 
	 */
	@Column(name="_isBoolean")
	private Boolean isBoolean=false;
	/**
	 * 代理商能添加活动的数量
	 * 
	 */
	@Column(name="_activity_num")
	private Integer activityNum;
	/**
	 * 代理商类型 0试用 1正式
	 * @return
	 */
	@Column(name="_type")
	private Integer type=1;
	public Float getMoney() {
		return money;
	}
	
	/**
	 * 平台手续费
	 * 
	 */
	@Column(name="_pt_fee")
	private Integer ptFee;
	/**
	 * 代理手续费
	 * 
	 */
	@Column(name="_ter_fee")
	private Integer terFee;
	/**
	 * 代理支付宝账号
	 * 
	 */
	@Column(name="_zfb")
	private String zfb;
	
	/**
	 * 支付宝帐号姓名
	 * @return
	 */
	@Column(name="_zfbname")
	private String zfbname;
	
	
	public String getZfbname() {
		return zfbname;
	}

	public void setZfbname(String zfbname) {
		this.zfbname = zfbname;
	}

	public void setMoney(Float money) {
		this.money = money;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
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

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getWeixin() {
		return weixin;
	}

	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Double getXCoordinate() {
		return xCoordinate;
	}

	public void setXCoordinate(Double coordinate) {
		xCoordinate = coordinate;
	}

	public Double getYCoordinate() {
		return yCoordinate;
	}

	public void setYCoordinate(Double coordinate) {
		yCoordinate = coordinate;
	}

	public Double getOffset() {
		return offset;
	}

	public void setOffset(Double offset) {
		this.offset = offset;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
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

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public Float getMoneyUse() {
		return moneyUse;
	}

	public void setMoneyUse(Float moneyUse) {
		this.moneyUse = moneyUse;
	}

	public Boolean getIsBoolean() {
		return isBoolean;
	}

	public void setIsBoolean(Boolean isBoolean) {
		this.isBoolean = isBoolean;
	}

	public Integer getActivityNum() {
		return activityNum;
	}

	public void setActivityNum(Integer activityNum) {
		this.activityNum = activityNum;
	}

	
	public Integer getPartner() {
		return partner;
	}

	public void setPartner(Integer partner) {
		this.partner = partner;
	}

	public String getHigher() {
		return higher;
	}

	public void setHigher(String higher) {
		this.higher = higher;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
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

	public String getZfb() {
		return zfb;
	}

	public void setZfb(String zfb) {
		this.zfb = zfb;
	}
	
	
}