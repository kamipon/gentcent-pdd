package com.keji09.pdd.service;

import com.keji09.pdd.bean.ThemeItemBean;
import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkThemeListGetRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkThemePromUrlGenerateRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkCmsPromUrlGenerateResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkResourceUrlGenResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkThemeListGetResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkThemeListGetResponse.ThemeListGetResponseThemeListItem;
import com.pdd.pop.sdk.http.api.response.PddDdkThemePromUrlGenerateResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkThemePromUrlGenerateResponse.ThemePromotionUrlGenerateResponseUrlListItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

/**
 * pdd信息缓存
 *
 * @author zuozhi
 * @since 2020-02-14
 */
@Service
public class PddCacheMap {
	@Autowired
	private PopHttpClient client;
	@Autowired
	private IndexService indexService;
	
	final static int ONE_SECOND = 1000;
	final static int ONE_MINUTE = ONE_SECOND * 60;
	
	//	多多进宝主题列表
	public List<ThemeItemBean> themeList = new ArrayList<ThemeItemBean>();
	//	多多进宝频道推广链接1
	public List<String> urlList1 = new ArrayList<String>();
	//	多多进宝频道推广链接2
	public List<String> urlList2 = new ArrayList<String>();
	
	public PddCacheMap() {
		new Timer().schedule(new TimerTask() {
			@Override
			public void run() {
				try {
					loadThemeList();
					loadUrlList1();
					loadUrlList2();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}, ONE_SECOND*10, ONE_MINUTE * 10);
	}
	
	/**
	 * 加载多多进宝主题列表
	 */
	public List<ThemeItemBean> loadThemeList() throws Exception {
		List<Long> themeIdList = new ArrayList<Long>();
		//查询列表
		PddDdkThemeListGetRequest request = new PddDdkThemeListGetRequest();
		PddDdkThemeListGetResponse response = client.syncInvoke(request);
		for (int i = 0; i < response.getThemeListGetResponse().getThemeList().size(); i++) {
			ThemeListGetResponseThemeListItem item = response.getThemeListGetResponse().getThemeList().get(i);
			themeIdList.add(item.getId());
		}
		
		//生成链接
		PddDdkThemePromUrlGenerateRequest request2 = new PddDdkThemePromUrlGenerateRequest();
		request2.setPid(Constants.PDD_PID);
		request2.setThemeIdList(themeIdList);
		
		//这里直接调用会发生拼多多系统内部异常
		TimeUnit.MILLISECONDS.sleep(1000);
		
		PddDdkThemePromUrlGenerateResponse response2 = client.syncInvoke(request2);
		if (response2.getErrorResponse() != null) {
			String errorMsg = response2.getErrorResponse().getErrorMsg();
			System.err.println(errorMsg);
			return themeList;
		}
		
		for (int i = 0; i < themeIdList.size(); i++) {
			ThemeListGetResponseThemeListItem item = response.getThemeListGetResponse().getThemeList().get(i);
			ThemePromotionUrlGenerateResponseUrlListItem urlItem = response2.getThemePromotionUrlGenerateResponse().getUrlList().get(i);
			themeList.add(new ThemeItemBean(item, urlItem.getUrl()));
		}
		
		System.out.println("多多进宝主题列表 - - -加载完成：" + themeIdList.size() + "条");
		return themeList;
	}
	
	/**
	 * 加载多多进宝频道推广链接1
	 */
	public List<String> loadUrlList1() throws Exception {
		List<String> temp = new ArrayList<String>();
		final Integer[] allChannelType = {0, 1, 2};
		for (Integer type : allChannelType) {
			PddDdkCmsPromUrlGenerateResponse response = indexService.promUrlGen(type);
			if (response == null || response.getCmsPromotionUrlGenerateResponse() == null) {
				System.err.println("loadUrlList1 出错 type：" + type);
				return null;
			} else {
				temp.add(response.getCmsPromotionUrlGenerateResponse().getUrlList().get(0).getUrl());
			}
		}
		System.out.println("多多进宝频道推广链接1 - - -加载完成：" + urlList1.size() + "条");
		urlList1 = temp;
		return urlList1;
	}
	
	/**
	 * 加载多多进宝频道推广链接2
	 */
	public List<String> loadUrlList2() throws Exception {
		List<String> temp = new ArrayList<String>();
		final Integer[] allResourceType = {4, 39997, 39999, 39996};
		for (Integer type : allResourceType) {
			PddDdkResourceUrlGenResponse response = indexService.resourceUrlGen(type);
			if (response == null || response.getResourceUrlResponse() == null) {
				System.err.println("loadUrlList1 出错 type：" + type);
				return null;
			} else {
				temp.add(response.getResourceUrlResponse().getSingleUrlList().getUrl());
			}
		}
		System.out.println("多多进宝频道推广链接2 - - -加载完成：" + urlList2.size() + "条");
		urlList2 = temp;
		return temp;
	}
}
