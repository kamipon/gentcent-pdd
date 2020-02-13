<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	<title>用户列表(通知绑定)</title>
	<link rel="shortcut icon" href="favicon.ico">
	<link href="css/bootstrap.minb16a.css" rel="stylesheet">
	<link href="css/font-awesome.min93e3.css" rel="stylesheet">
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
						<h5>
							用户列表(通知绑定)
						</h5>
					</div>
					<form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
					<div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/managerMsg/list" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												<div class="dataTables_length" id="DataTables_Table_0_filter">
													<label>
														<input type="button" class="btn btn-sm btn-primary" onclick="account()" style="margin-left: 10px;margin-top: 3px" value="绑定通知">
													</label>
												</div>
											</label>
										</div>
									</div>
									<div class="col-sm-6">
										<div id="DataTables_Table_0_length" class="dataTables_filter">
											<label>
												每页
												<select class="form-control input-sm" aria-controls="DataTables_Table_0" name="pageSize" onchange="javascript:this.form.submit();">
													<c:if test="${pageSize!=null}">
														<option value="${pageSize }">
															${pageSize }
														</option>
													</c:if>
													<option value="10">10</option>
													<option value="25">25</option>
													<option value="50">50</option>
													<option value="100">100</option>
												</select>
												条记录
											</label>
										</div>
									</div>
							</form>
							<form
								action="${pageContext.request.contextPath }/activity/export"
								method="get" style="position: absolute; margin-left: 309px">
								<div class="dataTables_length" id="DataTables_Table_0_filter">
									<input type="hidden" name="name" value="${name }" maxlength="255">
								</div>
							</form>
						</div>
					</div>
					<table
						class="table table-striped table-bordered table-hover dataTables-example"
						id="editable">
						<thead>
							<tr>
								<th>
									sid
								</th>
								<th>
									用户昵称
								</th>
								<th>
								  	用户身份
								</th>
								<th>
									微信openid
								</th>
								<th>
									shotID
								</th>
								<th>
									真实姓名
								</th>
								<th>
									性别
								</th>
								<th>
									最后登录日期
								</th>
								<th>
									IP
								</th>
								<th>
									状态
								</th>
								<th >
									添加时间
								</th>
								<!-- 保留 -->
								<th style="width: 10%">
									操作
								</th>
							</tr>
						</thead>
						<tbody id="idsVal">
							<c:forEach items="${list}" var="items">
								<tr>
									<td>
										${items.member.sid}
									</td>
									<td>
										${items.member.nick}
									</td>
									<td>
										<c:choose>
											<c:when test="${items.member.type==1}">
												管理员
											</c:when>
											<c:when test="${items.member.type==2}">
												代理
											</c:when>
											<c:when test="${items.member.type==3}">
												商户
											</c:when>
											<c:otherwise>
												游客
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										${items.member.openId}
									</td>
									<td>
										${items.member.shotId}
									</td>
									<td>
										${items.member.realName}
									</td>
									<td>
										<c:if test="${items.member.sex==2}">
											男
										</c:if>
										<c:if test="${items.member.sex==1}">
											女
										</c:if>
									</td>
									<td>
										${items.member.loginLastTime}
									</td>
									<td>
										${items.member.ip}
									</td>
									<td>
										<c:choose>
											<c:when test="${items.member.status==1}">
												启动
											</c:when>
											<c:otherwise>
												禁用
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										${items.member.addTime}
									</td>
									<td>
									
										<c:choose>
											<c:when test="${items.status==0 || empty items.status}">
												<a class="pn-opt" onclick="remove('${items.member.id}')">取消管理员</a>
											</c:when>
											<c:otherwise>
												<a class="pn-opt" onclick="enabled('${items.member.id}')">设为管理员</a>
											</c:otherwise>
										</c:choose>
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
										<form id="paging" action="${pageContext.request.contextPath }/managerMsg/list" method="get">
											<%@include file="paging.jsp"%>
										</form>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" value="${total }" name="total" id="total">
	</div>
	<input type="hidden" id="message" value="${msg }" />
	<script src="js/jquery.min63b9.js?v=2.1.4"></script>
	<script type="text/javascript" src="js/childrenToMenu.js"></script>
	<script type="text/javascript"
		src="js/plugins/sweetalert/sweetalert.min.js"></script>
	<script src="js/layer/layer.js"></script>
	<script type="text/javascript">
	function remove(id){
		    swal({
		        title: "您确定要解除这个用户的管理员权限么？",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "解除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"member/unbind?id="+id,
						data:{
						_method:"delete"},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"解除成功！", text:"您已经解除成功此用户的相关权限。", type:"success"},function(){
									window.location.reload();
								});
							}else{
								layer.msg(data.msg);
							}

						}
					});
			    }
		    });
		}
	function enabled(id){
		    swal({
		        title: "您确定要将这个用户的设为管理员么？",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "确定",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"member/enabled?id="+id,
						data:{
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"设置成功！", text:"您已经成功将此用户设为管理员。", type:"success"},function(){
									window.location.reload();
								});
							}else{
								layer.msg(data.msg);
							}

						}
					});
			    }
		    });
		}
	function acts(){
		layer.open({
			type: 2,
			title: '绑定',
			shadeClose: true,
			shade: 0.8,
			area: ['1200px', '80%'],
			content: 'managerMsg/acts'  //iframe的url
		});
	}
	function account(){
   		layer.open({
			type: 2,
			title: '绑定',
			shadeClose: true,
			shade: 0.8,
			area: ['800px', '50%'],
			content: 'managerMsg/binding'  //iframe的url
		});
   	}
	//通知设置
   	function check(mbId){
		layer.open({
			type: 2,
			title: '通知设置',
			shadeClose: true,
			shade: 0.8,
			area: ['1200px', '70%'],
			content:"${cp}/wxmodel_sms?mbId="+mbId
		});	
   	}
	//删除
	function deleteMember(id){
		swal({
		     title: "您确定要删除该信息吗",
		     text: "删除后将无法恢复，请谨慎操作！",
		     type: "warning",
		     showCancelButton: true,
		     confirmButtonColor: "#DD6B55",
		     confirmButtonText: "删除",
		     closeOnConfirm: false
		}, function (isConfirm) {
		 	if(isConfirm){
		 		$.ajax({
					url:"member/" + id,
					type:"post",
					data:{
						_method:'delete'
					},
					success:function(data){
						if(data.flag){
							swal({title:"删除成功！",type:"success"},function(){
									window.location.reload();
							});	
						}else{
							layer.msg(msg);
						}
					}
				});
			}
		});
	};
   </script>
</body>
</html>