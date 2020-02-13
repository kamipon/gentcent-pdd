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
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet"><base target="_blank">
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
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
        <div>

                <img src="images/logo.jpg" width="300px" height="150px">
            </div>
            <form class="m-t" role="form" action="recode" method="post" target="_top">
                <div class="form-group">
                    <input  class="form-control" placeholder="用户名" name="username" required="">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="密码" name="password" required="">
                </div>
                <input type="submit" class="btn btn-primary block full-width m-b" value="登陆">
            </form>
        </div>
    </div>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/layer/layer.js"></script>
</body>
</html>