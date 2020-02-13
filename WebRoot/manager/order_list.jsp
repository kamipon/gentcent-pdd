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
    <title>活动互动系统-订单列表</title>
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
                        <h5>订单列表</h5>
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/order" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text" name="orderCode" placeholder="根据订单号查询">
				                        		<input type="text" name="phone" placeholder="根据手机号查询">
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
	                                    <th>订单码</th>
	                                    <th>商品名称</th>
                                    	<th>用户</th>
                                    	<th>姓名</th>
                                    	<th>手机号</th>
                                    	<th>当前金额</th>
                                    	<th>创建时间</th>
                                    	<th>到期时间</th>
                                    	<th>状态</th>
                                    	<th>操作</th>	                           
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			${items.orderCode }
		                            		</td>
		                            		<td>
		                            			${items.commodity.name}
		                            		</td>
		                            		<td>
		                            			${items.member.nick }
		                            		</td>
		                            		<td>
		                            			${items.name }
		                            		</td>
		                            		<td>
		                            			${items.phone }
		                            		</td>
		                            		<td>
		                            			${items.nowPrice }
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.createDate}" pattern="yyyy-MM-dd" type="both" />
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.endDate}" pattern="yyyy-MM-dd"	type="both" />
		                            		</td>
		                            		<td>
		                            			<c:choose>
		                            				<c:when test="${items.state=='0'}">
		                            					<span style="color:green">未兑奖</span>
		                            				</c:when>
		                            				<c:when test="${items.state=='1'}">
		                            					<span style="color:green">未兑奖</span>
		                            				</c:when>
		                            				<c:when test="${items.state=='3'}">
		                            					<span style="color:red">已兑奖</span>
		                            				</c:when>
		                            				<c:when test="${items.state=='2'}">
		                            					<span style="color:red">已失效</span>
		                            				</c:when>
		                            			</c:choose>
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.state=='0'||items.state=='1'}">
		                            				<input type="button"  class="btn btn-sm btn-primary"  value="兑奖" onclick="suc('${items.id}')"> 
		                            				<input type="button"  class="btn btn-sm btn-primary"   value="失效"  onclick="fai('${items.id}')">
		                            			</c:if> 
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
		                                    <form id="paging" action="${pageContext.request.contextPath }/order" method="get">
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
		function suc(id){
	   		swal({
		        title: "请确认已兑奖",
		        type: "warning",
		        showCancelButton:true,
		        closeOnConfirm:false,
		        confirmButtonText:"确认",
		        cancelButtonText:"取消",
		    },
		    function(){
		    	$.ajax({
    			url:"hx/"+id,
    			type:"post",
    			data:{
    				_method:"put",
    				num:"1",
    				type:3
    			},
    			success:function(){
    				swal({title:"兑奖成功！",type:"success"},function(){
    						location.reload();
						});
    			}
    		});
    	}
    	);
    	}
    	
   		function fai(id){
	   		swal({
		        title: "请确认该订单已失效",
		        type: "warning",
		        showCancelButton:true,
		        closeOnConfirm:false,
		        confirmButtonText:"确认",
		        cancelButtonText:"取消",
		    },
		    function(){
		    	$.ajax({
    			url:"hx/"+id,
    			num:"2",
    			type:"post",
    			data:{
    				_method:"put",
    				num:"2",
    				type:2
    			},
    			success:function(){
    				swal({title:"操作成功！",type:"success"},function(){
   							location.reload();
						});
    			}
    		});
    	}
    	);
    	}
    </script>
</body>
</html>