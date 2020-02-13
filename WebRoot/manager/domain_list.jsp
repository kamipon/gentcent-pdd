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
    <title>域名列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <link href="manager/css/switchery.css" rel="stylesheet">
    <style type="text/css">
    	.qrcodeIcon {
		    background-image: url(images/ermIcon.png?v=201507271756);
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
		.td2_name{
			position: absolute;
			left: 35%;
			text-align: center;
		}
    </style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    <h5>域名列表</h5>
                        <div class="ibox-tools">
                       			<span class="glyphicon glyphicon-plus"></span>
	                       		<a class="J_menuItem" href="manager/domain_add.jsp">域名添加</a> 
                        </div>   
                    </div>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/domain/list" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
<!--											<label>-->
<!--												查找：-->
<!--					                        	<input type="text"  value="${name}" name="name" placeholder="根据商品名查询">-->
<!--					                        	<input type="text"  value="${telephone}" name="telephone" placeholder="根据联系方式查询">-->
<!--					                        	&nbsp;&nbsp;-->
<!--					                        	<input type="submit" class="btn btn-sm btn-primary" value="搜索"> -->
<!--											</label>-->
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
	                                	<th>域名</th>
	                                    <th>状态</th>
	                                    <th>操作</th>
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            <c:forEach items="${list}" var="items">
		                            		<td>
		                            			${items.url }
		                            		</td>
		                            		<td>
		                            			<input type="checkbox" class="js-switch" 
		                            			<c:if test="${items.status eq '0'}">checked</c:if>
		                            			 data-switchery="true" style="display: none;" value="${items.id}" onchange="ajaxStartAlterable('${items.id}')" id="${items.id}">
		                            		</td>
		                            		<td>
		                                		<a class="J_menuItem" href="domain/${items.id}">修改</a>
		                                		| <a href="javascript:void(0)" onclick="del('${items.id }')">删除</a>
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
		                                    <form id="paging" action="domian/list" method="get">
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
    <script src="manager/js/switchery.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
      	var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
		elems.forEach(function(html) {
		var switchery = new Switchery(html);
		});
	 });
	   		function del(id){
		    swal({
		        title:"确定删除此域名？删除后无法恢复！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"domain/"+id,
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
								layer.msg("删除失败");
							}

						}
					});
			    }
		    });
		}
		
	function ajaxStartAlterable(code){
				    swal({
		        title:"确定切换域名?！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "切换",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
		    			 	var checked = $('#'+code).val();
	 		        $.ajax({
					url:"domain/changeStatus",
					type:"post",
					data:{	
						_method:"put",
						id:checked,
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							swal("切换成功");
							setTimeout('goFresh("domain/list");',1000); 
						}else{
							swal("切换失败");
						}
					}
				});
		    	}
		    });
	
	

	 }
    </script>
</body>
</html>