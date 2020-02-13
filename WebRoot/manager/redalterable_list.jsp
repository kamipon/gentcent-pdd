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
    <title>活码列表</title>
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
                        <h5>活码列表</h5>
                        <div class="ibox-tools">
                       			<span class="glyphicon glyphicon-plus"></span>
	                       		<a class="J_menuItem" href="manager/redalterable_add.jsp">活码添加</a> 
                        </div>                     
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/redAlterable/list" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text"  name="name" placeholder="根据活码名查询">
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
	                                	<th style="width: 5%">二维码</th>
	                                	<th>编号</th>
	                                	<th>名称</th>
	                                	<th>描述</th>
	                                	<th>省</th>
	                                	<th>市</th>
	                                	<th>区/县</th>
	                                	<th>添加时间</th>
	                                	<th>操作</th>
	                                </tr>
	                            </thead>
	                            <tbody id="user" style="height: 10%">
	                            	<c:forEach items="${list}" var="items" varStatus="status">
	                            		<tr> 
		                            		<td>
			                                	<div class="qrcodeIcon" _style="16" _id="5" onMouseOut="hideImg('${status.index }')"  onmouseover="showImg('${status.index }')"></div>
			                                    <div class="qrcodeBox" style="display: none;" id="wxImg${status.index }">
			                                    	<div class="inIcon"></div>
													<img alt="Wxmenu" src="wresource/url?url=<%=res.getString("project.host")%>/item/alter/${items.id }" style="height:100%;width:100%;">
												</div>
                            				</td>
		                            		<td>
		                            			${items.code }
		                            		</td>
		                            		<td>
		                            			${items.name }
		                            		</td>
		                            		<td>
		                            			${items.desc }
		                            		</td>
		                            		<td>
		                            			<c:if test="${empty items.sheng}">未限制</c:if>
		                            			<c:if test="${!empty items.sheng}">${items.sheng}</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${empty items.shi}">未限制</c:if>
		                            			<c:if test="${!empty items.shi}">${items.shi}</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${empty items.area}">未限制</c:if>
		                            			<c:if test="${!empty items.area}">${items.area}</c:if>
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime}" dateStyle="long" timeStyle="long" pattern="yyyy-MM-dd HH:mm:ss" type="both" />
		                            		</td>
		                            		<td>
		                            			<a class="pn-opt" href="javascript:void(0);" onclick="del('${items.id}')">删除</a>|
		                                		<a class="J_menuItem" href="redAlterable/toUpdate?id=${items.id}">修改</a>|
		                                		<a href="javascript:void(0)" onclick="setRedPacket('${items.id }','${items.name }')">绑定红包</a>|
		                                		<a href="javascript:void(0)" onclick="lookRedPacket('${items.id }')">查看红包</a>|
		                                		<a href="javascript:void(0)" onclick="down('${items.id }')">下载</a>
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
		                                    <form id="paging" action="redAlterable/list" method="get">
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
	    function showImg(index){
			document.getElementById("wxImg"+index).style.display='block';
		}
		function hideImg(index){
			document.getElementById("wxImg"+index).style.display='none';
		}
		 function del(id){
		    swal({
		        title:"确定删除此活码？删除后无法恢复！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"redAlterable/delete",
						data:{
							_method:"delete",
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
		function setRedPacket(id,name){
		 	layer.open({
			type: 2,
			title: '绑定红包',
			shadeClose: true,
			moveOut: true,
			shade: 0.8,
			area: ['1500px', '80%'],
			content: 'manager/redalterable_binding.jsp?id='+id+'&name='+name
		});		
	}
	
	function lookRedPacket(id){
		 	layer.open({
			type: 2,
			title: '查看红包',
			shadeClose: true,
			moveOut: true,
			shade: 0.8,
			area: ['1500px', '80%'],
			content: 'redAlterable/look?id='+id
		});		
	}
	
		function down(id){
				swal({
		        title:"是否导出二维码图片？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "导出",
		        closeOnConfirm: false
		    },function (isConfirm) {
		   		 if(isConfirm){
		    		window.location.href="redAlterable/down?id="+id;
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
    </script>
</body>
</html>