package com.keji09.erp.bean;

import java.util.Map;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 *HTTP服务请求的响应
 * @author pc02
 *
 * @param <T>
 */
@JsonIgnoreProperties(value={"hibernateLazyInitializer"}) 
public class ResponseBean<T> {
	/**
	 * 响应的结果状态
	 */
	private boolean success=true;
	private String msg="ok";
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	private ResponseStatusBean status=null;
	/**
	 * 响应的具体业务数据
	 */
	private T items=null;
	
	public ResponseBean() {
		this(ResponseStatusBean.STAUTS_SUCCESS);
	}
	
	public ResponseBean(T items) {
		this();
		this.items = items;
	}

	public ResponseBean(int status) {
		this.status=new ResponseStatusBean(status);
	}
	
	public ResponseBean(String message) {
		this.status=new ResponseStatusBean(message);
	}
	
	public ResponseBean(Map<String, Integer> details) {
		this.status=new ResponseStatusBean(details);
	}
	/**
	 * 得到响应的结果状态
	 * @return
	 */
	public ResponseStatusBean getStatus() {
		return status;
	}

	public void setStatus(ResponseStatusBean status) {
		this.status = status;
	}
	
	/**
	 * 得到响应的具体业务数据
	 * @return
	 */
	public T getItems() {
		return items;
	}

	public void setItems(T items) {
		this.items = items;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
}
