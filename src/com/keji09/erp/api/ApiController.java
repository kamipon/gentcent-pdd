package com.keji09.erp.api;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.CaptchaUtil;

/**
 * 公网静态页面调用API控制器
 * 
 */
@Controller
@RequestMapping("/api")
public class ApiController extends XDAOSupport {
	
	/**
	 * 返回null，说明验证正确
	 */
	public static Map<String,Object> validateCaptcha(HttpServletRequest req,String captcha) {
		Map<String,Object> result = new HashMap<String, Object>();
		Object temp = req.getSession().getAttribute("captcha");
		if (temp == null) {
			result.put("flag", false);
			result.put("msg", "验证码错误！");
			return result;
		} else if (!temp.toString().equals(captcha)) {
			result.put("flag", false);
			result.put("msg", "验证码错误！");
			return result;
		}
		return null;
	}

	/**
	 * 输出验证码
	 */
	@RequestMapping(value = "system/getCaptcha", method = RequestMethod.GET)
	public void getCaptcha(HttpServletRequest req, HttpServletResponse resp) {
		CaptchaUtil captcha = new CaptchaUtil();
		req.getSession().setAttribute("captcha", captcha.getCode());
		CaptchaUtil.writeCaptcha(resp, captcha);
	}

}