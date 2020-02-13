package com.keji09.weixin.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;

import com.keij09.weixin.core.WeixinCore;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.HDaoUtils;
/**
 * 微信用户控制器
 *
 */
@Controller
public class MemberController extends XDAOSupport{

	/**
	 * 创建用户/更新用户
	 * @param openId 
	 * @param isAttention 是否关注
	 * @param city 地区
	 * @param sex 性别
	 * @param nickname 昵称
	 * @param headimgurl 头像
	 * 
	 */
	public MemberEntity initUser(String openId,Boolean isAttention,String city,String sex,String nickname,String headimgurl){
		//ue关注者
		MemberEntity ue=this.getMemberEntityDAO().findUnique(HDaoUtils.eq("openId", openId).toCondition());
		if(ue!=null){
			ue.setCity(city);
			Integer s=1;
			if(sex.equals("1")){
				s=1;
			}else{
				s=2;
			}
			ue.setOpenId(openId);
			ue.setSex(s);
			ue.setNick(WeixinCore.filterEmoji(nickname));
			ue.setPicUrl(headimgurl);
			ue.setLoginLastTime(new Date());
			this.getMemberEntityDAO().update(ue);
		}else{
			ue=new MemberEntity();
			ue.setCity(city);
			Integer s=1;
			if(sex.equals("1")){
				s=1;
			}else{
				s=2;
			}
			ue.setOpenId(openId);
			ue.setSex(s);
			ue.setNick(WeixinCore.filterEmoji(nickname));
			ue.setPicUrl(headimgurl);
			ue.setLoginLastTime(new Date());
			ue.setAddTime(new Date());
			this.getMemberEntityDAO().create(ue);
		}
		return ue;
	}
}
