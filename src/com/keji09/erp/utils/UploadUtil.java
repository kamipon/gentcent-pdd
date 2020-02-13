package com.keji09.erp.utils;

import java.io.File;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

public class UploadUtil {
	
	/**
	 * 文件访问url
	 */
	public static final String FILE_URL = "fileUrl";
	/**
	 * 文件本地存储地址
	 */
	public static final String FILE_PATH = "filePath";
	/**
	 * 文件名称
	 */
	public static final String FILE_NAME = "fileName";
	/**
	 * 原文件名称
	 */
	public static final String FILE_OLD_NAME = "fileOldName";
	
	/**
	 * 设置文件的名称防止文件名称重复
	 */
	public static String renameFileName(File dir, String fileName) {
		File temp = new File(dir, fileName);
		// 如果文件存在，重命名
		if (temp.exists()) {
			return "_" + String.valueOf(System.nanoTime()).replaceAll("-", "") + "_" + fileName;
		} else {
			return fileName;
		}
	}

	/**
	 * 获取日期目录
	 */
	public static String getDateRoot() {
		Calendar now = Calendar.getInstance();
		return now.get(Calendar.YEAR) + "/" + (now.get(Calendar.MONTH) + 1) + "/" + now.get(Calendar.DAY_OF_MONTH);
	}
	
	/**
	 * 获取访问前缀
	 */
	public static String getVisitPrefixUrl(HttpServletRequest request,String userRoot,String userName) {
		String result = "";
		String domain = request.getServerName();
		
//		//如果没有域名，使用访问名称
		if(StringUtils.isNotEmpty(domain)&&!domain.equals("localhost")) {
			if (StringUtils.isNotEmpty(userRoot)) {
				result = request.getScheme() + "://" + domain + "/"+ Constants.RPOJECT_SYSTEM+"/"+userRoot;
			} else if (StringUtils.isNotEmpty(userName)) {
				result = request.getScheme() + "://" + domain + "/" + Constants.RPOJECT_SYSTEM + "/" + userName + "/" + Constants.PROJECT_UPLOAD;
			}
		}else {
			result += request.getScheme() + "://" + request.getServerName();
			//不是80端口加端口号
			if(request.getServerPort() != 80) {
				result += ":" + request.getServerPort();
			}
			result+="/"+Constants.PROJECT_SYSTEM_HOST;
			if (StringUtils.isNotEmpty(userRoot)) {
				result += "/" + Constants.PROJECT_UPLOAD;
			}
			if (StringUtils.isNotEmpty(userName)) {
				result += "/" + userName;
			}
		}
		
		return result;
	}
	
	/**
	 * 获取整个访问路径
	 * @param f
	 * @param visitPrefixUrl
	 * @return
	 */
	public static String getVisitUrl(File f,String visitPrefixUrl) {
		String result = "";
		String localPath = f.getAbsolutePath();
		localPath = localPath.replaceAll("\\\\", "/");
		// /2016/03/31/xxxxxxxxxxxxxxx.jpg
		result = visitPrefixUrl + "/" + localPath.substring(localPath.indexOf(getDateRoot() + "/"));
		return result;
	}
	
	/**
	 * 获取存储地址
	 */
	public static String getStoreUrl(HttpServletRequest request,String userRoot,String userName) {
		String result = "";
		if (StringUtils.isNotEmpty(userRoot)) {
			result = Constants.RPOJECT_STORE_ROOT + "/" +Constants.RPOJECT_SYSTEM +"/"+userRoot;
		} else if (StringUtils.isNotEmpty(userName)) {
			result = Constants.RPOJECT_STORE_ROOT + "/" + Constants.RPOJECT_SYSTEM + "/" + userName + "/" + Constants.PROJECT_UPLOAD;
		}
		result += "/" + getDateRoot();
		return result;
	}
	

	/**
	 * 上传文件
	 * @param req request
	 * @param userName 用户名称，如果有说明是没有站点的用户上传文件
	 * @param userRoot 用户站点目录，如果有说明是以后站点用户上传文件
	 * @param suffixList 根据文件后缀名过滤文件
	 * @return 返回上传信息
	 */
	public static JSONObject saveFile(HttpServletRequest req, String userRoot, String userName,List<String> suffixList) {
		JSONObject obj = new JSONObject();
		if (StringUtils.isEmpty(userName) && StringUtils.isEmpty(userRoot)) {
			obj.put("error", 1);
			obj.put("msg", "请先登录");
			obj.put("flag", false);
			return obj;
		}
		String storeUrl = getStoreUrl(req, userRoot, userName);
		File f = new File(storeUrl);
		if (!f.exists()) {
			f.mkdirs();
		}
		
		String uploadUrl = "";
		String filePath = "";
		String fileName = "";
		String fileOldName = "";
		String type = "";
		long size = 0L;
		MultipartHttpServletRequest request = (MultipartHttpServletRequest) req;
		CommonsMultipartResolver resolver = new CommonsMultipartResolver(req.getSession().getServletContext());
		
		// 判断是否是文件
		if (resolver.isMultipart(request)) {
			// 进行转换
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) (request);
			// 获取所有文件名称
			Iterator<String> it = multiRequest.getFileNames();
			while (it.hasNext()) {
				// 根据文件名称取文件
				MultipartFile file = multiRequest.getFile(it.next());
				size = file.getSize();
				if(size>Long.parseLong(Constants.MAXUPLOAD_SIZE)){   
            		String msg = "上传失败：图片大小不能超过200KB！";//字节
	        		obj.put("msg", msg);
					obj.put("error", 1);
					obj.put("flag", false);
					return obj;
		        }
				fileName = file.getOriginalFilename().trim();
				if(suffixList != null && suffixList.size() > 0) {
					type = fileName.substring(fileName.lastIndexOf(".")+1, fileName.length());
					if(!suffixList.contains(type.toLowerCase())){
						obj.put("msg", "请选择正确的文件类型！");
						obj.put("error", 1);
						obj.put("flag", false);
						return obj;
					}
				}
				//如果重名更改名称
				fileOldName = file.getOriginalFilename().trim();
				fileName = renameFileName(f, file.getOriginalFilename().trim());
				filePath = storeUrl + "/" + fileName;
				File newFile = new File(filePath);
				try {
					file.transferTo(newFile);
				} catch (Exception e) {
					System.out.println("文件存在"+e.getMessage());
				}
				uploadUrl = getVisitUrl(newFile, getVisitPrefixUrl(req, userRoot, userName));
				System.out.println(uploadUrl);
				
			}
		}
		//local
		obj.put("src", uploadUrl);
		obj.put("fileUrl", uploadUrl);
		obj.put("fileName", fileName);
		obj.put("fileOldName", fileOldName);
		
		//ueditor
		obj.put("state", "SUCCESS");
		obj.put("title", fileName);
		obj.put("original", fileOldName);
		obj.put("type", "."+type);
		obj.put("url", uploadUrl);
		obj.put("size", size+"");
		
		
		if (uploadUrl.equals("")) {
			obj.put("flag", false);
			obj.put("error", 1);
			obj.put("msg", "上传失败!");
		} else {
			obj.put("flag", true);
			obj.put("error", 0);
			obj.put("msg", "上传成功!");
		}
		return obj;
	}
}
