package com.keji09.erp.api.controller;

import com.keji09.erp.model.FavoritesEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.SmsEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.HDaoUtils;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkGoodsBasicInfoGetRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkGoodsBasicInfoGetResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * 
 */
@Controller
@RequestMapping("/app_favorites")
public class FavoritesController extends XDAOSupport {

	@Autowired
	private PopHttpClient client;

	@RequestMapping(value="getState",method = RequestMethod.GET)
	@ResponseBody
	public Object getState(
			@RequestParam(value = "id") String id,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		FavoritesEntity favorites = this.getFavoritesEntityDAO().findUnique(HDaoUtils.eq("memberId",member.getId()).andEq("pid",id).toCondition());
		if(favorites==null){
			return false;
		}else{
			return true;
		}
	}

	/**
	 *添加收藏
	 */
	@RequestMapping(value="add",method = RequestMethod.GET)
	@ResponseBody
	public Object add(
			@RequestParam(value = "id") String id,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		FavoritesEntity favorites = this.getFavoritesEntityDAO().findUnique(HDaoUtils.eq("memberId",member.getId()).andEq("pid",id).toCondition());
		if(favorites==null){
			favorites = new FavoritesEntity();
			favorites.setMemberId(member.getId());
			favorites.setPid(id);
			this.getFavoritesEntityDAO().create(favorites);
		}
		map.put("flag",true);
		return map;
	}
	/**
	 * 删除
	 */
	@RequestMapping(value="remove",method = RequestMethod.GET)
	@ResponseBody
	public Object remove(
			@RequestParam(value = "id") String id,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		FavoritesEntity favorites = this.getFavoritesEntityDAO().findUnique(HDaoUtils.eq("memberId",member.getId()).andEq("pid",id).toCondition());
		if(favorites!=null){
			this.getFavoritesEntityDAO().remove(favorites);
		}
		map.put("flag",true);
		return map;
	}

	@RequestMapping(value="list",method = RequestMethod.GET)
	@ResponseBody
	public Object list(
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		MemberEntity member = (MemberEntity) req.getSession().getAttribute("member");
		List<FavoritesEntity> flist =  this.getFavoritesEntityDAO().list(HDaoUtils.eq("memberId",member.getId()).toCondition());
		map.put("list",flist);

		PddDdkGoodsBasicInfoGetRequest request = new PddDdkGoodsBasicInfoGetRequest();
		List<Long> goodsIdList = new ArrayList<Long>();
		for (FavoritesEntity f:flist) {
			goodsIdList.add(Long.valueOf(f.getPid() ));
		}
		try {
			request.setGoodsIdList(goodsIdList);
			PddDdkGoodsBasicInfoGetResponse response = client.syncInvoke(request);
			return JsonUtil.transferToJson(response);
		}catch (Exception e){
			e.printStackTrace();
		}

		return map;
	}

}