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
    <title>活动互动系统-大转盘列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <style type="text/css">
		.td2_name{
			position: absolute;
			left: 35%;
			text-align: center;
		}
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
                        <h5>大转盘列表</h5>
                        <div class="ibox-tools">
                       		<span class="glyphicon glyphicon-plus"></span> 
                            <a class="J_menuItem"  onclick="add()">添加大转盘</a>
                        </div>                     
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/dial" method="get">
								<div class="row">
								<div class="col-sm-6">
									<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text"   name="name" placeholder="根据名称查询">
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
	                                    <th>名称</th>
	                                    <th>添加时间</th>
                                    	<th>开始时间</th>
                                    	<th>结束时间</th>
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
		                            			<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd" type="both" />
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.startTime}" pattern="yyyy-MM-dd" type="both" />
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.endTime }" pattern="yyyy-MM-dd" type="both" />
		                            		</td>
		                            		<td>
												<a href="javascript:void(0);" onclick="del('${items.id}')">删除</a>|
		                                		<a class="J_menuItem"  onclick="up('${items.id }')">修改</a>
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
		                                    <form id="paging" action="${pageContext.request.contextPath }/dial" method="get">
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
	    function add(){
			 	layer.open({
					type: 2,
					title: '添加大转盘',
					shadeClose: true,
					moveOut: true,
					shade: 0.8,
					area: ['1500px', '90%'],
					content: 'dial/toadd',
					end:function(){
							location.reload();
						}
			});		
		}
		function up(id){
			layer.open({
						type: 2,
						title: '修改大转盘',
						shadeClose: true,
						moveOut: true,
						shade: 0.8,
						area: ['1500px', '90%'],
						content: 'dial/toUpdate?id='+id,
						end:function(){
							location.reload();
						}
				});		
		}
	   function del(id){
	    swal({
	        title:"确定删除此大转盘？删除后无法恢复！",
	        type: "warning",
         	showCancelButton: true,
	        confirmButtonColor: "#DD6B55",
	        confirmButtonText: "删除",
	        closeOnConfirm: false
	    }, function (isConfirm) {
	   		 if(isConfirm){
	    		$.ajax({
	    			type:"post",
					url:"dial/delete",
					data:{
						id:id,
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
	function showImg(index){
		document.getElementById("wxImg"+index).style.display='block';
	}
	function hideImg(index){
		document.getElementById("wxImg"+index).style.display='none';
	}
    </script>
</body>
</html>