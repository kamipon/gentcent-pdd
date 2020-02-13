package com.keji09.erp.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji09.erp.bean.MemberBean;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;

/**
 * 用户管理管理器
 * */
@Controller
@RequestMapping(value="/member")
public class MemberEntityController extends XDAOSupport{
	/**
	 * 初始化查询用户信息
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String findAll(@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
						  @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
						  @RequestParam(value="nick",required=false)String nick,
						  @RequestParam(value="utype",required=false)Integer utype,
						  HttpServletRequest request,
						  ModelMap map){
		PaginationList<MemberEntity> memberList = null;
		Exp<Criterion> exp = null;
		exp=HDaoUtils.notEmpty("nick").andNe("nick","");
		if((StringUtils.isNotEmpty(nick))){
			exp=exp.andLike("nick", nick);
			map.put("nick", nick);
		}
		if(utype!=null){
			exp=exp.andEq("utype", utype);
			map.put("utype", utype);
		}
		memberList = this.getMemberEntityDAO().list(exp.toCondition(),pageIndex, pageSize,Order.desc("addTime"));
		map.put("list", memberList.getItems());
		map.put("total", memberList.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(memberList.getTotalCount()/ pageSize.doubleValue()));

		return "manager/member_list";
	}
	
	
	/**
	 * 给对应的用户绑定活动
	 */
	@RequestMapping(value="setActivity",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> set(@RequestParam(value="id")String ids,
			@RequestParam(value="memberId")String id,
			HttpServletRequest request,ModelMap map
			){
			String[] str=ids.split(",");
			try{
			
			
			MemberEntity entity = this.getMemberEntityDAO().get(id);
			map.put("msg", "绑定成功");
			map.put("flag", true);
			}catch (Exception e) {
				// TODO: handle exception
			map.put("msg", "绑定失败");
			map.put("flag", false);
			}
			return map;
			}
	/**
	 * 微信用户列表
	 */
	@RequestMapping(value="/bind/tobind",method = RequestMethod.GET)
	public String memberlist(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			  @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
			  @RequestParam(value = "nick",required=false) String nick,
			  @RequestParam(value = "shotId",required=false) String shotId,
			  ModelMap map,HttpServletRequest request){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		TerPointEntity terpoint =this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		ActivityEntity activity =this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		map.put("terPoint", terpoint);
		map.put("activity", activity);
		List<MemberEntity> mlist = null;
		Exp<Criterion> exp = HDaoUtils.notEmpty("id");
		if(activity!=null){
			exp.andEq("activity", activity);
			map.put("activity",activity);
		}
		if(!StringUtils.isBlank(nick)){
			exp.andLike("nick", nick);
			map.put("nick",nick);
		}
		if(!StringUtils.isBlank(shotId)){
			exp.andEq("shotId", shotId);
			map.put("shotId",shotId);
		}
		if(terpoint!=null){
			exp.andEq("terpoint", terpoint);
			map.put("terpoint", terpoint);
		}
		mlist = this.getMemberEntityDAO().list(exp.toCondition());
		List<MemberBean> beanlist = new ArrayList<MemberBean>();
		map.put("list", beanlist);
		map.put("total", beanlist.size());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(mlist.size()/ pageSize.doubleValue()));
		return "manager/member_bind";
	}
	
	/**
	 * 给用户绑定活动管理员身份先查询出所有活动并回显
	 */
	@RequestMapping(value="/set/{id}",method=RequestMethod.GET)
	public String set(
			@PathVariable(value="id") String id,
			ModelMap map
		){
		MemberEntity memberEntity = this.getMemberEntityDAO().get(id);
		map.put("member", memberEntity);
		return "manager/member_set";
	}
	
	/**
	 * 给用户绑定活动管理员身份先查询出所有活动并回显
	 */
	@RequestMapping(value="/set/{id}",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sets(
			@PathVariable(value="id") String id,
			@RequestParam(value="utype") Integer utype,
			ModelMap map
		){
		MemberEntity memberEntity = this.getMemberEntityDAO().get(id);
		memberEntity.setUtype(utype);
		this.getMemberEntityDAO().update(memberEntity);
		map.put("flag", true);
		map.put("msg","设置成功");
		return map;
	}
}
