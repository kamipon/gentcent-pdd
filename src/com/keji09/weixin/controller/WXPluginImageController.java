package com.keji09.weixin.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.keji09.erp.bean.IconBean;
import com.keji09.erp.bean.ResponseBean;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.keji09.erp.utils.FileUtil;
import com.keji09.erp.utils.ImageCompressUtil;
import com.mezingr.dao.PaginationList;

@Controller
@RequestMapping(value = "/wx_plugin")
public class WXPluginImageController extends XDAOSupport {
	
	/***
	 * 转换微信图片接口
	 */
	@RequestMapping(value = "wx_img", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> wx_img(
			@RequestParam(value = "image") String image,
			ModelMap mm, HttpServletRequest request)
			throws Exception {
		String id1 = image;
		if (image != null) {
			System.out.println(image);
			WechartConfigEntity wce = this.getWechartConfigEntityDAO().get("1");
			String uploadpath = request.getSession().getServletContext().getRealPath("/upload/image");
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + wce.getAccesstoken() + "&media_id=" + image;
			System.out.println(url);
			try {
				URL uri = new URL(url);
				BufferedImage backImage = ImageIO.read(uri);
				//backImage.flush();
				if (backImage != null) {
					String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + ".jpg";
					ImageCompressUtil.compressPic(backImage, uploadpath + "/" + newFileName, (float) 1);
					image = "http://es.xb568.com/upload/image/" + newFileName;
					System.out.println("image=" + image);
					mm.put("msg", "上传成功");
					mm.put("flag", true);
					mm.put("image", image);
					mm.put("id", id1);
					return mm;
				}
			} catch (MalformedURLException e) {
				System.out.println("获取远程图片错误:" + e.getMessage());
				mm.put("msg", "读取远程图片错误");
				mm.put("flag", false);
				return mm;
			} catch (IOException e) {
				System.out.println("读取远程图片错误:" + e.getMessage());
				mm.put("msg", "读取远程图片错误");
				mm.put("flag", false);
				return mm;
			}
		} else {
			mm.put("msg", "IMG为空");
			mm.put("flag", false);
			return mm;
		}
		return mm;
	}
	
	/***
	 * 获取公共图片库
	 */
	@RequestMapping(value = "getIcons", method = RequestMethod.GET)
	@ResponseBody
	public ResponseBean<PaginationList<IconBean>> getIcons(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, ModelMap mm, HttpServletRequest request)
			throws Exception {
		String pre = request.getScheme() + "://" + request.getServerName();
		if (request.getServerName().equals("localhost")) {
			pre = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/" + Constants.PROJECT_SYSTEM_HOST;
		}
		String root = pre + "/" + Constants.RPOJECT_SYSTEM + "/public";
		String uploadpath = Constants.RPOJECT_STORE_ROOT + "/" + Constants.RPOJECT_SYSTEM + "/" + "public";
		ResponseBean<PaginationList<IconBean>> result = getImagesByUrl(pageIndex, pageSize, uploadpath, root);
		return result;
	}
	
	/***
	 * 获取登录用户的图片库
	 */
	@RequestMapping(value = "getOwn", method = RequestMethod.GET)
	@ResponseBody
	public ResponseBean<PaginationList<IconBean>> getOwn(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, ModelMap mm, HttpServletRequest request)
			throws Exception {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		String uploadpath = "";
		String root = "";
		String pre = request.getScheme() + "://" + request.getServerName();
		uploadpath = Constants.RPOJECT_STORE_ROOT + "/" + Constants.RPOJECT_SYSTEM + "/" + user.getUserName();
		pre = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/" + Constants.PROJECT_SYSTEM_HOST;
		root = pre + "/" + Constants.RPOJECT_SYSTEM + "/" + user.getUserName();
		File uploadpaths = new File(uploadpath);
		if (!uploadpaths.exists()) {
			uploadpaths.mkdirs();
		}
		ResponseBean<PaginationList<IconBean>> result = getImagesByUrl(pageIndex, pageSize, uploadpath, root);
		return result;
	}
	
	
	/***
	 * 根据路径获取图片列表（分页）
	 * @param pageIndex 图片起始位置
	 * @param pageSize 每次获取数量
	 * @param path 本地硬盘目录
	 * @return
	 * @throws IOException
	 */
	public ResponseBean<PaginationList<IconBean>> getImagesByUrl(Integer pageIndex, Integer pageSize, String path, String root) throws IOException {
		ResponseBean<PaginationList<IconBean>> result = new ResponseBean<PaginationList<IconBean>>();
		final List<IconBean> list = new ArrayList<IconBean>();
		List<String> suffixs = new ArrayList<String>();
		suffixs.add("jpg");
		suffixs.add("png");
		suffixs.add("gif");
		suffixs.add("ico");
		final List<File> files = FileUtil.getFileDeeps(path, suffixs);
		
		//时间排序，最新日期在前面
		FileUtil.sortByDate(files, true);
		
		Integer start = (pageIndex - 1) * pageSize;
		Integer end = start + pageSize;
		if (files.size() > start) {
			for (int i = start; i < end; i++) {
				if (i < files.size()) {
					File file1 = files.get(i);
					String p = path.replace("\\", "/");
					String url = root + file1.getPath().replace("\\", "/").replace(p, "");
					
					IconBean ib = new IconBean();
					ib.setUrl(url);
					String ext = FileUtil.getExt(file1);
					if (StringUtils.isNotEmpty(ext) && ".ico".equals(ext)) {
						ib.setWidth("32");
						ib.setHeight("32");
					} else {
						InputStream in = new FileInputStream(file1);
						try {
							BufferedImage buff = ImageIO.read(in);
							String width = buff.getWidth() + "";//得到图片的宽度
							String height = buff.getHeight() + "";//得到图片的高度
							ib.setWidth(width);
							ib.setHeight(height);
						} catch (Exception e) {
							e.printStackTrace();
						} finally {
							in.close();
						}
					}
					
					
					list.add(ib);
				}
			}
		}
		PaginationList<IconBean> bean = new PaginationList<IconBean>() {
			public List<IconBean> getItems() {
				return list;
			}
			
			public int getTotalCount() {
				return files.size();
			}
			
		};
		result.setItems(bean);
		return result;
	}
	
	/**
	 * 设置文件的名称防止文件名称重复
	 *
	 * @param fileName
	 * @return
	 */
	private String markFileName(File dir, String fileName) {
		File temp = new File(dir, fileName);
		//如果文件存在，重命名
		if (temp.exists()) {
			return "_" + UUID.randomUUID().toString().replaceAll("-", "") + "_" + fileName;
		} else {
			return fileName;
		}
	}
	
	/**
	 * 文件删除
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping("deleteImges")
	@ResponseBody
	public Map<String, Object> deleteImges(HttpServletRequest request) {
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		String uploadpath = "";
		String path = request.getParameter("path");
		uploadpath = Constants.PROJECT_REAL_PATH + "/" + Constants.PROJECT_UPLOAD;
		uploadpath += path.substring(path.indexOf(user.getUserName()) + user.getUserName().length());
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = false;
		String msg = "删除失败!";
		
		File filePath = new File(uploadpath);
		if (filePath.exists() && filePath.isFile()) {
			filePath.delete();
			flag = true;
			msg = "删除成功!";
		}
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}
	
	/**
	 * 获取日期目录
	 *
	 * @return
	 */
	public String getDateRoot() {
		Calendar now = Calendar.getInstance();
		return now.get(Calendar.YEAR) + "/" + (now.get(Calendar.MONTH) + 1) + "/" + now.get(Calendar.DAY_OF_MONTH);
	}
	
}
