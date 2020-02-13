package com.keji09.erp.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 微信开发者信息设置
 * @author Administrator
 *
 */
@Entity
@Table(name="wx_wechart_activity_config")
public class WechartActivityConfigEntity implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name="_id",length = 32)
	private String id;

	/**
	 * appid
	 */
	@Column(name="_app_id")
	private String appId;

	/**
	 * appSecret
	 */
	@Column(name="_app_secret")
	private String appSecret;

	/**
	 * 存储全局accesstoken,2小时更新一次
	 */
	@Column(name="_access_token",length=1000)
	private String accesstoken;
	
	
	/**
	 * 存储全局jsapi_ticket,2小时更新一次
	 */
	@Column(name="_jsapi_ticket",length=1000)
	private String jsapiTicket;

	/**
	 * 服务器地址，用于自动生成填入微信
	 */
	@Column(name="_url")
	private String url;

	/**
	 * 用于与微信平台的token对应
	 */
	@Column(name="_token")
	private String token;

	/**
	 * 消息加密密匙
	 */
	@Column(name="_encodingAESKey")
	private String encodingAESKey;

	/**
	 * 菜单格式字符串
	 */
	@Column(name="_menu",length = 16777216)
	private String menu;
	
	/**
	 * ---------------------微信支付设置-----------------------
	 */
	/**
	 * 商户号
	 */
	@Column(name="_partner")
	private String partner;
	
	/**
	 * 商户密匙
	 */
	@Column(name="_partnerkey")
	private String partnerkey;
	
	/**
	 * 所属活动
	 */
	@Column(name="activity")	
	private String activity;

	//---------------------------------以下设置是属于系统作为微信第三方开放平台时获取用户公众号信息时使用到的，用于免配置一键授权
	/**
	 * 用户是否授权(取消授权后为false)
	 */
	@Column(name="_is_auth")
	private Boolean isAuth=true;

	/**
	 * 存储全局accesstoken,2小时更新一次
	 */
	@Column(name="_auth_access_token",length=1000)
	private String authAccesstoken;
	
	/**
	 * 第三方开放平台appid,这里是系统在微信开放平台申请的appid，非公众平台appid
	 */
	@Column(name="_component_appid")
	private String componentAppid;
	
	/**
	 * 配置类型(1.为用户自填 2.第三方平台关联)
	 */
	@Column(name="_type")
	private Integer type=1;
	
	/**
	 * 接口调用凭据刷新令牌
	 */
	@Column(name="_refresh_token",length=1000)
	private String refreshtoken;
	
	/**
	 * 权限集合，以逗号分割的数字
	 * 公众号授权给开发者的权限集列表，ID为1到15时分别代表：
	 * 1.消息管理权限
	 * 2.用户管理权限
	 * 3.帐号服务权限
	 * 4.网页服务权限
	 * 5.微信小店权限
	 * 6.微信多客服权限
	 * 7.群发与通知权限
	 * 8.微信卡券权限
	 * 9.微信扫一扫权限
	 * 10.微信连WIFI权限
	 * 11.素材管理权限
	 * 12.微信摇周边权限
	 * 13.微信门店权限
	 * 14.微信支付权限
	 * 15.自定义菜单权限
	 */
	@Column(name="_func_info")
	private String funcInfo;
	
	/**
	 * 授权方昵称
	 */
	@Column(name="_nick_name")
	private String nickName;
	
	/**
	 * 授权方头像
	 */
	@Column(name="_head_img")
	private String headImg;
	
	/**
	 * 授权方公众号类型，0代表订阅号，1代表由历史老帐号升级后的订阅号，2代表服务号
	 */
	@Column(name="_service_type_info")
	private Integer serviceTypeInfo;

	/**
	 * 授权方认证类型，
	 * -1代表未认证，
	 * 0代表微信认证，
	 * 1代表新浪微博认证，
	 * 2代表腾讯微博认证，
	 * 3代表已资质认证通过但还未通过名称认证，
	 * 4代表已资质认证通过、还未通过名称认证，但通过了新浪微博认证，
	 * 5代表已资质认证通过、还未通过名称认证，但通过了腾讯微博认证
	 */
	@Column(name="_verify_type_info")
	private Integer verifyTypeInfo;

	/**
	 * 授权方公众号的原始ID
	 */
	@Column(name="_user_name")
	private String userName;

	/**
	 * 授权方公众号所设置的微信号，可能为空
	 */
	@Column(name="_alias")
	private String alias;
	
	/**
	 *  用以了解以下功能的开通状况（0代表未开通，1代表已开通）：
	 *  open_store:是否开通微信门店功能
	 *  open_scan:是否开通微信扫商品功能
	 *  open_pay:是否开通微信支付功能
	 *  open_card:是否开通微信卡券功能
	 *  open_shake:是否开通微信摇一摇功能
	 */
	@Column(name="_business_info")
	public String businessInfo;

	/**
	 * 二维码图片的URL
	 */
	@Column(name="_qrcode_url")
	private String qrcodeUrl;
	
	/**
	 * 添加时间
	 */
	@Column(name="_add_time")
	private Date addTime=new Date();

	/**
	 * 修改时间
	 */
	@Column(name="_update_time")
	private Date updateTime=new Date();

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getHeadImg() {
		return headImg;
	}

	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}

	public Integer getServiceTypeInfo() {
		return serviceTypeInfo;
	}

	public void setServiceTypeInfo(Integer serviceTypeInfo) {
		this.serviceTypeInfo = serviceTypeInfo;
	}

	public Integer getVerifyTypeInfo() {
		return verifyTypeInfo;
	}

	public void setVerifyTypeInfo(Integer verifyTypeInfo) {
		this.verifyTypeInfo = verifyTypeInfo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getBusinessInfo() {
		return businessInfo;
	}

	public void setBusinessInfo(String businessInfo) {
		this.businessInfo = businessInfo;
	}

	public String getQrcodeUrl() {
		return qrcodeUrl;
	}

	public void setQrcodeUrl(String qrcodeUrl) {
		this.qrcodeUrl = qrcodeUrl;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getAppSecret() {
		return appSecret;
	}

	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getEncodingAESKey() {
		return encodingAESKey;
	}

	public void setEncodingAESKey(String encodingAESKey) {
		this.encodingAESKey = encodingAESKey;
	}

	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public String getPartner() {
		return partner;
	}

	public void setPartner(String partner) {
		this.partner = partner;
	}

	public String getPartnerkey() {
		return partnerkey;
	}

	public void setPartnerkey(String partnerkey) {
		this.partnerkey = partnerkey;
	}

	public String getAccesstoken() {
		return accesstoken;
	}

	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}
	
	public String getJsapiTicket() {
		return jsapiTicket;
	}

	public void setJsapiTicket(String jsapiTicket) {
		this.jsapiTicket = jsapiTicket;
	}

	public String getRefreshtoken() {
		return refreshtoken;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public void setRefreshtoken(String refreshtoken) {
		this.refreshtoken = refreshtoken;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getFuncInfo() {
		return funcInfo;
	}

	public void setFuncInfo(String funcInfo) {
		this.funcInfo = funcInfo;
	}

	public String getComponentAppid() {
		return componentAppid;
	}

	public void setComponentAppid(String componentAppid) {
		this.componentAppid = componentAppid;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Boolean getIsAuth() {
		return isAuth;
	}

	public void setIsAuth(Boolean isAuth) {
		this.isAuth = isAuth;
	}

	public String getAuthAccesstoken() {
		return authAccesstoken;
	}

	public void setAuthAccesstoken(String authAccesstoken) {
		this.authAccesstoken = authAccesstoken;
	}
}
