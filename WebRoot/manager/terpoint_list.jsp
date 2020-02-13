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
    <title>活动互动系统-商家列表</title>
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
                        <h5>代理商列表</h5>
                        <div class="ibox-tools">
                       		<span class="glyphicon glyphicon-plus"></span> 
                            <a class="J_menuItem" href="terPoint/add">代理商添加</a>
                        </div>                     
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/terPoint" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text"  value="${name }" name="name" placeholder="根据店名查询">
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
	                                    <th>店名</th>
	                                    <th>账号</th>
                                    	<th>联系方式</th>
                                    	<th>状态</th>
                                    	<th>余额</th>
                                    	<th>支付宝账号</th>
                                    	<th>平台手续费</th>
                                    	<th>代理手续费</th>
                                    	<th style="width:120px">可添加商家数量</th>
                                    	<th>到期时间</th>
                                    	<th>操作</th>	                                   
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			${items.name }
		                            		</td>
		                            		<td>
		                            			${items.user.userName }
		                            		</td>
		                            		<td>
		                            			${items.phone }
		                            		</td>
		                            		<td>
		                            			<c:choose>
		                            				<c:when test="${items.status=='0'}">
		                            					正常
		                            				</c:when>
		                            				<c:when test="${items.status=='1'}">
		                            					冻结
		                            				</c:when>
		                            			</c:choose>
		                            		</td>
		                            		<td>
		                            		${items.money}
		                            		</td>
		                            		<td>
											${items.zfb}
		                            		</td>
		                            		<td>
											${items.ptFee}%
		                            		</td>
		                            		<td>
											${items.terFee}%
		                            		</td>
		                            		<td>
		                            			${items.activityNum }
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.overTime}" pattern="yyyy-MM-dd"	type="both" />
		                            		</td>
		                            		<td>
												<a href="javascript:void(0);" onclick="del('${items.id}')">删除</a>|
		                                		<a class="J_menuItem" href="terPoint/${items.id}">修改资料</a>
<!--		                                		<a href="javascript:void(0)" onclick="setMoney('${items.id }')">充值余额</a>|-->
												<br>
	                                			<a class="pn-opt" href="javascript:void(0);" onclick="setActivityNum('${items.id}','${items.activityNum }')">修改商家数量</a>
	                                			<br>
	                                			<a class="pn-opt" href="javascript:void(0);" onclick="setFee('${items.id}')">手续费一键设置</a>
	                                			<br>
												<a class="pn-opt" href="javascript:void(0);" onclick="setFeeAc('${items.id}')">商家手续费设置</a>
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
		                                    <form id="paging" action="${pageContext.request.contextPath }/terPoint" method="get">
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
    <script type="text/javascript">
   		function del(id){
		    swal({
		        title:"确定删除此代理商？删除后无法恢复！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"terPoint/"+id,
						data:{
							_method:"delete"
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"删除成功！",type:"success"},function(){
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
    
    	function setBoolean(id,boolean){
    		var title;
    		if(boolean=="true"){
    			title="是否关闭电子二维码？";
    		}else{
    			title="是否开启电子二维码？";
    		}
		    swal({
		        title:title,
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "设置",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"get",
						url:"terPoint/boolean?id="+id,
						data:{boolean:boolean},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"成功！",type:"success"},function(){
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
		
		function setActivityNum(id,num){
			layer.open({
				type: 2,
				title: '修改代理商可添加商家数量',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'terPoint/activityNum?terId='+id
			});	
		}
		function setFee(id){
			layer.open({
				type: 2,
				title: '修改手续费',
				shadeClose: true,
				shade: 0.8,
				area: ['1020px', '60%'],
				content: 'terPoint/fee?id='+id
			});	
		}
		
		function setFeeAc(tid){
			layer.open({
				type: 2,
				title: '代理手续费设置',
				shadeClose: true,
				shade: 0.8,
				area: ['1020px', '60%'],
				content: 'activity/selectAllAcFee?tid='+tid
			});	
		}
		
		function setMoney(id){
			layer.open({
				type: 2,
				title: '充值余额',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'terPoint/money?id='+id
			});	
		}
		
		function setRedPacket(id){
			layer.open({
				type: 2,
				title: '绑定红包码',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'manager/redpacket_binding.jsp?id='+id
			});	
		}
    </script>
</body>
</html>