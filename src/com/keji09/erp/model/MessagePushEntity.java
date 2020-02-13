package com.keji09.erp.model;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.annotations.GenericGenerator;

import com.keji09.erp.model.role.UserEntity;

/**
 * 消息推送实体
 */
@Entity
@Table(name = "inv_message_push")
public class MessagePushEntity implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
/***************************************** 主键id*****************************************/
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name="id",length = 32)
	private String id;
/*****************************************具体字段*****************************************/
	
	/**
	 * 推送时间
	 */
	@Column(name="_addTime")
	private Date addTime = new Date();
	
	/**
	 * 代理id
	 */
	@Column(name="_terpoint")
	private String terpoint;
	
	/**
	 * 收到此条推送的人数
	 */
	@Column(name="_count")
	private Integer count;
	
	/**
	 * 推送所用的模板
	 */
	@Column(name="_xcxTemplate")
	private String xcxTemplate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public String getTerpoint() {
		return terpoint;
	}

	public void setTerpoint(String terpoint) {
		this.terpoint = terpoint;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getXcxTemplate() {
		return xcxTemplate;
	}

	public void setXcxTemplate(String xcxTemplate) {
		this.xcxTemplate = xcxTemplate;
	}

	
}