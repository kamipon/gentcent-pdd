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

import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.annotations.GenericGenerator;

import com.keji09.erp.model.role.UserEntity;

/**
 * 商家（活动）实体
 */
@Entity
@Table(name = "inv_activity")
public class ActivityEntity implements Serializable{
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
	 * 名称
	 */
	@Column(name="_name")
	private String name;
	
	/**
	 * 红包名称
	 */
	@Column(name="_redName")
	private String redName;
	/**
	 * 图片地址
	 */
	@Column(name="_pic_url")
	private String picUrl;
	/**
	 * 标题
	 */
	@Column(name="_title")
	private String title;
	/**
	 * 名称
	 */
	@Column(name="_url",length=1000)
	private String url;

	/**
	 * 代号
	 */
	@Column(name="_code")
	private String code;
	
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
	 * 微信公众号
	 */
	@Column(name="_weixin")
	private String weixin;

	/**
	 * 联系方式
	 */
	@Column(name="_phone")
	private String phone;
	/**
	 * 账号
	 */
	@Column(name="_userName",unique=true)
	private String userName;
	/**
	 * 密码
	 */
	@Column(name="_password")
	private String password;
	/**
	 * 创建时间
	 */
	@Column(name="_addTime")
	private Date addTime=new Date();
	
	/**
	 * 地址
	 */
	@Column(name="_address")
	private String address;
	/**
	 * 介绍
	 */
	@Column(name="_desc")
	private String desc;
	/**
	 * 状态（0.正常; -1.关闭; 13.已删除）
	 */
	@Column(name="_status")
	private Integer status=0;

	/**
	 * 到期时间
	 */
	@Column(name="_overTime")
	private Date overTime;

	/**
	 * 余额
	 */
	@Column(name="_money")
	private Float money=0.0f;
	/**
	 * 冻结金额
	 */
	@Column(name="_useMoney")
	private Float useMoney=0.0f;
	
	/**
	 * 所属代理商
	 * 
	 */
	@ManyToOne
	@JoinColumn(name="_terpoint")
	private TerPointEntity terpoint;
	
	/**
	 * 活动的红包数量
	 * 
	 */
	@Column(name="_activity_redpacket_num")
	private Integer num=0;

	/**
	 * 是否允许重复领取二维码
	 * 
	 */
	@Column(name="_isBoolean")
	private Boolean isBoolean=false;
	/**
	 * 多领取间隔时间
	 * 0代表没有间隔时间 单位为分钟
	 */
	@Column(name="interval_time")
	private Integer intervalTime=0;
	/**
	 * 
	 * 活动领取模式
	 * 0 分享领取
	 * 1 直接领取
	 * 2 关注领取
	 */
	@Column(name="_pattern")
	private Integer pattern=0;
	/**
	 * 到账方式
	 * 0 到余额
	 * 1 直接转账
	 */
	@Column(name="_saveType")
	private Integer saveType=1;
	/**
	 * 所属用户
	 * 
	 */
	@ManyToOne
	@JoinColumn(name="act_user")
	private UserEntity user;

	/**
	 * appid
	 */
	@Column(name="_app_id")
	private String appId=RandomStringUtils.randomAlphanumeric(6);;

	/**
	 * appsecret
	 */
	@Column(name="_appsecret")
	private String appsecret=java.util.UUID.randomUUID().toString().replaceAll("-", "");
	/**
	 * 
	 * 注册类型 0:代理商添加 1：自行注册
	 */
	@Column(name="_categoryt")
	private Integer categoryt;
	/**
	 * 商家类型 0试用 1正式
	 * @return
	 */
	@Column(name="_type")
	private Integer type=1;
	
	/**
	 * 领取优惠券，实物是否需要输入地址
	 * @return
	 */
	@Column(name="_isaddress")
	private Integer isaddress=1;

	/**
	 * 曝光量
	 */
	@Column(name="_baoguang")
	private Integer baoguang=0;
	
	/**
	 * 商品密码
	 * @return
	 */
	@Column(name="_hx_password")
	private String hx_password;
	
	/**
	 *	推广活码
	 * @return
	 */
	@Column(name="_redalterable")
	private String redalterable;
	
	/**
	 * 短信总条数
	 * @return
	 */
	@Column(name="_note_total")
	private Integer noteTotal = 0;
	
	/**
	 * 是否显示小程序码
	 * @return
	 */
	@Column(name="_showxcx")
	private String showxcx;
	
	/**
	 * 省
	 * @return
	 */
	@Column(name="_province")
	private String province;
	
	/**
	 * 市
	 * @return
	 */
	@Column(name="_city")
	private String city;
	
	/**
	 * 支付宝账号
	 * @return
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

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getShowxcx() {
		return showxcx;
	}

	public void setShowxcx(String showxcx) {
		this.showxcx = showxcx;
	}

	public Integer getNoteTotal() {
		return noteTotal;
	}
	
	public void setNoteTotal(Integer noteTotal) {
		this.noteTotal = noteTotal;
	}
	public String getRedalterable() {
		return redalterable;
	}
	public void setRedalterable(String redalterable) {
		this.redalterable = redalterable;
	}
	
	public String getHx_password() {
		return hx_password;
	}
	public void setHx_password(String hx_password) {
		this.hx_password = hx_password;
	}
	public Integer getBaoguang() {
		return baoguang;
	}
	public void setBaoguang(Integer baoguang) {
		this.baoguang = baoguang;
	}
	public Integer getCategoryt() {
		return categoryt;
	}
	public void setCategoryt(Integer categoryt) {
		this.categoryt = categoryt;
	}
	public UserEntity getUser() {
		return user;
	}
	public void setUser(UserEntity user) {
		this.user = user;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getAppsecret() {
		return appsecret;
	}
	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}
	public Boolean getIsBoolean() {
		return isBoolean;
	}
	public void setIsBoolean(Boolean isBoolean) {
		this.isBoolean = isBoolean;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	public TerPointEntity getTerpoint() {
		return terpoint;
	}
	public void setTerpoint(TerPointEntity terpoint) {
		this.terpoint = terpoint;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getIntervalTime() {
		return intervalTime;
	}
	public void setIntervalTime(Integer intervalTime) {
		this.intervalTime = intervalTime;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Float getUseMoney() {
		return useMoney;
	}
	public void setUseMoney(Float useMoney) {
		this.useMoney = useMoney;
	}
	public Integer getPattern() {
		return pattern;
	}
	public void setPattern(Integer pattern) {
		this.pattern = pattern;
	}
	public Integer getSaveType() {
		return saveType;
	}
	public void setSaveType(Integer saveType) {
		this.saveType = saveType;
	}

	public String getRedName() {
		return redName;
	}

	public void setRedName(String redName) {
		this.redName = redName;
	}

	public Integer getIsaddress() {
		return isaddress;
	}

	public void setIsaddress(Integer isaddress) {
		this.isaddress = isaddress;
	}

	public String getZfb() {
		return zfb;
	}

	public void setZfb(String zfb) {
		this.zfb = zfb;
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
	
}