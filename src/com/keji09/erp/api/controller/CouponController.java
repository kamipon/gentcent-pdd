package com.keji09.erp.api.controller;

import com.keji09.erp.model.BillEntity;
import com.keji09.erp.model.CouponEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.OrderEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsDetailRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsPromotionUrlGenerateRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsSearchRequest;
import com.pdd.pop.sdk.http.api.request.PddGoodsCatsGetRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsDetailResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsPromotionUrlGenerateResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsSearchResponse;
import com.pdd.pop.sdk.http.api.response.PddGoodsCatsGetResponse;
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
@RequestMapping("/app_coupon")
public class CouponController extends XDAOSupport {

	@Autowired
	private PopHttpClient client;

	/**
	 * 生成推广链接
	 * https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.promotion.url.generate
	 */
	@RequestMapping(value="generate",method = RequestMethod.GET)
	@ResponseBody
	public Object generate(
			@RequestParam(value = "id") Long id, //拼多多商品id
			@RequestParam(value = "name") String name, //拼多多商品id
			@RequestParam(value = "money") Integer money, //拼多多商品id
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		if(money<0){
			map.put("flag",false);
			map.put("msg","创建失败,请刷新页面后重新尝试!");
			return  map;
		}
		MemberEntity member = (MemberEntity)req.getSession().getAttribute("member");
		member = this.getMemberEntityDAO().get(member.getId());
		if(member.getMoney()<money){
			map.put("flag",false);
			map.put("msg","创建失败,余额不足!");
			return  map;
		}
		member.setMoney(member.getMoney()-money);
		PddDdkGoodsPromotionUrlGenerateRequest request = new PddDdkGoodsPromotionUrlGenerateRequest();
		List<Long> goodsIdList = new ArrayList<Long>();
		goodsIdList.add(id);
		request.setPId(member.getPid());
		request.setGoodsIdList(goodsIdList);
		request.setGenerateWeiboappWebview(true);
		request.setGenerateWeApp(true);
		request.setGenerateWeiboappWebview(true);
		request.setGenerateMallCollectCoupon(true);
		request.setGenerateSchemaUrl(true);
		request.setGenerateQqApp(true);
		CouponEntity coupon = new CouponEntity();
		coupon.setMemberId(member.getId());
		coupon.setGoodsId(id);
		coupon.setMoney(money);
		coupon.setGoodsName(name);
		BillEntity bill = new BillEntity();
		bill.setForm(2);
		bill.setMemberId(member.getId());
		bill.setActivityId(member.getActivity().getId());
		bill.setType(6);
		bill.setMoney(money);
		try{
			PddDdkGoodsPromotionUrlGenerateResponse response = client.syncInvoke(request);
			coupon.setWebUrl(response.getGoodsPromotionUrlGenerateResponse().getGoodsPromotionUrlList().get(0).getMobileShortUrl());
			this.getCouponEntityDAO().create(coupon);
			this.getMemberEntityDAO().update(member);
			this.getBillEntityDAO().create(bill);
			System.out.println( JsonUtil.transferToJson(response));
		}catch (Exception e){
			map.put("flag",false);
			map.put("msg","创建失败,请刷新页面后重新尝试!");
			e.printStackTrace();
			return  map;
		}
		map.put("flag",true);
		map.put("coupon",coupon);
		return map;
	}

	/**
	 * 优惠券列表
	 */
	@RequestMapping(value="list",method = RequestMethod.GET)
	@ResponseBody
	public Object getCaptcha(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
			HttpServletRequest req,
			ModelMap map) {
		MemberEntity member = (MemberEntity)req.getSession().getAttribute("member");
		Exp<Criterion> exp =  HDaoUtils.eq("memberId",member.getId());
		PaginationList<CouponEntity> orderList = this.getCouponEntityDAO().list(exp.toCondition(),pageIndex,pageSize);
		map.put("couponList",orderList.getItems());
		map.put("total",orderList.getTotalCount());//总条数
		return map;
	}
}