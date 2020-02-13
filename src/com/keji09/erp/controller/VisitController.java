package com.keji09.erp.controller;


import com.keji09.erp.bean.ConsoleBean;
import com.keji09.erp.model.ActivityEntity;
import com.keji09.erp.model.TerPointEntity;
import com.keji09.erp.model.role.UserEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.JdbcUtil;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HDaoUtils;
import org.hibernate.criterion.Criterion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigInteger;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="visit")
public class VisitController extends XDAOSupport {
	
	@Autowired
	JdbcTemplate jt;
	/**
	 * 初始化后台
	 */
	@RequestMapping(method=RequestMethod.GET)
	public String init(HttpServletRequest request,ModelMap mm){
		Object obj=request.getSession().getAttribute("loginUser");
		if(obj==null){
			return "login";
		}
		return "manager/index";
	}
	/**
	 * 平台管理员
	 */
	@RequestMapping(value="manager",method=RequestMethod.GET)
	public String initManager(HttpServletRequest request,ModelMap mm){
		UserEntity user=(UserEntity)request.getSession().getAttribute("loginUser");
		ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		if(act!=null){
			request.getSession().setAttribute("activity", act);
			mm.put("activity",act);
			Date date = new Date();
			long last = 0;
			if(act.getOverTime()!=null){
				last = act.getOverTime().getTime()- date.getTime();
			}
			request.getSession().setAttribute("lastTime", last);
			//新消息数量
			Exp<Criterion> exp = null;
			exp = HDaoUtils.eq("user.id", user.getId());
			Integer count = this.getNoticeUserEntityDAO().count(exp.toCondition());
			mm.put("newNotice", count);
		}
		return "manager/index";
	}
	
	/**
	 * 控制台
	 * */
	@RequestMapping(value="console",method=RequestMethod.GET)
	public String console(HttpServletRequest request,ModelMap mm){
		UserEntity user=(UserEntity)request.getSession().getAttribute("loginUser");
		if(user == null){
			return "login";
		}
		//正式商家数量
		Integer zhengshi=0;
		//试用商家数量
		Integer shiyong=0;
		TerPointEntity ter = this.getTerPointEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		ActivityEntity act = this.getActivityEntityDAO().findUnique(HDaoUtils.eq("user", user).toCondition());
		if(ter!=null){
			request.getSession().setAttribute("terpoint", ter);
			mm.put("ter",ter);
		}
		if(act!=null){
			request.getSession().setAttribute("activity", act);
			mm.put("activity",act);
		}
		Float totalMoney=0.0f;
		if(ter!=null){
			zhengshi=this.getActivityEntityDAO().count(HDaoUtils.eq("terpoint", ter).andEq("type", 1).toCondition());
			shiyong=this.getActivityEntityDAO().count(HDaoUtils.eq("terpoint", ter).andEq("type", 0).toCondition());
			mm.put("money", ter.getMoney());
		}
		if(act!=null){
			Float xs=0.00f;
			Float fee=0.0f;
			//商家结算的手续费
			//结算销售
			
			//结束
			mm.put("jssxf", fee);
			mm.put("xs", xs);
			
			//有效点击量
			String sql2="select count(t.`_openid`) from `inv_recode` t where t.`_activity`='"+act.getId()+"'";
			final String hql2=sql2;
			Object[] ob2= new Object[]{};
			Object a2=JdbcUtil.getUnique(hql2,ob2,getTemplateFactory());
			if(a2==null){
				a2=0;
			}
			int preIp=Integer.valueOf(a2.toString());
			//ip总访问量
			mm.put("preIp", preIp);
			mm.put("baoguang", act.getBaoguang());
		}
		int terNum=this.getTerPointEntityDAO().count();
		ConsoleBean bean = new ConsoleBean();
		//拓客红包admin统计数据
		Integer members=this.getMemberEntityDAO().count();
		Float axs=0.00f;
		Float ayongjin=0.00f;
		mm.put("members", members);
		mm.put("axs", axs);
		mm.put("ayongjin", ayongjin);
		mm.put("terNum", terNum);
		mm.put("zhengshi", zhengshi);
		mm.put("shiyong", shiyong);
		mm.put("totalMoney", totalMoney);
		mm.put("bean", bean);
		//活动书签
		ActivityEntity activity = this.getActivityEntityDAO().findUnique("user", user);
		return "manager/console";
	}
	
	/**
	 * 查询某一时间段的活动统计数量
	 * @throws ParseException 
	 */
	@RequestMapping(value="between",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> between(String id,String nian,String yue,ModelMap map) throws ParseException{
		ActivityEntity act = this.getActivityEntityDAO().get(id);
		List<String> xzhou = new ArrayList<String>();
		List<BigInteger> lingJiang = new ArrayList<BigInteger>();
		List<BigInteger> dianJi = new ArrayList<BigInteger>();
		int[] monthDay = {31,28,31,30,31,30,31,31,30,31,30,31};
		Integer year = Integer.parseInt(nian);
		if(yue!=null&&!yue.equals("")){
			Integer month = Integer.parseInt(yue.substring(0, yue.length()-1));
			String mo = month>=10?month+"":"0"+month;
			for(int i=1;i<=monthDay[month-1];i++){
				xzhou.add(i+"号");
				String da = i>=10?i+"":"0"+i;
				String sql3="select count(`_openid`) cou from `inv_recode` t where t.`_activity`='"+act.getId()+"' AND MONTH(_add_time)="+mo+" and YEAR(_add_time)="+year+" and DAY(_add_time)="+da;
				Object[] ob3= new Object[]{};
				BigInteger a2=JdbcUtil.getUnique(sql3,ob3,getTemplateFactory());
				dianJi.add(a2);
				String sql4="select count(*) cou from `inv_red_member` t where t.`_activity_id`='"+act.getId()+"' AND MONTH(_add_time)="+mo+" and YEAR(_add_time)="+year+" AND _status = '2' and DAY(_add_time)="+da;
				BigInteger a3=JdbcUtil.getUnique(sql4,ob3,getTemplateFactory());
				lingJiang.add(a3);
			}
		}else{
			for(int i=1;i<=12;i++){
				xzhou.add(i+"月");
				String mo = i>=10?i+"":"0"+i;
				String sql3="select count(`_openid`) cou from `inv_recode` t where t.`_activity`='"+act.getId()+"' AND MONTH(_add_time)="+mo+" and YEAR(_add_time)="+year;
				Object[] ob3= new Object[]{};
				BigInteger a2=JdbcUtil.getUnique(sql3,ob3,getTemplateFactory());
				dianJi.add(a2);
				String sql4="select count(*) cou from `inv_red_member` t where t.`_activity_id`='"+act.getId()+"' AND MONTH(_add_time)="+mo+" and YEAR(_add_time)="+year+" AND _status = '2'";
				BigInteger a3=JdbcUtil.getUnique(sql4,ob3,getTemplateFactory());
				lingJiang.add(a3);
			}
		}
		map.put("xzhou", xzhou);
		map.put("dianJi", dianJi);
		map.put("lingJiang", lingJiang);
		map.put("flag", false);
		return map;
	}
	
	/**
	 * 查询某一时间段领红包总钱数
	 * @throws ParseException 
	 */
	@RequestMapping(value="money",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> money(String id,String nian,String yue,ModelMap map) throws ParseException{
		List<String> xzhou = new ArrayList<String>();
		List<Object> dianJi = new ArrayList<Object>();
		List<Object> yuer = new ArrayList<Object>();
		List<Object> zhijie = new ArrayList<Object>();
		int[] monthDay = {31,28,31,30,31,30,31,31,30,31,30,31};
		Integer year = Integer.parseInt(nian);
		if(yue!=null&&!yue.equals("")){
			Integer month = Integer.parseInt(yue.substring(0, yue.length()-1));
			String mo = month>=10?month+"":"0"+month;
			for(int i=1;i<=monthDay[month-1];i++){
				xzhou.add(i+"号");
				String da = i>=10?i+"":"0"+i;
				List<String> list = getDayTime(year.toString(),mo,da);
				String sql3="select sum(t.`money`) cou from `inv_redpacket` t where _type=0 and _status=2 and  _over_time between '"+list.get(0)+"' and '"+list.get(1)+"'";
				String sql4 ="select sum(t.`_money`) cou from `wx_withdrawalrecord` t where _status=1 and _type=0 and _startDate between '"+list.get(0)+"' and '"+list.get(1)+"'";
				String sql5 ="select sum(t.`_money`) cou from `wx_withdrawalrecord` t where _status=1 and _type = 1 and _startDate between '"+list.get(0)+"' and '"+list.get(1)+"'";
				Object[] ob3= new Object[]{};
				Object a2=JdbcUtil.getUnique(sql3,ob3,getTemplateFactory());
				Object a3 = JdbcUtil.getUnique(sql4,ob3,getTemplateFactory());
				Object a4 = JdbcUtil.getUnique(sql5,ob3,getTemplateFactory());
				DecimalFormat df = new DecimalFormat(".##");
				if(a2!=null){
					a2 = df.format(a2);
				}
				dianJi.add(a2);
				if(a3!=null){
					a3 = df.format(a3);
				}
				yuer.add(a3);
				if(a4!=null){
					a4 = df.format(a4);
				}
				zhijie.add(a4);
			}
		}else{
			for(int i=1;i<=12;i++){
				xzhou.add(i+"月");
				String mo = i>=10?i+"":"0"+i;
				String lastDay = monthDay[i-1]+"";
				List<String> first = getDayTime(nian,mo,"1");
				List<String> last = getDayTime(nian,mo,lastDay);
				String sql3="select sum(t.`money`) cou from `inv_redpacket` t where _type=0 and _status=2 and _over_time between '"+first.get(0)+"' and '"+last.get(1)+"'";
				String sql4="select sum(t.`_money`) cou from `wx_withdrawalrecord` t where  _status=1 and _type=0 and _startDate between '"+first.get(0)+"' and '"+last.get(1)+"'";
				String sql5="select sum(t.`_money`) cou from `wx_withdrawalrecord` t where  _status=1 and _type=1 and _startDate between '"+first.get(0)+"' and '"+last.get(1)+"'";
				Object[] ob3= new Object[]{};
				Object a2=JdbcUtil.getUnique(sql3,ob3,getTemplateFactory());
				Object a3=JdbcUtil.getUnique(sql4,ob3,getTemplateFactory());
				Object a4=JdbcUtil.getUnique(sql5,ob3,getTemplateFactory());
				DecimalFormat df = new DecimalFormat(".##");
				if(a2!=null){
					a2 = df.format(a2);
				}
				dianJi.add(a2);
				if(a3!=null){
					a3 = df.format(a3);
				}
				yuer.add(a3);
				if(a4!=null){
					a4 = df.format(a4);
				}
				zhijie.add(a4);
			}
		}
		map.put("xzhou", xzhou);
		map.put("dianJi", dianJi);
		map.put("yuer",yuer);
		map.put("zhijie", zhijie);
		map.put("flag", true);
		return map;
	}
	
	/**
	 * 获取某一天的开始时间和结束时间 
	 * @return
	 * @throws ParseException 
	 */
	public List<String> getDayTime(String nian,String yue,String ri) throws ParseException{
		String start = nian+"-"+yue+"-"+ri+" 00:00:00";
		String end = nian+"-"+yue+"-"+ri+" 23:59:59";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String kaishi = sdf.format(sdf.parse(start));
		String jieshu = sdf.format(sdf.parse(end));
		List<String> list = new ArrayList<String>();
		list.add(kaishi);
		list.add(jieshu);
		return list;
	}
	
	/**
	 *查询某一时段的所有商家发放红包金额 
	 * @throws ParseException
	 */
	@RequestMapping(value="faFang",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> faFangmoney(@RequestParam(value="start")String start,
										  @RequestParam(value="end")String end,
										  @RequestParam(value="pageIndex", defaultValue="1")Integer pageIndex,
										  @RequestParam(value="pageSize",defaultValue="20")Integer pageSize, ModelMap map) throws ParseException{
		map.put("fa", "");
		return map;
	}
	
	/**
	 *大屏统计
	 */
	@RequestMapping(value="shuaxin",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> shuaXin(ModelMap map){
		//代理总数
		int dailiCount = this.getTerPointEntityDAO().count();
		//商家总数
		int shangjiaCount = this.getActivityEntityDAO().count();
		//用户总数
		int yonghuCount = this.getMemberEntityDAO().count();
		//商家余额
		Object yue = this.getActivityEntityDAO().sum("money", HDaoUtils.eq("status", 0).toCondition());
		//用户总余额
		Object yonghuYue = this.getMemberEntityDAO().sum("balance",HDaoUtils.eq("status", 1).toCondition());
		List<Object> list = new ArrayList<Object>();
		DecimalFormat decimalFormat = new DecimalFormat("#");
		list.add(decimalFormat.format(dailiCount));
		list.add(decimalFormat.format(shangjiaCount));
		list.add(decimalFormat.format(yonghuCount));
		list.add(decimalFormat.format(yue));
		list.add(decimalFormat.format(yonghuYue));
		map.put("shuaxin", list);
		return map;
	}
}
