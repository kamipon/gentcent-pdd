package com.keji09.erp.api.bean;

import com.pdd.pop.sdk.http.api.response.PddDdkThemeListGetResponse;

/**
 * 多多进宝主题
 *
 * @author zuozhi
 * @since 2020-02-14
 */

public class ThemeItemBean {
	private String name;
	private long id;
	private String imageUrl;
	private Long goodsNum;
	private String url;
	
	public ThemeItemBean(PddDdkThemeListGetResponse.ThemeListGetResponseThemeListItem item, String url) {
		this.name = item.getName();
		this.goodsNum = item.getGoodsNum();
		this.id = item.getId();
		this.imageUrl = item.getImageUrl();
		this.url = url;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public String getImageUrl() {
		return imageUrl;
	}
	
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
	public Long getGoodsNum() {
		return goodsNum;
	}
	
	public void setGoodsNum(Long goodsNum) {
		this.goodsNum = goodsNum;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
}
