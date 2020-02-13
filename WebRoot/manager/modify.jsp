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
    

    <title>11cms系统</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
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
                    <div class="ibox-title">
                        <h5>密码修改</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" name="form1" class="form-horizontal">
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>原始密码</label>
	                            <div class="col-sm-10">
	                               <input type="password" id="oldpassword"  class="form-control"  placeholder="请输入原始密码" name="oldpassword">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>新密码</label>
	                            <div class="col-sm-10">
	                                <input type="password" id="newpassword"  class="form-control" placeholder="请输入新密码"  name="newpassword">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>重复密码</label>
	                            <div class="col-sm-10">
	                                <input type="password" id="replypassword" class="form-control"  placeholder="请重复输入密码" name="replypassword">
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                                 <input type="button" class="btn btn-primary"  id="update_password"  value="修改" >
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
</body>
<script type="text/javascript">
		$(function(){
			$("#update_password").click(function(){
			//原始密码
			var oldpassword = $.trim($("#oldpassword").val());
			//新密码
			var newpassword = $.trim($("#newpassword").val());
			if($('#oldpassword').val()!=""){
	       			if($('#newpassword').val()!=""){
	       				if($('#replypassword').val()!=""){
	       					if($('#newpassword').val()==$('#replypassword').val()){
	       						$.ajax({
										type:"post",
										url:"${cp}/user/modifyPs",
										dataType:"json",
										data:{oldpassword:oldpassword,newpassword:newpassword},
										success:function(data){
											if(data.flag){
												layer.msg(data.msg);
											}else{
												layer.msg(data.msg);
											}
										}
									});		 
	       					}else{
	       						layer.msg("两次密码不一致");
	       					}
	       				}else{
	       					layer.msg("请重复密码");
	       				}
	       			}else{
	       				layer.msg("请输入新密码");
	       			}
	       		}else{
	       			layer.msg("请输入旧密码");
	       			
	       		}
			});
		});
</script>
</html>
