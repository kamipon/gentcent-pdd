package com.keji09.erp.utils;

import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Map;

public class HttpClientUtil {
	private CloseableHttpClient client;
	
	HttpClientUtil() {
		client = HttpClients.createDefault();
	}
	
	public  JSONObject doGet(String url, Map<String, String> params) {
		try {
			URIBuilder uriBuilder = new URIBuilder(url);
			for (String key : params.keySet()) {
				uriBuilder.addParameter(key, params.get(key));
			}
			HttpGet get = new HttpGet(uriBuilder.build());
			CloseableHttpResponse response = client.execute(get);
			
			// 服务器返回内容
			String respStr = null;
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				respStr = EntityUtils.toString(entity, "UTF-8");
			}
			// 释放资源
			EntityUtils.consume(entity);
			
			return JSONObject.parseObject(respStr);
		} catch (URISyntaxException | IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
