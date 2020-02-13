package com.keji09.erp.jstl.tag;

import java.io.StringWriter;
import java.util.List;

import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.keji09.erp.model.role.UserMenuEntity;
import com.keji09.erp.service.CmsService;
import com.keji09.erp.utils.SpringContextHolder;
import com.mezingr.dao.HDaoUtils;

/**
 * 基础控件，一些公用方法
 */
public abstract class BaseTag extends SimpleTagSupport{
	
	private CmsService cmsService = SpringContextHolder.getCmsService();
	/**
	 * 控件id
	 */
	protected String id;
	/** 
	 * 页面使用key
	 */
	protected String var;
	
	public String getVar() {
		return var;
	}
	public void setVar(String var) {
		this.var = var;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
	/********** 业务相关 **************/
	
	/**
	 * 获取控件标签内容
	 * @return
	 */
	public String getTagBody() {
		String tagBody = "";
		try {
			StringWriter sw = new StringWriter();
			try {
				getJspBody().invoke(sw);
			} catch (Exception e) {
				e.printStackTrace();
			}
			tagBody = sw.toString();
		} catch (NullPointerException e) {
			// 如果标签体为空，会报错如<cms:></cms>
		}
		return tagBody;
	}
	
	
	
	/******************数据库查询*******************/
	
	

	/**
	 * 用户是否有菜单权限
	 */
	protected boolean hasMenu(String userId,String menuId,String code) {
		boolean f = cmsService.getUserMenuEntityDAO().exist(HDaoUtils.eq("user", userId).andEq("menu.id", menuId).orEq("code", code).toCondition());
		return f;
	}
	
	protected List<UserMenuEntity> getMenus(String userId) {
		List<UserMenuEntity> list = cmsService.getUserMenuEntityDAO().list(HDaoUtils.eq("user", userId).toCondition());
		return list;
	}
	
	
	
}
