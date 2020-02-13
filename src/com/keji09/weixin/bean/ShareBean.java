package com.keji09.weixin.bean;

public class ShareBean {
	
	private String appId;
	
	private String timestamp;
	
	private String nonceStr;
	
	private String signature;
	
	private String promoteId;
	
	private String shopCode;
	
	private String shotId;
	
	private String picUrl;
	
	public String getShotId() {
		return shotId;
	}

	public void setShotId(String shotId) {
		this.shotId = shotId;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getNonceStr() {
		return nonceStr;
	}

	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getPromoteId() {
		return promoteId;
	}

	public void setPromoteId(String promoteId) {
		this.promoteId = promoteId;
	}

	public String getShopCode() {
		return shopCode;
	}

	public void setShopCode(String shopCode) {
		this.shopCode = shopCode;
	}

	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
	
}
