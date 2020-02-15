package com.keji09.model.role;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "sys_user_role")
public class UserRoleEntity implements Serializable {
	
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
	 * 角色id
	 */
	@ManyToOne
	@JoinColumn(name = "_role")
	private RoleEntity role;
	
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
	
	public RoleEntity getRole() {
		return role;
	}
	
	public void setRole(RoleEntity role) {
		this.role = role;
	}
	
}
