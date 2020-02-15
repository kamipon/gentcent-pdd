package com.keji09.erp.api.controller;

import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsSearchRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsSearchResponse;
import com.sun.org.apache.xpath.internal.objects.XObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 公网静态页面调用API控制器
 * 
 */
@Controller
@RequestMapping("/app_index")
public class IndexController extends XDAOSupport {

	/**
	 * 接口说明地址 https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.search
	 */
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public Object getCaptcha(HttpServletRequest req, HttpServletResponse res
		, ModelMap map) {
		String clientId = Constants.CLIENT_ID;
		String clientSecret = Constants.CLIENT_SECRET;
		try {
			PopHttpClient client = new PopHttpClient(clientId, clientSecret);
			PddDdkGoodsSearchRequest request = new PddDdkGoodsSearchRequest();
			PddDdkGoodsSearchResponse response = client.syncInvoke(request);
			System.out.println(JsonUtil.transferToJson(response));
			return  response;
			//msg+=JsonUtil.transferToJson(response);
		}catch (Exception e){
		}
		return map;
	}

}