package com.keji09.erp.api.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.keji09.erp.model.BillEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.WXMemberEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.service.RedpacketService;
import com.mezingr.dao.HDaoUtils;
import com.pdd.pop.ext.apache.http.client.methods.HttpGet;
import com.pdd.pop.ext.fasterxml.jackson.databind.util.JSONPObject;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * 微信登录
 */
@Controller
@RequestMapping("/app_WXLogin")
public class WXLoginController extends XDAOSupport {

	public final static String getPageOpenidUrl = "https://api.weixin.qq.com/sns/jscode2session";

	public  final static  String appid = "wxabbd08f9d6260357";

	public  final static  String secret = "c0f9cc70d74b23cf9df48ecae7be08b5";

	/**
	 * red  给红包派调用
	 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	@ResponseBody
	public Object login(
			@RequestParam(value = "code") String code,
			@RequestParam(value = "avatarUrl") String avatarUrl,
			@RequestParam(value = "gender") Integer gender,
			@RequestParam(value = "nickName") String nickName,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) { //请求参数
		try{
			String params = "appid=" + appid+ "&secret=" + secret + "&js_code=" + code + "&grant_type=authorization_code";
			// 发送请求
			String urlNameString = getPageOpenidUrl + "?" + params;
			JSONObject jsonObject = doGet(urlNameString);;
			Object wxOpenId = jsonObject.get("openid");
			Object wxSessionKey = jsonObject.get("session_key");
			if(wxOpenId==null || wxSessionKey ==null){
				map.put("flag",false);
				map.put("msg","信息错误或超时,请刷新页面!");
				return map;
			}
			System.out.println(wxOpenId);
			System.out.println(wxSessionKey);
			WXMemberEntity wxMember = this.getWXMemberEntityDAO().findUnique(HDaoUtils.eq("openid",wxOpenId.toString()).toCondition());
			boolean register = true;
			if(wxMember==null){
				wxMember = new WXMemberEntity();
				wxMember.setOpenid(wxOpenId.toString());
				wxMember.setAvatarUrl(avatarUrl);
				wxMember.setGender(gender);
				wxMember.setNickName(nickName);
				this.getWXMemberEntityDAO().create(wxMember);
			}else{
				wxMember.setAvatarUrl(avatarUrl);
				wxMember.setGender(gender);
				wxMember.setNickName(nickName);
				this.getWXMemberEntityDAO().update(wxMember);
				boolean exist = this.getMemberEntityDAO().exist(HDaoUtils.eq("wxMember",wxMember.getId()).toCondition());
				if(exist){
					register = false;
				}
			}
			map.put("flag",true);
			map.put("wxMember",wxMember.getId());
			map.put("register",register);
			return map;
		}
		catch (Exception e){
			e.printStackTrace();
			map.put("flag",false);
			map.put("msg","信息错误或超时,请刷新页面!");
			return map;
		}

	}
	public static JSONObject doGet(String temp) throws IOException {
		try {
			// 1.URL类封装了大量复杂的实现细节，这里将一个字符串构造成一个URL对象
			URL url = new URL(temp);
			// 2.获取HttpURRLConnection对象
			HttpURLConnection connection = (HttpURLConnection)url.openConnection();
			// 3.调用connect方法连接远程资源
			connection.connect();
			// 4.访问资源数据，使用getInputStream方法获取一个输入流用以读取信息
			BufferedReader bReader = new BufferedReader(
					new InputStreamReader(connection.getInputStream(), "UTF-8"));

			// 对数据进行访问
			String line = null;
			StringBuilder stringBuilder = new StringBuilder();
			while ((line = bReader.readLine()) != null) {
				stringBuilder.append(line);
			}
			// 关闭流
			bReader.close();
			// 关闭链接
			connection.disconnect();
			// 打印获取的结果
			System.out.println(stringBuilder.toString());
			JSONObject jsonObject = JSONObject.parseObject(stringBuilder.toString());
			return jsonObject;
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return  null;
		}
	}
	
}