package com.keji09.erp.controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.mezingr.hibernate.HibernateTemplateFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;
/**
 * 压缩文件导出控制器
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="zip")
public class ZipController {
	private static HibernateTemplateFactory templateFactory=null;
	public static HibernateTemplateFactory getTemplateFactory() {
		return templateFactory;
	}
	@Autowired
	public void setTemplateFactory(HibernateTemplateFactory templateFactory) {
		this.templateFactory = templateFactory;
	}
	//公共方法根据url生成二维码图片后写入输出流里
	public static void getBarCodeImgByUrl(String url,OutputStream os) throws WriterException,IOException{
		//二维码参数
		int width = 300; // 图像宽度
		int height = 300; // 图像高度
		String format = "png";// 图像类型
		Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		BitMatrix bitMatrix;
		bitMatrix = new MultiFormatWriter().encode(url,BarcodeFormat.QR_CODE, width, height, hints);
		MatrixToImageWriter.writeToStream(bitMatrix, format, os);
	}
	//入口
	@RequestMapping(value="download",method=RequestMethod.GET)
	@ResponseBody
	public static String download(
			@RequestParam(value = "code",required=false) String code,
			@RequestParam(value = "start",required=false) String start,
			@RequestParam(value = "end",required=false) String end,HttpServletRequest request, HttpServletResponse response,ModelMap map){
		ZipOutputStream zos = null;
		try {
			String downloadFilename ="红包二维码图片";//文件的名称
//		        downloadFilename = URLEncoder.encode(downloadFilename, "UTF-8");//转换中文否则可能会产生乱码
			response.setContentType("application/octet-stream");// 指明response的返回对象是文件流
			response.setHeader("Content-Disposition", "attachment;filename=" + new String(downloadFilename.getBytes("gb2312"), "ISO8859-1")+".zip");// 设置在下载框默认显示的文件名
			zos = new ZipOutputStream(response.getOutputStream());
			List<Object> param = new ArrayList<Object>();
			String code1="";
			String code2="";
			if((start.length()<12&&start!="")||(end.length()<12&&end!="")){
				map.put("flag", false);
				map.put("msg","输入的红包码位数不正确");
				return "manager/redpacket_list";
			}
			//类别CODE
			if(!code1.equals(code2)){
				map.put("flag", false);
				map.put("msg","开始段和结束段非同一段位！");
				return "manager/redpacket_list";
			}
			if(!"".equals(start)&&start!=null){
				String start1=start.substring(start.length()-7, start.length());
				param.add(start1);
				code1=start.substring(0, start.length()-7);
			}
			if(!"".equals(end)&&end!=null){
				String end1=end.substring(end.length()-7,end.length());
				code2=end.substring(0, end.length()-7);
				param.add(end1);
			}
			//开始位置和结束位置
			
			String sql="SELECT * FROM inv_redpacket";
			if(start!=null&&!"".equals(start)&&end!=null&&!"".equals(end)){
				sql=sql+" WHERE suffix BETWEEN ? AND ?";
			}
			
			if(code!=null&&!"".equals(code)){
				sql=sql+"ADN prefix LIKE ?";
				param.add(code1);
			}
			zos.flush();
			zos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manager/redpacket_list";
	}
	//入口
	@RequestMapping(value="downloadActivity",method=RequestMethod.GET)
	@ResponseBody
	public static String downloadActivity(
			@RequestParam(value = "id") String id,
			@RequestParam(value = "start",required=false) String start,
			@RequestParam(value = "end",required=false) String end,
			@RequestParam(value = "type",required=false) String type,
			HttpServletRequest request, HttpServletResponse response,ModelMap map){
		ZipOutputStream zos = null;
		try {
			String downloadFilename ="红包二维码图片";//文件的名称
//		        downloadFilename = URLEncoder.encode(downloadFilename, "UTF-8");//转换中文否则可能会产生乱码
			response.setContentType("application/octet-stream");// 指明response的返回对象是文件流
			response.setHeader("Content-Disposition", "attachment;filename=" + new String(downloadFilename.getBytes("gb2312"), "ISO8859-1")+".zip");// 设置在下载框默认显示的文件名
			zos = new ZipOutputStream(response.getOutputStream());
			List<Object> param = new ArrayList<Object>();
			param.add(id);
			if((start.length()<12&&start!="")||(end.length()<12&&end!="")){
				map.put("flag", false);
				map.put("msg","输入的红包码位数不正确");
				return "manager/redpacket_activity_list";
			}
			
			if(!"".equals(start)&&start!=null){
				String start1=start.substring(start.length()-7, start.length());
				param.add(start1);
				
			}
			if(!"".equals(end)&&end!=null){
				String end1=end.substring(end.length()-7,end.length());
				param.add(end1);
			}
			if(!"".equals(type)&&type!=null){
				param.add(type);
			}
			//开始位置和结束位置
			
			String sql="SELECT * FROM inv_redpacket WHERE _activity_redpacket = ?";
			if(start!=null&&!"".equals(start)&&end!=null&&!"".equals(end)){
				sql=sql+" AND suffix BETWEEN ? AND ?";
			}
			if(!"".equals(type)&&type!=null){
				sql=sql+" AND _type = ? ";
			}
			sql = sql +" AND _isWheel IS NULL ";
			
			zos.flush();
			zos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manager/redpacket_activity_list";
	}
}
