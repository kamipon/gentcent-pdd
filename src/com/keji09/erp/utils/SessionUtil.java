package com.keji09.erp.utils;

import com.keji09.erp.model.TerPointEntity;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class SessionUtil {
	
	public static HttpSession getSession() {
		RequestAttributes ra = RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = ((ServletRequestAttributes) ra).getRequest();
		HttpSession httpSession = request.getSession();
		return httpSession;
	}
	
	public static Object getAttribute(String name) {
		Object temp = getSession().getAttribute(name);
		return temp;
	}
	
	public static void setAttribute(String name, Object value) {
		getSession().setAttribute(name, value);
	}
	
	/**
	 * 仅登录后商户用
	 */
	public static TerPointEntity getTerPoint() {
		TerPointEntity terpoint = null;
		Object temp = getSession().getAttribute("terpoint");
		if (temp != null) {
			terpoint = (TerPointEntity) temp;
		}
		return terpoint;
	}
	
	/**
	 * 仅登录后商户用
	 */
	public static String getDomain() {
		String domain = null;
		Object temp = getSession().getAttribute("domain");
		if (temp != null) {
			domain = temp.toString();
		}
		return domain;
	}
	
	/**
	 * 仅登录后商户用
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getUser() {
		Object temp = getSession().getAttribute("loginUser");
		return temp == null ? null : (T) temp;
	}
	
	/**
	 * 仅登录后商户用
	 */
	public static TerPointEntity getTerPoint(HttpServletRequest request) {
		TerPointEntity terpoint = null;
		Object temp = request.getSession().getAttribute("terpoint");
		if (temp != null) {
			terpoint = (TerPointEntity) temp;
		}
		return terpoint;
	}
	
	/**
	 * 仅登录后商户用
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getUser(HttpServletRequest request) {
		Object temp = request.getSession().getAttribute("loginUser");
		return temp == null ? null : (T) temp;
	}
}
