<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ResourceBundle res = ResourceBundle.getBundle("11erp");
%>
<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>活动推广列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <style type="text/css">
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
                    <div class="ibox-title">
                        <h5>活动推广列表</h5>
                        <div class="ibox-tools">
                    		<span class="glyphicon glyphicon-plus"></span>
                       		<a class="J_menuItem" onclick="javascript:toAdd()">活动添加</a> 
                        </div>                     
                    </div>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/promotion/list" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text"  name="name" placeholder="根据活动名查询">
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
	                     <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed;">
	                            <thead class="pn-lthead">
	                                <tr >
                                		<th style="width: 5%">活动图</th>
	                                	<th>活动名称</th>
	                                	<th>描述</th>
	                                	<th>类型</th>
	                                	<th>红包数量</th>
	                                	<th>省</th>
	                                	<th>市</th>
	                                	<th>行业</th>
	                                	<th>添加时间</th>
                                		<th>是否开启</th>
	                                	<th>状态</th>
	                                	<th>操作</th>
	                                </tr>
	                            </thead>
	                            <tbody id="user" style="height: 10%">
	                            	<c:forEach items="${list}" var="items" varStatus="status">
	                            		<tr style="height: 60px"> 
		                            		<td>
		                            			<img src="${items.img}" style="width: 50px">
		                            		</td>
		                            		<td>
		                            			${items.name }
		                            		</td>
		                            		<td>
		                            			${items.desc }
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.type==0}">现金</c:if>
		                            			<c:if test="${items.type==1}">优惠券</c:if>
		                            			<c:if test="${items.type==2}">实物</c:if>
		                            			<c:if test="${items.type==3}">积分</c:if>
		                            			<c:if test="${items.type==4}">大转盘</c:if>
		                            		</td>
		                            		<td>
		                            			${items.redNumber }
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.isSheng==0}">不限制</c:if>
		                            			<c:if test="${not empty items.sheng&&items.isSheng==1}">${items.sheng}</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.isShi==0}">不限制</c:if>
		                            			<c:if test="${not empty items.shi&&items.isShi==1}">${items.shi}</c:if>
		                            		</td>
		                            		<td>${items.work }</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime}" dateStyle="long" timeStyle="long" pattern="yyyy-MM-dd HH:mm:ss" type="both" />
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.isOpen==1}">开启</c:if>
		                            			<c:if test="${items.isOpen==0}">关闭</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.status==1 }"><font style="color: red">待审核</font></c:if>
		                            			<c:if test="${items.status==2 }"><font style="color: green">已通过</font></c:if>
		                            			<c:if test="${items.status==3 }"><font style="color: red">未通过</font></c:if>
		                            		</td>
		                            		<td>
		                            			<a class="pn-opt" href="javascript:void(0);" onclick="del('${items.id}')">删除</a>|
		                                		<a class="J_menuItem"  onclick="update('${items.id}')">修改</a>|
		                                		<a class="J_menuItem"  onclick="mess('${items.id}')">详情</a>
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
		                                    <form id="paging" action="promotion/list" method="get">
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
    function toAdd(){
    	layer.open({
			type: 2,
			title: '添加活动推广',
			shadeClose: true,
			moveOut: true,
			shade: 0.8,
			area: ['1500px', '80%'],
			content: 'promotion/to_add',
			end:function(){
							location.reload();
						}
		});	
	}
	
	function update(id){
    	layer.open({
			type: 2,
			title: '修改活动推广',
			shadeClose: true,
			moveOut: true,
			shade: 0.8,
			area: ['1500px', '80%'],
			content: 'promotion/toUpdate?id='+id,
			end:function(){
							location.reload();
						}
		});	
	}
	
	function mess(id){
    	layer.open({
			type: 2,
			title: '红包领取详情',
			shadeClose: true,
			moveOut: true,
			shade: 0.8,
			area: ['1500px', '80%'],
			content: 'promotion/mess?id='+id,
			end:function(){
						}
		});	
	}
	
		function promotion(id){
				swal({
		        title:"是否将此活码应用于小程序推广？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "是",
		        closeOnConfirm: false
		    },function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"redAlterable/promotion",
						data:{
							_method:"put",
							id:id
						},
						dataType:"json",
						success:function(data){
							
						}
					});
			    }
		    });
			
		}
		
		function del(id){
		    swal({
		        title:"确定删除此活动？删除后无法恢复！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"promotion/remove",
						data:{
							id:id
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
    </script>
</body>
</html>