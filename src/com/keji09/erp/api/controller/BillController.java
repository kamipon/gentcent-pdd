package com.keji09.erp.api.controller;

import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.BillEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.pdd.pop.sdk.http.PopHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 *充值
 */
@Controller
@RequestMapping("/app_recharge")
public class BillController extends XDAOSupport {

	@Autowired
	private PopHttpClient client;

	/**
	 * red  给红包派调用
	 */
	@RequestMapping(value="redRecharge",method = RequestMethod.GET)
	@ResponseBody
	public Object redRecharge(
			@RequestParam(value = "id") String id,//用户id
			@RequestParam(value = "money") Integer money,//金额 单位分
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map){
		MemberEntity member = this.getMemberEntityDAO().get(id);
		if(member==null){
			map.put("flag",false);
			return map;
		}
		member.setMoney(member.getMoney()+money);
		BillEntity recharge = new BillEntity();
		recharge.setMoney(money);
		recharge.setType(1);
		recharge.setForm(1);
		recharge.setMemberId(member.getId());
		recharge.setActivityId(member.getActivity().getId());
		this.getBillEntityDAO().create(recharge);
		this.getMemberEntityDAO().update(member);
		map.put("flag",true);
		return map;
	}

}