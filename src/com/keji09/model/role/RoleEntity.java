package com.keji09.model.role;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;


/**
 * 用户角色实体
 */
@Entity
@Table(name = "sys_role")
public class RoleEntity implements Serializable {
	
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
	@GeneratedValue(generator = "uuidhex")
	@Column(name = "id", length = 32)
	private String id;
	
	/**
	 * 角色名称
	 */
	@Column(name = "r_name")
	private String roleName;
	
	/**
	 * 角色类型(system、custom),系统角色无法删除，自定义角色可以删除
	 */
	@Column(name = "_type")
	private String type = "system";
	
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getRoleName() {
		return roleName;
	}
	
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
}
