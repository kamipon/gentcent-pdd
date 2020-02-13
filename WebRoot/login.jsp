<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 11 Dec 2015 04:46:12 GMT -->
<head>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <title>  登录</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">

    <link href="css/animate.min.css" rel="stylesheet">
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet"><base target="_blank">
    <script src="js/layer/layer.js"></script>
    <!--<link rel="stylesheet" type="text/css" href="css/css/layer.css">-->
    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
</head>

<script type="text/javascript">
	if("${param.message}") {
		alert("${param.message}");
	}
</script>

<body class="gray-bg">
    <jsp:include page="message_alert.jsp"></jsp:include>
    <div class="middle-box text-center loginscreen  animated fadeInDown">
        <div style="height: 150px">

<!--                <img src="images/tuike.png" width="300px" height="150px">-->
            </div>
            <h3>欢迎登录</h3>
            <form id="umerchantForm" class="m-t" role="form" action="user/login" method="post" target="_top">
                <div class="form-group">
                    <input id="username" class="form-control" placeholder="用户名" name="username" value="${username }" required="">
                </div>
                <div class="form-group">
                    <input id="password" type="password" class="form-control" placeholder="密码" name="password" value="${password }" required="">
                </div>
                
<!--                <div id="dongtaima" class="row" >-->
<!--                	<div class="form-inline">-->
<!--						<input style="width:175px;" class="form-control" id="phoneCode" name="phoneCode" maxlength="4" placeholder="请输入动态码" value="" type="text">-->
<!--						<input style="cursor:pointer;background-color: #18a689;color: rgb(255, 255, 255);width: 35%;height: 35px;border:0;" value="获取动态码" onclick="allow(this);" type="button">-->
<!--					</div>-->
<!--				</div>-->
                <input style="margin-top: 5px;" id="denglu" type="submit" class="btn btn-primary block full-width m-b" value="登陆">
                <!--<input type="button" onclick="RedPacket();" class="btn btn-primary block full-width m-b" value="注册">-->
            </form>
        </div>
        <div style="width: 100%;text-align: center;">
     	   <span style="margin-left: auto;color:red">保证功能正常使用，请使用谷歌、火狐或者IE9以上浏览器</span>
        </div>
    </div>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    function RedPacket(){
		 	layer.open({
			type: 2,
			title: '账号注册',
			shadeClose: true,
			shade: 0.8,
			area: ['1000px', '50%'],
			content: 'register.jsp'
		});		
	}
	$(function (){
		//隐藏动态码框
		$("#dongtaima").hide();
		isShow();
		//判断账号输入后是否显示动态码框
		$("#username").change(isShow);
		$("#denglu").click(function(){
			// 变量定义
			var formId = $("#umerchantForm");
			var phoneCodeLength = $("#phoneCode").val().length;
			var phoneCodeValue = $("#phoneCode").val();
			// 微信验证码校验
			if(!$("#dongtaima").is(':hidden')){
				if(phoneCodeLength == 0 && phoneCodeValue == "") {
					layer.tips("请输入动态码！", '#phoneCode', {
						tips: [1, '#1AB394'] //还可配置颜色
					});
					return false;
				}
			}
			formId.submit();
		});
	});
	
	//验证是否可以发送动态码
	function allow(a){
		var accountValue = $("#username").val();
		var passwordValue = $("#password").val();
		$.ajax({
		 		url:"user/allow",
		 		type:"get",
		 		data:{
		 			userId: accountValue,
		 			level: 1,
		 			userPwd : passwordValue
		 		},
		 		dataType:"json",
		 		success:function(data){
		 			if(data.flag){
		 				if(data.message!=""){
			 				layer.alert(data.message, {time: 2000});
		 				}
		 				time(a);
		 			}else{
		 				if(data.message!=""){
			 				layer.alert(data.message, {time: 2000});
		 				}
		 			}
		 		}
		 	});
	}
	//是否显示动态码框
	function isShow(){
		var accountValue = $.trim($("#username").val());
		if(""==accountValue){
			$("#dongtaima").hide();
			return ;
		}
		$.ajax({
		 		url:"user/isShow",
		 		type:"get",
		 		data:{
		 			userId: accountValue,
		 		},
		 		dataType:"json",
		 		success:function(data){
		 			if(data.flag){
		 				$("#dongtaima").show();
		 			}else{
		 				$("#dongtaima").hide();
		 			}
		 		}
		 	});
	}
	//等待60，可重新获取验证码
	var wait=60;
	var statu=true;
	function time(o) {
		if (wait == 0) {
			o.value="获取验证码";
			$(o).css("background-color","#18a689");
			wait =60;
			statu=true;
		} else {
			o.value=wait;
			$(o).css("background-color","#c2c2c2");
			wait--;
			statu=false;
			setTimeout(function() {
					time(o)
			},1000)
		}
		//不可点击
		if(!statu){
			$(o).attr("disabled", true);
			$(o).css("cursor","auto");
		}else{
			$(o).attr("disabled", false);
			$(o).css("cursor","pointer");
		}
	}
	</script>
</body>
</html>