package com.keji09.model;

import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户表
 */
@Entity
@Table(name = "inv_member")
public class MemberEntity implements Serializable {
	
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	//物流家电项目字段
	/**
	 * 用户类型 99admin
	 * typo =0 普通用户
	 * 1.商户 2.销售 3.市场 4.物流 5.客服 99:管理员
	 */
	@Column(name = "u_utype")
	private Integer utype = 0;
	
	/**
	 * 微信openid
	 */
	@Column(name = "u_open_id", unique = true)
	private String openId;
	
	/**
	 * 小程序openId
	 */
	@Column(name = "u_xcxopen_id", unique = true)
	private String xcxOpenId;
	/**
	 * shotID
	 */
	@Column(name = "u_shotId", unique = true)
	private String shotId = RandomStringUtils.randomNumeric(7);
	
	/**
	 * 我的上级的shotId
	 */
	@Column(name = "u_shot_code")
	private String shotCode;
	
	/**
	 * 用户名
	 */
	@Column(name = "u_user_name")
	private String userName;
	
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
	@Column(name = "u_realName")
	private String realName;
	
	/**
	 * 性别（0.女，1.男）
	 */
	@Column(name = "u_sex")
	private Integer sex = 1;
	
	/**
	 * 是否初次绑定上下级
	 * 0.可以绑定 1.不能绑定
	 */
	@Column(name = "u_is_bind")
	private Integer isBind = 0;
	
	/**
	 * 电话号码
	 */
	@Column(name = "u_phone")
	private String phone;
	
	/**
	 * 微信
	 */
	@Column(name = "u_weixin")
	private String weixin;
	
	/**
	 * 身份证
	 */
	@Column(name = "u_card")
	private String card;
	
	/**
	 * 出生日期
	 */
	@Column(name = "u_birthday")
	private Date birthday;
	
	/**
	 * 最后登录日期
	 */
	@Column(name = "u_loginLastTime")
	private Date loginLastTime;
	
	/**
	 * 状态(0,禁用; 1,启用;)
	 */
	@Column(name = "u_status")
	private Integer status = 1;
	
	/**
	 * 地址
	 */
	@Column(name = "u_address")
	private String address;
	
	/**
	 * 头像地址
	 */
	@Column(name = "u_pic_url")
	private String picUrl;
	
	/**
	 * 自增长id
	 */
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "u_sid")
	private Integer sid;
	
	/**
	 * 新增时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();
	
	/**
	 * 余额
	 */
	@Column(name = "_balance")
	private Float balance = 0f;
	
	/**
	 * 城市
	 */
	@Column(name = "_city")
	private String city;
	
	/**
	 * 是否关注
	 */
	@Column(name = "_attention")
	private Boolean attention;
	
	
	/**
	 * 是否小程序member
	 */
	@Column(name = "_isxcx")
	private Integer isXcx = 0;
	
	/**
	 * 购物车 JSON字符串
	 */
	@Column(name = "_cart")
	private String cart;
	
	/**
	 * 用户类型
	 * 用来发送模板消息时使用(1管理员 2.代理 3.商家 0游客)
	 */
	@Column(name = "type")
	private Integer type;
	
	/**
	 * 所属代理
	 */
	@ManyToOne
	@JoinColumn(name = "_terpoint")
	private TerPointEntity terpoint;
	
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
	@Column(name = "_num")
	private Integer num = 0;
	
	/**
	 * 备注
	 */
	@Column(name = "_desc")
	private String desc;
	
	/**
	 * 提现类型
	 * 1.支付宝 2.银行卡
	 */
	@Column(name = "_ti_type")
	private Integer titype;
	
	/**
	 * zfb
	 */
	@Column(name = "_zfb")
	private String zfb;
	
	/**
	 * zfbname
	 */
	@Column(name = "_zfbname")
	private String zfbname;
	
	/**
	 * 银行卡真实姓名
	 */
	@Column(name = "_cardrealname")
	private String cardrealname;
	
	/**
	 * 银行卡帐号
	 */
	@Column(name = "_cardnumber")
	private String cardnumber;
	
	/**
	 * 银行卡所属支行
	 */
	@Column(name = "_cardfrom")
	private String cardfrom;
	
	public String getDesc() {
		return desc;
	}
	
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	public String getZfb() {
		return zfb;
	}
	
	public void setZfb(String zfb) {
		this.zfb = zfb;
	}
	
	public String getZfbname() {
		return zfbname;
	}
	
	public void setZfbname(String zfbname) {
		this.zfbname = zfbname;
	}
	
	public String getCardrealname() {
		return cardrealname;
	}
	
	public void setCardrealname(String cardrealname) {
		this.cardrealname = cardrealname;
	}
	
	public String getCardnumber() {
		return cardnumber;
	}
	
	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}
	
	public String getCardfrom() {
		return cardfrom;
	}
	
	public void setCardfrom(String cardfrom) {
		this.cardfrom = cardfrom;
	}
	
	public String getIp() {
		return ip;
	}
	
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	public ActivityEntity getActivity() {
		return activity;
	}
	
	public Integer getIsXcx() {
		return isXcx;
	}
	
	public void setIsXcx(Integer isXcx) {
		this.isXcx = isXcx;
	}
	
	public void setActivity(ActivityEntity activity) {
		this.activity = activity;
	}
	
	public Integer getType() {
		return type;
	}
	
	public void setType(Integer type) {
		this.type = type;
	}
	
	public TerPointEntity getTerpoint() {
		return terpoint;
	}
	
	public void setTerpoint(TerPointEntity terpoint) {
		this.terpoint = terpoint;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getOpenId() {
		return openId;
	}
	
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	
	public String getShotId() {
		return shotId;
	}
	
	public void setShotId(String shotId) {
		this.shotId = shotId;
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
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getWeixin() {
		return weixin;
	}
	
	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}
	
	public String getCard() {
		return card;
	}
	
	public void setCard(String card) {
		this.card = card;
	}
	
	public Date getBirthday() {
		return birthday;
	}
	
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
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
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getPicUrl() {
		return picUrl;
	}
	
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
	public Integer getSid() {
		return sid;
	}
	
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public Float getBalance() {
		return balance;
	}
	
	public void setBalance(Float balance) {
		this.balance = balance;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public Boolean getAttention() {
		return attention;
	}
	
	public void setAttention(Boolean attention) {
		this.attention = attention;
	}
	
	public String getXcxOpenId() {
		return xcxOpenId;
	}
	
	public void setXcxOpenId(String xcxOpenId) {
		this.xcxOpenId = xcxOpenId;
	}
	
	public Integer getNum() {
		return num;
	}
	
	public void setNum(Integer num) {
		this.num = num;
	}
	
	public String getShotCode() {
		return shotCode;
	}
	
	public void setShotCode(String shotCode) {
		this.shotCode = shotCode;
	}
	
	public Integer getIsBind() {
		return isBind;
	}
	
	public void setIsBind(Integer isBind) {
		this.isBind = isBind;
	}
	
	public Integer getUtype() {
		return utype;
	}
	
	public void setUtype(Integer utype) {
		this.utype = utype;
	}
	
	public String getCart() {
		return cart;
	}
	
	public void setCart(String cart) {
		this.cart = cart;
	}
	
	public Integer getTitype() {
		return titype;
	}
	
	public void setTitype(Integer titype) {
		this.titype = titype;
	}
	
}
