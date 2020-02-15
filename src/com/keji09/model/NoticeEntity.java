package com.keji09.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 通知实体
 *
 * @author Administrator
 */
@Entity
@Table(name = "inv_notice")
public class NoticeEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	/***************************************** 主键id*****************************************/
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	/*****************************************具体字段*****************************************/
	/**
	 * 标题
	 */
	@Column(name = "_title")
	private String title;
	
	/**
	 * 地址
	 */
	@Column(name = "_url")
	private String url;
	
	/**
	 * 创建时间
	 */
	@Column(name = "_addTime")
	private Date addTime = new Date();
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public Date getAddTime() {
		return addTime;
	}
	
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}

