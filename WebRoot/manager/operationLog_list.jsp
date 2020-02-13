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
    <title>资金流水列表</title>
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
                        <h5>资金流水</h5>
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable">
	                            <thead>
	                                <tr>
	                                	<th><input type="checkbox" name="check_all" id="checkedAll"></th>
	                                    <th>操作用户</th>
                                    	<th>内容</th>
	                                    <th>操作时间</th>
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td><input type="checkbox" name="check_all" value="${items.id }"></td>
		                            		<td>
		                            			${items.userName}
		                            		</td>
		                            		<td>
		                            			${items.content}
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
		                                    <form id="paging" action="${pageContext.request.contextPath }/system_log" method="get">
		                                      <input type="hidden" name="terpoint" value="${terpoint.id }">
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
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript">
    	function delContent(id){
		    swal({
		        title: "您确定要删除这条信息吗",
		        text: "删除后将无法恢复，请谨慎操作！",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
			        document.form2.attributes["action"].value = "widget/" + id;
					document.form2.submit();
			        swal("删除成功！", "您已经永久删除了这条信息。", "success");
			        }
		    });
		}
		$(function(){
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