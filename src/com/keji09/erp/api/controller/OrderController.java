package com.keji09.erp.api.controller;

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
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 订单控制器
 */
@Controller
@RequestMapping("/app_order")
public class OrderController extends XDAOSupport {

	@Autowired
	private PopHttpClient client;

	/**
	 * 商品详情 https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.detail
	 */
	@RequestMapping(value="list",method = RequestMethod.GET)
	@ResponseBody
	public Object getCaptcha(
			@RequestParam(value = "status",defaultValue = "0") Integer status, //0全部 1已支付 2已结算 3已失效
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
			HttpServletRequest req,
			ModelMap map) {
		MemberEntity member = (MemberEntity)req.getSession().getAttribute("member");
		Exp<Criterion> exp =  HDaoUtils.eq("memberId",member.getId());
		if(status==1){
			exp.and(HDaoUtils.eq("orderStatus",0)
					.orEq("orderStatus",1)
					.orEq("orderStatus",2)
					.orEq("orderStatus",3));
		}else if(status==2){
			exp.and(HDaoUtils.eq("orderStatus",5));
		}else if(status==3){
			exp.and(HDaoUtils.eq("orderStatus",4));
		}
		PaginationList<OrderEntity> orderList = this.getOrderEntityDAO().list(exp.toCondition(),pageIndex,pageSize);
		map.put("orderList",orderList.getItems());
		map.put("total",orderList.getTotalCount());//总条数
		return map;
	}

	@RequestMapping(value="detail/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Object detail(
			@PathVariable(value = "id") String id, //0全部 1已支付 2已结算 3已失效
			HttpServletRequest req,
			ModelMap map) {
		OrderEntity order = this.getOrderEntityDAO().get(id);
		map.put("order",order);
		return map;
	}


}