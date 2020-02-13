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
    <title>小程序列表</title>
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
                        <h5>小程序列表</h5>
                        <div class="ibox-tools">
                        	<span class="glyphicon glyphicon-plus"></span> 
                            <a class="J_menuItem" onclick="toadd();">小程序添加</a>
                        </div>
                    </div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable">
	                            <thead>
	                                <tr>
	                                    <th>名称</th>
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
		                            			<button class="btn btn-primary" type="button" onclick="change('${items.id }')"><c:if test="${items.isKai==1 }">关闭</c:if><c:if test="${items.isKai==2 }">开启</c:if></button>
		                            			<button class="btn btn-primary" type="button" onclick="delContent('${items.id }')">删除</button>
		                            		</td>
	                            		</tr>
	                            	</c:forEach>
	                            </tbody>
	                        </table>
                    </div>
                </div>
            </div>
        </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    	function delContent(id){
		    swal({
		        title: "您确定要删除这个小程序吗",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
		    		$.ajax({
						url:"xcx/delete",
						type:"post",
						data:{id: id},
						dataType:"json",
						success:function(data){
							swal({title:"删除成功！", text:"已从小程序列表中删除", type:"success"},function(){
								window.location.reload();
							});
						}
					});
			    }
		    });
		}
		function change(id){
			$.ajax({
					url:"xcx",
					type:"post",
					data:{id: id,_method:"put"},
					dataType:"json",
					success:function(data){
						if(data.type=="2"){
							layer.msg("小程序已关闭");
							setTimeout("location.reload()",1000);
						}else{
							layer.msg("小程序已开启");
							setTimeout("location.reload()",1000);
						}
					}
				});
		}
		
		function toadd(){
			layer.open({
				type: 2,
				title: '添加小程序',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'manager/xcx_add.jsp'
			});	
		}
    </script>
</body>
</html>