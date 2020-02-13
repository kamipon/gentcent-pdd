package com.keji09.weixin.bean;

import java.util.HashMap;
import java.util.Map;

public class ResponseStatusBean {
	/**
	 * 成功
	 */
	public static final int STAUTS_SUCCESS=0;
	/**
	 * 未激活
	 */
	public static final int STAUTS_NONACTIVITYED=-4;
	/**
	 * 未知错误
	 */
	public static final int STATUS_UNKNOWN_ERROR=-99;
	/**
	 * 参数验证失败
	 */
	public static final int STAUTS_PARAMETERS_ERROR=-1;
	/**
	 * 参数不能为空
	 */
	public static final int PARAMETER_NOT_ALLOW_EMPTY=-1;
	/**
	 * 参数数据格式错误
	 */
	public static final int PARAMETER_BAD_DATA_FORMAT_SPECIFICATIONS=-2;
	/**
	 * 参数数据重复
	 */
	public static final int PARAMETER_DATA_DUPLICATE=-3;
	/**
	 * 参数数据重复
	 */
	public static final int DATA_INTERVAL=-5;
	
	
	/**
	 * 状态代码
	 */
	private int code = 0;
	/**
	 * 消息内容
	 */
	private String message = null;
	/**
	 * 描述信息
	 */
	private Map<String,Integer> details = null;
	
	/**
	 * 用户角色
	 */
	private int type = 0;
	
	/**
	 * 得到状态代码
	 */
	public int getCode() {
		return code;
	}
	
	public void setCode(int code) {
		this.code = code;
	}
	/**
	 * 得到消息内容
	 */
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * 得到描述信息
	 */
	public Map<String, Integer> getDetails() {
		return details;
	}
	
	public void setDetails(Map<String, Integer> details) {
		this.details = details;
	}
	
	public ResponseStatusBean() {
		super();
	}
	
	public ResponseStatusBean(int code) {
		super();
		this.code = code;
		if(code==STATUS_UNKNOWN_ERROR){
			this.message="UNKOWN ERROR";
		}
	}
	
	public ResponseStatusBean(String message) {
		super();
		this.code=STATUS_UNKNOWN_ERROR;
		this.message = message;
	}
	
	public ResponseStatusBean(Map<String, Integer> details) {
		super();
		this.code=STAUTS_PARAMETERS_ERROR;
		this.details = details;
	}

	public void addParametersError(String paramName,int value){
		this.code=STAUTS_PARAMETERS_ERROR;
		if(this.details==null){
			this.details=new HashMap<String,Integer>();
		}
		this.details.put(paramName, value);
	}
	
	public void addParametersNotAllowEmptyError(String paramName){
		this.addParametersError(paramName, PARAMETER_NOT_ALLOW_EMPTY);
	}
	
	public void addParametersDataDuplicateError(String paramName){
		this.addParametersError(paramName, PARAMETER_DATA_DUPLICATE);
	}
	
	public void addParametersBadDataFormatSpecError(String paramName){
		this.addParametersError(paramName, PARAMETER_BAD_DATA_FORMAT_SPECIFICATIONS);
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	
}
