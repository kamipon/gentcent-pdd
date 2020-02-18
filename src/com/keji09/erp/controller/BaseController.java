package com.keji09.erp.controller;

import com.keji09.erp.bean.PageBean;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.CommonUtil;
import com.mezingr.dao.Exp;
import com.mezingr.dao.HibernateDAO;
import com.mezingr.dao.PaginationList;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.ui.ModelMap;

/**
 * 一些简单公用方法
 */
public abstract class BaseController extends XDAOSupport {
	
	protected abstract <T> HibernateDAO<T> getHibernateDAO();
	
	/**
	 * 根据参数查询排序，并将查询结果设置进入map，名称page
	 *
	 * @param page   翻页
	 * @param map    设置属性map
	 * @param exp    条件
	 * @param orders 排序
	 * @return 查询结果，PageBean
	 */
	protected PageBean queryPage(PageBean page, ModelMap map, Exp<Criterion> exp, Order... orders) {
		map.clear();
		//设置分页
		PaginationList<?> list = getHibernateDAO().list(exp.toCondition(), page.getPageIndex(), page.getPageSize(), orders);
		PageBean _page = getPageBean(list, page);
		map.put("page", _page);
		return _page;
	}
	
	/**
	 * 根据id查询，并将查询结果设置进入map，名称bean
	 *
	 * @return 查询结果，没查到没null
	 */
	protected Object queryById(String id, ModelMap map) {
		map.clear();
		Object obj = null;
		try {
			obj = getHibernateDAO().get(id);
			//设置值bean
			map.put("bean", obj);
			map.put("msg", "查询成功");
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "查询失败");
			map.put("flag", false);
		}
		return obj;
	}
	
	/**
	 * 新增
	 */
	protected void add(Object obj, ModelMap map) {
		map.clear();
		try {
			getHibernateDAO().create(obj);
			map.put("msg", "添加成功");
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "添加失败");
			map.put("flag", false);
		}
	}
	
	/**
	 * 修改
	 */
	protected void update(Object obj, ModelMap map) {
		map.clear();
		try {
			getHibernateDAO().update(obj);
			map.put("msg", "修改成功");
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "修改失败");
			map.put("flag", false);
		}
	}
	
	/**
	 * 删除
	 */
	protected void delete(String id, ModelMap map) {
		map.clear();
		try {
			getHibernateDAO().removeById(id);
			map.put("msg", "删除成功");
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "删除失败");
			map.put("flag", false);
		}
	}
	
	/**
	 * ids批量删除
	 */
	protected void deleteByIds(String ids, ModelMap map) {
		map.clear();
		if (StringUtils.isNotEmpty(ids)) {
			String[] arrIds = ids.split(",");
			
			for (int i = 0; i < arrIds.length; i++) {
				getHibernateDAO().removeById(arrIds[i]);
			}
			
			map.put("msg", "删除成功");
			map.put("flag", true);
		} else {
			map.put("msg", "删除失败,ids为空");
			map.put("flag", false);
		}
	}
	
	
	/**
	 * 根据结果设置查询翻页bean
	 */
	protected PageBean getPageBean(PaginationList<?> list, PageBean page) {
		if (list != null && list.getItems() != null) {
			page.setList(list.getItems());
			page.setTotal(list.getTotalCount());
			int totalPage = CommonUtil.getPageTotal(list.getTotalCount(), page.getPageSize());
			page.setTotalPage(totalPage);
		}
		return page;
	}
	
	
}