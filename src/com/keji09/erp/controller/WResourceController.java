package com.keji09.erp.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.util.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;

@Controller
@RequestMapping(value = "/wresource")
public class WResourceController extends XDAOSupport {

	

	/**
	 * 生成二维码
	 */
	public String twoDimensionCode(String url, HttpServletRequest request) {
		String uploadpath = request.getSession().getServletContext()
				.getRealPath("/upload/image");
		int width = 300;
		int height = 300;
		String fileName = "";
		//二维码的图片格式 
		String format = "gif";
		Hashtable hints = new Hashtable();
		//内容所使用编码 
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix;
		try {
			bitMatrix = new MultiFormatWriter().encode(url,
					BarcodeFormat.QR_CODE, width, height, hints);
			//生成二维码 
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			fileName = df.format(new Date()) + "_" + new Random().nextInt(1000)
					+ ".gif";
			String fileUrl = uploadpath + "/" + fileName;
			File outputFile = new File(fileUrl);
			MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}

	/**
	 * 生成二维码2
	 */
	public String twoDimensionCode2(String url, String openId, HttpServletRequest request) {
		String uploadpath = request.getSession().getServletContext() 
				.getRealPath("/upload/image");
		int width = 300;
		int height = 300;
		String fileName = "";
		//二维码的图片格式 
		String format = "png";
		Hashtable hints = new Hashtable();
		//内容所使用编码 
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix;
		try {
			bitMatrix = new MultiFormatWriter().encode(url,
					BarcodeFormat.QR_CODE, width, height, hints);
			//生成二维码 
//			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
//			fileName = df.format(new Date()) + "_" + new Random().nextInt(1000)
//					+ ".png";
			fileName = openId + "_.png";
			String fileUrl = uploadpath + "/" + fileName;
			File outputFile = new File(fileUrl);
			MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}
	
	/**
	 * 将连接输出成图片
	 * @param url
	 * @param request
	 * @param response
	 * @return
	 */
	//二维码直接输出方式
	@RequestMapping(value = "/url", method = RequestMethod.GET)
	public void getUrl2(@RequestParam(value="url")String url, HttpServletRequest request,HttpServletResponse response) {
		url=URLDecoder.decode(url);
		int width = 300;
		int height = 300;
		//二维码的图片格式 
		Hashtable hints = new Hashtable();
		//内容所使用编码 
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix;
		try {
			bitMatrix = new MultiFormatWriter().encode(url,
					BarcodeFormat.QR_CODE, width, height, hints);
			BufferedImage image=MatrixToImageWriter.toBufferedImage(bitMatrix);
			ByteArrayOutputStream os = new ByteArrayOutputStream();  
			ImageIO.write(image, "gif", os);  
			InputStream is = new ByteArrayInputStream(os.toByteArray());  
			IOUtils.copy(is,response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 将连接输出成图片
	 * @param url
	 * @param request
	 * @param response
	 * @return
	 */
	//二维码直接输出方式
	@RequestMapping(value = "/url2", method = RequestMethod.GET)
	public void getUrl3(@RequestParam(value="url2")String url, HttpServletRequest request,HttpServletResponse response) {
		url=URLDecoder.decode(Constants.PROJECT_HOST+url);
		int width = 300;
		int height = 300;
		//二维码的图片格式 
		Hashtable hints = new Hashtable();
		//内容所使用编码 
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix;
		try {
			bitMatrix = new MultiFormatWriter().encode(url,
					BarcodeFormat.QR_CODE, width, height, hints);
			BufferedImage image=MatrixToImageWriter.toBufferedImage(bitMatrix);
			ByteArrayOutputStream os = new ByteArrayOutputStream();  
			ImageIO.write(image, "gif", os);  
			InputStream is = new ByteArrayInputStream(os.toByteArray());  
			IOUtils.copy(is,response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}


final class MatrixToImageWriter {

	private static final int BLACK = 0xFF000000;
	private static final int WHITE = 0xFFFFFFFF;

	private MatrixToImageWriter() {
	}

	public static BufferedImage toBufferedImage(BitMatrix matrix) {
		int width = matrix.getWidth();
		int height = matrix.getHeight();
		BufferedImage image = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				image.setRGB(x, y, matrix.get(x, y) ? BLACK : WHITE);
			}
		}
		return image;
	}

	public static void writeToFile(BitMatrix matrix, String format, File file)
			throws IOException {
		BufferedImage image = toBufferedImage(matrix);
		if (!ImageIO.write(image, format, file)) {
			throw new IOException("Could not write an image of format "
					+ format + " to " + file);
		}
	}

	public static void writeToStream(BitMatrix matrix, String format,
			OutputStream stream) throws IOException {
		BufferedImage image = toBufferedImage(matrix);
		if (!ImageIO.write(image, format, stream)) {
			throw new IOException("Could not write an image of format "
					+ format);
		}
	}

	

	
	
}
