package com.keji09.pdd.controller;

import com.keji09.pdd.bean.ThemeItemBean;
import com.keji09.pdd.service.IndexService;
import com.keji09.pdd.service.PddCacheMap;
import com.keji09.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsRecommendGetRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsSearchRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkTopGoodsListQueryRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsRecommendGetResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsSearchResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkTopGoodsListQueryResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	private PddCacheMap pddCacheMap;
	@Autowired
	private IndexService indexService;
	
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
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("flag", false);
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
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("flag", false);
			map.put("msg", "连接超时");
		}
		return map;
	}
	
	/**
	 * 运营频道商品
	 */
	@RequestMapping(value = "goods/recommend", method = RequestMethod.GET)
	@ResponseBody
	public Object recommendGoods(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			@RequestParam(value = "channelType", defaultValue = "1") Integer channelType,//0, "1.9包邮", 1, "今日爆款", 2, "品牌清仓", 非必填 ,默认是1
			ModelMap map) {
		PddDdkGoodsRecommendGetRequest request = new PddDdkGoodsRecommendGetRequest();
		request.setOffset((pageIndex - 1) * pageSize);
		request.setLimit(pageSize);
		request.setChannelType(channelType);
		try {
			PddDdkGoodsRecommendGetResponse response = client.syncInvoke(request);
			map.put("data", response);
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("flag", false);
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
		if (pddCacheMap.themeList.size() > 0) {
			map.put("data", pddCacheMap.themeList);
			map.put("flag", true);
		} else {
			try {
				List<ThemeItemBean> list = pddCacheMap.loadThemeList();
				if (list.size() > 0) {
					map.put("data", list);
					map.put("flag", true);
					return map;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			map.put("flag", false);
			map.put("msg", "连接超时");
		}
		return map;
	}
	
	/**
	 * 频道推广链接
	 */
	@RequestMapping(value = "resource/url", method = RequestMethod.GET)
	@ResponseBody
	public Object resourceUrlGen(ModelMap map) {
		if (pddCacheMap.urlList1.size() > 0 && pddCacheMap.urlList2.size() > 0) {
			map.put("data1", pddCacheMap.urlList1);
			map.put("data2", pddCacheMap.urlList2);
			map.put("flag", true);
		} else {
			try {
				List<String> list1 = pddCacheMap.loadUrlList1();
				List<String> list2 = pddCacheMap.loadUrlList2();
				if (list1.size() > 0 && list2.size() > 0) {
					map.put("data1", list1);
					map.put("data2", list2);
					map.put("flag", true);
					return map;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			map.put("flag", false);
			map.put("msg", "连接超时");
		}
		return map;
	}
	
}