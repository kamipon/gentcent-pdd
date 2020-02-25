package com.keji09.erp.model.support;

import com.keji09.erp.model.*;
import com.keji09.erp.model.role.*;
import com.mezingr.dao.HibernateDAO;
import com.mezingr.dao.HibernateDAOFactory;
import com.mezingr.hibernate.HibernateTemplateFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

public class XDAOSupport {
	
	private HibernateDAOFactory hibernateDAOFactory = null;
	private HibernateTemplateFactory templateFactory = null;
	private HibernateDAO<OperationLogEntity> logDao = null;
	
	public HibernateTemplateFactory getTemplateFactory() {
		return templateFactory;
	}
	
	@Autowired
	public void setTemplateFactory(HibernateTemplateFactory templateFactory) {
		this.templateFactory = templateFactory;
	}
	
	@Autowired
	public void setFactory(HibernateDAOFactory hibernateDAOFactory) {
		this.hibernateDAOFactory = hibernateDAOFactory;
	}
	
	public HibernateDAO<OperationLogEntity> getOperationLogEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(OperationLogEntity.class);
	}
	
	//pdd
	public HibernateDAO<TokenEntity> getTokenEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(TokenEntity.class);
	}
	public HibernateDAO<PddPidEntity> getPddPidEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(PddPidEntity.class);
	}
	public HibernateDAO<CouponEntity> getCouponEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(CouponEntity.class);
	}

	//角色相关
	public HibernateDAO<UserEntity> getUserEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(UserEntity.class);
	}
	//角色相关
	public HibernateDAO<OrderEntity> getOrderEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(OrderEntity.class);
	}

	public HibernateDAO<SmsEntity> getSmsEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(SmsEntity.class);
	}
	public HibernateDAO<RoleEntity> getRoleEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(RoleEntity.class);
	}
	
	public HibernateDAO<MenuEntity> getMenuEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(MenuEntity.class);
	}
	
	public HibernateDAO<UserRoleEntity> getUserRoleEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(UserRoleEntity.class);
	}
	
	public HibernateDAO<RoleMenuEntity> getRoleMenuEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(RoleMenuEntity.class);
	}
	
	public HibernateDAO<UserMenuEntity> getUserMenuEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(UserMenuEntity.class);
	}
	
	//业务实体相关
	public HibernateDAO<ActivityEntity> getActivityEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(ActivityEntity.class);
	}
	
	public HibernateDAO<MemberEntity> getMemberEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(MemberEntity.class);
	}
	
	public HibernateDAO<OperationLogEntity> getOperationLogEntityDao() {
		return this.hibernateDAOFactory.getHibernateDAO(OperationLogEntity.class);
	}
	
	public HibernateDAO<TerPointEntity> getTerPointEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(TerPointEntity.class);
	}
	
	
	public HibernateDAO<DictionaryEntity> getDictionaryEntityDAO() {
		return this.hibernateDAOFactory.getHibernateDAO(DictionaryEntity.class);
	}
	
	/**
	 * 可能会有线程问题，如果有问题加上synchronized
	 */
	public void log(String userName, String content) {
		if (logDao == null) {
			logDao = getOperationLogEntityDAO();
		}
		OperationLogEntity log = new OperationLogEntity();
		log.setContent(content);
		log.setUserName(userName);
		log.setAddTime(new Date());
		logDao.create(log);
	}
	
	/**
	 * 用于记录登录和给红包设置金额
	 *
	 * @param userName 账号
	 * @param content  操作内容
	 * @param openId   微信用户openId
	 * @param nick     微信用户昵称
	 */
	public void log(String userName, String content, String openId, String nick) {
		if (logDao == null) {
			logDao = getOperationLogEntityDAO();
		}
		OperationLogEntity log = new OperationLogEntity();
		log.setContent(content);
		log.setUserName(userName);
		log.setOpenId(openId);
		log.setNick(nick);
		logDao.create(log);
	}
}
