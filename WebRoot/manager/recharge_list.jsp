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
    <title>充值信息列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <script type="text/javascript" src="${cp }/manager/js/date/WdatePicker.js"></script>
    <style>
    	td{
			word-wrap: break-word;
			white-space:nowrap; 
			word-break:keep-all; 
			overflow:hidden; 
			text-overflow:ellipsis;
		}
		.list{ background:none repeat scroll 0 0; margin:0px auto;  width:100%; table-layout:fixed; border:1px solid #a1bcdb; }
		.list td{ border:1px solid #a1bcdb; word-break:break-all; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; -o-text-overflow:ellipsis; }
    	.sweet-alert p{
    		margin: 5px;
    		margin-bottom: 10px;
    	}
    </style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>充值信息列表</h5>
	                    <form name="form2" action="" method="post">
							<input type="hidden" name="_method" value="delete"/>
						</form>
                    	<div class="ibox-content" style="padding: 3px 17px 17px;">
							<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid" style="padding-bottom:15px;">
								<form action="${pageContext.request.contextPath }/recharge" method="get">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="DataTables_Table_0_filter" style="width:700px;">
												<label>
					                        		查找：
						                        	<input type="text"  value="${num }" name="num"  maxlength="255" placeholder="根据订单编号查询..."/>
						                        	<select id="status" name="status" style="height: 26px; width: 170px;margin-left: 42px;">
						                        		<option value="" <c:if test="${statusId=='' }">selected = 'selected'</c:if>>
						                        			请选择状态
						                        		</option>
						                        		<option value="已完成" >
						                        			已完成
						                        		</option>
						                        		<option value="待付款" >
						                        			待付款 
						                        		</option>
						                        	</select> 
						                        	<input type="text" name="staticTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" placeholder="提交时间" value="${staticTime }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="height: 26px; width: 170px;"/>
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
	                      	<table class="table table-striped table-bordered table-hover dataTables-example" id="editable">
	                      		<span style="font-size:17px;font-weight: bold">充值次数:<span style="color: #E23B07;font-weight: bold">${total }</span>次</span>&nbsp;&nbsp;
	                      		<span style="font-size:17px;font-weight: bold">充值金额:<span style="color: #E23B07;font-weight: bold"><fmt:formatNumber value="${money }" pattern="##.##" minFractionDigits="2" ></fmt:formatNumber></span>元</span>
	                          	<input type="button" class="btn btn-sm btn-primary" onclick="updownexel()" value="导出execl表格" style="float: right;"/>
	                            <thead>
	                                <tr>
                                    	<th>订单编号</th>
                                    	<th>充值账户</th>
                                    	<th>充值金额</th>
                                    	<th width="4%">状态</th>
                                    	<th>充值前余额</th>
                                    	<th>提交时间</th>
                                    	
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal" class="list">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			${items.num}
		                            		</td>
		                            		<td>
		                            			<c:choose>
		                            				<c:when test="${! empty items.terpointName}">
		                            					${items.terpointName}
		                            				</c:when>
		                            				<c:when test="${! empty items.activityname}">
		                            					${items.activityname}
		                            				</c:when>
		                            			</c:choose>
		                            		</td>
		                            		<td>
		                            			${items.price}
		                            		</td>
		                            		<td>
		                            		<c:choose>
		                            				<c:when test="${!empty items.desc}">
		                            					${items.status }(后台手动)
		                            				</c:when>
		                            				<c:when test="${empty items.desc}">
		                            					${items.status }
		                            				</c:when>
		                            			</c:choose>
		                            			
		                            		</td>	
		                            		<td>
		                            			<fmt:formatNumber type="number" value="${items.balance }" maxFractionDigits="2" pattern="0.0"/>
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd HH:mm:ss"	type="both" />
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
			                                    <form id="paging" action="${pageContext.request.contextPath }/recharge" method="get">
			                                      <input type="hidden" name="status" value="${status }"/>
			                                      <input type="hidden" name="num" value="${num }"/>
			                                      <input type="hidden" name="staticTime" value="${staticTime }"/>
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
        </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$(".list td").each(function(i){
	            //给td设置title属性,并且设置td的完整值.给title属性.
	        	$(this).attr("title",$(this).text());
	      	});
    	});
    	function updownexel(){
    		var status = $.trim($("input[name='status']").val()); 
    		var num = $.trim($("input[name='num']").val());
    		var staticTime = $.trim($("input[name='staticTime']").val());
    		window.location.href="recharge/out?num="+num+"&status="+status+"&staticTime="+staticTime;
    		
    	}
    	function audit(id){
			swal({
        		title: "您确定要审核这条提现记录么",
       			text: "审核后将不能再做修改，请谨慎操作!",
        		type: "warning",
       			showCancelButton: true,
        		confirmButtonColor: "#DD6B55",
       			confirmButtonText: "审核",
        		closeOnConfirm: false
    		}, function (isConfirm) {
		    	if(isConfirm){
			       $.ajax({
				   		type:"post",
						url:"${cp}/recharge/audit",
						dataType:"json",
						data:{
							id:id
						},
						success:function(data){
							if(data.flag){
								swal({
									title: "GOOD", 
									text: "审核通过", 
									type: "success",
									confirmButtonText: "是的",
									confirmButtonColor: "#ec6c62"
									}, function() {
										window.location.href="recharge";
								});
							}else{
								swal("审核失败!", data.msg, "error");
							}
						}
					});
			     }
		    });
		}
    </script>
</body>
</html>