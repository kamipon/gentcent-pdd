package com.keji09.erp.api.controller;

import com.keji09.erp.api.service.PddCacheMap;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopClient;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsDetailRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsPromotionUrlGenerateRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsSearchRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsDetailResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsPromotionUrlGenerateResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsSearchResponse;
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
@RequestMapping("/app_goods")
public class GoodsController extends XDAOSupport {

	final static String PDD_PID = Constants.PDD_PID;

	@Autowired
	private PopHttpClient client;

	/**
	 * 商品详情 https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.detail
	 */
	@RequestMapping(value="detail",method = RequestMethod.GET)
	@ResponseBody
	public Object getCaptcha(
			@RequestParam(value = "id") Long id,
			ModelMap map) {
		//id = 7440289L;
		//id =86954697838L;
		//resp.addHeader("Access-Control-Allow-Origin", "*");
		try {
			PddDdkGoodsDetailRequest request = new PddDdkGoodsDetailRequest();
			List<Long> goodsIdList = new ArrayList<Long>();
			goodsIdList.add(id);
			//goodsIdList.add(86954697838L);
			request.setGoodsIdList(goodsIdList);
			PddDdkGoodsDetailResponse response = client.syncInvoke(request);
			System.out.println( "-------");
			System.out.println( JsonUtil.transferToJson(response));
			return  JsonUtil.transferToJson(response);
			//msg+=JsonUtil.transferToJson(response);
		}catch (Exception e){
		}
		return map;
	}

	/**
	 * 获取同类商品 id ,切割
	 */
	@RequestMapping(value="opt",method = RequestMethod.GET)
	@ResponseBody
	public Object getOpt(
			@RequestParam(value = "ids") String ids,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {
		try {
			PddDdkGoodsSearchRequest request = new PddDdkGoodsSearchRequest();
			request.setPage(1);
			request.setPageSize(10);
			request.setOptId(Long.valueOf(ids.split(",")[0]));
			request.setWithCoupon(true);
			PddDdkGoodsSearchResponse response = client.syncInvoke(request);
			return  JsonUtil.transferToJson(response);
			//msg+=JsonUtil.transferToJson(response);
		}catch (Exception e){
		}
		return map;
	}

	/**
	 * https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.promotion.url.generate
	 */
	@RequestMapping(value="generate",method = RequestMethod.GET)
	@ResponseBody
	public Object generate(
			@RequestParam(value = "id") String id,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		PddDdkGoodsPromotionUrlGenerateRequest request = new PddDdkGoodsPromotionUrlGenerateRequest();
		List<Long> goodsIdList = new ArrayList<Long>();
		goodsIdList.add(Long.valueOf(id));
		System.out.println( PDD_PID);
		request.setPId(PDD_PID);
		request.setGoodsIdList(goodsIdList);
		request.setGenerateWeiboappWebview(true);
		request.setGenerateWeApp(true);
		request.setGenerateWeiboappWebview(true);
		request.setGenerateMallCollectCoupon(true);
		request.setGenerateSchemaUrl(true);
		request.setGenerateQqApp(true);
		try{
			PddDdkGoodsPromotionUrlGenerateResponse response = client.syncInvoke(request);
			System.out.println( JsonUtil.transferToJson(response));
			return  JsonUtil.transferToJson(response);
		}catch (Exception e){
			e.printStackTrace();
		}
		return map;
	}

	@RequestMapping(value = "search", method = RequestMethod.GET)
	@ResponseBody
	public Object search(
			@RequestParam(value = "keyword") String keyword,
			@RequestParam(value = "sortType") Integer sortType,
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {

		PddDdkGoodsSearchRequest request = new PddDdkGoodsSearchRequest();
		request.setPage(pageIndex);
		request.setPageSize(10);
		if(keyword!=null&&!keyword.equals("")){
			request.setKeyword(keyword);
		}
		request.setSortType(sortType);
		request.setWithCoupon(true);
		PddDdkGoodsSearchResponse response;
		try {
			response = client.syncInvoke(request);
			return JsonUtil.transferToJson(response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}


}