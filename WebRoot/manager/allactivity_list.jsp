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
    <title>商家列表</title>
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
                        <h5>商家列表</h5>
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/activity/selectAllAc" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text"  value="${username }" name="name" placeholder="根据商家名查询">
					                        	<input type="text"  value="${username }" name="userName" placeholder="根据账号查询">
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
	                            <thead class="pn-lthead">
	                                <tr>
<!--                                	 	<th style="width:100px;">活动图</th>-->
	                                    <th>名称</th>
	                                    <th>账号</th>
                                    	<th>联系方式</th>
                                    	<th>余额</th>
                                    	<th>支付宝账号</th>
                                    	<th>代理商</th>
                                    	<th>创建时间</th>	  
                                    	<th>操作</th>                                 
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<c:choose>
	                            			<c:when test="${items.isOverTime}">
	                            				<tr style="color:red">
	                            			</c:when>
	                            			<c:otherwise>
	                            				<tr>
	                            			</c:otherwise>
                            			</c:choose>
<!--	                            			<td>-->
<!--		                            			<img src="${items.picUrl }" style="width:50px;height:50px;">-->
<!--		                            		</td>-->
		                            		<td>
		                            			${items.activity.name }
		                            		</td>
		                            		<td>
		                            			${items.userName }
		                            		</td>
		                            		<td>
                            					${items.activity.phone }
		                            		</td>
		                            		<td>
		                            		<fmt:formatNumber value="${items.restMoney }" pattern="0.00"/>	
		                            		</td>
		                            		<td>
		                            		${items.activity.zfb }
		                            		</td>
		                            		<td>
		                            			${items.activity.terpoint.name}
		                            		</td>
		                            		<td>
		                            			${items.activity.addTime }
		                            		</td>
		                            		<td>
		                            			<a class="J_menuItem" href="activity/${items.id}">修改</a>
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
		                                    <form id="paging" action="activity/selectAllAc" method="get">
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
		        title:"确定删除此商家？删除后无法恢复！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"activity/"+id,
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
    			title="是否关闭多领取？";
    		}else{
    			title="是否开启多领取？";
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
						url:"activity/boolean?id="+id,
						data:{boolean:boolean},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"成功！", type:"success"},function(){
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
    	
	function setMoney(id){
			layer.open({
				type: 2,
				title: '充值余额',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'activity/money?id='+id
			});	
		}
	function setRedPacket(id,num){
		 	layer.open({
			type: 2,
			title: '绑定红包',
			shadeClose: true,
			shade: 0.8,
			area: ['1500px', '50%'],
			content: 'manager/redpacket_binding_activity.jsp?id='+id
		});		
	}
	function buyRedPacket(){
		 	layer.open({
			type: 2,
			title: '购买红包码',
			shadeClose: true,
			shade: 0.8,
			area: ['1500px', '50%'],
			content: 'manager/redpacket_buy.jsp'
		});		
	}
		
    </script>
</body>
</html>