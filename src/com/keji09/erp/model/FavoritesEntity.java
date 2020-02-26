package com.keji09.erp.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 多多进宝 商品收藏
 */
@Entity
@Table(name = "pdd_favorites")
public class FavoritesEntity implements Serializable {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	/***************************************** 主键id*****************************************/
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	/*****************************************具体字段*****************************************/

	/**
	 */
	@Column(name = "_add_time")
	private Date addTime = new Date();
	/**
	 * 所属用户Id
	 */
	@Column(name = "_member_id")
	private String memberId;
	/**
	 * 商品id
	 */
	@Column(name = "_pid")
	private String pid;

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

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}
}