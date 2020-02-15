package com.keji09.model.role;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "sys_role_menu")
public class RoleMenuEntity implements Serializable {
	
	private static final long serialVersionUID = -3504534789465335329L;
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * 角色id
	 */
	@Column(name = "_role")
	private String role;
	
	/**
	 * 菜单id
	 */
	@Column(name = "_menu")
	private String menu;
	
	/**
	 * 菜单编码
	 */
	@Column(name = "_code")
	private String code;
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getRole() {
		return role;
	}
	
	public void setRole(String role) {
		this.role = role;
	}
	
	public String getMenu() {
		return menu;
	}
	
	public void setMenu(String menu) {
		this.menu = menu;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	
}
