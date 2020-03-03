package com.keji09.erp.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 优惠券
 */
@Entity
@Table(name = "pdd_coupon")
public class CouponEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;

	/**
	 * h5链接
	 */
	@Column(name = "_web_url")
	private String webUrl;

	/**
	 * 拼多多商品id
	 */
	@Column(name = "_goods_id")
	private Long goodsId;

	/**
	 * 拼多多商品名称
	 */
	@Column(name = "_goods_name")
	private String goodsName;

	/**
	 * 价格
	 */
	@Column(name = "_money")
	private Integer money;

	/**
	 * 用户
	 */
	@Column(name = "_member_id")
	private String memberId;

	/**
	 * 添加时间
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();

	/**
	 * 微信小程序来源名称
	 */
	@Column(name = "_we_app_info_source_display_name")
	private String weAppInfoSourceDisplayName;
	/**
	 * 微信小程序参数
	 */
	@Column(name = "_we_app_info_page_path")
	private String weAppInfoAppId;
	//微信小程序appid
	@Column(name = "_we_app_info_app_id")
	private String weAppInfoPagePath;

	public CouponEntity() {
	}

	public String getWeAppInfoSourceDisplayName() {
		return weAppInfoSourceDisplayName;
	}

	public void setWeAppInfoSourceDisplayName(String weAppInfoSourceDisplayName) {
		this.weAppInfoSourceDisplayName = weAppInfoSourceDisplayName;
	}

	public String getWeAppInfoAppId() {
		return weAppInfoAppId;
	}

	public void setWeAppInfoAppId(String weAppInfoAppId) {
		this.weAppInfoAppId = weAppInfoAppId;
	}

	public String getWeAppInfoPagePath() {
		return weAppInfoPagePath;
	}

	public void setWeAppInfoPagePath(String weAppInfoPagePath) {
		this.weAppInfoPagePath = weAppInfoPagePath;
	}

	public String getWebUrl() {
		return webUrl;
	}

	public void setWebUrl(String webUrl) {
		this.webUrl = webUrl;
	}

	public Long getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Long goodsId) {
		this.goodsId = goodsId;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public Integer getMoney() {
		return money;
	}

	public void setMoney(Integer money) {
		this.money = money;
	}
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getMemberId() {
		return memberId;
	}
	
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
}
