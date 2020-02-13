package com.keji09.erp.controller;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.WechartActivityConfigEntity;
import com.keji09.erp.model.WechartComponentEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.weixin.bean.WechartMenuBean;
import com.mezingr.dao.HDaoUtils;
/**
 * 网站设置管理控制器  
 *
 */
@Controller
@RequestMapping("/wechart")
public class WechartComponentController extends XDAOSupport{
	
	/**
	 * 判断用户是否需要公众号授权，如果已授权过则不需要授权
	 * @return
	 */
	@RequestMapping(value="isauth",method = RequestMethod.GET)
	@ResponseBody
	public Boolean isAuth(HttpServletRequest request){
		ActivityEntity activity =(ActivityEntity)request.getSession().getAttribute("activity");
		if(activity!=null){
			//获取用户公众号授权信息，如果没有授权则前往授权
			List<WechartActivityConfigEntity> list=this.getWechartActivityConfigEntityDAO().list(HDaoUtils.eq("activity", activity.getId()).andEq("type", 2).andEq("isAuth", true).toCondition());
			if(list!=null&&list.size()>0){
				return true;
			}
		}
		return false;
	}

	/**
	 * 获取微信设置
	 */
	@RequestMapping(value="auth",method = RequestMethod.GET)
	public String initAuth(ModelMap mm,HttpServletRequest request){
		ActivityEntity activity =(ActivityEntity)request.getSession().getAttribute("activity");
		if(activity!=null){
			//获取用户公众号授权信息，如果没有授权则前往授权
			List<WechartActivityConfigEntity> list=this.getWechartActivityConfigEntityDAO().list(HDaoUtils.eq("activity", activity.getId()).andEq("type", 2).andEq("isAuth", true).toCondition());
			if(list!=null&&list.size()>0){
				WechartActivityConfigEntity wce=list.get(0);
				mm.put("item", wce);
				return "manager/wechart_auth_success";
			}else{
				List<WechartComponentEntity> wces=this.getWechartComponentEntityDAO().listAll();
				if(wces!=null&&wces.size()>0){
					WechartComponentEntity wce=wces.get(0);
					//获取预授权码
					String url="https://api.weixin.qq.com/cgi-bin/component/api_create_preauthcode?component_access_token="+wce.getAccesstoken();
					String param="{\"component_appid\":\""+wce.getAppId()+"\"}";
    				JSONObject tempObj=WeixinUtil.httpRequest(url,"POST",param);
    				System.out.println("预授权信息："+tempObj);
					mm.put("component_appid", wce.getAppId());
					mm.put("pre_auth_code", tempObj.getString("pre_auth_code"));
					mm.put("redirect_uri", URLEncoder.encode(wce.getRedirectUri()));
				}
			}
		}
		return "manager/wechart_auth";
	}

	/**
	 * 授权回调
	 */
	@RequestMapping(value="validate",method = RequestMethod.GET)
	public String validate(ModelMap mm,HttpServletRequest request){
		String authCode=request.getParameter("auth_code");
		if(authCode!=null){
			System.out.println("授权码:"+authCode);
			ActivityEntity activity =(ActivityEntity)request.getSession().getAttribute("activity");
			System.out.println("授权商家id:"+activity.getId());
			List<WechartComponentEntity> wces=this.getWechartComponentEntityDAO().listAll();
			if(wces!=null&&wces.size()>0){
				WechartComponentEntity wce=wces.get(0);
				String tempUrl="https://api.weixin.qq.com/cgi-bin/component/api_query_auth?component_access_token="+wce.getAccesstoken();
				String tempParam="{\"component_appid\":\""+wce.getAppId()+"\",\"authorization_code\":\""+authCode+"\"}";
				try{
					JSONObject tempObj=WeixinUtil.httpRequest(tempUrl,"POST",tempParam);
					System.out.println("获取授权信息:"+tempObj);
					JSONObject info=tempObj.getJSONObject("authorization_info");
					//获取授权对象的appid
					String appid=info.getString("authorizer_appid");
					//获取授权对象的authorizer_access_token
					String accessToken=info.getString("authorizer_access_token");
					//获取授权对象的authorizer_refresh_token
					String refreshToken=info.getString("authorizer_refresh_token");
					//获取公众号授权给开发者的权限集列表
					String funcCount="";
					JSONArray funcInfo=info.getJSONArray("func_info");
					for(int i=0;i<funcInfo.size();i++){
						Integer id=funcInfo.getJSONObject(i).getJSONObject("funcscope_category").getInt("id");
						if(i==funcInfo.size()-1){
							funcCount+=id;
						}else{
							funcCount+=id+",";
						}
					}
					/**
					 * 获取授权方的公众号帐号基本信息
					 */
					String wechartInfoUrl="https://api.weixin.qq.com/cgi-bin/component/api_get_authorizer_info?component_access_token="+wce.getAccesstoken();
					String wechartParam="{\"component_appid\":\""+wce.getAppId()+"\",\"authorizer_appid\":\""+appid+"\"}";
					JSONObject wechartInfo=WeixinUtil.httpRequest(wechartInfoUrl,"POST",wechartParam);
					System.out.println("公众号帐号基本信息:"+wechartInfo);
					//获取授权方信息
					JSONObject authorizerInfo=wechartInfo.getJSONObject("authorizer_info");
					//获取授权方昵称
					String nickName=authorizerInfo.getString("nick_name");
					//获取授权方头像
					String headImg=authorizerInfo.getString("head_img");
					//授权方公众号类型，0代表订阅号，1代表由历史老帐号升级后的订阅号，2代表服务号
					Integer serviceTypeInfo=authorizerInfo.getJSONObject("service_type_info").getInt("id");
					//授权方认证类型
					Integer verifyTypeInfo=authorizerInfo.getJSONObject("verify_type_info").getInt("id");
					//授权方公众号的原始ID
					String userName=authorizerInfo.getString("user_name");
					//授权方公众号所设置的微信号，可能为空
					String alias=authorizerInfo.getString("alias");
					//功能的开通状况
					JSONObject businessInfo=authorizerInfo.getJSONObject("business_info");
					// 二维码图片的URL
					String qrcodeUrl=authorizerInfo.getString("qrcode_url");
					//先将之前授权的公众号删除2017-12-22 14:31:27
					List<WechartActivityConfigEntity> before = this.getWechartActivityConfigEntityDAO().list(HDaoUtils.eq("activity", activity.getId()).toCondition());
					for(WechartActivityConfigEntity wac:before){
						this.getWechartActivityConfigEntityDAO().remove(wac);
					}
					//获取授权对象的设置，如果有则更新，没有则创建
					List<WechartActivityConfigEntity> list=this.getWechartActivityConfigEntityDAO().list(HDaoUtils.eq("appId", appid).andEq("type", 2).toCondition());
					if(list!=null&&list.size()>0){
						WechartActivityConfigEntity item=list.get(0);
						item.setAppId(appid);
						item.setAccesstoken(accessToken);
						item.setRefreshtoken(refreshToken);
						item.setFuncInfo(funcCount);
						item.setNickName(nickName);
						item.setHeadImg(headImg);
						item.setServiceTypeInfo(serviceTypeInfo);
						item.setVerifyTypeInfo(verifyTypeInfo);
						item.setUserName(userName);
						item.setAlias(alias);
						item.setBusinessInfo(businessInfo.toString());
						item.setQrcodeUrl(qrcodeUrl);
						item.setUpdateTime(new Date());
						item.setIsAuth(true);
						this.getWechartActivityConfigEntityDAO().update(item);
					}else{
						WechartActivityConfigEntity item=new WechartActivityConfigEntity();
						item.setAppId(appid);
						item.setAccesstoken(accessToken);
						item.setRefreshtoken(refreshToken);
						item.setFuncInfo(funcCount);
						item.setNickName(nickName);
						item.setHeadImg(headImg);
						item.setServiceTypeInfo(serviceTypeInfo);
						item.setVerifyTypeInfo(verifyTypeInfo);
						item.setUserName(userName);
						item.setAlias(alias);
						item.setBusinessInfo(businessInfo.toString());
						item.setQrcodeUrl(qrcodeUrl);
						item.setType(2);
						item.setActivity(activity.getId());
						item.setComponentAppid(wce.getAppId());
						item.setIsAuth(true);
						this.getWechartActivityConfigEntityDAO().create(item);
					}
				}catch(Exception ex){
					ex.printStackTrace();
				}
			}
		}
		return "redirect:/wechart/auth";
	}
	/**
	 * 微信菜单初始化
	 */
	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public String getMenu(ModelMap mm,HttpServletRequest request){
		ActivityEntity activity =(ActivityEntity)request.getSession().getAttribute("activity");
		WechartActivityConfigEntity config=null;
		if(activity!=null){
			config=this.getWechartActivityConfigEntityDAO().findUnique(HDaoUtils.eq("activity", activity.getId()).toCondition());
		}
		if(config!=null){
			if(config.getMenu()==null){
				mm.put("menuString", new ArrayList<String>());
			}else{
				mm.put("menuString", config.getMenu());
			}
		}
		return "manager/wechart_menu_activity";
	}
	/**
	 * 微信菜单设置
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/menu", method = RequestMethod.POST)
	public String menu(@RequestParam(value = "menuString")String menuString,ModelMap mm,HttpServletRequest request){
		ActivityEntity activity =(ActivityEntity)request.getSession().getAttribute("activity");
		WechartActivityConfigEntity config=null;
		if(activity!=null){
			config=this.getWechartActivityConfigEntityDAO().findUnique(HDaoUtils.eq("activity", activity.getId()).toCondition());
		}
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
	        if(appId==null||appSecret==null){
	        	System.out.println("请先设置微信应用id和密匙！");
	        	mm.put("message", "请先设置微信应用id和密匙");
	        }else{
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
	     }
		config.setMenu(menuString);
		this.getWechartActivityConfigEntityDAO().update(config);
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
        	if(wmb==null)break;
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
    
    /**
     * 微信参数初始化
     */
    @RequestMapping(value = "/parameter", method = RequestMethod.GET)
	public String getparameter(ModelMap mm,HttpServletRequest request){
    	ActivityEntity activity =(ActivityEntity)request.getSession().getAttribute("activity");
		WechartActivityConfigEntity config=null;
		if(activity!=null){
			config=this.getWechartActivityConfigEntityDAO().findUnique(HDaoUtils.eq("activity", activity.getId()).toCondition());
		}
		mm.put("config", config);
		return "manager/wechart_config";
	}
    
    /**
     * 对接参数设置
     */
    @RequestMapping("setparameter")
    @ResponseBody
    public Map<String, Object> setparameter(
    		@RequestParam(value = "AppId") String appId,
    		@RequestParam(value = "AppSecret") String appSecret,
    		HttpServletRequest request){
    	Map<String,Object> map = new HashMap<String, Object>();
    	boolean flag = false;
    	ActivityEntity activity =(ActivityEntity)request.getSession().getAttribute("activity");
		WechartActivityConfigEntity config=null;
		if(activity!=null){
			config=this.getWechartActivityConfigEntityDAO().findUnique(HDaoUtils.eq("activity", activity.getId()).toCondition());
		}
    	if(config!=null){
    		config.setAppId(appId);
    		config.setAppSecret(appSecret);
    		this.getWechartActivityConfigEntityDAO().update(config);
    	}else{
    		WechartActivityConfigEntity wc = new WechartActivityConfigEntity();
    		wc.setAppId(appId);
    		wc.setAppSecret(appSecret);
    		wc.setActivity(activity.getId());
    		this.getWechartActivityConfigEntityDAO().create(wc);
    	}
    	flag = true;
    	map.put("flag", flag);
    	return map;
    }
}