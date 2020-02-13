package com.keji09.erp.filter;

import com.keji09.develop.weixin.pojo.AccessToken;
import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.weixin.controller.MemberController;
import com.mezingr.dao.HDaoUtils;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.util.Date;
import java.util.List;

@Aspect
public class LogService extends XDAOSupport{
	private static Log log = LogFactory.getLog(LogService.class);
	
	private MemberController memberController;

	@Autowired
	public void setMemberController(MemberController memberController) {
		this.memberController = memberController;
	}

	@Around("execution(* com.keji09.erp.controller..*.*(..))")
	public Object validateLogin(ProceedingJoinPoint point) throws Throwable{
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		//设置不过滤的链接
		String[] notFilter = new String[] {"hx","login","registers","user/code","alipay/notify","activity/register","wresource/url","note/notify","allow","isShow"};
		String uri = request.getRequestURL().toString();
		boolean doFilter = true;  
        for (String s : notFilter) {  
            if (uri.indexOf(s) != -1) {  
                // 如果uri中包含不过滤的uri，则不进行过滤  
                doFilter = false;  
                break;
            }  
       }
		if(doFilter){
			Object temp = request.getSession().getAttribute("loginUser");
			if(temp == null){
				return "login";
			}
		}
		return point.proceed();
	}
	
	@AfterThrowing(pointcut = "execution(* com.keji09.erp.controller..*.*(..))", throwing = "ex")
	public void afterThrowing(Exception ex) {
		try{
	        log.error(ex.getMessage(),ex);
		}catch(Exception ee){
			System.out.println("记录错误："+ee.getMessage());
		}
	}
	/**
	 * 微信授权
	 * @param point
	 * @return
	 * @throws Throwable
	 */
	@Around("execution(* com.keji09.weixin.controller.*.*(..))")
	public Object validateServerPin(ProceedingJoinPoint point) throws  Throwable{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String baseUrl=request.getRequestURL().toString();
		
		boolean doFilter = true;  
		//设置不过滤的链接
		String[] notFilter = new String[] { "pay/notify","wx_plugin"};
		String uri = request.getRequestURL().toString();
        for (String s : notFilter) {  
            if (uri.indexOf(s) != -1) {  
                // 如果uri中包含不过滤的uri，则不进行过滤  
                doFilter = false;  
                break;
            }  
        }
		//用于本地测试，上线时注释下面两行
		MemberEntity m=this.getMemberEntityDAO().get("000000006bf57107016bf61f5af1000e");
		request.getSession().setAttribute("member", m);
		Object member = request.getSession().getAttribute("member");
		if(member!=null){
			doFilter=false;
		}
		System.out.println("do1");
        if(doFilter){
        	System.out.println("do2");
			String code=request.getParameter("code");
			System.out.println("do3,code:"+code);
			List<WechartConfigEntity> list=this.getWechartConfigEntityDAO().listAll();
			WechartConfigEntity wce=null;
			if(list!=null&&list.size()>0){
				 wce=list.get(0);
			}
			if(wce==null){
				return "500";
			}
			if(code!=null&&!code.equals("")){
				System.out.println("code值："+code);
				// 获取accessToken
				String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+wce.getAppId()+"&secret="+wce.getAppSecret()+"&code="+code+"&grant_type=authorization_code";
				JSONObject obj=WeixinUtil.httpRequest(url,"GET",null);
				if(obj!=null){
					try{
						String openId=obj.getString("openid");
						String accessToken=obj.getString("access_token");
						System.out.println("obj"+obj);
						System.out.println("Openid:"+openId);
						System.out.println("access_token:"+accessToken);
						String infoUrl="https://api.weixin.qq.com/sns/userinfo?access_token="+accessToken+"&openid="+openId+"&lang=zh_CN";
						JSONObject object=WeixinUtil.httpRequest(infoUrl,"GET",null);
						System.out.println(object);
						try{
							String nickname="";
							String headimgurl="";
							String city="";
							String sex="";
							String country="";
							boolean status = object.toString().contains("nickname");
							if(status){
								nickname=object.getString("nickname");
								headimgurl=object.getString("headimgurl");
								country=object.getString("country");
								city=object.getString("country")+","+object.getString("province")+","+object.getString("city");
								sex=object.getString("sex");
							}
							if(nickname.equals("")){
								System.out.println("进入空判断回调");
								String base=URLEncoder.encode(baseUrl,"UTF-8");
								String urls="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wce.getAppId()+"&redirect_uri="+base+"&response_type=code&scope=snsapi_userinfo&state=123&connect_redirect=1#wechat_redirect";
								System.out.println("1:"+urls);
								return "redirect:"+url;
							}
							MemberEntity ue=memberController.initUser(openId, false, city, sex, nickname, headimgurl);
							request.getSession().setAttribute("member", ue);
						}catch(JSONException ex){
							log.error("Bug1:"+ex.getMessage(),ex);
							log.error("obj1:"+obj);
							AccessToken at = WeixinUtil.getAccessToken(wce.getAppId(), wce.getAppSecret());
		        			if(accessToken!=null){
		        				System.out.println("获取access_token成功，有效时长"+at.getExpiresIn()+"秒 token:"+at.getToken());  
		        				wce.setAccesstoken(at.getToken());
		        			}
		        			getWechartConfigEntityDAO().update(wce);
						}
					}catch(JSONException ex){
						log.error("Bug2"+ex.getMessage(),ex);
						log.error("obj2"+obj);
						String errcode=obj.getString("errcode");
						if(errcode.equals("40029")){
							baseUrl=baseUrl.replace(("&code="),"&rrr=");
							String base=URLEncoder.encode(baseUrl,"UTF-8");
							String redirectUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wce.getAppId()+"&redirect_uri="+base+"&response_type=code&scope=snsapi_userinfo&state=123&connect_redirect=1#wechat_redirect";
							System.out.println("2:"+redirectUrl);
							return "redirect:"+redirectUrl;
						}
					}
				}
			}else{
//				String id=request.getParameter("id");
//				if(id!=null){
//					baseUrl = baseUrl+"?id="+id;
//				}
				String base=URLEncoder.encode(baseUrl,"UTF-8");
				String url="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wce.getAppId()+"&redirect_uri="+base+"&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
				System.out.println("3:"+url);
				return "redirect:"+url;
			}
		}
		return point.proceed();
	}
	
	
	/**
	 * 截图字符串前面字节的方法
	 * @param b
	 * @param charsetName
	 * @return
	 */
	public static String decode(byte[] b, String charsetName) {
        ByteBuffer in = ByteBuffer.wrap(b);
        Charset charset = Charset.forName(charsetName);
        CharsetDecoder decoder = charset.newDecoder();
        CharBuffer out = CharBuffer.allocate(b.length);
        out.clear();
        decoder.decode(in, out, false);
        out.flip();
        return out.toString();
 
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
