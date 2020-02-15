package com.keji09.pdd.controller;

import com.keji09.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsDetailRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsSearchRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsDetailResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsSearchResponse;
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
 */
@Controller
@RequestMapping("/app_goods")
public class GoodsController extends XDAOSupport {
	
	/**
	 * 商品详情 https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.detail
	 */
	@RequestMapping(value = "detail", method = RequestMethod.GET)
	@ResponseBody
	public Object getCaptcha(
			@RequestParam(value = "id") Long id,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {
		//id = 7440289L;
		//resp.addHeader("Access-Control-Allow-Origin", "*");
		String clientId = Constants.CLIENT_ID;
		String clientSecret = Constants.CLIENT_SECRET;
		try {
			PopHttpClient client = new PopHttpClient(clientId, clientSecret);
			PddDdkGoodsDetailRequest request = new PddDdkGoodsDetailRequest();
			List<Long> goodsIdList = new ArrayList<Long>();
			goodsIdList.add(id);
			request.setGoodsIdList(goodsIdList);
			PddDdkGoodsDetailResponse response = client.syncInvoke(request);
			return JsonUtil.transferToJson(response);
			//msg+=JsonUtil.transferToJson(response);
		} catch (Exception e) {
		}
		return map;
	}
	
	
	@RequestMapping(value = "opt", method = RequestMethod.GET)
	@ResponseBody
	public Object getOpt(
			@RequestParam(value = "ids") String ids,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {
		String clientId = Constants.CLIENT_ID;
		String clientSecret = Constants.CLIENT_SECRET;
		try {
			PopHttpClient client = new PopHttpClient(clientId, clientSecret);
			PddDdkGoodsSearchRequest request = new PddDdkGoodsSearchRequest();
			request.setPage(1);
			request.setPageSize(10);
			request.setOptId(Long.valueOf(ids.split(",")[0]));
			request.setWithCoupon(true);
			PddDdkGoodsSearchResponse response = client.syncInvoke(request);
			return JsonUtil.transferToJson(response);
			//msg+=JsonUtil.transferToJson(response);
		} catch (Exception e) {
		}
		return map;
	}
	
}