package com.keji09.pdd.service;

import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkCmsPromUrlGenerateRequest;
import com.pdd.pop.sdk.http.api.request.PddDdkResourceUrlGenRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkCmsPromUrlGenerateResponse;
import com.pdd.pop.sdk.http.api.response.PddDdkResourceUrlGenResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * @author zuozhi
 * @since 2020-02-14
 */
@Service
public class IndexService {
	@Autowired
	private PopHttpClient client;
	
	/**
	 * 生成频道推广链接
	 */
	public PddDdkCmsPromUrlGenerateResponse promUrlGen(Integer channelType) {
		
		PddDdkCmsPromUrlGenerateRequest request = new PddDdkCmsPromUrlGenerateRequest();
		request.setWeAppWebViewShortUrl(false);
		request.setWeAppWebViewUrl(false);
		request.setChannelType(channelType);
		ArrayList<String> pids = new ArrayList<>();
		pids.add(Constants.PDD_PID);
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
	public PddDdkResourceUrlGenResponse resourceUrlGen(Integer resourceType) {
		PddDdkResourceUrlGenRequest request = new PddDdkResourceUrlGenRequest();
		request.setPid(Constants.PDD_PID);
		request.setResourceType(resourceType);
		try {
			return client.syncInvoke(request);
		} catch (Exception e) {
			return null;
		}
	}
	
}
