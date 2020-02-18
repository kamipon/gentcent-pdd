package com.keji09.erp.model.role;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "sys_user_menu")
public class UserMenuEntity implements Serializable {
	
	private static final long serialVersionUID = 3636048667116041805L;
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * 用户id
	 */
	@Column(name = "_user")
	private String user;
	
	/**
	 * 菜单编码
	 */
	@Column(name = "_code")
	private String code;
	
	/**
	 * 操作
	 */
	@ManyToOne
	@JoinColumn(name = "_menu")
	private MenuEntity menu;
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public MenuEntity getMenu() {
		return menu;
	}
	
	public void setMenu(MenuEntity menu) {
		this.menu = menu;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getUser() {
		return user;
	}
	
	public void setUser(String user) {
		this.user = user;
	}
	
}
