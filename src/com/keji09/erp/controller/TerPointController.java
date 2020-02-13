package com.keji09.erp.controller;


import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.WechartConfigEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.role.UserRoleEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.service.PermissionService;
import com.keji09.erp.utils.DateUtil2;
import com.mezingr.dao.HDaoUtils;
import com.mezingr.dao.PaginationList;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
/**
 * 代理商实体控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/terPoint")
public class TerPointController extends XDAOSupport{
	
	@Autowired
	PermissionService permissionService;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	/**
	 * 初始化查询所有代理商
	 * @param map
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET)
	public String findAll(@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
		    			  @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
		    			  @RequestParam(value="name",required=false)String name,
		    			  @RequestParam(value="username",required=false)String username,
		    			  @RequestParam(value="type",required=false)String type,
		    			  HttpServletRequest request,
		    			  ModelMap map){
		PaginationList<TerPointEntity> terPointList = null;
		UserEntity u = (UserEntity) request.getSession().getAttribute("loginUser");
		TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", u).toCondition());
		if((StringUtils.isNotEmpty(name))){
			if(StringUtils.isNotEmpty(username)){
				UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", username).toCondition());
				if(type!=null&&type.equals("1")){
					terPointList = this.getTerPointEntityDAO().list(HDaoUtils.like("name", name).andEq("user", user).andEq("higher", ter.getId()).toCondition(),pageIndex, pageSize,Order.desc("addTime"));
				}else{
					terPointList = this.getTerPointEntityDAO().list(HDaoUtils.like("name", name).andEq("user", user).toCondition(),pageIndex, pageSize,Order.desc("addTime"));
				}
			}else{
				if(type!=null&&type.equals("1")){
					terPointList = this.getTerPointEntityDAO().list(HDaoUtils.like("name", name).andEq("higher", ter.getId()).toCondition(),pageIndex, pageSize,Order.desc("addTime"));
				}else{
					terPointList = this.getTerPointEntityDAO().list(HDaoUtils.like("name", name).toCondition(),pageIndex, pageSize,Order.desc("addTime"));
				}
			}
		}else{
			if(StringUtils.isNotEmpty(username)){
				UserEntity user = this.getUserEntityDAO().findUnique(HDaoUtils.eq("userName", username).toCondition());
				if(type!=null&&type.equals("1")){
					terPointList = this.getTerPointEntityDAO().list(HDaoUtils.eq("user", user).andEq("higher", ter.getId()).toCondition(),pageIndex, pageSize,Order.desc("addTime"));
				}else{
					terPointList = this.getTerPointEntityDAO().list(HDaoUtils.eq("user", user).toCondition(),pageIndex, pageSize,Order.desc("addTime"));
				}
			}else{
				if(type!=null&&type.equals("1")){
					terPointList = this.getTerPointEntityDAO().list(HDaoUtils.eq("higher", ter.getId()).toCondition(),pageIndex, pageSize,Order.desc("addTime"));
				}else{
					terPointList = this.getTerPointEntityDAO().list(pageIndex, pageSize,Order.desc("addTime"));
				}
			}
		}
		map.put("list", terPointList.getItems());
		map.put("total", terPointList.getTotalCount());
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("totalPage", (int) Math.ceil(terPointList.getTotalCount()/ pageSize.doubleValue()));
		return "manager/terpoint_list";		
	}
			
	/**
	 * 添加代理商
	 * @param host
	 * @param code
	 * @param weixin
	 * @param openTime
	 * @param phone
	 * @param state
	 * @param money
	 * @param overTime
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(@RequestParam(value="name")String name,
			@RequestParam(value="userName")String userName,
			@RequestParam(value="passWord")String passWord,
			@RequestParam(value="host",required=false)String host,
			@RequestParam(value="code",required=false)String code,
			@RequestParam(value="weixin",required=false)String weixin,
			@RequestParam(value="openTime",required=false)String openTime,
			@RequestParam(value="phone")String phone,
			@RequestParam(value="sheng")String sheng,
			@RequestParam(value="shi")String shi,
			@RequestParam(value="jibie")String jibie,
			@RequestParam(value="shangji",required=false)String shangji,
			@RequestParam(value="state",defaultValue="0")String state,
			@RequestParam(value="type",defaultValue="0")String type,
			@RequestParam(value="money",defaultValue="0")String money,
			@RequestParam(value="overTime")String overTime,
			@RequestParam(value="activityNum")String activityNum,HttpServletRequest request, ModelMap map){
	  try {
		  UserEntity user = new UserEntity();
		  user.setUserName(userName);
		  user.setPassword(passWord);
		  user.setWeixin(weixin);
		  user.setCode(code);
		  user.setPhone(phone);
		  user.setStatus(1);
		  user.setAddTime(new Date());
		  user.setRoleName(this.getRoleEntityDAO().get("2"));
		  this.getUserEntityDAO().create(user);
		  TerPointEntity entity = new TerPointEntity();
		  entity.setName(name);
		  entity.setUserName(userName);
		  entity.setPassword(passWord);
		  entity.setHost(host);
		  entity.setProvince(sheng);
		  entity.setCity(shi);
		  entity.setCode(code);
		  entity.setWeixin(weixin);
		  entity.setOpenTime(openTime);
		  if(jibie!=null&&!jibie.equals("0")){
			  entity.setPartner(1);
//			  UserMenuEntity ume = new UserMenuEntity();
//			  MenuEntity me = this.getMenuEntityDAO().get("8ab3bf6e62fc05670162fc5b688c0d8e");
//			  ume.setMenu(me);
//			  ume.setUser(user.getId());
//			  this.getUserMenuEntityDAO().create(ume);
		  }
		  if(shangji!=null&&!shangji.equals("1")){
			  entity.setHigher(shangji);
		  }else{
			  UserEntity user1 = (UserEntity) request.getSession().getAttribute("loginUser");
			  TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user1).toCondition());
			  if(ter!=null){
				  entity.setHigher(ter.getId());
			  }
		  }
		  entity.setPhone(phone);
		  entity.setStatus(Integer.valueOf(state));
		  entity.setType(Integer.valueOf(type));
		  entity.setMoney(Float.valueOf(money));
		  entity.setAddTime(new Date());
		  entity.setUser(user);
		  entity.setOverTime(DateUtil2.parseDateTime(overTime));
		  entity.setActivityNum(Integer.parseInt(activityNum));
		  this.getTerPointEntityDAO().create(entity);
		  //给新增的代理商设置角色
		  permissionService.setRole(user.getId(), new String[]{"2"});
		  map.put("flag", true);
		  map.put("msg","添加成功");
		} catch (Exception e) {
			map.put("flag", false);
			map.put("msg","添加失败");
		}
		return map;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String toadd(HttpServletRequest request, ModelMap map){
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		UserRoleEntity ur = this.getUserRoleEntityDAO().findUnique(HDaoUtils.eq("user", user.getId()).toCondition());
		List<TerPointEntity> list = this.getTerPointEntityDAO().list(HDaoUtils.eq("partner", 1).toCondition());
		map.put("hehuo", list);
		map.put("role", ur.getRole().getId());
		if(ur.getRole().getId().equals("2")){
			TerPointEntity te = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
			map.put("terpoint", te);
		}
		return "manager/terpoint_add";
	}
	
	/**
	 * 去修改代理商信息
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String findById(@PathVariable(value="id")String id,HttpServletRequest request,
							ModelMap map){
		TerPointEntity entity = this.getTerPointEntityDAO().get(id);
		UserEntity user = (UserEntity) request.getSession().getAttribute("loginUser");
		UserRoleEntity ur = this.getUserRoleEntityDAO().findUnique(HDaoUtils.eq("user", user.getId()).toCondition());
		List<TerPointEntity> list = this.getTerPointEntityDAO().list(HDaoUtils.eq("partner", 1).toCondition());
		if(entity.getHigher()!=null&&!entity.getHigher().equals("")){
			TerPointEntity te = this.getTerPointEntityDAO().get(entity.getHigher());
			map.put("te", te);
		}
		map.put("terpoint", entity);
		map.put("hehuo", list);
		map.put("role", ur.getRole().getId());
		return "manager/terpoint_update";
	}
	/**
	 * 去修改代理商可添加商家数量
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/activityNum",method=RequestMethod.GET)
	public String activityNum(@RequestParam(value="terId")String terId,
							ModelMap map){
		TerPointEntity entity = this.getTerPointEntityDAO().get(terId);
		map.put("terpoint", entity);
	
		return "manager/terpoint_activityNum";
	}
	
	
			
	/**
	 * 修改代理商信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> update(
	  @PathVariable(value="id") String id,
	  @RequestParam(value="name")String name,
	  @RequestParam(value="phone")String phone,
	  @RequestParam(value="state")String state,
	  @RequestParam(value="sheng")String sheng,
	  @RequestParam(value="shi")String shi,
	  @RequestParam(value="jibie")String jibie,
	  @RequestParam(value="shangji",required=false)String shangji,
	  @RequestParam(value="type")String type,
	  @RequestParam(value="money")String money,
	  @RequestParam(value="overTime")String overTime,
	  @RequestParam(value="zfb")String zfb,
	  @RequestParam(value="zfbname")String zfbname,
	  @RequestParam(value="password")String password,
	  HttpServletRequest request,
	  ModelMap map
	  ){
		map.clear();
		TerPointEntity entity = this.getTerPointEntityDAO().get(id);
		try {
			entity.setName(name);
			entity.setPhone(phone);
			entity.setStatus(Integer.valueOf(state));
			entity.setProvince(sheng);
			entity.setCity(shi);
			entity.setZfb(zfb);
			entity.setZfbname(zfbname);
			entity.setType(Integer.valueOf(type));
//			MenuEntity me = this.getMenuEntityDAO().get("8ab3bf6e62fc05670162fc5b688c0d8e");
//			UserMenuEntity ume1 = this.getUserMenuEntityDAO().findUnique(HDaoUtils.eq("menu", me).andEq("user", entity.getUser().getId()).toCondition());
//		    if(jibie!=null&&!jibie.equals("0")){
//			    entity.setPartner(1);
//			    if(ume1==null){
//			    	  UserMenuEntity ume = new UserMenuEntity();
//					  ume.setMenu(me);
//					  ume.setUser(entity.getUser().getId());
//					  this.getUserMenuEntityDAO().create(ume);
//			    }
//		    }else{
//		    	if(ume1!=null){
//		    		this.getUserMenuEntityDAO().remove(ume1);
//		    	}
//		    	entity.setPartner(null);
//		    }
		    if(shangji!=null&&!shangji.equals("1")){
			    entity.setHigher(shangji);
		    }else{
		    	UserEntity user1 = (UserEntity) request.getSession().getAttribute("loginUser");
				TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user1).toCondition());
			    if(ter==null){
			    	entity.setHigher(null);
			    }
		    }
			entity.setMoney(Float.valueOf(money));
			entity.setOverTime(DateUtil2.parseDateTime(overTime));
			entity.getUser().setPassword(password);
			this.getUserEntityDAO().update(entity.getUser());
			this.getTerPointEntityDAO().update(entity);
			map.put("flag", true);
		    map.put("msg","修改成功");
		} catch (Exception e) {
			// TODO: handle exception
			map.put("flag", false);
		    map.put("msg","修改失败");
		}
			return map;
	}
	/**
	 * 删除代理商信息
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> del(@PathVariable(value="id") String id,ModelMap map){
		try {
			TerPointEntity ter=this.getTerPointEntityDAO().get(id);
			List<ActivityEntity> list = this.getActivityEntityDAO().list(HDaoUtils.eq("terpoint", ter).toCondition());
				if (list!=null&&list.size()>0) {
					map.put("msg", "代理商存在下级商家，无法删除！");
					map.put("flag", false);
					return map;
				}
				if(ter.getMoney()>0.0f){
					map.put("msg", "代理商存在可用余额，无法删除！");
					map.put("flag", false);
					return map;
				}
			UserEntity user=ter.getUser();
			this.getTerPointEntityDAO().remove(ter);
			this.getUserEntityDAO().remove(user);
			map.put("msg", "删除成功！");
			map.put("flag", true);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace(); // 打印异常信息
			map.put("msg", "删除失败！");
			map.put("flag", false);
		}
		return map;
	}
	/**
	 * 去到代理商余额管理
	 */
	@RequestMapping(value="money",method=RequestMethod.GET)
	public String money(@RequestParam(value="id") String id,
									ModelMap map
			){
		TerPointEntity entity = this.getTerPointEntityDAO().get(id);
		map.put("terpoint", entity);

		return "manager/terpoint_money";
												
		
			}
	/**
	 * 去到代理商余额充值
	 */
	@RequestMapping(value="changeMoney",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> changeMoney(
			@RequestParam(value="id") String id,
			@RequestParam(value="pay") String pay,
			HttpServletRequest request,ModelMap map
			){
		try {
			UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
			TerPointEntity entity = this.getTerPointEntityDAO().get(id);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String addTime=sdf.format(new Date());
			entity.setMoney(entity.getMoney()+Float.parseFloat(pay));
			this.getTerPointEntityDAO().update(entity);
			map.put("flag", true);
			map.put("msg", "充值成功");
		} catch (Exception e) {
			// TODO: handle exception
			map.put("flag", false);
			map.put("msg", "充值失败");
		}
		
		return map;
												
		
			}

	/**
	 * 代理商绑定红包码
	 */
	@RequestMapping(value="binding",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> binding(
		@RequestParam(value="id") String id,		
		@RequestParam(value="start") String start,
		@RequestParam(value="end") String end,HttpServletRequest request,ModelMap map){

		if(start.length()<12||end.length()<12){
			map.put("flag", false);
		    map.put("msg","输入的红包码位数不正确");
			return map;
		}
		String start1=start.substring(start.length()-7, start.length());
		String end1=end.substring(end.length()-7,end.length());
		//类别CODE
		String code=start.substring(0, start.length()-7);
		String code2=end.substring(0, end.length()-7);
		if(!code.equals(code2)){
			map.put("flag", false);
		    map.put("msg","开始段和结束段非同一段位！");
			return map;
		}
		TerPointEntity terPointEntity = this.getTerPointEntityDAO().get(id);
		String sql1 = "UPDATE inv_redpacket SET _terpoint_redpacket = ? WHERE prefix = ? AND  suffix BETWEEN ? AND ?";
		int num = jdbcTemplate.update(sql1,terPointEntity.getId(),code,start1,end1);
		int fail = Integer.parseInt(end1)-Integer.parseInt(start1)+1-num;
		map.put("flag", true);
		map.put("num", num);
		map.put("fail", fail);
	    map.put("msg","设置成功:"+num+"个二维码,失败:"+fail+"个二维码");
		return map;
	}
/**
 * 去到代理商电子二维码是否开启
 */
@RequestMapping(value="boolean",method=RequestMethod.GET)
@ResponseBody
public Map<String, Object> kaiqi(
		@RequestParam(value="boolean") boolean isConfirm,
		@RequestParam(value="id") String id,
								ModelMap map
		){
	TerPointEntity terPointEntity = this.getTerPointEntityDAO().get(id);
	try {
		if(isConfirm){
			terPointEntity.setIsBoolean(false);
			map.put("flag", true);
		    map.put("msg","关闭成功");
		}else{
		
			terPointEntity.setIsBoolean(true);
			map.put("flag", true);
		    map.put("msg","开启成功");
		}
		this.getTerPointEntityDAO().update(terPointEntity);
		
	} catch (Exception e) {
		// TODO: handle exception
		map.put("flag", false);
	    map.put("msg","开启失败");
	}
	return map;
											
	
		}
/**
 * 修改代理商可以添加商家数量
 */
@RequestMapping(method=RequestMethod.PUT)
@ResponseBody
public Map<String, Object> activityNum(
		@RequestParam(value="activityNum") String activityNum,
		@RequestParam(value="id") String id,
								ModelMap map
		){
	int	activitynum=Integer.parseInt(activityNum);
	TerPointEntity ter = this.getTerPointEntityDAO().get(id);
	int num=this.getActivityEntityDAO().count(HDaoUtils.eq("terpoint", ter).andEq("type", 1).toCondition());
	if(activitynum<num){
		map.put("flag", false);
		map.put("msg","此代理已经绑定了"+num+"个正式商家，您不能设置比更小的数量!");
		return map;
	}else{
		ter.setActivityNum(activitynum);
		this.getTerPointEntityDAO().update(ter);
		map.put("flag", true);
		map.put("msg","修改成功");
	}
	return map;
		}

/**
/**
 * 
 * 购买红包
 * 
 * 
 */
@RequestMapping(value="buy",method=RequestMethod.GET)
@ResponseBody
public Map<String, Object> buy(
	@RequestParam(value="redpacketNum") String redpacketNum,HttpServletRequest request,ModelMap map){
	int num =Integer.parseInt(redpacketNum);
	List<WechartConfigEntity> wechartList=this.getWechartConfigEntityDAO().listAll();
	WechartConfigEntity wce=null;
	if(wechartList!=null&&wechartList.size()>0){
		 wce=wechartList.get(0);
	}
	float money=wce.getRedpacketMoney();
	try {
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		if(num*money>ter.getMoney()-ter.getMoneyUse()){
			map.put("flag",false);
			map.put("msg","购买失败，购买红包的金额超过账户可用余额，请充值！");
			return map;	 
		}else{
		}
		ter.setMoney(ter.getMoney()-num*money);
		this.getTerPointEntityDAO().update(ter);
		map.put("flag",true);
		map.put("msg","购买成功");
	} catch (Exception e) {
		// TODO: handle exception
		map.put("flag",false);
		map.put("msg","购买失败");
	}
		return map;
}

	/**
	 * 代理个人资料展示
	 */
	@RequestMapping(value="details",method=RequestMethod.GET)
	public String person(HttpServletRequest request,ModelMap map){
		UserEntity user =(UserEntity)request.getSession().getAttribute("loginUser");
		TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		map.put("terpoint", ter);
		return "manager/terpoint_details";
	}
	
	/**
	 * 代理修改个人信息
	 */
	@RequestMapping(value="details",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> details(
			@RequestParam(value="id")String id,
			@RequestParam(value="name")String name,
			@RequestParam(value="phone")String phone,
			@RequestParam(value="zfb")String zfb,
			@RequestParam(value="zfbname")String zfbname,
			HttpServletRequest request,ModelMap map){
		TerPointEntity ter=this.getTerPointEntityDAO().get(id);
		ter.setName(name);
		ter.setPhone(phone);
		ter.setZfb(zfb);
		ter.setZfbname(zfbname);
		this.getTerPointEntityDAO().update(ter);
		map.put("flag", true);
	    map.put("msg","修改成功");
		return map;
	}
	
	/**
	 * 修改手续费
	 */
	/**
	 * 去修改代理商可添加商家数量
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/fee",method=RequestMethod.GET)
	public String fee(@RequestParam(value="id")String terId,
							ModelMap map){
		TerPointEntity entity = this.getTerPointEntityDAO().get(terId);
		map.put("terpoint", entity);
	
		return "manager/terpoint_fee";
	}
	/**
	 * 修改手续费
	 */
	@RequestMapping(value="upfee",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> upfee(
			@RequestParam(value="id") String id,
			@RequestParam(value="ptFee") Integer ptFee,
			@RequestParam(value="terFee") Integer terFee,
			ModelMap map){
		TerPointEntity ter = this.getTerPointEntityDAO().get(id);
		ter.setPtFee(ptFee);
		ter.setTerFee(terFee);
		this.getTerPointEntityDAO().update(ter);
		List<ActivityEntity> alist = this.getActivityEntityDAO().list(HDaoUtils.eq("terpoint", ter).toCondition());
		for (ActivityEntity activityEntity : alist) {
			if(ter.getTerFee()!=null&&ter.getPtFee()!=null){
				if(activityEntity.getTerFee()==null&&activityEntity.getPtFee()==null){
					activityEntity.setTerFee(activityEntity.getTerpoint().getTerFee());
					activityEntity.setPtFee(activityEntity.getTerpoint().getPtFee());
					this.getActivityEntityDAO().update(activityEntity);
				}
			}
		}
		map.put("flag", true);
	    map.put("msg","修改成功");
		return map;
		}
}
