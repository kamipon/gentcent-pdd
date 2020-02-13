package com.keji09.erp.service;

import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import net.sf.json.JSONObject;

import com.keji09.develop.weixin.pojo.AccessToken;
import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.DateUtil2;
import com.mezingr.dao.HDaoUtils;

public class TaskService extends XDAOSupport{
	Timer timer;
    public TaskService() {
		timer = new Timer();
		timer.schedule(new RemindTask(),10*1000, 3600*1000);
		System.out.println("系统微信任务启动,准备更新accesstoken！");
    }
  
    class RemindTask extends TimerTask {
        public void run() {
        	List<WechartConfigEntity> list=getWechartConfigEntityDAO().listAll();
        	System.out.println("更新数量:"+list.size());
        	for(WechartConfigEntity wce:list){
        		if(wce.getAppId()!=null&&wce.getAppSecret()!=null&&!wce.getAppId().equals("")&&!wce.getAppSecret().equals("")){
        			AccessToken accessToken = WeixinUtil.getAccessToken(wce.getAppId(), wce.getAppSecret());
        			if(accessToken!=null){
        				System.out.println("获取access_token成功，有效时长"+accessToken.getExpiresIn()+"秒 token:"+accessToken.getToken());  
        				wce.setAccesstoken(accessToken.getToken());
        				String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token="+ accessToken.getToken() + "";
        				JSONObject object=WeixinUtil.httpRequest(url,"GET",null);
        				if(object.getString("errmsg").equals("ok")){
	        				String ticket=object.getString("ticket");
	        				wce.setJsapiTicket(ticket);
	        				System.out.println("获取ticket成功,ticket:"+ticket);
        				}
        			}
        			getWechartConfigEntityDAO().update(wce);
        		}
        	}
        }
    }
}
