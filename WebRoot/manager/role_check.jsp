<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="cp" value="${pageContenxt.request.contextPath }"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:set var="cp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>选择角色</title>
		<link rel="shortcut icon" href="favicon.ico">
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
		<link href="css/font-awesome.min93e3.css" rel="stylesheet">
		<link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
		<link href="css/animate.min.css" rel="stylesheet">
		<link href="css/style.min1fc6.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
		<link rel="stylesheet" href="${cp }/manager/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${cp }/manager/js/jquery.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery1.9.1.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery.ztree.core-3.5.js"></script>
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
	    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
	    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
	    <link href="css/animate.min.css" rel="stylesheet">
	    <link href="css/style.min1fc6.css" rel="stylesheet">
		<link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
		<script src="js/layer/layer.js"></script>
	</head>
	<body class="gray-bg">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content" style="padding: 3px 17px 0px;">
							<div class="row border-bottom white-bg dashboard-header">
								<div class="col-sm-8" style="width: 100%; border: 1px #CCCCCC solid;">
					                <div class="ibox float-e-margins">
					                    <div class="ibox-content mailbox-content">
					                        <div class="file-manager">
					                            <a class="btn btn-block btn-primary compose-mail" href="javascript:void(0)">选择角色</a>
					                            <div class="space-25"></div>
					                            <ul class="folder-list m-b-md" style="padding: 0" id="roleList">
					                            	<c:forEach var="item" items="${list}">
						                                <li data_id="${item.id}" style="height:30px;">
					                                    	<input type="checkbox" style="float: left;" name="checkbox" value="${item.id}">
					                                    	<a href="javascript:void(0)" style="float: left;margin-left: 30px;"> 
						                                    	${item.roleName }
						                                    </a>
						                                </li>
					                            	</c:forEach>
					                            </ul>
					                            <div class="clearfix"></div>
					                        </div>
					                    </div>
											<button onclick="bind()">确定选择</button>
					                </div>
									<div class="ibox-content" style="padding: 3px 17px 0px;">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			function bind(){
				var value=[];
				$('input[name="checkbox"]:checked').each(function(){ 
					value.push($(this).val());
				});
				if(value.length>0){
					$.ajax({
						url:"role/setBind?userId=${userId}",
						type:"post",
						data:{'roleId[]':value},
						dataType:"json",
						success:function(res){
							if(res.flag){
								layer.msg('设置成功');
							}else{
								layer.msg(res.msg);
							}
						}
					});
				}else{
					layer.msg("请选择角色");
				}
			}
			$(function(){
				//页面加载完成后回选已经绑定的角色
				$.ajax({
					url:"role/getBind?userId=${userId}",
					type:"get",
					dataType:"json",
					success:function(res){
						for(var i=0;i<res.length;i++){
							$("#roleList li[data_id="+res[i].id+"]").find("input").attr("checked", true);
						}
					}
				});
				
			});
		</script>
	</body>
</html>
