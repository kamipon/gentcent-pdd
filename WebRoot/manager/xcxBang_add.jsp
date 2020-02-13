<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>


	<!-- Mirrored from www.zi-han.net/theme/hplus/form_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 11 Dec 2015 04:46:12 GMT -->
	<head>
		<base href="<%=basePath%>">

		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>小程序解绑或绑定</title>
		<link rel="shortcut icon" href="favicon.ico">
		<link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
		<link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
		<link href="css/plugins/dataTables/dataTables.bootstrap.css"
			rel="stylesheet">
		<link href="css/animate.min.css" rel="stylesheet">
		<link href="css/style.min1fc6.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css"
			href="css/plugins/sweetalert/sweetalert.css">
		<link href="css/plugins/iCheck/custom.css" rel="stylesheet">
		<style>
.qrcodeIcon {
	background-image: url("images/ermIcon.png?v=201507271756");
	background-position: 11px 10px;
	background-repeat: no-repeat;
	display: inline-block;
	height: 25px;
	width: 33px;
}

.qrcodeBox {
	background-color: #fff;
	border: 1px solid #cfcfcf;
	border-radius: 4px;
	height: 150px;
	left: 80px;
	margin-top: -58px;
	padding: 5px;
	position: absolute;
	width: 150px;
	z-index: 1000;
}
</style>
	</head>
	<body class="gray-bg">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content">
							<div id="DataTables_Table_0_wrapper"
								class="dataTables_wrapper form-inline" role="grid"
								style="padding-bottom: 10px">
								<form
									action="${pageContext.request.contextPath }/promotion/bang"
									method="get">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="DataTables_Table_0_filter">
												<label>
													查找：
													<input type="text" name="name" placeholder="根据商家名称查询">
													<input type="text" name="userName" placeholder="根据账号查询">
													<input type="submit" class="btn btn-sm btn-primary"
														value="搜索">
												</label>
											</div>
										</div>
										<div class="col-sm-6" style="height: 40px">
											<div id="DataTables_Table_0_length" class="dataTables_filter">
												<label>
													每页
													<select class="form-control input-sm"
														aria-controls="DataTables_Table_0" name="pageSize"
														onchange="javascript:this.form.submit();">
														<c:if test="${pageSize!=null}">
															<option value="${pageSize }">
																${pageSize }
															</option>
														</c:if>
														<option value="10">
															10
														</option>
														<option value="25">
															25
														</option>
														<option value="50">
															50
														</option>
														<option value="100">
															100
														</option>
													</select>
													条记录
												</label>
											</div>
										</div>
								</form>
							</div>
						</div>
						<table
							class="table table-striped table-bordered table-hover dataTables-example"
							id="editable" style="table-layout: fixed;">
							<thead class="pn-lthead">
								<tr>
									<th>
										商家名称
									</th>
									<th>
										操作
									</th>
								</tr>
							</thead>
							<tbody id="user" style="height: 10%">
								<c:forEach items="${list}" var="items" varStatus="status">
									<tr style="height: 60px">
										<td>
											${items.name}
										</td>
										<td>
											<button onclick="bang('${items.id}')" type="button"
												class="btn btn-primary" style="margin-left: 50%">
												<c:if test="${empty items.showxcx}">解绑小程序</c:if>
												<c:if test="${!empty items.showxcx}">绑定小程序</c:if>
											</button>
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
											<form id="paging" action="promotion/bang" method="get">
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
		</div>
		<script src="js/jquery.min63b9.js?v=2.1.4"></script>
		<script type="text/javascript" src="js/childrenToMenu.js"></script>
		<script type="text/javascript"
			src="js/plugins/sweetalert/sweetalert.min.js"></script>
		<script src="js/layer/layer.js"></script>
		<script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
		<script>
	function bang(id){
		    $.ajax({
	    			type:"post",
					url:"promotion/bdType",
					data:{
						id:id
					},
					dataType:"json",
					success:function(data){
						layer.msg(data.msg);
							setTimeout("window.location.reload()",1000);
					}
				});
		}
</script>
	</body>
</html>
