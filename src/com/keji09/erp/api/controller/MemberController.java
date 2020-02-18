package com.keji09.erp.api.controller;

import com.keji09.erp.api.service.PddService;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.PddPidEntity;
import com.keji09.erp.model.TokenEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.DAOException;
import com.mezingr.dao.HDaoUtils;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsPidGenerateResponse;
import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * 用户控制器
 */
@Controller
@RequestMapping("/app_member")
public class MemberController extends XDAOSupport {
	
	@Autowired
	SessionFactory sessionFactory;
	@Autowired
	PddService pddService;
	
	private static final long ONE_DAY = 60 * 60 * 24;
	private static final long ONE_WEEK = ONE_DAY * 7;
	
	/**
	 * 用户注册
	 */
	@RequestMapping(value = "register", method = RequestMethod.POST)
	@ResponseBody
	public Object register(
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "invcode") String invcode,
			@RequestParam(value = "authcode") String authcode,
			ModelMap map) {
		//TODO
		if (!"1234".equals(authcode)) {
			map.put("errcode", 10003);
			map.put("msg", "验证码错误");
			return map;
		}
		boolean exist = this.getMemberEntityDAO().exist("username", phone);
		if (exist) {
			map.put("errcode", 10002);
			map.put("msg", "该手机号已经被注册");
			return map;
		}
		boolean b = this.getActivityEntityDAO().exist("shotId", invcode);
		if (!b) {
			map.put("errcode", 10001);
			map.put("msg", "邀请码错误");
			return map;
		}
		
		//开启事务
		Transaction transaction = sessionFactory.getCurrentSession().getTransaction();
		transaction.begin();
		try {
			//注册
			ActivityEntity act = this.getActivityEntityDAO().findUnique("shotId", invcode);
			MemberEntity member = new MemberEntity();
			member.setUsername(phone);
			member.setPassword(password);
			member.setNick("用户" + RandomStringUtils.randomNumeric(8));
			member.setLoginLastTime(new Date());
			member.setPicUrl("https://cdn2.jianshu.io/assets/default_avatar/2-9636b13945b9ccf345bc98d0d81074eb.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240");
			member.setTerpointId(act.getTerpoint().getId());
			member.setActivity(act);
			this.getMemberEntityDAO().create(member);
			//创建推广位
			PddDdkGoodsPidGenerateResponse response = pddService.pidGen("member_shotid_" + member.getShotId());
			PddDdkGoodsPidGenerateResponse.PIdGenerateResponsePIdListItem item = response.getPIdGenerateResponse().getPIdList().get(0);
			Long createTime = item.getCreateTime();
			String pId = item.getPId();
			String pidName = item.getPidName();
			PddPidEntity pddPidEntity = new PddPidEntity();
			pddPidEntity.setPid(pId);
			pddPidEntity.setPidName(pidName);
			pddPidEntity.setAddTime(new Date(createTime));
			pddPidEntity.setMemberId(member.getId());
			this.getPddPidEntityDAO().create(pddPidEntity);
			member.setPid(pId);
			this.getMemberEntityDAO().update(member);
			//登录
			TokenEntity token = new TokenEntity(member.getId());
			this.getTokenEntityDAO().create(token);
			transaction.commit();
			map.put("token", token.getId());
			map.put("member", member);
			map.put("errcode", 200);
			return map;
		} catch (Exception e) {
			transaction.rollback();
			e.printStackTrace();
			map.put("msg", "系统内部错误");
			map.put("errcode", 500);
			return map;
		}
	}
	
	/**
	 * 令牌登录
	 */
	@RequestMapping(value = "login_token", method = RequestMethod.POST)
	@ResponseBody
	public Object login(
			@RequestParam(value = "token") String tokenId,
			ModelMap map) {
		boolean b = this.getTokenEntityDAO().exist("id", tokenId);
		if (!b) {
			map.put("msg", "登录信息失效");
			map.put("errcode", 10006);
			return map;
		}
		TokenEntity tokenEntity = this.getTokenEntityDAO().get(tokenId);
		if (System.currentTimeMillis() - tokenEntity.getAddTime().getTime() > ONE_WEEK) {
			map.put("msg", "登录信息失效");
			map.put("errcode", 10006);
			return map;
		}
		MemberEntity member = this.getMemberEntityDAO().get(tokenEntity.getMemberId());
		member.setLoginLastTime(new Date());
		this.getMemberEntityDAO().update(member);
		map.put("member", member);
		map.put("token", tokenId);
		map.put("errcode", 200);
		return map;
	}
	
	/**
	 * 用户登录
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	@ResponseBody
	public Object login(
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "password") String password,
			ModelMap map) {
		boolean exist1 = this.getMemberEntityDAO().exist("username", phone);
		if (!exist1) {
			map.put("errcode", 10005);
			map.put("msg", "该手机号还未注册");
			return map;
		}
		boolean exist2 = this.getMemberEntityDAO().exist(HDaoUtils.eq("username", phone).andEq("password", password).toCondition());
		if (!exist2) {
			map.put("errcode", 10004);
			map.put("msg", "密码错误");
			return map;
		}
		
		//登录
		MemberEntity member = this.getMemberEntityDAO().findUnique("username", phone);
		String sql = "DELETE FROM pdd_token WHERE _member_id = ?";
		TokenEntity token = null;
		
		Session session = sessionFactory.getCurrentSession();
		Transaction transaction = session.getTransaction();
		try {
			transaction.begin();
			session.createSQLQuery(sql).setString(0, member.getId()).executeUpdate();
			token = new TokenEntity(member.getId());
			this.getTokenEntityDAO().create(token);
			member.setLoginLastTime(new Date());
			this.getMemberEntityDAO().update(member);
			transaction.commit();
		} catch (Exception e) {
			e.printStackTrace();
			transaction.rollback();
			map.put("msg", "系统内部错误");
			map.put("errcode", 500);
			return map;
		}
		
		map.put("token", token.getId());
		map.put("member", member);
		map.put("errcode", 200);
		return map;
	}
	
	/**
	 * 手机验证码登录
	 */
	@RequestMapping(value = "login_authcode", method = RequestMethod.POST)
	@ResponseBody
	public Object loginAuthcode(
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "authcode") String authcode,
			ModelMap map) {
		//TODO
		if (!"1234".equals(authcode)) {
			map.put("errcode", 10003);
			map.put("msg", "验证码错误");
			return map;
		}
		boolean exist1 = this.getMemberEntityDAO().exist("username", phone);
		if (!exist1) {
			map.put("errcode", 10005);
			map.put("msg", "该手机号还未注册");
			return map;
		}
		
		//登录
		MemberEntity member = this.getMemberEntityDAO().findUnique("username", phone);
		String sql = "DELETE FROM pdd_token WHERE _member_id = ?";
		TokenEntity token = null;
		Session session = sessionFactory.getCurrentSession();
		Transaction transaction = session.getTransaction();
		try {
			transaction.begin();
			session.createSQLQuery(sql).setString(0, member.getId()).executeUpdate();
			token = new TokenEntity(member.getId());
			this.getTokenEntityDAO().create(token);
			member.setLoginLastTime(new Date());
			this.getMemberEntityDAO().update(member);
			transaction.commit();
		} catch (Exception e) {
			e.printStackTrace();
			transaction.rollback();
			map.put("msg", "系统内部错误");
			map.put("errcode", 500);
			return map;
		}
		
		map.put("token", token.getId());
		map.put("errcode", 200);
		return map;
	}
	
	/**
	 * 退出登录
	 */
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	@ResponseBody
	public Object logout(HttpServletRequest req, ModelMap map) {
		//登录
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		req.getSession().removeAttribute("member");
		
		String sql = "DELETE FROM pdd_token WHERE _member_id = ?";
		Session session = sessionFactory.getCurrentSession();
		Transaction transaction = session.getTransaction();
		try {
			transaction.begin();
			session.createSQLQuery(sql).setString(0, member.getId()).executeUpdate();
			transaction.commit();
		} catch (Exception e) {
			e.printStackTrace();
			transaction.rollback();
			map.put("msg", "系统内部错误");
			map.put("errcode", 500);
			return map;
		}
		map.put("errcode", 200);
		return map;
	}
	
	
}