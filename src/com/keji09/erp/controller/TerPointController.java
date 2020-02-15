package com.keji09.erp.controller;


import com.keji09.model.support.XDAOSupport;
import com.keji09.erp.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 代理商实体控制层
 *
 * @author Administrator
 */
@Controller
@RequestMapping(value = "/terPoint")
public class TerPointController extends XDAOSupport {
	
	@Autowired
	PermissionService permissionService;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
}
