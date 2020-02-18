package com.keji09.erp.api.filter;

import com.alibaba.fastjson.JSON;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.TokenEntity;
import com.keji09.erp.model.support.XDAOSupport;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zuozhi
 * @since 2020-02-17
 */
public class TokenInterceptors extends XDAOSupport implements HandlerInterceptor {
	
	private static final long ONE_DAY = 60 * 60 * 24;
	
	private static final long ONE_WEEK = ONE_DAY * 7;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
		String token = request.getParameter("token");
		if (token == null)
			return true;
		TokenEntity tokenEntity = (TokenEntity) getTokenEntityDAO().get(token);
		if (tokenEntity == null || System.currentTimeMillis() - tokenEntity.getAddTime().getTime() > ONE_WEEK) {
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
			PrintWriter writer = response.getWriter();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("tokenInvalid", Boolean.TRUE);
			writer.write(JSON.toJSONString(map));
			return false;
		}
		request.removeAttribute("token");
		MemberEntity member = this.getMemberEntityDAO().get(tokenEntity.getMemberId());
		request.getSession().setAttribute("member", member);
		if (System.currentTimeMillis() - tokenEntity.getAddTime().getTime() > ONE_DAY) {
			tokenEntity.setAddTime(new Date());
			getTokenEntityDAO().update(tokenEntity);
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
	
	}
	
	@Override
	public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
	
	}
}
