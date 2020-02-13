package com.keji09.erp.controller;

import com.keji09.develop.weixin.util.WeixinUtil;
import com.keji09.erp.model.*;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HDaoUtils;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Criterion;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
/**
 * 微信模板消息  
 *
 */
@Controller
@RequestMapping("/wxmodel_sms")
public class WxModelSMSController extends XDAOSupport{
	
	/**
	 *  微信模板消息设置查询
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String WxModel(
			@RequestParam(value="mbId") String mbId,
			ModelMap map,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		List<WxModelSMSBindingEntity> list = this.getWxModelSMSBindingEntityDAO().list(HDaoUtils.eq("member.id",mbId).toCondition());
		map.put("list", list);
		return "manager/wxmodel_setting";
	}
	
	/**
	 * 开关
	 * @param id	WxModelSMSBindingEntity.id
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/status/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> onOrOff(@PathVariable("id")String id,ModelMap map){
		WxModelSMSBindingEntity smsB=this.getWxModelSMSBindingEntityDAO().get(id);
		if(smsB!=null){
			if (smsB.getStatus()==0) {
				smsB.setStatus(1);
			}else{
				smsB.setStatus(0);
			}
			this.getWxModelSMSBindingEntityDAO().update(smsB);
			map.put("flag", true);
		}else{
			map.put("flag", false);
		}
		return map;
	}
	
	/**
	 * 判断用户是否绑定微信，绑定则关系二维码页面
	 * @param old	微信管理员个数
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/isBing",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> isBing(@RequestParam(value="old",defaultValue="0")Integer old,HttpServletRequest request,ModelMap map){
		ActivityEntity activity = (ActivityEntity)request.getSession().getAttribute("activity");
		List<MemberEntity> mbList=this.getMemberEntityDAO().list(HDaoUtils.eq("activity", activity).toCondition());
		if(mbList==null||mbList.size()==0){
			map.put("flag", false);
			map.put("_new", 0);
			return map;
		}
		if(old==mbList.size()){
			map.put("flag", false);
			map.put("_new", old);
			return map;
		}else{
			map.put("flag", true);
			map.put("_new", mbList.size());
			return map;
		}
	}
	
	/**
	 * 打开iframe 绑定用户
	 * 显示二维码
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/binding",method=RequestMethod.GET)
	public String query_of_id(
			ModelMap map,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		TerPointEntity terpoint =this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		ActivityEntity activity =this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		String type = "";
		if(terpoint!=null){
			type ="2";
		}
		if(activity!=null){
			type ="3";
		}
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
	
	/**
	 * 管理员查询所有绑定微信了的用户
	 * @return
	 */
	@RequestMapping(value="/wxList",method=RequestMethod.GET)
	public String wxList(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			@RequestParam(value = "openId",required=false) String openId,
			ModelMap map,HttpServletRequest request){
		Exp<Criterion> exp = HDaoUtils.notEmpty("activity");
		if(!StringUtils.isBlank(openId)){
			exp.andEq("openId", openId);
		}
		List<MemberEntity> list = this.getMemberEntityDAO().list(exp.toCondition());
		List<ActivityEntity> a_list = new ArrayList<ActivityEntity>();
		for(MemberEntity m :list){
			a_list.add(m.getActivity());
		}
		//去重
		List<ActivityEntity> actList = quchong(a_list);
		Integer sum = actList.size();
		//分页
		List<MemberEntity> mlist = fenye(list, pageIndex, pageSize);
		map.put("sum", sum);
		map.put("openId1", openId);
		map.put("list", mlist);
		map.put("total", list.size());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(list.size()/ pageSize.doubleValue()));
		return "manager/wx_list";
	}
	/**
	 * 去重复
	 * @param list
	 * @return
	 */
	public List<ActivityEntity> quchong(List<ActivityEntity> list){
         List<ActivityEntity> newList = new  ArrayList<ActivityEntity>(); 
         for (ActivityEntity cd:list) {
            if(!newList.contains(cd)){
                newList.add(cd);
            }
        }
		return newList;
	}
	/**
	 * 手动分页
	 */
	public List<MemberEntity> fenye(List<MemberEntity> list,Integer pageIndex,Integer pageSize){
		int start = (pageIndex-1)*pageSize;
		int end = pageIndex*pageSize;
		if(end>list.size()){
			end = list.size();
		}
		list = list.subList(start, end);
		return list;
	}
	
}