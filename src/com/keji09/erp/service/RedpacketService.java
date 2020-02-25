package com.keji09.erp.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.keji09.erp.api.service.PddService;
import com.keji09.erp.bean.red.RedActivityBean;
import com.keji09.erp.bean.red.RedMemberBean;
import com.keji09.erp.bean.red.RedTerpointBean;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.PddPidEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.keji09.erp.utils.HttpClientUtil;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsPidGenerateResponse;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;

@Service
public class RedpacketService extends XDAOSupport {
	
	@Autowired
	HttpClientUtil httpClientUtil;
	@Autowired
	SessionFactory sessionFactory;
	@Autowired
	PermissionService permissionService;
	@Autowired
	PddService pddService;
	
	
	//-------------------------------------------------代理-------------------------------------------------
	
	/**
	 * 更新所有代理
	 */
	public void increaseTerpoint() {
		JSONObject jsonObject = httpClientUtil.doGet(Constants.redUrl + "/move/terpoint", new HashMap<String, String>());
		int code = jsonObject.getIntValue("code");
		if (code == 200) {
			JSONArray data = jsonObject.getJSONArray("data");
			for (int i = 0; i < data.size(); i++) {
				RedTerpointBean bean = data.getObject(i, RedTerpointBean.class);
				boolean exist = this.getTerPointEntityDAO().exist("redId", bean.getId());
				if (exist) {
					updateTerpoint(bean);
				} else {
					createTerpoint(bean);
				}
				System.out.println("同步红包派代理：" + (i + 1) + "/" + data.size());
			}
			System.out.println("同步红包派代理完毕");
		} else {
			System.out.println("同步红包派代理出错:" + code);
		}
	}
	
	/**
	 * 获取指定代理
	 */
	public TerPointEntity getTerpoint(String redId) {
		boolean exist = this.getTerPointEntityDAO().exist("redId", redId);
		if (exist) {
			return this.getTerPointEntityDAO().findUnique("redId", redId);
		}
		HashMap<String, String> map = new HashMap<>();
		map.put("id", redId);
		JSONObject jsonObject = httpClientUtil.doGet(Constants.redUrl + "/move/terpoint", map);
		int code = jsonObject.getIntValue("code");
		if (code == 200) {
			RedTerpointBean bean = jsonObject.getObject("data", RedTerpointBean.class);
			return createTerpoint(bean);
		} else {
			System.out.println("同步红包派代理出错:" + code);
			return null;
		}
	}
	
	/**
	 * 红包派bean转entity
	 */
	public TerPointEntity createTerpoint(RedTerpointBean bean) {
		Transaction transaction = sessionFactory.getCurrentSession().getTransaction();
		try {
			transaction.begin();
			UserEntity user = new UserEntity();
			user.setUsername(bean.getUsername());
			user.setPassword(bean.getPassword());
			user.setPicUrl(bean.getPicUrl());
			user.setRealName(bean.getRealName());
			user.setPhone(bean.getPhone());
			user.setJoinTime(bean.getAddTime());
			user.setQq(bean.getQq());
			user.setWeixin(bean.getWeixin());
			user.setEmail(bean.getEmail());
			user.setAddress(bean.getAddress());
			this.getUserEntityDAO().create(user);
			TerPointEntity ter = new TerPointEntity();
			ter.setName(bean.getName());
			ter.setProvince(bean.getProvince());
			ter.setCity(bean.getCity());
			ter.setUser(user);
			ter.setActivityNum(bean.getActivityNum());
			ter.setAddTime(bean.getAddTime());
			ter.setOverTime(bean.getOverTime());
			ter.setRedId(bean.getId());
			this.getTerPointEntityDAO().create(ter);
			permissionService.setRole(user.getId(), new String[]{"2"});
			transaction.commit();
			return ter;
		} catch (Exception e) {
			transaction.rollback();
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 红包派bean转entity
	 */
	public TerPointEntity updateTerpoint(RedTerpointBean bean) {
		Transaction transaction = sessionFactory.getCurrentSession().getTransaction();
		try {
			transaction.begin();
			TerPointEntity ter = this.getTerPointEntityDAO().findUnique("redId", bean.getId());
			UserEntity user = ter.getUser();
			user.setUsername(bean.getUsername());
			user.setPassword(bean.getPassword());
			user.setPicUrl(bean.getPicUrl());
			user.setRealName(bean.getRealName());
			user.setPhone(bean.getPhone());
			user.setJoinTime(bean.getAddTime());
			user.setQq(bean.getQq());
			user.setWeixin(bean.getWeixin());
			user.setEmail(bean.getEmail());
			user.setAddress(bean.getAddress());
			this.getUserEntityDAO().update(user);
			ter.setName(bean.getName());
			ter.setProvince(bean.getProvince());
			ter.setCity(bean.getCity());
			ter.setUser(user);
			ter.setActivityNum(bean.getActivityNum());
			ter.setAddTime(bean.getAddTime());
			ter.setOverTime(bean.getOverTime());
			this.getTerPointEntityDAO().update(ter);
			permissionService.setRole(user.getId(), new String[]{"2"});
			transaction.commit();
			return ter;
		} catch (Exception e) {
			transaction.rollback();
			e.printStackTrace();
			return null;
		}
	}
	
	//-------------------------------------------------商家-------------------------------------------------
	
	/**
	 * 同步所有商家
	 */
	public void increaseActivity() {
		JSONObject jsonObject = httpClientUtil.doGet(Constants.redUrl + "/move/activity", new HashMap<String, String>());
		int code = jsonObject.getIntValue("code");
		if (code == 200) {
			JSONArray data = jsonObject.getJSONArray("data");
			for (int i = 0; i < data.size(); i++) {
				RedActivityBean bean = data.getObject(i, RedActivityBean.class);
				boolean exist = this.getActivityEntityDAO().exist("redId", bean.getId());
				if (exist) {
					updateActivity(bean);
				} else {
					createActivity(bean);
				}
				System.out.println("同步红包派商家：" + (i + 1) + "/" + data.size());
			}
			System.out.println("同步红包派商家完毕");
		} else {
			System.out.println("同步红包派商家出错:" + code);
		}
	}
	
	/**
	 * 获取指定商家
	 */
	public ActivityEntity getActivity(String redId) {
		boolean exist = this.getActivityEntityDAO().exist("redId", redId);
		if (exist) {
			return this.getActivityEntityDAO().findUnique("redId", redId);
		}
		HashMap<String, String> map = new HashMap<>();
		map.put("id", redId);
		JSONObject jsonObject = httpClientUtil.doGet(Constants.redUrl + "/move/activity", map);
		int code = jsonObject.getIntValue("code");
		if (code == 200) {
			RedActivityBean bean = jsonObject.getObject("data", RedActivityBean.class);
			return createActivity(bean);
		} else {
			System.out.println("同步红包派代理出错:" + code);
			return null;
		}
	}
	
	/**
	 * 红包派bean转entity
	 */
	public ActivityEntity createActivity(RedActivityBean bean) {
		Transaction transaction = sessionFactory.getCurrentSession().getTransaction();
		try {
			transaction.begin();
			UserEntity user = new UserEntity();
			user.setUsername(bean.getUsername());
			user.setPassword(bean.getPassword());
			user.setPicUrl(bean.getPicUrl());
			user.setRealName(bean.getRealName());
			user.setPhone(bean.getPhone());
			user.setJoinTime(bean.getAddTime());
			user.setQq(bean.getQq());
			user.setWeixin(bean.getWeixin());
			user.setEmail(bean.getEmail());
			user.setAddress(bean.getAddress());
			this.getUserEntityDAO().create(user);
			ActivityEntity act = new ActivityEntity();
			act.setName(bean.getName());
			act.setTerpoint(getTerpoint(bean.getRedTerId()));
			act.setUser(user);
			act.setCategoryt(2);
			act.setOverTime(bean.getOverTime());
			act.setAddTime(bean.getAddTime());
			act.setRedId(bean.getId());
			this.getActivityEntityDAO().create(act);
			//给新增的商家设置商家角色
			permissionService.setRole(user.getId(), new String[]{"3"});
			transaction.commit();
			return act;
		} catch (Exception e) {
			transaction.rollback();
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 红包派bean转entity
	 */
	public ActivityEntity updateActivity(RedActivityBean bean) {
		Transaction transaction = sessionFactory.getCurrentSession().getTransaction();
		try {
			transaction.begin();
			ActivityEntity act = this.getActivityEntityDAO().findUnique("redId", bean.getId());
			UserEntity user = act.getUser();
			user.setUsername(bean.getUsername());
			user.setPassword(bean.getPassword());
			user.setPicUrl(bean.getPicUrl());
			user.setRealName(bean.getRealName());
			user.setPhone(bean.getPhone());
			user.setJoinTime(bean.getAddTime());
			user.setQq(bean.getQq());
			user.setWeixin(bean.getWeixin());
			user.setEmail(bean.getEmail());
			user.setAddress(bean.getAddress());
			this.getUserEntityDAO().update(user);
			act.setName(bean.getName());
			act.setTerpoint(getTerpoint(bean.getRedTerId()));
			act.setUser(user);
			act.setCategoryt(2);
			act.setOverTime(bean.getOverTime());
			act.setAddTime(bean.getAddTime());
			act.setRedId(bean.getId());
			this.getActivityEntityDAO().update(act);
			//给新增的商家设置商家角色
			permissionService.setRole(user.getId(), new String[]{"3"});
			transaction.commit();
			return act;
		} catch (Exception e) {
			transaction.rollback();
			e.printStackTrace();
			return null;
		}
	}
	
	//-------------------------------------------------用户-------------------------------------------------
	/**
	 * 获取指定用户
	 */
	public MemberEntity getMember(String redId) {
		boolean exist = this.getMemberEntityDAO().exist("redId", redId);
		if (exist) {
			return this.getMemberEntityDAO().findUnique("redId", redId);
		}
		HashMap<String, String> map = new HashMap<>();
		map.put("id", redId);
		JSONObject jsonObject = httpClientUtil.doGet(Constants.redUrl + "/move/member", map);
		int code = jsonObject.getIntValue("code");
		if (code == 200) {
			RedMemberBean bean = jsonObject.getObject("data", RedMemberBean.class);
			return createMember(bean);
		} else {
			System.out.println("获取红包派用户出错:" + code);
			return null;
		}
	}
	
	/**
	 * 红包派bean转entity
	 */
	public MemberEntity createMember(RedMemberBean bean) {
		Transaction transaction = sessionFactory.getCurrentSession().getTransaction();
		try {
			transaction.begin();
			ActivityEntity activity = getActivity(bean.getRedActId());
			TerPointEntity terpoint = activity.getTerpoint();
			MemberEntity member = new MemberEntity();
			member.setShotId(bean.getShotId());
			member.setUsername(bean.getUsername());
			member.setNick(bean.getNick());
			member.setRealName(bean.getRealName());
			member.setSex(bean.getSex());
			member.setPicUrl(bean.getPicUrl());
			member.setAddTime(bean.getAddTime());
			member.setTerpointId(terpoint.getId());
			member.setActivity(activity);
			member.setRedId(bean.getId());
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
			transaction.commit();
			return member;
		} catch (Exception e) {
			transaction.rollback();
			e.printStackTrace();
			return null;
		}
	}
	
}
