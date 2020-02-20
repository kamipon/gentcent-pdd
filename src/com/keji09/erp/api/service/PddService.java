package com.keji09.erp.api.service;

import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.*;
import com.pdd.pop.sdk.http.api.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author zuozhi
 * @since 2020-02-14
 */
@Service
public class PddService {
	@Autowired
	private PopHttpClient client;
	
	/**
	 * 生成运营频道推广链接
	 */
	public PddDdkCmsPromUrlGenerateResponse channelUrlGen(String pid, Integer channelType) {
		
		PddDdkCmsPromUrlGenerateRequest request = new PddDdkCmsPromUrlGenerateRequest();
		request.setWeAppWebViewShortUrl(false);
		request.setWeAppWebViewUrl(false);
		request.setChannelType(channelType);
		ArrayList<String> pids = new ArrayList<>();
		pids.add(pid);
		request.setPIdList(pids);
		try {
			return client.syncInvoke(request);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 生成频道推广链接 2
	 */
	public PddDdkResourceUrlGenResponse resourceUrlGen(String pid, Integer resourceType) {
		PddDdkResourceUrlGenRequest request = new PddDdkResourceUrlGenRequest();
		request.setPid(pid);
		request.setResourceType(resourceType);
		try {
			return client.syncInvoke(request);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 生成主题推广链接
	 */
	public PddDdkThemePromUrlGenerateResponse themeUrlGen(String pid, Long themeId) {
		
		PddDdkThemePromUrlGenerateRequest request = new PddDdkThemePromUrlGenerateRequest();
		request.setPid(pid);
		List<Long> longs = new ArrayList<>();
		longs.add(themeId);
		request.setThemeIdList(longs);
		try {
			return client.syncInvoke(request);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 运营频道商品
	 */
	public PddDdkGoodsRecommendGetResponse channelGoods(Integer channelType) {
		PddDdkGoodsRecommendGetRequest request = new PddDdkGoodsRecommendGetRequest();
		request.setOffset(0);
		request.setLimit(20);
		request.setChannelType(channelType);
		try {
			return client.syncInvoke(request);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 创建推广位
	 */
	public PddDdkGoodsPidGenerateResponse pidGen(String pidName) {
		PddDdkGoodsPidGenerateRequest request = new PddDdkGoodsPidGenerateRequest();
		request.setNumber(1L);
		List<String> pidNameList = new ArrayList<>();
		pidNameList.add(pidName);
		request.setPIdNameList(pidNameList);
		try {
			return client.syncInvoke(request);
		} catch (Exception e) {
			return null;
		}
	}
	
}
