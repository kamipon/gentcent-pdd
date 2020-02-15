package com.keji09.erp.utils;



/**
 * 静态字段
 */
public class Constants {
	
	
	/**
	 * 拼多多测试推广位Id
	 */
	public static final String  PDD_PID = PropertiesUtil.getProperty("project.pid");
	/**
	 * 拼多多 clientId
	 */
	public static final String  CLIENT_ID = PropertiesUtil.getProperty("project.clientId");
	/**
	 * 拼多多 clientSecret
	 */
	public static final String  CLIENT_SECRET = PropertiesUtil.getProperty("project.clientSecret");

	/**
	 * 项目绝对路径，如D\:/G/workbench/myeclipse9_workplace/11cms/WebRoot
	 */
	public static final String PROJECT_REAL_PATH = PropertiesUtil.getProperty("project.realpath");
	
	/**
	 * 项目host，如localhost
	 */
	public static final String PROJECT_HOST = PropertiesUtil.getProperty("project.host");
	/**
	 * 图片存放项目根目录
	 */
	public static final String PROJECT_SYSTEM_HOST = PropertiesUtil.getProperty("project.system.root");
	/**
	 * 非站点用户图片保存路径如：system
	 */
	public static final String RPOJECT_SYSTEM = PropertiesUtil.getProperty("project.system");
	/**
	 * 站点用户图片保存路径如：D\:/store
	 */
	public static final String RPOJECT_STORE_ROOT = PropertiesUtil.getProperty("project.store.root");
	/**
	 * 用户上传文件目录名，upload
	 */
	public static final String PROJECT_UPLOAD = PropertiesUtil.getProperty("project.upload");
	/**
	 * 用户上传图片大小，maxUploadSize
	 */
	public static final String MAXUPLOAD_SIZE = PropertiesUtil.getProperty("project.maxUploadSize");
	/**
	 * appid
	 */
	public static final String PROJECT_APPID = PropertiesUtil.getProperty("sms.appid");
	/**
	 * secret
	 */
	public static final String PROJECT_SECRET = PropertiesUtil.getProperty("sms.secret");
	/**
	 * template
	 */
	public static final String PROJECT_TEMPLATE = PropertiesUtil.getProperty("sms.template");
	/**
	 * signName
	 */
	public static final String PROJECT_SIGNNAME= PropertiesUtil.getProperty("sms.signName");

	
}
