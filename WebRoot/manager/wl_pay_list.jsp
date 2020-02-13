<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>收款码</title>
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
                        <h5>收款码</h5>
                        <div class="ibox-tools">
                        	<span class="glyphicon glyphicon-plus"></span> 
                            <a class="J_menuItem" href="manager/wl_pay_add.jsp">收款码添加</a>
                        </div>
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/wlpay" method="get">
								<div class="row" style="display: none">
									<div class="col-sm-6">
										<div id="DataTables_Table_0_length" class="dataTables_filter"  >
											<label>每页
												<select class="form-control input-sm" aria-controls="DataTables_Table_0" name="pageSize" onchange="javascript:this.form.submit();">
													<c:if test="${page.pageSize!=null}">
														<option value="${page.pageSize }">${page.pageSize }</option>
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
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable">
	                            <thead>
	                                <tr>
	                                    <th>支付名称</th>
                                    	<th>支付二维码</th>
	                                    <th>操作</th>
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			${items.name}
		                            		</td>
		                            		<td>
		                            			<img src="${items.url}" style="width: 80px;height: 120px;">
		                            		</td>
		                            		<td>
		                            			<a class="pn-opt" onclick="delContent('${items.id}')" href="javascript:void(0);" >删除</a>|
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
		                                    <form id="paging" action="${pageContext.request.contextPath }/wlpay" method="get">
		                                      <input type="hidden" name="roleName" value="${roleName }">
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
		    		$.ajax({
						url:"wlpay/" + id,
						type:"post",
						data:{'_method':'delete'},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"删除成功！", text:"您已经永久删除了这条信息。", type:"success"},function(){
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
		function setPermission(id){
			layer.open({
				type: 2,
				title: '设置权限',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'menu/toMenu?roleId='+id
			});	
		}
		function setPermission1(id){
			layer.open({
				type: 2,
				title: '设置权限',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'menu/toMenu?roleId='+id+'&&type=pl'
			});	
		}
		
    </script>
</body>
</html>