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
    <title>模板列表</title>
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
                        <h5>模板列表</h5>
                        <div class="ibox-tools">
                       		<span class="glyphicon glyphicon-plus"></span> 
                            <a class="J_menuItem" href="manager/content_add.jsp">模板添加</a>
                        </div>                     
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/user" method="get">
								<div class="row">
									
                 				  </form>
								</div>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead class="pn-lthead">
	                                <tr>
	                                    <th>标题</th>
                                    	<th>操作</th>	                                   
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			<a class="J_menuItem" href="content/query?id=${items.id}">${items.title }</a>
		                            		</td>
		                            		<!--<td>
		                            			<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd"	type="both" />
		                            		</td>
		                            		-->
		                            		
		                            		<td>
		                            			<a href="javascript:void(0);" onclick="del('${items.id}')">删除</a>|
		                                		<a class="J_menuItem" href="content/${items.id}">修改模板</a>|
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
		                                    <form id="paging" action="activity" method="get">

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
		        title: "您确定要删除这条模板吗",
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
						url:"content/"+id,
						data:{_method:"delete"},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"删除成功！", text:"您已经永久删除这条模板。", type:"success"},function(){
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
		function setRedPacket(id,num){
		    		layer.open({
						type: 2,
						title: '增加红包',
						shadeClose: true,
						shade: 0.8,
						area: ['1500px', '50%'],
						content: 'manager/redpacket_num.jsp?id='+id+'&num='+num
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
			//删除
			$("#delete").click(function(){
				var ids = "";
				$("#idsVal").find("input[name='check_all']:checked").each(function(){
					ids += $.trim($(this).val())+",";
				});
				if(ids == ''){
					layer.msg("请选择需要删除的记录!");
					return false;
				}
				$.ajax({
					type:"post",
					url:"${cp}/template/template_delete",
					dataType:"json",
					data:{id:ids},
					success:function(data){
						if(data.flag){
						  	layer.msg(data.msg);
							location.reload();
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