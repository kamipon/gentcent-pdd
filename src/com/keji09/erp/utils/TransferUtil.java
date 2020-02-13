package com.keji09.erp.utils;
import java.io.File;
import java.io.FileInputStream;
import java.security.KeyStore;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.util.EntityUtils;

import com.keji09.develop.weixin.util.GetWxOrderno;
import com.keji09.develop.weixin.util.HttpClientConnectionManager;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.support.XDAOSupport;


/**
 * 转账工具类（企业转账，红包，退款等）
 * @author Administrator
 *
 */
public class TransferUtil extends XDAOSupport{
	
	//转账验证返回结果不同，所以要有多个返回验证
	//企业转账
	public String companyPay(String url,String xmlParam,HttpServletRequest request) throws Exception{
		String result = "";
		System.out.println("xml是:"+xmlParam);
		//-------------------------------证书加载
		KeyStore keyStore  = KeyStore.getInstance("PKCS12");
		List<WechartConfigEntity> list=this.getWechartConfigEntityDAO().listAll();
		WechartConfigEntity wce=null;
		if(list!=null&&list.size()>0){
			 wce=list.get(0);
		}
		if(wce.getNewFileName()!=null){
			String allfile="/opt/keji09/apache-tomcat-tk-red/webapps/"+wce.getNewFileName();
			FileInputStream instream = new FileInputStream(new File(allfile));
			System.out.println("文件地址"+allfile);
			System.out.println("文件地址stream"+instream);
			try {
				keyStore.load(instream, wce.getPartner().toCharArray());
			} finally {
				instream.close();
			}
		}else {
			result = "红包证书为空";
			return result;
		}

        // Trust own CA and all self-signed certs
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, wce.getPartner().toCharArray()).build();
        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                sslcontext,
                new String[] { "TLSv1" },
                null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
        //--------------------------------------------
        
//		DefaultHttpClient httpclient= new DefaultHttpClient();
//		httpclient = (DefaultHttpClient)HttpClientConnectionManager.getSSLInstance(httpclient);
		DefaultHttpClient client = new DefaultHttpClient(new ThreadSafeClientConnManager());
		client.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
		HttpPost httpost= HttpClientConnectionManager.getPostMethod(url);
		HttpResponse response=null;
	    try {
			 httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));
			 response = httpclient.execute(httpost);
		     String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");
		     Map<String, Object> dataMap = new HashMap<String, Object>();
//		    if(jsonStr.indexOf("FAIL")!=-1){
//		    	return result;
//		    }
		     System.out.println("微信返回的字符串："+jsonStr);
		    if(jsonStr.contains("更换了openid，但商户单号未更新")){
		    	result = "更换了openid，但商户单号未更新";
		    	return result;
		    }
		    Map map = GetWxOrderno.doXMLParse(jsonStr);
		    String return_code  = (String) map.get("return_code");
		    String result_code = (String)map.get("result_code");
		    if("SUCCESS".equals(return_code)){
		    	if("SUCCESS".equals(result_code)){
		    		result=(String) map.get("result_code");
		    	}else{
		    		result=(String) map.get("err_code_des");
		    	}
		    }else{
			    result=return_code;
		    }
		    System.out.println("支付结果:"+jsonStr);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {  
				response.getEntity().getContent().close(); //!!!IMPORTANT  
			} catch (Exception e) {  // go to hell  
			}
		}
		return result;
	}
	
	//红包转账验证
	public String redPay(String url,String xmlParam,MemberEntity member,HttpServletRequest request) throws Exception{
		System.out.println("xml是:"+xmlParam);
		//-------------------------------证书加载
		KeyStore keyStore  = KeyStore.getInstance("PKCS12");
		List<WechartConfigEntity> list=this.getWechartConfigEntityDAO().listAll();
		WechartConfigEntity wechart=null;
		if(list!=null&&list.size()>0){
			wechart=list.get(0);
		}
		String allfile="/opt/keji09/apache-tomcat-tk-red/webapps/";
		FileInputStream instream = new FileInputStream(new File(allfile));
        try {
            keyStore.load(instream, wechart.getPartner().toCharArray());
        } finally {
            instream.close();
        }

        // Trust own CA and all self-signed certs
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, wechart.getPartner().toCharArray()).build();
        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                sslcontext,
                new String[] { "TLSv1" },
                null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
        //--------------------------------------------
        
//		DefaultHttpClient httpclient= new DefaultHttpClient();
//		httpclient = (DefaultHttpClient)HttpClientConnectionManager.getSSLInstance(httpclient);
		DefaultHttpClient client = new DefaultHttpClient(new ThreadSafeClientConnManager());
		client.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
		HttpPost httpost= HttpClientConnectionManager.getPostMethod(url);
		String result = "";
		HttpResponse response=null;
	    try {
			 httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));
			 response = httpclient.execute(httpost);
		     String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");
		     Map<String, Object> dataMap = new HashMap<String, Object>();
//		    if(jsonStr.indexOf("FAIL")!=-1){
//		    	return result;
//		    }
		    Map map = GetWxOrderno.doXMLParse(jsonStr);
		    String return_code  = (String) map.get("return_msg");
		    if("SUCCESS".equals(return_code)){
		    	result=(String) map.get("result_code");
		    }
		    System.out.println("支付结果:"+jsonStr);
		    result=return_code;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {  
				response.getEntity().getContent().close(); //!!!IMPORTANT  
			} catch (Exception e) {  // go to hell  
			}
		}
		return result;
	  }

	
}
