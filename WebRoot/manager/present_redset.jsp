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
    

    <title>贵金属交易系统 - 红包转账设置</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
	<script src="js/jquery.min63b9.js?v=2.1.4"></script>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
        	<jsp:include page="message.jsp"></jsp:include>
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>密码修改</h5>
                    </div>
                    <div class="ibox-content" style="background-color: white;padding: 20px 5px 20px;">
	                    <form action="present/upredset" name="form1" method="post" class="form-horizontal">
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>旧密码</label>
	                            <div class="col-sm-10">
	                               <input type="password" id="redpassword"  class="form-control"  placeholder="首次使用密码为登录密码" name="redpassword">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>新密码</label>
	                            <div class="col-sm-10">
	                                <input type="password" id="redpasswordnew"  class="form-control" placeholder="请输入新密码"  name="redpasswordnew">
	                            </div>
	                        </div>
                        	<div>
                                 <input type="submit" onclick="return old('${red.redpassword }')" class="btn btn-primary" value="提交" name="f42">
                            </div>
	                     </form>
	                     <iframe name="hidden_frame" id="hidden_frame" style="display: none" style="display:none"></iframe>
                    </div>
                    <jsp:include page="error_message.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript">
    	function old(oldpassword){
			var password=$('#redpassword').val();
			if(oldpassword!=password){
				alert("旧密码填写错误，请重新输入");
				return false;
			}else{
				return true;
			}
	    }
	</script>
</body>
</html>
