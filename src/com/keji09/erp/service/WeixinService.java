package com.keji09.erp.service;

import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.keji09.develop.weixin.pojo.AccessToken;
import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.WechartActivityConfigEntity;
import com.keji09.erp.model.WechartComponentEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.HDaoUtils;

@Service
public class WeixinService extends XDAOSupport{
	private static Log log = LogFactory.getLog(WeixinService.class);
	Timer timer;
    public WeixinService() {
//		timer = new Timer();
//		timer.schedule(new RemindTask(),10*1000, 3600*1000);
//		log.info("定时任务启动,准备更新accesstoken！");
    }
    class RemindTask extends TimerTask {
        public void run() {
        	List<WechartActivityConfigEntity> list1=getWechartActivityConfigEntityDAO().list(HDaoUtils.eq("type", 2).toCondition());
        	log.info("自主公众号accessToken更新数量:"+list1.size());
        	for(WechartActivityConfigEntity wce:list1){
        		if(wce.getAppId()!=null&&wce.getAppSecret()!=null&&!wce.getAppId().equals("")&&!wce.getAppSecret().equals("")){
        			AccessToken accessToken = WeixinUtil.getAccessToken(wce.getAppId(), wce.getAppSecret());
        			if(accessToken!=null){
        				log.info("获取access_token成功，有效时长"+accessToken.getExpiresIn()+"秒 token:"+accessToken.getToken());  
        				wce.setAccesstoken(accessToken.getToken());
        				String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token="+ accessToken.getToken() + "";
        				JSONObject object=WeixinUtil.httpRequest(url,"GET",null);
        				if(object.getString("errmsg").equals("ok")){
	        				String ticket=object.getString("ticket");
	        				wce.setJsapiTicket(ticket);
	        				log.info("获取ticket成功,ticket:"+ticket);
        				}
        			}
        			getWechartActivityConfigEntityDAO().update(wce);
        		}
        	}
        	List<WechartActivityConfigEntity> list2=getWechartActivityConfigEntityDAO().list(HDaoUtils.eq("type", 2).andEq("isAuth", true).toCondition());
        	log.info("授权公众号accessToken更新数量:"+list2.size());
        	for(WechartActivityConfigEntity wce:list2){
        		if(wce.getAppId()!=null&&!wce.getAppId().equals("")&&wce.getComponentAppid()!=null&&!wce.getComponentAppid().equals("")&&wce.getRefreshtoken()!=null&&!wce.getRefreshtoken().equals("")){
        			WechartComponentEntity w=getWechartComponentEntityDAO().findUnique(HDaoUtils.eq("appId", wce.getComponentAppid()).toCondition());
        			if(w!=null){
        				String url="https://api.weixin.qq.com/cgi-bin/component/api_authorizer_token?component_access_token="+w.getAccesstoken();
        				String param="{\"component_appid\":\""+w.getAppId()+"\",\"authorizer_appid\":\""+wce.getAppId()+"\",\"authorizer_refresh_token\":\""+wce.getRefreshtoken()+"\"}";
        				JSONObject tempObj=WeixinUtil.httpRequest(url,"POST",param);
        				log.info("结果:"+tempObj);
        				try{
	        				String authorizerAccessToken=tempObj.getString("authorizer_access_token");
	        				String authorizerRefreshToken=tempObj.getString("authorizer_refresh_token");
	        				log.info("获取授权公众号access_token成功:"+authorizerAccessToken);  
	        				wce.setAuthAccesstoken(authorizerAccessToken);
	        				wce.setAccesstoken(authorizerAccessToken);
	        				wce.setRefreshtoken(authorizerRefreshToken);
	        				getWechartActivityConfigEntityDAO().update(wce);
        				}catch(Exception ex){
        					log.info(ex.getMessage());
        				}
        			}
        		}
        	}
        	List<WechartComponentEntity> components=getWechartComponentEntityDAO().listAll();
        	log.info("第三方平台accessToken更新数量:"+components.size());
        	for(WechartComponentEntity wce:components){
        		if(wce.getAppId()!=null&&wce.getAppSecret()!=null&&!wce.getAppId().equals("")&&!wce.getAppSecret().equals("")&&wce.getVerifyTicket()!=null&&!wce.getVerifyTicket().equals("")){
        			AccessToken accessToken = WeixinUtil.getAccessTokenByComponent(wce.getAppId(), wce.getAppSecret(),wce.getVerifyTicket());
        			if(accessToken!=null){
        				log.info("获取component_access_token成功，有效时长"+accessToken.getExpiresIn()+"秒 token:"+accessToken.getToken());  
        				wce.setAccesstoken(accessToken.getToken());
        				getWechartComponentEntityDAO().update(wce);
        			}else{
        				log.info("---------第三方平台更新access_token失败---------");
        			}
        		}
        	}
        }
    }
}
