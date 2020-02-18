package com.keji09.erp.filter;

import com.keji09.erp.model.support.XDAOSupport;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;

@Aspect
public class LogService extends XDAOSupport {
	private static Log log = LogFactory.getLog(LogService.class);
	
	@Around("execution(* com.keji09.erp.controller..*.*(..))")
	public Object validateLogin(ProceedingJoinPoint point) throws Throwable {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		//设置不过滤的链接
		String[] notFilter = new String[]{"hx", "login", "registers", "user/code", "alipay/notify", "activity/register", "wresource/url", "note/notify", "allow", "isShow"};
		String uri = request.getRequestURL().toString();
		boolean doFilter = true;
		for (String s : notFilter) {
			if (uri.indexOf(s) != -1) {
				// 如果uri中包含不过滤的uri，则不进行过滤
				doFilter = false;
				break;
			}
		}
		if (doFilter) {
			Object temp = request.getSession().getAttribute("loginUser");
			if (temp == null) {
				return "login";
			}
		}
		return point.proceed();
	}
	
	@AfterThrowing(pointcut = "execution(* com.keji09.erp.controller..*.*(..))", throwing = "ex")
	public void afterThrowing(Exception ex) {
		try {
			log.error(ex.getMessage(), ex);
		} catch (Exception ee) {
			System.out.println("记录错误：" + ee.getMessage());
		}
	}
	
	
	/**
	 * 截图字符串前面字节的方法
	 *
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
				String strIp = ips[index];
				if (!("unknown".equalsIgnoreCase(strIp))) {
					ip = strIp;
					break;
				}
			}
		}
		return ip;
	}
}
