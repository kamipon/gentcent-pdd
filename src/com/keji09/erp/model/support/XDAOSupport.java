package com.keji09.erp.model.support;

import com.keji09.erp.model.*;
import com.keji09.erp.model.role.*;
import com.mezingr.dao.HibernateDAO;
import com.mezingr.dao.HibernateDAOFactory;
import com.mezingr.hibernate.HibernateTemplateFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

public class XDAOSupport {

	private HibernateDAOFactory hibernateDAOFactory=null;
	private HibernateTemplateFactory templateFactory=null;
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
	public HibernateDAO<OperationLogEntity> getOperationLogEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(OperationLogEntity.class);
	}
	
	//角色相关
	public HibernateDAO<UserEntity> getUserEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(UserEntity.class);
	}
	public HibernateDAO<RoleEntity> getRoleEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(RoleEntity.class);
	}
	public HibernateDAO<MenuEntity> getMenuEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(MenuEntity.class);
	}
	public HibernateDAO<UserRoleEntity> getUserRoleEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(UserRoleEntity.class);
	}
	public HibernateDAO<RoleMenuEntity> getRoleMenuEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(RoleMenuEntity.class);
	}
	public HibernateDAO<UserMenuEntity> getUserMenuEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(UserMenuEntity.class);
	}
	//业务实体相关
	public HibernateDAO<WxModelSCEntity> getWxModelSCEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(WxModelSCEntity.class);
	}
	public HibernateDAO<NoticeEntity> getNoticeEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(NoticeEntity.class);
	}
	public HibernateDAO<NoticeUserEntity> getNoticeUserEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(NoticeUserEntity.class);
	}
	public HibernateDAO<ActivityEntity> getActivityEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(ActivityEntity.class);
	}
	public HibernateDAO<MemberEntity> getMemberEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(MemberEntity.class);
	}
	public HibernateDAO<OperationLogEntity> getOperationLogEntityDao(){
		return this.hibernateDAOFactory.getHibernateDAO(OperationLogEntity.class);
	}
	public HibernateDAO<TerPointEntity> getTerPointEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(TerPointEntity.class);
	}
	public HibernateDAO<WechartConfigEntity> getWechartConfigEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(WechartConfigEntity.class);
	}
	public HibernateDAO<WechartActivityConfigEntity> getWechartActivityConfigEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(WechartActivityConfigEntity.class);
	}
	public HibernateDAO<WechartComponentEntity> getWechartComponentEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(WechartComponentEntity.class);
	}
	public HibernateDAO<WxModelSMSEntity> getWxModelSMSEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(WxModelSMSEntity.class);
	}
	public HibernateDAO<WxModelSMSBindingEntity> getWxModelSMSBindingEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(WxModelSMSBindingEntity.class);
	}
	public HibernateDAO<FormIdEntity> getFormIdEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(FormIdEntity.class);
	}
	public HibernateDAO<MessagePushEntity> getMessagePushEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(MessagePushEntity.class);
	}
	public HibernateDAO<DomainEntity> getDomainEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(DomainEntity.class);
	}
	public HibernateDAO<ManagerMsgEntity> getManagerMsgEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(ManagerMsgEntity.class);
	}
	public HibernateDAO<DictionaryEntity> getDictionaryEntityDAO(){
		return this.hibernateDAOFactory.getHibernateDAO(DictionaryEntity.class);
	}
	/**
	 * 获取微信配置
	 * @return
	 */
	public WechartConfigEntity getWechatConfig(){
		List<WechartConfigEntity> list=this.getWechartConfigEntityDAO().listAll();
		WechartConfigEntity wechart=null;
		if(list!=null&&list.size()>0){
			wechart=list.get(0);
		}
		return wechart;
	}
	
	/**
	 * 可能会有线程问题，如果有问题加上synchronized
	 */
	public void log(String userName,String content){
		if(logDao == null) {
			logDao = getOperationLogEntityDAO();
		}
		OperationLogEntity log =new OperationLogEntity();
		log.setContent(content);
		log.setUserName(userName);
		log.setAddTime(new Date());
		logDao.create(log);
	}
	/**
	 * 用于记录登录和给红包设置金额
	 * @param userName 	账号
	 * @param content	操作内容
	 * @param openId	微信用户openId
	 * @param nick		微信用户昵称
	 */
	public void log(String userName,String content,String openId,String nick){
		if(logDao == null) {
			logDao = getOperationLogEntityDAO();
		}
		OperationLogEntity log =new OperationLogEntity();
		log.setContent(content);
		log.setUserName(userName);
		log.setOpenId(openId);
		log.setNick(nick);
		logDao.create(log);
	}
}
