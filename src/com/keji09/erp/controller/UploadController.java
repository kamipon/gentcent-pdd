package com.keji09.erp.controller;

import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.SessionUtil;
import com.keji09.erp.utils.UploadUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * 上传文件，如果没有站点，就使用用户名
 */
@Controller
@RequestMapping("/upload")
public class UploadController extends XDAOSupport {
//	private static Log log = LogFactory.getLog(UploadController.class);
	
	@RequestMapping(value = "image", method = RequestMethod.POST)
	@ResponseBody
	public Object uploadImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserEntity user = SessionUtil.getUser();
		List<String> surfixList = Arrays.asList("jpg", "jpeg", "gif", "png", "bmp");
		JSONObject json = UploadUtil.saveFile(request, user.getUsername(), user == null ? null : user.getUsername(), surfixList);
		return json;
	}
	
	/***
	 * 上传文件
	 */
	@RequestMapping(value = "file", method = RequestMethod.POST)
	@ResponseBody
	public Object uploadFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserEntity user = SessionUtil.getUser();
		JSONObject json = UploadUtil.saveFile(request, user.getUsername(), user == null ? null : user.getUsername(), null);
		return json;
	}
	
	
}