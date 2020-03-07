package com.keji09.erp.api.controller;

import com.keji09.erp.model.BillEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.support.XDAOSupport;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/micro_data")
public class MicroController extends XDAOSupport {
    private static List<String> symbolList = new ArrayList<>();
    private static String BASE_URL ="http://ds.cnshuhai.com";
    private static String appId = "xbd144";
    private static String appSecret = "q237788284";
    private static Map<String,Object> nowQuotation = new HashMap<>();

    @RequestMapping(value = "getTimeQuotation", method = RequestMethod.GET)
    @ResponseBody
    public Object getTimeQuotation(
            @RequestParam(value = "symbol") String symbol,//商品代码
            @RequestParam(value = "time",defaultValue = "1") String time,//时间间隔
            @RequestParam(value = "count",defaultValue = "100") Integer count,//条数
            HttpServletRequest req, HttpServletResponse resp
            , ModelMap map) {
        JSONArray data = timeQuotation(symbol,time,count);
        map.put("data", data);
        return map;
    }
    @RequestMapping(value = "getNowQuotation", method = RequestMethod.GET)
    @ResponseBody
    public Object getNowQuotation(
            @RequestParam(value = "symbol") String symbol,//商品代码
            HttpServletRequest req, HttpServletResponse resp
            , ModelMap map) {

        JSONArray data = nowQuotation(symbol);
        map.put("data", data.get(0));
        return map;
    }


    public static JSONArray timeQuotation(String code,String time, Integer count)
    {
        List list = new ArrayList();
        String url = BASE_URL + "/stock.php?type=kline&num=" + count + "&line=min," + time + "&symbol=" + code + "&u=" + appId + "&p=" + appSecret;
        if (time.equals("1D")||time.equals("1W")||time.equals("1M")) {
            url = BASE_URL + "/stock.php?type=kline&num=" + count + "&line=day&symbol=" + code + "&u=" + appId + "&p=" + appSecret;
        }
        String result = doGet(url, null, "UTF-8");
        JSONArray array= JSONArray.fromObject(result);
        return array;
    }

    public static JSONArray nowQuotation(String symbol){
        String url=BASE_URL+"/stock.php?type=stock&symbol="+symbol+"&u="+appId+"&p="+appSecret+"&limit=0,200";;
        String result=doGet(url,null,"UTF-8");
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
