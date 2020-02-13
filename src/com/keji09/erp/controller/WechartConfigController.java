package com.keji09.erp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji09.develop.weixin.pojo.AccessToken;
import com.keji09.develop.weixin.pojo.Button;
import com.keji09.develop.weixin.pojo.CommonButton;
import com.keji09.develop.weixin.pojo.ComplexButton;
import com.keji09.develop.weixin.pojo.Menu;
import com.keji09.develop.weixin.pojo.ViewButton;
import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.weixin.bean.WechartMenuBean;
import com.mezingr.dao.HDaoUtils;


/**
 * 微信开发者管理器
 * */

@Controller
@RequestMapping(value="/wechart_config")
public class WechartConfigController extends XDAOSupport{
	
	/**
	 * 获取微信设置
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String wechartConfig(ModelMap mm,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		if(user == null){
			return "login";
		}
		List<WechartConfigEntity> list=this.getWechartConfigEntityDAO().listAll();
		WechartConfigEntity wce=null;
		if(list!=null&&list.size()>0){
			 wce=list.get(0);
		}
		if(wce!=null){
			mm.put("config", wce);
		}else{
			wce=new WechartConfigEntity();
			this.getWechartConfigEntityDAO().create(wce);
			mm.put("config", wce);
		}
		return "manager/wechart_setting";
	}

	/**
	 * 微信设置
	 */
	@RequestMapping(value="add",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap wechart(
			@RequestParam(value = "appId") String appid,
			@RequestParam(value = "appSecret") String appSecret,
			@RequestParam(value = "token") String token,
			@RequestParam(value = "encodingAESKey") String encodingAESKey,
			@RequestParam(value = "partner") String partner,
			@RequestParam(value = "partnerkey") String partnerkey,
			@RequestParam(value = "payAccount") String payAccount,
			@RequestParam(value = "cooperateAccount") String cooperateAccount,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "presentOpen") Boolean presentOpen,
			@RequestParam(value = "rechargeOpen") Boolean rechargeOpen,
			@RequestParam(value = "isMoreService") Boolean isMoreService,
			@RequestParam(value = "redpacketMoney") String redpacketMoney,
			ModelMap mm,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		if(user == null){
			mm.put("message", "该用户不存在，请重新登陆！");
		}else{
			List<WechartConfigEntity> list=this.getWechartConfigEntityDAO().listAll();
			WechartConfigEntity config=null;
			if(list!=null&&list.size()>0){
				config=list.get(0);
			}
			if(config!=null){
				config.setAppId(appid);
				config.setAppSecret(appSecret);
				config.setToken(token);
				config.setEncodingAESKey(encodingAESKey);
				config.setPartner(partner);
				config.setPartnerkey(partnerkey);
				config.setPayAccount(payAccount);
				config.setCooperateAccount(cooperateAccount);
				config.setPassword(password);
				config.setRechargeOpen(rechargeOpen);
				config.setPresentOpen(presentOpen);
				config.setIsMoreService(isMoreService);
				config.setRedpacketMoney(Float.parseFloat(redpacketMoney));
				this.getWechartConfigEntityDAO().update(config);
				System.out.println("微信设置成功！");
	        	mm.put("message", "微信设置成功！");
				AccessToken accessToken = WeixinUtil.getAccessToken(config.getAppId(), config.getAppSecret());
				if(accessToken!=null){
					System.out.println("获取access_token成功，有效时长"+accessToken.getExpiresIn()+"秒 token:"+accessToken.getToken());  
					config.setAccesstoken(accessToken.getToken());
					String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token="+ accessToken.getToken() + "";
					JSONObject object=WeixinUtil.httpRequest(url,"GET",null);
					if(object.getString("errmsg").equals("ok")){
	    				String ticket=object.getString("ticket");
	    				config.setJsapiTicket(ticket);
	    				System.out.println("获取ticket成功,ticket:"+ticket);
					}
				}
				this.getWechartConfigEntityDAO().update(config);
			}
		}
		return mm;
	}
	
	/**
	 * 微信菜单初始化
	 */
	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public String getMenu(ModelMap mm,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		if(user == null){
			return "login";
		}
		WechartConfigEntity config=this.getWechatConfig();
		if(config!=null){
			if(config.getMenu()==null){
				mm.put("menuString", new ArrayList<String>());
			}else{
				mm.put("menuString", config.getMenu());
			}
		}
		return "manager/wechart_menu";
	}
	/**
	 * 微信菜单设置
	 */
	@RequestMapping(value = "/adds", method = RequestMethod.POST)
	public String menu(@RequestParam(value = "menuString")String menuString,ModelMap mm,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		if(user == null){
			return "login";
		}
		WechartConfigEntity config=this.getWechatConfig();
		if(config!=null){
			List<WechartMenuBean> menus=new ArrayList<WechartMenuBean>();
			JSONObject jsonobject = JSONObject.fromObject(menuString);
			JSONArray array = jsonobject.getJSONArray("menus");
			for (int i = 0; i < array.size(); i++) {   
				JSONObject object = (JSONObject)array.get(i);  
				WechartMenuBean menu = (WechartMenuBean)JSONObject.toBean(object,WechartMenuBean.class);
				if(object.get("items")!=null){
					JSONArray items=object.getJSONArray("items");
					List<WechartMenuBean> list = (List<WechartMenuBean>)JSONArray.toCollection(items, WechartMenuBean.class);
					menu.setItems(list);
				}
				if(menu != null){
					menus.add(menu);
				}
			}
			// 第三方用户唯一凭证  
	        String appId = config.getAppId();  
	        // 第三方用户唯一凭证密钥  
	        String appSecret = config.getAppSecret();  
	        // 调用接口获取access_token  
	        AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);  
	        if (null != at) {  
	            // 调用接口创建菜单  
	            int result = WeixinUtil.createMenu(getMenu(menus), at.getToken());  
	            // 判断菜单创建结果  
	            if (0 == result){  
	            	System.out.println("菜单创建成功！");
	            	mm.put("message", "菜单创建成功！");
	            }else{  
	            	System.out.println("菜单创建失败，错误码：" + result);
	            	mm.put("message", "菜单创建失败，错误码：" + result);
	            }
	        }  
		}
		config.setMenu(menuString);
		this.getWechartConfigEntityDAO().update(config);
    	return getMenu(mm, request);
	}
	/** 
     * 组装菜单数据 
     *  
     * @return 
     */  
    private Menu getMenu(List<WechartMenuBean> menus) {  
        Menu menu = new Menu();  
        Button[] button=new Button[menus.size()];
        for(int i=0;i<menus.size();i++){
        	WechartMenuBean wmb=menus.get(i);
        	if(wmb.getType().equals("view")){
        		ViewButton btn = new ViewButton();  
        		btn.setName(wmb.getName());  
        		btn.setType("view");  
        		btn.setUrl(wmb.getUrl());
        		button[i]=btn;
        	}else if(wmb.getType().equals("click")){
        		CommonButton btn = new CommonButton();  
        		btn.setName(wmb.getName());  
        		btn.setType("click");  
        		btn.setKey(wmb.getKey()); 
        		button[i]=btn;
        	}else if(wmb.getType().equals("menu")){
        		ComplexButton mainBtn = new ComplexButton();  
        		mainBtn.setName(wmb.getName());
        		Button[] subBtn=new Button[wmb.getItems().size()];
        		for(int j=0;j<wmb.getItems().size();j++) {
                	WechartMenuBean sub=wmb.getItems().get(j);
        			if(sub.getType().equals("view")){
                		ViewButton btn = new ViewButton();  
                		btn.setName(sub.getName());  
                		btn.setType("view");  
                		btn.setUrl(sub.getUrl());
                		subBtn[j]=btn;
                	}else if(sub.getType().equals("click")){
                		CommonButton btn = new CommonButton();  
                		btn.setName(sub.getName());  
                		btn.setType("click");  
                		btn.setKey(sub.getKey()); 
                		subBtn[j]=btn;
                	}
				}
        		mainBtn.setSub_button(subBtn);
        		button[i]=mainBtn;
        	}
        }
        menu.setButton(button);
        return menu;  
    }
}
