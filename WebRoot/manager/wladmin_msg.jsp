<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
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
    <title>设置-客服电话</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
	
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>设置-客服电话</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" action="wechart" class="form-horizontal" id="wechartForm">
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">客服电话号：</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="msgphone" value="${loginUser.msgphone }">
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                                  <button class="btn btn-primary" type="button" id="add">确定</button>
                                  <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
</body>


</html>
<script >
	$(function(){
		$("#add").click(function(){
			var msgphone = $.trim($("input[name='msgphone']").val());
				$.ajax({
					url:"wladmin/msg",
					type:"post",
					dataType:"json",
					data:{
						msgphone:msgphone
					},
					success:function(res){
						if(res.flag){
							layer.msg("设置成功");
							window.location.reload();
						}else{
							layer.msg("设置失败");
						}
					}
				});
		});
	});
</script>