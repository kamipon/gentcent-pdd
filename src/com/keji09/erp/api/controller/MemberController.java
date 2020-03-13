package com.keji09.erp.api.controller;

import com.keji09.erp.api.service.PddService;
import com.keji09.erp.model.*;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.service.RedpacketService;
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
	@Autowired
	private RedpacketService redpacketService;
	
	private static final long ONE_DAY = 60 * 60 * 24;
	private static final long ONE_WEEK = ONE_DAY * 7;
	
	/**
	 * 用户注册
	 */
	@RequestMapping(value = "register", method = RequestMethod.POST)
	@ResponseBody
	public Object register(
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "invcode", required = false) String invcode,
			@RequestParam(value = "authcode", required = false) String authcode,
			@RequestParam(value = "wxMember", required = false) String wxMember,
			ModelMap map) {
		WXMemberEntity wxm = null;
		MemberEntity member = new MemberEntity();
		if (wxMember != null && !"".equals(wxMember)) {
			wxm = this.getWXMemberEntityDAO().get(wxMember);
			if (wxm != null) {
				member.setSex(wxm.getGender());
				member.setPicUrl(wxm.getAvatarUrl());
				member.setNick(wxm.getNickName());
				member.setWxMember(wxm.getId());
			} else {
				map.put("errcode", 10000);
				map.put("msg", "数据错误");
				return map;
			}
		}
		//TODO
		if (authcode != null && !"1234".equals(authcode)) {
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
		MemberEntity upMember = this.getMemberEntityDAO().findUnique(HDaoUtils.eq("shotId", invcode).toCondition());
		String supShotId = null;
		
		ActivityEntity act = null;
		if (upMember == null) {
			act = this.getActivityEntityDAO().get("40285581707b4e2701707b4f02c40002");
		} else {
			act = upMember.getActivity();
			supShotId = upMember.getShotId();
		}
		
		//开启事务
		Transaction transaction = sessionFactory.getCurrentSession().getTransaction();
		transaction.begin();
		try {
			//注册
			member.setUsername(phone);
			member.setSupShotId(supShotId);
			member.setNick("用户" + RandomStringUtils.randomNumeric(8));
			member.setLoginLastTime(new Date());
			member.setPicUrl("http://pdd.chaoniuma.cn/picUrl.jpg");
			member.setTerpointId(act.getTerpoint().getId());
			member.setActivity(act);
			
			if (wxm != null) {
				member.setSex(wxm.getGender());
				member.setPicUrl(wxm.getAvatarUrl());
				member.setNick(wxm.getNickName());
				member.setWxMember(wxm.getId());
			}
			
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
	 * 红包派登录
	 */
	@RequestMapping(value = "login_red", method = RequestMethod.POST)
	@ResponseBody
	public Object loginRed(
			@RequestParam(value = "redId") String redId,
			ModelMap map) {
		MemberEntity member = redpacketService.getMember(redId);
		if (member == null) {
			map.put("msg", "用户登录失败");
			map.put("errcode", 10007);
			return map;
		}
		if (member.getUsername() == null || "".equals(member.getUsername())) {
			map.put("msg", "用户登录失败，请绑定手机号");
			map.put("errcode", 10008);
			return map;
		}
		//登录
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
		map.put("member", member);
		map.put("token", token.getId());
		map.put("errcode", 200);
		return map;
	}
	
	/**
	 * 绑定手机号并登录
	 */
	@RequestMapping(value = "bind_phone", method = RequestMethod.POST)
	@ResponseBody
	public Object loginAndBindPhone(
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "redId") String redId,
			@RequestParam(value = "authcode", required = false) String authcode,
			@RequestParam(value = "wxMember", required = false) String wxMember,
			ModelMap map) {
		
		//TODO:
		if (authcode != null && !"1234".equals(authcode)) {
			map.put("errcode", 10003);
			map.put("msg", "验证码错误");
			return map;
		}
		MemberEntity member;
		boolean ex = this.getMemberEntityDAO().exist("username", phone);
		if (ex) {
			member = this.getMemberEntityDAO().findUnique("username", phone);
		} else {
			member = redpacketService.getMember(redId);
			if (member == null) {
				map.put("msg", "用户登录失败");
				map.put("errcode", 10007);
				return map;
			}
			member.setUsername(phone);
			this.getMemberEntityDAO().update(member);
		}
		WXMemberEntity wxm;
		if (wxMember != null && !"".equals(wxMember)) {
			wxm = this.getWXMemberEntityDAO().get(wxMember);
			if (wxm != null) {
				member.setSex(wxm.getGender());
				member.setPicUrl(wxm.getAvatarUrl());
				member.setNick(wxm.getNickName());
				member.setWxMember(wxm.getId());
			} else {
				map.put("errcode", 10000);
				map.put("msg", "数据错误");
				return map;
			}
		}
		
		//登录
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
		map.put("member", member);
		map.put("token", token.getId());
		map.put("errcode", 200);
		return map;
	}
	
	/**
	 * 令牌登录
	 */
	@RequestMapping(value = "login_token", method = RequestMethod.POST)
	@ResponseBody
	public Object loginToken(
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
			@RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "wxMember", required = false) String wxMember,
			ModelMap map) {
		WXMemberEntity wxm;
		MemberEntity member;
		if (wxMember != null && !"".equals(wxMember)) {//微信登录
			wxm = this.getWXMemberEntityDAO().get(wxMember);
			member = this.getMemberEntityDAO().findUnique(HDaoUtils.eq("wxMember", wxm.getId()).toCondition());
			if (member == null) {
				map.put("errcode", 10000);
				map.put("msg", "数据错误");
				return map;
			}
			if (wxm != null) {
				member.setSex(wxm.getGender());
				member.setPicUrl(wxm.getAvatarUrl());
				member.setNick(wxm.getNickName());
				member.setWxMember(wxm.getId());
				this.getMemberEntityDAO().update(member);
			} else {
				map.put("errcode", 10000);
				map.put("msg", "数据错误");
				return map;
			}
		} else {//账号登录
			boolean exist1 = this.getMemberEntityDAO().exist("username", phone);
			if (!exist1) {
				map.put("errcode", 10005);
				map.put("msg", "该手机号还未注册");
				return map;
			}
			if (code != null) {
				boolean exist2 = this.getSmsEntityDAO().exist(HDaoUtils.eq("code", code).andEq("phone", phone).toCondition());
				if (!exist2 && (wxMember == null || wxMember.equals(""))) {
					map.put("errcode", 10004);
					map.put("msg", "验证码错误!");
					return map;
				}
			}
			//登录
			member = this.getMemberEntityDAO().findUnique("username", phone);
		}
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
	
	/**
	 * 查询优惠券个数
	 */
	@RequestMapping(value = "couponNum", method = RequestMethod.GET)
	@ResponseBody
	public Object couponNum(HttpServletRequest req, ModelMap map) {
		//登录
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		Integer num = this.getCouponEntityDAO().count(HDaoUtils.eq("memberId", member.getId()).toCondition());
		if (num == null) {
			num = 0;
		}
		map.put("errcode", 200);
		map.put("num", num);
		return map;
	}
	
	/**
	 * 查询微信用户信息
	 */
	@RequestMapping(value = "wxMember", method = RequestMethod.GET)
	@ResponseBody
	public Object wxMember(
			@RequestParam(value = "id") String id,
			HttpServletRequest req, ModelMap map) {
		WXMemberEntity wxMember = this.getWXMemberEntityDAO().get(id);
		if (wxMember == null) {
			map.put("errcode", 404);
			map.put("wxMember", null);
		}
		map.put("errcode", 200);
		map.put("wxMember", wxMember);
		return map;
	}
	
	
}