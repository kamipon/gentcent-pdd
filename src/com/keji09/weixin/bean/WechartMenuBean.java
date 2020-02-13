package com.keji09.weixin.bean;

import java.util.List;

public class WechartMenuBean {
	private String name;
	
	private String type;
	
	private String url;
	
	private String key;
	
	private List<WechartMenuBean> items;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public List<WechartMenuBean> getItems() {
		return items;
	}

	public void setItems(List<WechartMenuBean> items) {
		this.items = items;
	}
}
