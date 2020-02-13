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
    <title>微信管理-设置</title>
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
                        <h5>微信管理-设置</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" action="wechart" class="form-horizontal" id="wechartForm">
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">AppId(应用ID)</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="appid" value="${config.appId }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">AppSecret(密钥)</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="appSecret" value="${config.appSecret }">
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                                  <button class="btn btn-primary" type="button" id="add_activity">确定</button>
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
		$("#add_activity").click(function(){
			var AppId = $.trim($("input[name='appid']").val());
			var AppSecret = $.trim($("input[name='appSecret']").val());
			if(AppId!=''){
				if(AppSecret!=''){
					$.ajax({
						url:"wechart/setparameter",
						type:"post",
						dataType:"json",
						data:{
							AppId:AppId,
							AppSecret:AppSecret
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
				}else{
					layer.msg("请输入AppSecret");
				}
			}else{
				layer.msg("请输入AppId");
			}
		});
	});
</script>