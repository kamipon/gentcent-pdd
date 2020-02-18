package com.keji09.erp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.hibernate.criterion.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.ManagerMsgEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
/**
 * 管理员通知帐号表
 * */
@Controller
@RequestMapping(value="/managerMsg")
public class ManagerMsgController extends XDAOSupport{

	
	@RequestMapping("/list")
	public String list(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			HttpServletRequest request,ModelMap map){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		if(user == null){
			return "login";
		}
		PaginationList<ManagerMsgEntity> ms=this.getManagerMsgEntityDAO().list(pageIndex, pageSize,Order.desc("addTime"));
		map.put("list", ms.getItems());
		map.put("total", ms.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(ms.getTotalCount()/ pageSize.doubleValue()));
		return "manager/managerMsg_list";
	}
	
	@RequestMapping("/acts")
	public String acts(			
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			HttpServletRequest request,ModelMap map){
		PaginationList<ActivityEntity> acts=this.getActivityEntityDAO().list(pageIndex, pageSize,Order.desc("addTime"));
		map.put("list", acts.getItems());
		map.put("total", acts.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(acts.getTotalCount()/ pageSize.doubleValue()));
		return "manager/managerMsg_acts_list";
	}
	
	@RequestMapping(value="/binding",method=RequestMethod.GET)
	public String query_of_id(
			ModelMap map,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		String type = "4";
		String host = Constants.PROJECT_HOST;
		WechartConfigEntity config=this.getWechartConfigEntityDAO().get("1");
		String accessToken=config.getAccesstoken();
		String key = type+"_id_"+user.getUserName()+"_ed";
		System.out.println("绑定二维码参数"+key);
		//获取带参数的二维码
		String ewmUrl="https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token="+accessToken;
		String param="{\"action_name\": \"QR_LIMIT_STR_SCENE\", \"action_info\": {\"scene\": {\"scene_str\":\"t"+key+"\"}}}";
		System.out.println("param:"+param);
		JSONObject userObj=WeixinUtil.httpRequest(ewmUrl,"POST",param);
		System.out.println("获取微信二维码结果："+userObj);
		String url=userObj.getString("url");
		map.put("host", host);
		map.put("url", url);
		return "manager/wxmodel_binding";
	}
}
