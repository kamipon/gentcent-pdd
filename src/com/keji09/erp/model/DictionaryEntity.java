package com.keji09.erp.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 字典实体
 */
@Entity
@Table(name = "erp_dictionary")
public class DictionaryEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name="id",length = 32)
	private String id;

	/**
	 * 字典key
	 */
	@Column(name="_key")
	private String key;

	/**
	 * 字典value
	 */
	@Column(name="_value")
	private String value;
	
	/**
	 * 字典名称
	 */
	@Column(name="_name")
	private String name;
	
	/**
	 * 字典排序
	 */
	@Column(name="_order")
	private Integer order;

	/**
	 * 字典功能描述
	 */
	@Column(name="_desc")
	private String desc;
	
	/**
	 * 扩展字段1
	 */
	@Column(name="_extra1")
	private String extra1;
	
	/**
	 * 扩展字段2
	 */
	@Column(name="_extra2")
	private String extra2;

	/**
	 * 添加时间
	 */
	@Column(name="_add_time")
	private Date addTime=new Date();

	
	
	public String getExtra1() {
		return extra1;
	}

	public void setExtra1(String extra1) {
		this.extra1 = extra1;
	}

	public String getExtra2() {
		return extra2;
	}

	public void setExtra2(String extra2) {
		this.extra2 = extra2;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
}
