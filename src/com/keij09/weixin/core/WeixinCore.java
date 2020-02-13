package com.keij09.weixin.core;

//import java.awt.Color;
//import java.awt.Font;
//import java.awt.Graphics2D;
//import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.keji09.develop.weixin.message.resp.TextMessage;
import com.keji09.develop.weixin.util.MessageUtil;
import com.keji09.develop.weixin.util.SignUtil;
import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.ManagerMsgEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;


@Controller
public class WeixinCore extends XDAOSupport{
	private static final long serialVersionUID = 4440739483644821986L;  
	
	/** 
     * 确认请求来自微信服务器 
     */  
	@RequestMapping(value="/wechat/{type}",method=RequestMethod.GET)
    public void doGet(@PathVariable(value = "type")String type,
    		HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        // 微信加密签名  
		String signature = request.getParameter("signature");  
        // 时间戳  
        String timestamp = request.getParameter("timestamp");  
        // 随机数  
        String nonce = request.getParameter("nonce");  
        // 随机字符串  
        String echostr = request.getParameter("echostr");
        PrintWriter out = response.getWriter();  
        String token="123456";
        // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败  
        if (SignUtil.checkSignature(token,signature, timestamp, nonce)) {  
            out.print(echostr);
        }  
        out.close();  
        out = null;  
    }  
  
    /** 
     * 处理微信服务器发来的消息 
     */  
	@RequestMapping(value="/wechat/{type}",method=RequestMethod.POST)
    public void doPost(@PathVariable(value = "type")String type,
    		HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
		System.out.println("进入weixincore");
		//type值为1代表商户，2代表门店
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）  
        request.setCharacterEncoding("UTF-8");  
        response.setCharacterEncoding("UTF-8");  
        // 调用核心业务类接收消息、处理消息  
        String respMessage = null;
		try {
			// 默认返回的文本消息内容
			String respContent = "请求处理异常，请稍候尝试！";
			System.out.println("进入weixincore2");
			// xml请求解析
			Map<String, String> requestMap = MessageUtil.parseXml(request);
			// 发送方帐号（open_id）
			String fromUserName = requestMap.get("FromUserName");
			// 公众帐号
			String toUserName = requestMap.get("ToUserName");
			// 消息类型
			String msgType = requestMap.get("MsgType");
			// 事件类型
			String eventType = requestMap.get("Event");
			System.out.println("进入weixincore3");
			System.out.println("eventType==="+eventType);
			System.out.println("msgType==="+msgType);
			if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {
				// 订阅
				if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)||eventType.equals("SCAN")) {
					System.out.println("进入weixincore4");
						/**
						 * 拉取用户基本信息（头像，性别，城市，昵称）,存入数据库
						 */
						WechartConfigEntity config; //TODO 将WechartConfigEntity的数据查出来
						config = this.getWechartConfigEntityDAO().get("1");
						String accessToken=config.getAccesstoken();
						String infoUrl="https://api.weixin.qq.com/cgi-bin/user/info?access_token="+accessToken+"&openid="+fromUserName;
						JSONObject object=WeixinUtil.httpRequest(infoUrl,"GET",null);
						System.out.println("关注获取资料:"+object+"|||openid："+fromUserName+"|||accessToken："+accessToken);
						if(object!=null){
							//TODO 用户资料
							String openId=object.getString("openid");
							String nickname=filterEmoji(object.getString("nickname"));
							String sex=object.getString("sex");
							String city=object.getString("city");
							String province=object.getString("province");
							String country=object.getString("country");
							String headimgurl=object.getString("headimgurl");
							if(openId!=null&&!openId.equals("")){
								System.out.println("进入weixincore5");
									MemberEntity member = this.getMemberEntityDAO().findUnique(HDaoUtils.eq("openId", openId).toCondition());
									if(member!=null){
										System.out.println("进入weixincore11");
										member.setCity(city);
										member.setOpenId(openId);
										member.setNick(WeixinCore.filterEmoji(nickname));
										member.setPicUrl(headimgurl);
										member.setLoginLastTime(new Date());
										this.getMemberEntityDAO().update(member);
										//ue关注着
										//根据eventKey获取关注者的推广人，为两者加积分并提示
										String parent="";
										String eventKey=requestMap.get("EventKey");
										String eventKey2=requestMap.get("EventKey");
										if(eventKey!=null&&!eventKey.equals("")){
											System.out.println("eventKey:"+eventKey);
											int i=eventKey.indexOf("_ed");
											int j=eventKey2.indexOf("_id");
											if(eventType.equals("SCAN")){
												eventKey=eventKey.substring(6, i);
												System.out.println("userid="+eventKey);
												eventKey2=eventKey2.substring(1, j);
												System.out.println("type="+eventKey2);
											}else{
												eventKey=eventKey.substring(14, i);
												System.out.println("userid="+eventKey);
												eventKey2=eventKey2.substring(9, j);
												System.out.println("type="+eventKey2);
											}
										}
										String types = "";
										if(eventKey2.equals("2")){
											System.out.println("进入代理222");	
											types="代理";
											UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", eventKey).toCondition());
											TerPointEntity terpoint = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
											member.setTerpoint(terpoint);
											member.setType(2);
										}
										if(eventKey2.equals("3")){
											System.out.println("进入商户333");	
											types="商户";
											UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", eventKey).toCondition());
											ActivityEntity activity = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
											//记录ip
											String ip = getIpAddress(request);
											member.setIp(ip);
											member.setType(3);
										}
										if(eventKey2.equals("4")){
											System.out.println("进入admin444");
											System.out.println("f:"+fromUserName);
											types="admin";
											UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", eventKey).toCondition());
											ManagerMsgEntity ms =  this.getManagerMsgEntityDAO().findUnique(HDaoUtils.eq("member", member).toCondition());
											if(ms==null){
												ms=new ManagerMsgEntity();
												ms.setMember(member);
												ms.setStatus(1);
												this.getManagerMsgEntityDAO().create(ms);
											}
											String ip = getIpAddress(request);
											member.setIp(ip);
											member.setType(3);
										}
										this.getMemberEntityDAO().update(member);
										/**
										 * 发送等待消息
										 */
										String msgUrl="https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+accessToken;
										String msgParam="{\"touser\":\""+fromUserName+"\","+
											    "\"msgtype\":\"text\","+
											    "\"text\":"+
											    "{\"content\":\"关注成功\"}}";
										JSONObject msgObj=WeixinUtil.httpRequest(msgUrl,"POST",msgParam);
										System.out.println("发送客服消息给关注者"+msgObj);
									}else{
										System.out.println("进入weixincore6");
										//TODO CREATE用户
										MemberEntity ue=new MemberEntity();//=generalUtil.initUser(openId, parent, tpe, true, country+","+province+","+city, sex, nickname, headimgurl);
										//ue关注着
										//根据eventKey获取关注者的推广人，为两者加积分并提示
										String parent="";
										String eventKey=requestMap.get("EventKey");
										String eventKey2=requestMap.get("EventKey");
										if(eventKey!=null&&!eventKey.equals("")){
											System.out.println("eventKey:"+eventKey);
											int i=eventKey.indexOf("_ed");
											int j=eventKey2.indexOf("_id");
											if(eventType.equals("SCAN")){
												eventKey=eventKey.substring(6, i);
												System.out.println("userid="+eventKey);
												eventKey2=eventKey2.substring(1, j);
												System.out.println("type="+eventKey2);
												ue.setType(Integer.parseInt(eventKey2));
											}else{
												eventKey=eventKey.substring(14, i);
												System.out.println("userid="+eventKey);
												eventKey2=eventKey2.substring(9, j);
												System.out.println("type="+eventKey2);
												ue.setType(Integer.parseInt(eventKey2));
											}
										}
										PaginationList<MemberEntity> u=this.getMemberEntityDAO().list(1,1,Order.desc("sid"));
										if(u!= null&& u.getTotalCount()>0){
											ue.setSid(u.getItems().get(0).getSid()+1);
										}else{
											ue.setSid(1);
										}
										ue.setOpenId(openId);
										ue.setNick(WeixinCore.filterEmoji(nickname));
										ue.setCity(city);
										ue.setPicUrl(headimgurl);
										ue.setLoginLastTime(new Date()); 
										ue.setAddTime(new Date());
										this.getMemberEntityDAO().create(ue);
										request.getSession().setAttribute("member", ue);
										String types = "";
										System.out.println("进入weixincore7");
										if(eventKey2.equals("2")){
											System.out.println("进入代理222");	
											types="代理";
											UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", eventKey).toCondition());
											TerPointEntity terpoint = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
											member.setTerpoint(terpoint);
											member.setType(2);
										}
										if(eventKey2.equals("3")){
											System.out.println("进入商户333");	
											types="商户";
											UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", eventKey).toCondition());
											ActivityEntity activity = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
											//记录ip
											String ip = getIpAddress(request);
											member.setIp(ip);
											member.setType(3);
										}
										this.getMemberEntityDAO().update(ue);
										/**
										 * 发送等待消息
										 */
										String msgUrl="https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+accessToken;
										String msgParam="{\"touser\":\""+fromUserName+"\","+
											    "\"msgtype\":\"text\","+
											    "\"text\":"+
											    "{\"content\":\"关注成功\"}}";
										JSONObject msgObj=WeixinUtil.httpRequest(msgUrl,"POST",msgParam);
										System.out.println("发送客服消息给关注者"+msgObj);
									}
								}
							}
						}
				}else if(eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)){
					request.getSession();
					PrintWriter out = response.getWriter();  
			        out.print("success");  
			        out.close();
				}else if(eventType.equals("SCAN")){
					TextMessage textMessage = new TextMessage();
					textMessage.setToUserName(fromUserName);
					textMessage.setFromUserName(toUserName);
					textMessage.setCreateTime(new Date().getTime());
					textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
					textMessage.setFuncFlag(0);
					textMessage.setContent("你已经关注过了！！");
					respMessage = MessageUtil.textMessageToXml(textMessage);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
        // 响应消息  
        PrintWriter out = response.getWriter();  
        out.print(respMessage);  
        out.close();   
    }  
	
//	/**
//	 * 从数据库获取用户地理位置对象
//	 */
//	public WeiUserPositionEntity getPosition(String fromUserName,Integer count){
//		WeiUserPositionEntity wupe=this.getWeiUserPositionEntityDAO().findUnique(HDaoUtils.eq("fromUserName", fromUserName).toCondition());
//		if(wupe==null&&count<2){
//			try {
//				Thread.sleep(5000);
//				return getPosition(fromUserName,++count);
//			} catch (InterruptedException e) {
//			}
//		}
//		return wupe;
//	}
///****************************以下代码来自网络*********/
	  /** 检测是否有emoji字符
	  * @param source
	  * @return 一旦含有就抛出
	  */
	  public static boolean containsEmoji(String source) {
		  if (StringUtils.isBlank(source)) {
			  return false;
		  }
		  int len = source.length();
		  for (int i = 0; i < len; i++) {
			  char codePoint = source.charAt(i);
			  if (isEmojiCharacter(codePoint)) {
				  //do nothing，判断到了这里表明，确认有表情字符
				  return true;
			  }
		  }
		  return false;
	  }
	  
	  private static boolean isEmojiCharacter(char codePoint) {
		  return (codePoint == 0x0) ||
		  (codePoint == 0x9) ||
		  (codePoint == 0xA) ||
		  (codePoint == 0xD) ||
		  ((codePoint >= 0x20) && (codePoint <= 0xD7FF)) ||
		  ((codePoint >= 0xE000) && (codePoint <= 0xFFFD)) ||
		  ((codePoint >= 0x10000) && (codePoint <= 0x10FFFF));
	  }
//	  
	  /**
	  * 过滤emoji 或者 其他非文字类型的字符
	  * @param source
	  * @return
	  */
	  public static String filterEmoji(String source) {
		  source=" "+source;
		  if (!containsEmoji(source)) {
			  return source;//如果不包含，直接返回
		  }
		  //到这里铁定包含
		  StringBuilder buf = null;
		  int len = source.length();
		  for (int i = 0; i < len; i++) {
			  char codePoint = source.charAt(i);
			  if (isEmojiCharacter(codePoint)) {
				  if (buf == null) {
					  buf = new StringBuilder(source.length());
				  }
				  buf.append(codePoint);
			  } else {
			  }
		  }
	  
		  if (buf == null) {
			  return source.trim();//如果没有找到 emoji表情，则返回源字符串
		  } else {
			  if (buf.length() == len) {//这里的意义在于尽可能少的toString，因为会重新生成字符串
				  buf = null;
				  return source.trim();
			  } else {
				  return buf.toString().trim();
			  }
		  }
	  
	  }
	  /**
		 * 获取请求端真实ip
		 */
		 public String getIpAddress(HttpServletRequest request) throws IOException {
		        // 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址

		        String ip = request.getHeader("X-Forwarded-For");
		        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		                ip = request.getHeader("Proxy-Client-IP");
		                System.out.println(ip);
		            }
		            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		                ip = request.getHeader("WL-Proxy-Client-IP");
		                System.out.println(ip);
		            }
		            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		                ip = request.getHeader("HTTP_CLIENT_IP");
		                System.out.println(ip);
		            }
		            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		                ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		                System.out.println(ip);
		            }
		            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		                ip = request.getRemoteAddr();
		                System.out.println(ip);
		            }
		        } else if (ip.length() > 15) {
		            String[] ips = ip.split(",");
		            for (int index = 0; index < ips.length; index++) {
		                String strIp = (String) ips[index];
		                if (!("unknown".equalsIgnoreCase(strIp))) {
		                    ip = strIp;
		                    break;
		                }
		            }
		        }
		        return ip;
		    }
}
