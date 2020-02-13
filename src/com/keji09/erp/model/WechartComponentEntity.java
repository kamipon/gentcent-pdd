package com.keji09.erp.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 微信第三方平台设置实体
 * @author Administrator
 *
 */
@Entity
@Table(name="wx_wechart_component")
public class WechartComponentEntity implements Serializable{

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
	 * 第三方平台compoment_access_token是第三方平台的下文中接口的调用凭据
	 */
	@Column(name="_access_token",length=1000)
	private String accesstoken;
	
	/**
	 * verifyTicket在公众号第三方平台创建审核通过后，微信服务器会向其“授权事件接收URL”每隔10分钟定时推送component_verify_ticket。第三方平台方在收到ticket推送后也需进行解密
	 */
	@Column(name="_verify_ticket",length=1000)
	private String verifyTicket;

	/**
	 * pre_auth_code预授权码用于公众号授权时的第三方平台方安全验证
	 */
	@Column(name="_pre_auth_code",length=1000)
	private String preAuthCode;
	
	/**
	 * 用于与微信平台的token对应
	 */
	@Column(name="_token")
	private String token;

	/**
	 * 回调URI
	 */
	@Column(name="_redirect_uri")
	private String redirectUri;


	/**
	 * 消息加密密匙
	 */
	@Column(name="_encodingAESKey")
	private String encodingAESKey;

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

	public String getAccesstoken() {
		return accesstoken;
	}

	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}

	public String getVerifyTicket() {
		return verifyTicket;
	}

	public void setVerifyTicket(String verifyTicket) {
		this.verifyTicket = verifyTicket;
	}

	public String getPreAuthCode() {
		return preAuthCode;
	}

	public void setPreAuthCode(String preAuthCode) {
		this.preAuthCode = preAuthCode;
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

	public String getRedirectUri() {
		return redirectUri;
	}

	public void setRedirectUri(String redirectUri) {
		this.redirectUri = redirectUri;
	}
	
	
}
