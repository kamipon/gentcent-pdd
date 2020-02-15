package com.keji09.model;

import com.keji09.model.role.UserEntity;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 用户通知实体
 *
 * @author Administrator
 */
@Entity
@Table(name = "inv_notice_user")
public class NoticeUserEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	/***************************************** 主键id*****************************************/
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	/*****************************************具体字段*****************************************/
	/**
	 * 所属通知
	 */
	@ManyToOne
	@JoinColumn(name = "notice")
	private NoticeEntity notice;
	
	/**
	 * 所属用户
	 */
	@ManyToOne
	@JoinColumn(name = "user")
	private UserEntity user;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public NoticeEntity getNotice() {
		return notice;
	}
	
	public void setNotice(NoticeEntity notice) {
		this.notice = notice;
	}
	
	public UserEntity getUser() {
		return user;
	}
	
	public void setUser(UserEntity user) {
		this.user = user;
	}
	
	
}

