package com.keji09.erp.api.controller;

import com.keji09.erp.model.CouponEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.SmsEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsPromotionUrlGenerateRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsPromotionUrlGenerateResponse;
import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.criterion.Criterion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * 
 */
@Controller
@RequestMapping("/app_sms")
public class SmsController extends XDAOSupport {

	@Autowired
	private PopHttpClient client;

	/**
	 * 生成推广链接
	 * https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.promotion.url.generate
	 */
	@RequestMapping(value="get",method = RequestMethod.GET)
	@ResponseBody
	public Object generate(
			@RequestParam(value = "phone") String phone,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		SmsEntity sms = new SmsEntity();
		boolean register =  this.getMemberEntityDAO().exist(HDaoUtils.eq("username",phone).toCondition());
		//sms.setCode((int)((Math.random()*9+1)*100000)+"");
		sms.setCode("1234");
		sms.setPhone(phone);
		this.getSmsEntityDAO().create(sms);
		map.put("msg","发送成功,请注意查收.");
		map.put("flag",true);
		map.put("register",register);
		return map;
	}

}