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
    <title>微信管理-授权</title>
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
                        <h5>公众号授权</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="list-group">
                        	<a class="list-group-item" href="javascript:void(0)">
								<h3 class="list-group-item-heading">公众号授权的用途:</h3>
								<p class="list-group-item-text">
									<ul class="unstyled">
										<li>1、公众号授权之后，用户帖子被回复的时候，系统会通过您的公众号自动给用户推送一个提醒消息。这样的话，可以增加用户回流到您的公众号。</li>
										<li>2、公众号授权之后，可以应用引导关注。即帖子分享到朋友圈或微信群，帖子详情页面展示二维码，帮助公众号吸粉涨粉。了解公众号吸粉</li>
										<li>3、公众号授权之后，可以应用强制关注参数。即用户只有关注公众号的情况下，才能发帖，回复，点赞。了解强制关注</li>
									</ul>
								</p>
							</a>
							<a class="list-group-item" href="javascript:void(0)">
								<h3 class="list-group-item-heading">限制条件:</h3>
								<p class="list-group-item-text">
									<ul class="unstyled">
										<li style="color: red">1、仅支持认证的服务号：由于我们是通过客服消息接口来实现这个功能，订阅号、未认证服务号没有客服消息接口的权限，这是微信平台的限制规则。所以订阅号和未认证的服务号，建议不要公众号授权。</li>
										<li>2、用户必须关注公众号：用户如果没有关注您的公众号，则无法给用户推送消息。</li>
										<li>3、48小时内有效：客服消息接口有48个小时的限制，所以当用户从公众号菜单进入到社区发帖，管理员需要在48个小时之内回复，系统才能够推送消息。</li>
										<li>4、回复自己的帖子，不会推送提醒消息。</li>
									</ul>
								</p>
							</a>
							<a class="list-group-item" href="javascript:void(0)">
								<h3 class="list-group-item-heading">关于安全性:</h3>
								<p class="list-group-item-text">
									<ul class="unstyled">
										<li>授权操作是跳转到微信开放平台完成，在微信提供的页面登录授权，这样可以确保公众号的信息安全，您可以放心登录并授权。如果授权之后，您觉得不适用，可以登录到微信公众号后台取消授权。</li>
									</ul>
								</p>
							</a>
							<a class="list-group-item" href="javascript:void(0)">
								<h3 class="list-group-item-heading">关于授权给多个第三方:</h3>
								<p class="list-group-item-text">
									<ul class="unstyled">
										<li>所申请的权限集是可以授权给多个第三方平台方，即授权不互斥，不会与其他第三方有冲突。</li>
									</ul>
								</p>
							</a>
							<a class="list-group-item" href="javascript:void(0)">
								<h3 class="list-group-item-heading">如何取消授权？</h3>
								<p class="list-group-item-text">
									<ul class="unstyled">
										<li>公众号管理后台 >> 添加功能插件 >> 授权管理</li>
									</ul>
								</p>
							</a>
							<a class="list-group-item" href="javascript:void(0)">
								<p>
									<a class="btn btn-w-m btn-primary" href="javascript:void(0)" onclick="toAuth();">微信公众号登录授权</a>
								</p>
							</a>
                        </div>
                    </div>
                </div>
            </div>
		</div>
    </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
</body>
</html>
<script>
	function toAuth(){
		$.ajax({
			url:"wechart/isauth",
			type:"get",
			dataType:"json",
			success:function(res){
				if(res){
					window.location.reload();
				}else{
					window.open("https://mp.weixin.qq.com/cgi-bin/componentloginpage?component_appid=${component_appid }&pre_auth_code=${pre_auth_code }&redirect_uri=${redirect_uri }");
				}
			}
		});
	}
</script>