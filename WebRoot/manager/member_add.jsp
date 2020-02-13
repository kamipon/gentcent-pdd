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
    <title>设置</title>
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
                        <h5>设置</h5>              
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="member" method="get">
							<input type="hidden" name="id" value="${member.id }">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
					                        	<input type="button" id="set" class="btn btn-sm btn-primary" value="绑定"> 
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
	                                	<th style="width:50px"><input type="checkbox" name="check_all" id="checkedAll"></th>
	                                    <th style="width:100px;">活动图</th>
	                                    <th>活动名</th>
	                                    <th>分享标题</th>
                                    	<th>联系方式</th>
                                    	<th>状态</th>
                                    	<th>金额</th>
                                    	<th>红包个数</th>                               
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
	                            			<td><input type="checkbox" name="check_all" value="${items.id }"></td>
		                            		<td>
		                            			<img src="${items.picUrl }" style="width:50px;height:50px;">
		                            		</td>
		                            		<td>
		                            			<a href="http://${items.url }" target="_blank">${items.name }</a>
		                            		</td>
		                            		<td>
		                            			<a href="http://${items.url }" target="_blank">${items.title }</a>
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
		                            			${items.money }
		                            		</td>
		                            		<td >
		                            			${items.num}
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
		                                    <form id="paging" action="member" method="get">

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
		        title: "您确定要删除这条活动吗",
		        text: "删除后将无法恢复，请谨慎操作！",
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
						data:{_method:"delete"},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"删除成功！", text:"您已经永久删除这条活动。", type:"success"},function(){
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
				content: 'menu/toMenu?userId='+id
			});	
		}
		function setRole(id){
			layer.open({
				type: 2,
				title: '设置角色',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'role/toCheck?userId='+id
			});	
		}
	
		$(function(){
			$(".list td").each(function(i){
	            //给td设置title属性,并且设置td的完整值.给title属性.
	        	$(this).attr("title",$(this).text());
	      	});
		
			//全选		
			$("#checkedAll").click(function(){
				var is = $(this).is(":checked");
				$("#editable").find(":checkbox").prop("checked",is);
			});
			//设置管理员
			$("#set").click(function(){
				var ids = "";
				//用户的ID
				var memberId = $.trim($("input[name='id']").val());
				$("#idsVal").find("input[name='check_all']:checked").each(function(){
					ids += $.trim($(this).val())+",";
				});
				if(ids == ''){
					layer.msg("请选择需要绑定的活动!");
					return false;
				}
				$.ajax({
					type:"post",
					url:"member/setActivity",
					dataType:"json",
					data:{id:ids,
						memberId:memberId	
					},
					success:function(data){
						if(data.flag){
						  	layer.msg(data.msg);
							goFresh("member");
						}else{
							layer.msg(data.msg);
						}
					}
				});
			});
		});
    </script>
</body>
</html>