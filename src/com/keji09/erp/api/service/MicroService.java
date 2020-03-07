package com.keji09.erp.api.service;

import com.keji09.erp.model.DictionaryEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.OrderEntity;
import com.mezingr.dao.HDaoUtils;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.*;
import com.pdd.pop.sdk.http.api.response.*;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author zuozhi
 * @since 2020-02-14
 */
@Service
public class MicroService {

	public static List<String> symbolList = Collections.synchronizedList(new ArrayList<String>());
	private final static String[] timeList ={"1","5","15","30","60","1D"} ;
	private static String BASE_URL ="http://ds.cnshuhai.com";
	private static String appId = "xbd144";
	private static String appSecret = "q237788284";
	/**
	 * 数据缓存
	 */
	public static Map<String,JSONArray> timeQuotation = new HashMap<>();

	Timer timer;
	public MicroService() {

		timer = new Timer();
        timer.schedule(new RemindTask(),10*1000, 1*1000);
		System.out.println("定时任务启动,准备更新行情！");
	}
	class RemindTask extends TimerTask {
		public void run() {
			//System.out.println("更新行情");
			Object list[] = symbolList.toArray();
			for (Object code: list) {
				for (String t: timeList) {
					JSONArray data = timeQuotation(code.toString(),t,1000);
					timeQuotation.put(code+"_"+t,data);
				}

			}
		}
	}
	public static JSONArray timeQuotation(String code, String time, Integer count)
	{
		String url = BASE_URL + "/stock.php?type=kline&num=" + count + "&line=min," + time + "&symbol=" + code + "&u=" + appId + "&p=" + appSecret;
		if (time.equals("1D")||time.equals("1W")||time.equals("1M")) {
			url = BASE_URL + "/stock.php?type=kline&num=" + count + "&line=day&symbol=" + code + "&u=" + appId + "&p=" + appSecret;
		}
		String result = doGet(url, null, "UTF-8");
		JSONArray array= JSONArray.fromObject(result);
		return array;
	}
	public static String doGet(String url,Map<String,String> params,String charset){
		if(StringUtils.isBlank(url)){
			return null;
		}
		try {
			if(params != null && !params.isEmpty()){
				List<BasicNameValuePair> pairs = new ArrayList<>(params.size());
				for(Map.Entry<String,String> entry : params.entrySet()){
					String value = entry.getValue();
					if(value != null){
						pairs.add(new BasicNameValuePair(entry.getKey(),value));
					}
				}
				url += "?" + EntityUtils.toString(new UrlEncodedFormEntity(pairs, charset));
			}
			HttpGet httpGet = new HttpGet(url);
			CloseableHttpResponse response = getHttpClient().execute(httpGet);
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != 200) {
				httpGet.abort();
				throw new RuntimeException("HttpClient,error status code :" + statusCode);
			}
			HttpEntity entity = response.getEntity();
			String result = null;
			if (entity != null){
				result = EntityUtils.toString(entity, charset);
			}
			EntityUtils.consume(entity);
			response.close();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public static CloseableHttpClient getHttpClient() {
		RequestConfig config = RequestConfig.custom().setConnectTimeout(60000).setSocketTimeout(15000).build();
		CloseableHttpClient httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
		return httpClient;
	}
}
