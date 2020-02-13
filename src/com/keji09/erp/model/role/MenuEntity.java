package com.keji09.erp.model.role;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 权限菜单表
 */
@Entity
@Table(name = "sys_menu")
public class MenuEntity implements Serializable {
	private static final long serialVersionUID = -5561297154319058315L;
	public static String NAVIGATION_ORDER="order";
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * 菜单名称
	 */
	@Column(name="_name")
	private String name;
	
	/**
	 * 菜单编码
	 */
	@Column(name="_code")
	private String code;
	
	/**
	 * 菜单类型menu,event
	 */
	@Column(name="_type")
	private String type;
	
	/**
	 * 排序
	 */
	@Column(name="_order")
	private Integer order = 10;
	
	/**
	 * 父菜单
	 */
	@Column(name="_parent")
	private String parent;
	
	/**
	 * 是否显示
	 */
	@Column(name="_display")
	private Boolean display = false;
	
	/**
	 * 访问地址
	 */
	@Column(name="_url")
	private String url;
	
	/**
	 * 左css
	 */
	@Column(name="_left_css")
	private String leftCss;
	
	/**
	 * 右css
	 */
	@Column(name="_right_css")
	private String rightCss;
	
	/**
	 * 新增时间
	 */
	@Column(name="_add_time")
	private Date addTime=new Date();
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Boolean getDisplay() {
		return display;
	}

	public void setDisplay(Boolean display) {
		this.display = display;
	}

	public String getLeftCss() {
		return leftCss;
	}

	public void setLeftCss(String leftCss) {
		this.leftCss = leftCss;
	}

	public String getRightCss() {
		return rightCss;
	}

	public void setRightCss(String rightCss) {
		this.rightCss = rightCss;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
