<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>用户列表</h5>
                        <div class="ibox-tools">
                       		<span class="glyphicon glyphicon-plus"></span> 
                            <a class="J_menuItem" href="manager/user_add.jsp">用户添加</a>
                        </div>
                        <form name="form22" action="${pageContext.request.contextPath }/user/repairUserRole" method="post">
							<input style="margin-left: 25px;" type="submit" class="btn btn-sm btn-primary" value="补全角色"> 
						</form>
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/user" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text"  value="${username }" name="username" placeholder="根据用户名查询">
					                        	<input type="submit" class="btn btn-sm btn-primary" value="搜索"> 
											</label>
										</div>
									</div>
									<div class="col-sm-6">
										<div id="DataTables_Table_0_length" class="dataTables_filter"  >
											<label>每页
												<select class="form-control input-sm" aria-controls="DataTables_Table_0" name="pageSize" onchange="javascript:this.form.submit();">
													<c:if test="${pageSize!=null}">
														<option value="${pageSize }">${pageSize }</option>
													</c:if>
													<option value="10">10</option>
													<option value="25">25</option>
													<option value="50">50</option>
													<option value="100">100</option>
												</select> 条记录
											</label>
										</div>
									</div>
                 				  </form>
								</div>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead>
	                                <tr>
	                                	<th style="width: 5%">头像</th>
	                                    <th>用户名</th>
	                                    <th>真实姓名</th>
	                                    <th>性别</th>
                                    	<th>手机号</th>
                                    	<th>QQ</th>
                                    	<th>账户状态</th>
                                    	<th>加入时间</th>
	                                    <th>操作</th>
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td class="nowrapTd">
		                            			<img src="${items.picUrl }" width="30px" height="30px"/>
		                            		</td>
		                            		<td>
		                            			${items.userName }
		                            		</td>
		                            		<td>
		                            			${items.realName}
		                            		</td>
		                            		<td>
		                            		<c:choose>
		                            			<c:when test="${items.sex=='1' }">
		                            				男
		                            			</c:when>
		                            			<c:when test="${items.sex=='0' }">
		                            				女
		                            			</c:when>
		                            		</c:choose>
		                            		</td>
		                            		<td>
		                            			${items.phone}
		                            		</td>
		                            		<td>
		                            			${items.qq }
		                            		</td>
		                            		<td>
		                            			<c:choose>
		                            				<c:when test="${items.status=='1'}">
		                            					正常
		                            				</c:when>
		                            				<c:when test="${items.status=='2'}">
		                            					冻结
		                            				</c:when>
		                            			</c:choose>
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.joinTime}" pattern="yyyy-MM-dd"	type="both" />
		                            		</td>
		                            		<td>
		                            			<erp:permission userId="${loginUser.id }" code="setUserRole">
			                                		<a href="javascript:void(0)" onclick="setRole('${items.id }')">设置角色</a>|
												</erp:permission>  
		                            			<erp:permission userId="${loginUser.id }" code="setUserMenu">
			                                		<a class="J_menuItem" onclick="setPermission('${items.id }');">设置权限</a>|
												</erp:permission>
<!--												<a class="J_menuItem" onclick="setEMP('${items.id }');">绑定员工帐号</a>|-->
		                                		<a class="J_menuItem" href="user/${items.id}">修改信息</a>
		                            		</td>
	                            		</tr>
	                            	</c:forEach>
	                            </tbody>
	                        </table>
                        <div method="post" id="tableForm">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        <tbody>
		                            <tr>
		                                <td align="center" class="pn-sp">
		                                    <form id="paging" action="${pageContext.request.contextPath }/user" method="get">
		                                      <input type="hidden" name="username" value="${username }">
		                                        <%@include file="paging.jsp" %>
		                                    </form>
		                                </td>
		                            </tr>
		                        </tbody>
		                    </table>
	                 	</div>	
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
	<jsp:include page="message_alert.jsp"></jsp:include>
    <script type="text/javascript">
    	function delContent(id){
		    swal({
		        title: "您确定要删除这条信息吗",
		        text: "删除后将无法恢复，请谨慎操作！",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
			        document.form2.attributes["action"].value = "role/" + id;
					document.form2.submit();
			        swal("删除成功！", "您已经永久删除了这条信息。", "success");
			        }
		    });
		}
		function setPermission(id){
			layer.open({
				type: 2,
				title: '设置权限',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'menu/toMenu?userId='+id
			});	
		}
		function setRole(id){
			layer.open({
				type: 2,
				title: '设置角色',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'role/toCheck?userId='+id
			});	
		}
		function setEMP(id){
			layer.open({
				type: 2,
				title: '绑定员工帐号',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'role/toEmp?userId='+id
			});	
		}
		$(function(){
			$(".list td").each(function(i){
	            //给td设置title属性,并且设置td的完整值.给title属性.
	        	$(this).attr("title",$(this).text());
	      	});
		
			//全选		
			$("#checkedAll").click(function(){
				var is = $(this).is(":checked");
				$("#editable").find(":checkbox").prop("checked",is);
			});
			//删除
			$("#delete").click(function(){
				var ids = "";
				$("#idsVal").find("input[name='check_all']:checked").each(function(){
					ids += $.trim($(this).val())+",";
				});
				if(ids == ''){
					layer.msg("请选择需要删除的记录!");
					return false;
				}
				$.ajax({
					type:"post",
					url:"${cp}/template/template_delete",
					dataType:"json",
					data:{id:ids},
					success:function(data){
						if(data.flag){
						  	layer.msg(data.msg);
							location.reload();
						}else{
							layer.msg(data.msg);
						}
					}
				});
			});
		});
    </script>
</body>
</html>