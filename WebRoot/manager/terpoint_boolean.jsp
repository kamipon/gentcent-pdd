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
    <title>电子二维码</title>
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

                    <div class="ibox-content">
						<div id="ibox-content" >
							<form action="${pageContext.request.contextPath }/user" method="get">
							<input type="hidden" value="${param.id}" name="id"/>
							<div class="row">
								<div class="form-group">
		                            <label class="col-sm-2 control-label"><font color="red">*</font>是否开启电子二维码</label>
	                                <input type="radio" name="boolean" value="1">是
	                                <input type="radio" name="boolean" value="0" checked="checked">否
                       		 	</div>
							<div>
								<button class="btn btn-primary" type="button" id="add_terpoint">设置</button>
	                        </div>
						</div>
	                     
                       
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    	$(function(){
		$("#add_terpoint").click(function(){
			var id = $.trim($("input[name='id']").val());
			//选中状态
			var boolean = $.trim($("input[name='boolean']:checked").val());
			
				$.ajax({
					url:"terPoint/boolean",
					type:"get",
					data:{
						boolean:boolean,
						id:id
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("terPoint");
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