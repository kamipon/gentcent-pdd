<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
  <head>
  	<base href="<%=basePath%>">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script src="js/jquery.min63b9.js"></script>
	<script type="text/javascript" src="manager/js/layer/layer.js"></script>
  </head>
  <body style="text-align:center;top:" >
    <div class="input-box bordernone clearfix" style="margin-top: 8%;">
		<input id="phoneCode" name="phoneCode" class="fillyzm" style="width: 23%;height: 34px;" maxlength="6" placeholder="请输入动态码" value="" type="text">
		<input style="cursor:pointer;background-color: #18a689;color: rgb(255, 255, 255);width: 20%;height: 35px;border:0" value="获取动态码" onclick="allow(this);" type="button">
	</div>
	<div class="submit-btn">
		<input style="cursor:pointer; width: 20%;height: 35px;margin-top:10px;" value="验证" onclick="checkout();" type="button">
	</div>
  </body>
  <script>
  	//验证验证码是否正确
  	function checkout(){
  		var code = $("#phoneCode").val();
  		var openId = "${openId}".trim();
  		$.ajax({
	 		url:"user/validate",
	 		type:"post",
	 		data:{
	 			openId: openId,
	 			level: 2,
	 			code : code
	 		},
	 		dataType:"json",
	 		success:function(data){
	 			if(data.flag){
	 				if(data.message!=""&&data.message!=undefined){
			 			layer.alert(data.message,tozh_t2);
		 			}
	 			}else{
	 				if(data.message!=""&&data.message!=undefined){
		 				layer.alert(data.message);
		 			}
	 			}
	 		}
	 	});
  	}
  	//设置金额
  	function tozh_t2(){
  		//取父窗口元素
		$("#redpacktModel", window.parent.document).click();
  	}
  	//验证是否可以发送微信验证码
	function allow(a){
		$.ajax({
	 		url:"user/allow",
	 		type:"get",
	 		data:{
	 			userId: "${loginUser.username}",
	 			level: 2
	 		},
	 		dataType:"json",
	 		success:function(data){
	 			if(data.flag){
	 				if(data.message!=""){
			 				layer.alert(data.message, {time: 2000});
		 				}
	 				time(a);
	 			}else{
	 				if(data.message=="暂未绑定微信号!"){
		 				layer.alert(data.message,function(){
		 					window.location = "wxmodel_sms/binding";
		 				});
	 				}else{
		 				layer.alert(data.message);
	 				}
	 			}
	 		}
	 	});
	}
	//等待60s，可重新获取验证码
	var wait=60;
	var statu=true;
	function time(o) {
		if (wait == 0) {
			o.value="获取动态码";
			$(o).css("background-color","#18a689");
			wait =60;
			statu=true;
		} else {
			o.value=wait;
			$(o).css("background-color","#c2c2c2");
			wait--;
			statu=false;
			setTimeout(function() {
					time(o);
			},1000)
		}
		//不可点击
		if(!statu){
			$(o).attr("disabled", true);
			$(o).css("cursor","auto");
		}
		if(statu){
			$(o).attr("disabled", false);
			$(o).css("cursor","pointer");
		}
	}
	</script>
</html>
