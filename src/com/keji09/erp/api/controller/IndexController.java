package com.keji09.erp.api.controller;

import com.keji09.erp.api.service.PddService;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsRecommendGetRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsSearchRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkThemeListGetRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkTopGoodsListQueryRequest;
import com.pdd.pop.sdk.http.api.response.*;
import com.pdd.pop.sdk.http.api.response.PddDdkCmsPromUrlGenerateResponse.CmsPromotionUrlGenerateResponseUrlListItem;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsRecommendGetResponse.GoodsBasicDetailResponseListItem;
import com.pdd.pop.sdk.http.api.response.PddDdkResourceUrlGenResponse.ResourceUrlResponseSingleUrlList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * app首页控制器
 */
@Controller
@RequestMapping("/app_index")
public class IndexController extends XDAOSupport {
	
	final static String PDD_PID = Constants.PDD_PID;
	@Autowired
	private PopHttpClient client;
	@Autowired
	private PddService pddService;
	
	/**
	 * 搜索商品
	 */
	@RequestMapping(value = "goods/search", method = RequestMethod.GET)
	@ResponseBody
	public Object dailyRecommendationGoods(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			ModelMap map) {
		PddDdkGoodsSearchRequest request = new PddDdkGoodsSearchRequest();
		request.setPage(pageIndex);
		request.setPageSize(pageSize);
		try {
			PddDdkGoodsSearchResponse response = client.syncInvoke(request);
			map.put("data", response);
			map.put("errcode", 200);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errcode", 500);
			map.put("msg", "连接超时");
		}
		return map;
	}
	
	/**
	 * 多多客获取爆款排行商品接口
	 */
	@RequestMapping(value = "goods/top", method = RequestMethod.GET)
	@ResponseBody
	public Object topGoodsList(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			ModelMap map) {
		PddDdkTopGoodsListQueryRequest request = new PddDdkTopGoodsListQueryRequest();
		request.setOffset((pageIndex - 1) * pageSize);
		request.setLimit(pageSize);
		try {
			PddDdkTopGoodsListQueryResponse response = client.syncInvoke(request);
			map.put("data", response);
			map.put("errcode", 200);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errcode", 500);
			map.put("msg", "连接超时");
		}
		return map;
	}
	
	/**
	 * 多多进宝主题列表查询
	 */
	@RequestMapping(value = "theme/list", method = RequestMethod.GET)
	@ResponseBody
	public Object themeList(ModelMap map) {
		PddDdkThemeListGetRequest request = new PddDdkThemeListGetRequest();
		try {
			PddDdkThemeListGetResponse response = client.syncInvoke(request);
			map.put("data", response.getThemeListGetResponse().getThemeList());
			map.put("errcode", 200);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errcode", 500);
			map.put("msg", "连接超时");
		}
		return map;
	}
	
	/**
	 * 多多进宝主题推广链接
	 */
	@RequestMapping(value = "theme/gen", method = RequestMethod.POST)
	@ResponseBody
	public Object themeUrlGen(
			@RequestParam(value = "id") Long id,
			HttpServletRequest req, ModelMap map) {
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		PddDdkThemePromUrlGenerateResponse response = pddService.themeUrlGen(member.getPid(), id);
		try {
			PddDdkThemePromUrlGenerateResponse.ThemePromotionUrlGenerateResponseUrlListItem item = response.getThemePromotionUrlGenerateResponse().getUrlList().get(0);
			map.put("data", item);
			map.put("errcode", 200);
		} catch (Exception e) {
			map.put("errcode", 500);
			map.put("msg", response.getErrorResponse().getErrorMsg());
		}
		return map;
	}
	
	/**
	 * 生成频道推广链接2
	 */
	@RequestMapping(value = "resource/gen", method = RequestMethod.POST)
	@ResponseBody
	public Object resourceUrlGen(
			@RequestParam(value = "type") Integer type, //4-限时秒杀,39997-充值中心, 39999-电器城，39996-百亿补贴
			HttpServletRequest req, ModelMap map) {
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		PddDdkResourceUrlGenResponse response = pddService.resourceUrlGen(member.getPid(), type);
		try {
			ResourceUrlResponseSingleUrlList item = response.getResourceUrlResponse().getSingleUrlList();
			map.put("data", item);
			map.put("errcode", 200);
		} catch (Exception e) {
			map.put("errcode", 500);
			map.put("msg", response.getErrorResponse().getErrorMsg());
		}
		return map;
	}
	
	/**
	 * 运营频道推广链接
	 */
	@RequestMapping(value = "channel/gen", method = RequestMethod.POST)
	@ResponseBody
	public Object channelUrlGen(
			@RequestParam(value = "type") Integer channelType, //0, "1.9包邮", 1, "今日爆款", 2, "品牌清仓", 非必填 ,默认是1
			HttpServletRequest req, ModelMap map) {
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		PddDdkCmsPromUrlGenerateResponse response = pddService.channelUrlGen(member.getPid(), channelType);
		try {
			CmsPromotionUrlGenerateResponseUrlListItem item = response.getCmsPromotionUrlGenerateResponse().getUrlList().get(0);
			map.put("data", item);
			map.put("errcode", 200);
		} catch (Exception e) {
			map.put("errcode", 500);
			map.put("msg", response.getErrorResponse().getErrorMsg());
		}
		return map;
	}
	
	/**
	 * 运营频道商品
	 */
	@RequestMapping(value = "goods/channel", method = RequestMethod.GET)
	@ResponseBody
	public Object channelGoods(ModelMap map) { //0, "1.9包邮", 1, "今日爆款", 2, "品牌清仓", 非必填 ,默认是1
		try {
			PddDdkGoodsRecommendGetResponse response1 = pddService.channelGoods(0);
			List<GoodsBasicDetailResponseListItem> list1 = response1.getGoodsBasicDetailResponse().getList();
			PddDdkGoodsRecommendGetResponse response2 = pddService.channelGoods(1);
			List<GoodsBasicDetailResponseListItem> list2 = response1.getGoodsBasicDetailResponse().getList();
			PddDdkGoodsRecommendGetResponse response3 = pddService.channelGoods(2);
			List<GoodsBasicDetailResponseListItem> list3 = response1.getGoodsBasicDetailResponse().getList();
			map.put("list1", list1);
			map.put("list2", list2);
			map.put("list3", list3);
			map.put("errcode", 200);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errcode", 500);
			map.put("msg", "连接超时");
		}
		return map;
	}
	
}