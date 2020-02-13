<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>


<head>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <title>注册</title>

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <script src="${cp}/js/f.js" type="text/javascript"></script>
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
     <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
	
</head>

<body class="gray-bg">
<jsp:include page="message_alert.jsp"></jsp:include>
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>注册</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>手机号</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="phone">
	                            </div>
	                        </div> 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>请输入密码</label>
	                            <div class="col-sm-10">
	                                <input type="password" class="form-control" name="password">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>重复密码</label>
	                            <div class="col-sm-10">
	                                <input type="password" class="form-control" name="password2">
	                            </div>
	                        </div>
	                        <div class="form-group">
								<label class="col-sm-2 control-label"><font color="red">*</font>验证码</label>
								<div class="col-sm-10">
									<input type="text" calss="form-control" maxlength="4" name="captcha" id="captcha" style="height: 34px;">
									<img id="captchaImg" class="validateCodeImg" onclick="changeCaptcha('captchaImg');" title="看不清？换一张" src="${cp}/api/system/getCaptcha" style="cursor: pointer; height: 24px;margin-left: 42px;margin-top: 4px;">
								  </div>
							</div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_activity">注册</button>
	                            <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
	                        </div>
                         </form>
                        </div>
                       
                    </div>
                </div>
            </div>
    </div>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/content.mine209.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
     <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>

</body>
<script type="text/javascript">
	$(function(){
		$("#add_activity").click(function(){
			//联系方式
			var phone = $.trim($("input[name='phone']").val());
			//验证码
			var captcha = $.trim($("input[name='captcha']").val());
			//密码
			var password = $.trim($("input[name='password']").val());
			//密码2
			var password2 = $.trim($("input[name='password2']").val());
			var flag = validate(
				password,"请输入密码",
				phone,"请输入联系方式",
				password2,"请输入重复密码"
			); 
			if(flag){
				$.ajax({
					type:"post",
					url:"activity/register",
					data:{	
						phone:phone,
						captcha:captcha,
						password:password
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
						}else{
							layer.msg(data.msg);
						}
							parent.location.reload(); 
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4,date5,msg5,date6,msg6,date7,msg7,date8,msg8){
		var regMobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(!regMobile.test(date2)){
				layer.msg("请输入正确格式的手机号");
				return false;
			}else if(date3 == ''){
				layer.msg("请输入重复密码");
				return false;
			}else if(date3 !=date1){
				layer.msg("两次输入的密码不一致");
				return false;
			}
			return true;
		}
	});
   	function showImg(imgId){
		var ref=$("#"+imgId);
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(100);
			$(ref).width(100);
		});
	}
</script>
</html>
