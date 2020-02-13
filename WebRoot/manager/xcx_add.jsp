<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 11 Dec 2015 04:46:12 GMT -->
<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>小程序添加</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
	                    <form method="post" class="form-horizontal" id="modularForm" >
	                    	<div class="form-group">
	                            <label class="col-sm-2 control-label">名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">appId</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="appid">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">appSecret</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="appSecret">
	                            </div>
	                        </div>
                        	<div>
                                  <button class="btn btn-primary" type="button" id="update_article">添加</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
</body>


</html>
<script >
	$(function(){
		$("#update_article").click(function(){
			//名称
			var name = $.trim($("input[name='name']").val());
			//appid
			var appid = $.trim($("input[name='appid']").val());
			//appSecret
			var appSecret = $.trim($("input[name='appSecret']").val());
			var flag = validate(name,"请输入名称",appid,"请输入appid",appSecret,"请输入appSecret");
			if(!flag){
				return;
			}
			$.ajax({
				url:"xcx",
				type:"post",
				data:{
					name: name,
					appid: appid,
					appSecret: appSecret
				},
				dataType:"json",
				success:function(data){
					//提示，关闭当前页面，刷新父页面
					layer.msg("添加成功",{time:1000},function(){
						parent.location.reload();
					});
				}
			});
		});
		function validate(date1,msg1,date2,msg2,date3,msg3){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}
			if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			if(date3==''){
				layer.msg(msg3);
				return false;
			}
			return true;
		}
		
	});
	
</script>