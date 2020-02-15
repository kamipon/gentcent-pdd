package com.keji09.erp.jstl.tag;

import org.apache.commons.lang.StringUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import java.io.IOException;

/**
 * 根据用户是否有权限，是否输出标签体type12，菜单id和菜单code选一个使用
 */
public class PermissionTag extends BaseTag {
	
	/**
	 * 用户id
	 */
	private String userId;
	/**
	 * 菜单id,可选
	 */
	private String menuId;
	/**
	 * 菜单code,可选
	 */
	private String code;
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getMenuId() {
		return menuId;
	}
	
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
	
	@Override
	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		boolean f = false;
		
		try {
			if (StringUtils.isEmpty(menuId) && StringUtils.isEmpty(code)) {
				out.println("权限参数错误！");
			}
			
			f = hasMenu(userId, menuId, code);
			
			//如果有权限，才输出标签体
			if (f) {
				out.println(getTagBody());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
