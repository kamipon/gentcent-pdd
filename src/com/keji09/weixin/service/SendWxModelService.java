package com.keji09.weixin.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.support.XDAOSupport;

@Service
public class SendWxModelService extends XDAOSupport{
	
	/**
	 * 发送模板消息接口
	 * 审核通知
	 * OPENTM406210250
	 * String openId, 微信用户的openId
	 * 	微信模板参数
		String first, 
		String keyword1,	订单号
		String keyword2,    金额
		String keyword3,    时间
		String keyword4     名称
	 */
	public void sendTemplate1(
			String openId,
			String first,
			String keyword1,
			String keyword2,
			String keyword3,
			String keyword4
			) throws Exception {
		//模板消息
		WechartConfigEntity wce = this.getWechartConfigEntityDAO().get("1");
		//检查当前微信公众号是否有，该编号的微信模板
		if(wce.getTemplate()==null||"".equals(wce.getTemplate())){
			String model = "OPENTM406210250";
			String tempUrl="https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+wce.getAccesstoken();
			String tempParam="{\"template_id_short\":\""+model+"\"}";
			JSONObject tempObj=WeixinUtil.httpRequest(tempUrl,"POST",tempParam);
			try{
				wce.setTemplate(tempObj.getString("template_id"));
			}catch (Exception e) {
				System.out.println("获取微信模板消息模板失败："+e.getMessage());
			}
			this.getWechartConfigEntityDAO().update(wce);
			
		}
		if(wce.getTemplate()!=null||!"".equals(wce.getTemplate())){
			//服务器域名-跟微信公众号绑定的
			String param="{"+
	        "\"touser\":\""+openId+"\","+
	        "\"template_id\":\""+wce.getTemplate()+"\","+
	        "\"topcolor\":\"#FF0000\","+
	        "\"data\":{"+
	                "\"first\": {\"value\":\""+first+"\",\"color\":\"#173177\"},"+
	                "\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},"+
	                "\"keyword2\": {\"value\":\""+keyword2+"\",\"color\":\"#173177\"},"+
	                "\"keyword3\": {\"value\":\""+keyword3+"\",\"color\":\"#173177\"},"+
	                "\"keyword4\": {\"value\":\""+keyword4+"\",\"color\":\"#173177\"},"+
	                "\"remark\":{\"value\":\"请尽快审核\",\"color\":\"#173177\"}"+
	                "}"+
			"}";
			String url="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+wce.getAccesstoken();
			JSONObject userObj=WeixinUtil.httpRequest(url,"POST",param);
		}
	}
	
	/**
	 * 发送模板消息接口
	 * 结算到账通知
	 * OPENTM401627249
	 * String first, 
		String keyword1,	结算金额
		String keyword2,    总笔数
		String keyword3,    结算日期
	 */
	public void sendTemplate2(
			String openId,
			String first,
			String keyword1,
			String keyword2,
			String keyword3) throws Exception {
		//模板消息
		WechartConfigEntity wce = this.getWechartConfigEntityDAO().get("1");
		//检查当前微信公众号是否有，该编号的微信模板
		if(wce.getTemplate2()==null||"".equals(wce.getTemplate2())){
			String model = "OPENTM401627249";
			String tempUrl="https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+wce.getAccesstoken();
			String tempParam="{\"template_id_short\":\""+model+"\"}";
			JSONObject tempObj=WeixinUtil.httpRequest(tempUrl,"POST",tempParam);
			try{
				wce.setTemplate2(tempObj.getString("template_id"));
			}catch (Exception e) {
				System.out.println("获取微信模板消息模板失败："+e.getMessage());
			}
			this.getWechartConfigEntityDAO().update(wce);
			
		}
		if(wce.getTemplate2()!=null||!"".equals(wce.getTemplate2())){
			//服务器域名-跟微信公众号绑定的
			String param="{"+
	        "\"touser\":\""+openId+"\","+
	        "\"template_id\":\""+wce.getTemplate2()+"\","+
	        "\"topcolor\":\"#FF0000\","+
	        "\"data\":{"+
	                "\"first\": {\"value\":\""+first+"\",\"color\":\"#173177\"},"+
	                "\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},"+
	                "\"keyword2\": {\"value\":\""+keyword2+"\",\"color\":\"#173177\"},"+
	                "\"keyword3\": {\"value\":\""+keyword3+"\",\"color\":\"#173177\"},"+
	                "\"remark\":{\"value\":\"感谢你的使用.\",\"color\":\"#173177\"}"+
	                "}"+
			"}";
			String url="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+wce.getAccesstoken();
			JSONObject userObj=WeixinUtil.httpRequest(url,"POST",param);
		}
	}
	
	/**
	 * 发送模板消息接口
	 * 交易成功通知	
	 * OPENTM408986311
	 * String first, 
		String keyword1,	付款金额
		String keyword2,    交易单号
	 */
	public void sendTemplate3(
			String openId,
			String first,
			String keyword1,
			String keyword2) throws Exception {
		//模板消息
		WechartConfigEntity wce = this.getWechartConfigEntityDAO().get("1");
		//检查当前微信公众号是否有，该编号的微信模板
		if(wce.getTemplate3()==null||"".equals(wce.getTemplate3())){
			String model = "OPENTM408986311";
			String tempUrl="https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+wce.getAccesstoken();
			String tempParam="{\"template_id_short\":\""+model+"\"}";
			JSONObject tempObj=WeixinUtil.httpRequest(tempUrl,"POST",tempParam);
			try{
				wce.setTemplate3(tempObj.getString("template_id"));
			}catch (Exception e) {
				System.out.println("获取微信模板消息模板失败："+e.getMessage());
			}
			this.getWechartConfigEntityDAO().update(wce);
			
		}
		if(wce.getTemplate3()!=null||!"".equals(wce.getTemplate3())){
			//服务器域名-跟微信公众号绑定的
			String param="{"+
	        "\"touser\":\""+openId+"\","+
	        "\"template_id\":\""+wce.getTemplate3()+"\","+
	        "\"topcolor\":\"#FF0000\","+
	        "\"data\":{"+
	                "\"first\": {\"value\":\""+first+"\",\"color\":\"#173177\"},"+
	                "\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},"+
	                "\"keyword2\": {\"value\":\""+keyword2+"\",\"color\":\"#173177\"},"+
	                "\"remark\":{\"value\":\"您好，客户已支付成功.\",\"color\":\"#173177\"}"+
	                "}"+
			"}";
			String url="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+wce.getAccesstoken();
			JSONObject userObj=WeixinUtil.httpRequest(url,"POST",param);
		}
	}
	
	/**
	 * 发送模板消息接口
	 * 余额变更通知
	 * String first, 
		时间	2018-01-08 00：00 到2018-01-08 23：59
		订单数量XXX，
		实际付款XX
		已付款XX，
		未付款XXX
	 */
	public void sendTemplate4(
			String openId,
			String first,
			String keyword1,
			String keyword2,
			String keyword3,
			String keyword4,
			String keyword5) throws Exception {
		//模板消息
		WechartConfigEntity wce = this.getWechartConfigEntityDAO().get("1");
		//检查当前微信公众号是否有，该编号的微信模板
		if(wce.getTemplate5()==null||"".equals(wce.getTemplate5())){
			String model = "OPENTM401833445";
			String tempUrl="https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+wce.getAccesstoken();
			String tempParam="{\"template_id_short\":\""+model+"\"}";
			JSONObject tempObj=WeixinUtil.httpRequest(tempUrl,"POST",tempParam);
			try{
				wce.setTemplate5(tempObj.getString("template_id"));
			}catch (Exception e) {
				System.out.println("获取微信模板消息模板失败："+e.getMessage());
			}
			this.getWechartConfigEntityDAO().update(wce);
			
		}
		if(wce.getTemplate5()!=null||!"".equals(wce.getTemplate5())){
			//服务器域名-跟微信公众号绑定的
			String param="{"+
	        "\"touser\":\""+openId+"\","+
	        "\"template_id\":\""+wce.getTemplate5()+"\","+
	        "\"topcolor\":\"#FF0000\","+
	        "\"data\":{"+
	                "\"first\": {\"value\":\""+first+"\",\"color\":\"#173177\"},"+
	                "\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},"+
	                "\"keyword2\": {\"value\":\""+keyword2+"\",\"color\":\"#173177\"},"+
	                "\"keyword3\": {\"value\":\""+keyword3+"\",\"color\":\"#173177\"},"+
	                "\"keyword4\": {\"value\":\""+keyword4+"\",\"color\":\"#173177\"},"+
	                "\"remark\":{\"value\":\"感谢你的使用.\",\"color\":\"#173177\"}"+
	                "}"+
			"}";
			String url="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+wce.getAccesstoken();
			JSONObject userObj=WeixinUtil.httpRequest(url,"POST",param);
		}
	}
	
	/**
	 * 发送模板消息接口
	 * 余额变更通知
	 * OPENTM401833445
	 * String first, 
		变动时间：2017-10-10
		变动类型：支付
		变动金额：+50
		当前余额：150
	 */
	public void sendTemplate5(
			String openId,
			String first,
			String keyword1,
			String keyword2,
			String keyword3,
			String keyword4) throws Exception {
		//模板消息
		WechartConfigEntity wce = this.getWechartConfigEntityDAO().get("1");
		//检查当前微信公众号是否有，该编号的微信模板
		if(wce.getTemplate5()==null||"".equals(wce.getTemplate5())){
			String model = "OPENTM401833445";
			String tempUrl="https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+wce.getAccesstoken();
			String tempParam="{\"template_id_short\":\""+model+"\"}";
			JSONObject tempObj=WeixinUtil.httpRequest(tempUrl,"POST",tempParam);
			try{
				wce.setTemplate5(tempObj.getString("template_id"));
			}catch (Exception e) {
				System.out.println("获取微信模板消息模板失败："+e.getMessage());
			}
			this.getWechartConfigEntityDAO().update(wce);
			
		}
		if(wce.getTemplate5()!=null||!"".equals(wce.getTemplate5())){
			//服务器域名-跟微信公众号绑定的
			String param="{"+
	        "\"touser\":\""+openId+"\","+
	        "\"template_id\":\""+wce.getTemplate5()+"\","+
	        "\"topcolor\":\"#FF0000\","+
	        "\"data\":{"+
	                "\"first\": {\"value\":\""+first+"\",\"color\":\"#173177\"},"+
	                "\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},"+
	                "\"keyword2\": {\"value\":\""+keyword2+"\",\"color\":\"#173177\"},"+
	                "\"keyword3\": {\"value\":\""+keyword3+"\",\"color\":\"#173177\"},"+
	                "\"keyword4\": {\"value\":\""+keyword4+"\",\"color\":\"#173177\"},"+
	                "\"remark\":{\"value\":\"感谢你的使用.\",\"color\":\"#173177\"}"+
	                "}"+
			"}";
			String url="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+wce.getAccesstoken();
			JSONObject userObj=WeixinUtil.httpRequest(url,"POST",param);
		}
	}
	
	/**
	 * 发送模板消息接口
	 * 安全验证码通知
	 * OPENTM411737351
	 * String first,
	 * 验证码：1234 
	 * 发送时间：2017-10-10
	 */
	public void sendTemplate6(
			String openId,
			String first,
			String keyword1,
			String keyword2) throws Exception {
		//模板消息
		WechartConfigEntity wce = this.getWechartConfigEntityDAO().get("1");
		//检查当前微信公众号是否有，该编号的微信模板
		if(wce.getTemplate6()==null||"".equals(wce.getTemplate6())){
			String model = "OPENTM411737351";
			String tempUrl="https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+wce.getAccesstoken();
			String tempParam="{\"template_id_short\":\""+model+"\"}";
			JSONObject tempObj=WeixinUtil.httpRequest(tempUrl,"POST",tempParam);
			System.out.println(tempObj);
			try{
				wce.setTemplate6(tempObj.getString("template_id"));
			}catch (Exception e) {
				System.out.println("获取微信模板消息模板失败："+e.getMessage());
			}
			this.getWechartConfigEntityDAO().update(wce);
			
		}
		if(wce.getTemplate6()!=null||!"".equals(wce.getTemplate6())){
			//服务器域名-跟微信公众号绑定的
			String param="{"+
			"\"touser\":\""+openId+"\","+
			"\"template_id\":\""+wce.getTemplate6()+"\","+
			"\"topcolor\":\"#FF0000\","+
			"\"data\":{"+
			"\"first\": {\"value\":\""+first+"\",\"color\":\"#173177\"},"+
			"\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},"+
			"\"keyword2\": {\"value\":\""+keyword2+"\",\"color\":\"#173177\"},"+
			"\"remark\":{\"value\":\"感谢你的使用.\",\"color\":\"#173177\"}"+
			"}"+
			"}";
			String url="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+wce.getAccesstoken();
			JSONObject userObj=WeixinUtil.httpRequest(url,"POST",param);
			System.out.println("发送验证码结果"+userObj);
		}
	}
	
}
