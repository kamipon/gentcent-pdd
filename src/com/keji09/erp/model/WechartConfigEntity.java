package com.keji09.erp.model;

import java.io.Serializable;

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
@Table(name="wx_wechart_config")
public class WechartConfigEntity implements Serializable{
 
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
	 * 缓存模版id
	 */
	@Column(name="_template",length=1000)
	private String template;
	
	/**
	 * 订单付款成功通知模板id（OPENTM202496297）
	 */
	@Column(name="_template2",length=1000)
	private String template2;
	
	/**
	 * 订单发货通知模板id（OPENTM201541214）
	 */
	@Column(name="_template3",length=1000)
	private String template3;
	/**
	 * 订单完成通知模板id（OPENTM202531033）
	 */
	@Column(name="_template4",length=1000)
	private String template4;
	
	/**
	 * 领取优惠券模板id（OPENTM200739958）
	 */
	@Column(name="_template5",length=1000)
	private String template5;

	/**
	 * 微信安全验证码通知 OPENTM411737351
	 */
	@Column(name="_template6",length=1000)
	private String template6;

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
	 * 提现开启
	 * */
	@Column(name="_present_open")
	private Boolean presentOpen=false;
	
	/**
	 * 充值开启
	 * */
	@Column(name="_recharge_open")
	private Boolean rechargeOpen=false;

	/**
	 * 是否开通多客服
	 */
	@Column(name="_is_more_service")
	private Boolean isMoreService=false;

	/**
	 * 红包安全密码
	 */
	@Column(name="t_redpassword")
	private String redpassword;

	/**
	 * 红包证书名称
	 */
	@Column(name="t_newFileName")
	private String newFileName;
	
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
	 * 是否使用支付代理
	 */
	@Column(name="_agency_pay")
	private Boolean agencyPay=false;
	
	/**
	 * ---------------------支付宝支付设置-----------------------
	 */
	/**
	 * 支付账号
	 */
	@Column(name="_payAccount")
	private String payAccount;
	/**
	 * 合作账号
	 */
	@Column(name="_cooperateAccount")
	private String cooperateAccount;
	/**
	 * 密匙
	 */
	@Column(name="_password")
	private String password;
	/**
	 * 购买红包金额
	 */
	@Column(name="_redpacket_money")
	private Float redpacketMoney=1.0f;

	/**
	 * 警报金额
	 */
	@Column(name="_jingbao_money")
	private Float jingBaoMoney=0.0f;
	
	
	public Float getJingBaoMoney() {
		return jingBaoMoney;
	}
	public void setJingBaoMoney(Float jingBaoMoney) {
		this.jingBaoMoney = jingBaoMoney;
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

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public Boolean getAgencyPay() {
		return agencyPay;
	}

	public void setAgencyPay(Boolean agencyPay) {
		this.agencyPay = agencyPay;
	}

	/**
	 * 返回订单付款成功通知模板id（OPENTM202496297）
	 */
	public String getTemplate2() {
		return template2;
	}

	public void setTemplate2(String template2) {
		this.template2 = template2;
	}

	/**
	 * 订单发货通知模板id（OPENTM201541214）
	 */
	public String getTemplate3() {
		return template3;
	}

	public void setTemplate3(String template3) {
		this.template3 = template3;
	}

	/**
	 * 订单完成通知模板id（OPENTM202531033）
	 */
	public String getTemplate4() {
		return template4;
	}

	public void setTemplate4(String template4) {
		this.template4 = template4;
	}

	public String getJsapiTicket() {
		return jsapiTicket;
	}

	public void setJsapiTicket(String jsapiTicket) {
		this.jsapiTicket = jsapiTicket;
	}

	public String getTemplate5() {
		return template5;
	}

	public void setTemplate5(String template5) {
		this.template5 = template5;
	}

	public String getPayAccount() {
		return payAccount;
	}

	public void setPayAccount(String payAccount) {
		this.payAccount = payAccount;
	}

	public String getCooperateAccount() {
		return cooperateAccount;
	}

	public void setCooperateAccount(String cooperateAccount) {
		this.cooperateAccount = cooperateAccount;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getPresentOpen() {
		return presentOpen;
	}

	public void setPresentOpen(Boolean presentOpen) {
		this.presentOpen = presentOpen;
	}

	public Boolean getRechargeOpen() {
		return rechargeOpen;
	}

	public void setRechargeOpen(Boolean rechargeOpen) {
		this.rechargeOpen = rechargeOpen;
	}

	public Boolean getIsMoreService() {
		return isMoreService;
	}

	public void setIsMoreService(Boolean isMoreService) {
		this.isMoreService = isMoreService;
	}

	public String getRedpassword() {
		return redpassword;
	}

	public void setRedpassword(String redpassword) {
		this.redpassword = redpassword;
	}

	public String getNewFileName() {
		return newFileName;
	}

	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}

	public Float getRedpacketMoney() {
		return redpacketMoney;
	}

	public void setRedpacketMoney(Float redpacketMoney) {
		this.redpacketMoney = redpacketMoney;
	}
	public String getTemplate6() {
		return template6;
	}
	public void setTemplate6(String template6) {
		this.template6 = template6;
	}
	
}
