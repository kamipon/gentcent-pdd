package com.keji09.erp.jstl.tag;

import com.keji09.erp.bean.MenuTreeBean;
import com.keji09.erp.model.role.UserMenuEntity;
import com.keji09.erp.utils.TreeUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 根据用户，返回对应权限树type11
 */
public class PermissionTreeTag extends BaseTag {
	
	/**
	 * 用户id
	 */
	private String userId;
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		String result = "";
		
		try {
			List<UserMenuEntity> list = getMenus(userId);
			List<MenuTreeBean> trees = new ArrayList<MenuTreeBean>();
			
			if (list != null && list.size() > 0) {
				trees = MenuTreeBean.transTree(list);
				trees = (List<MenuTreeBean>) TreeUtils.buildTree(trees);
			} else {
				list = new ArrayList<UserMenuEntity>();
			}
			
			getJspContext().setAttribute(getVar(), trees);
			
			result = getTagBody();
			out.println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
}
