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
    <meta name="referrer" content="never">
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
								<h3 class="list-group-item-heading">授权成功:</h3>
								<p class="list-group-item-text">
									<ul class="unstyled">
										<li>您的公众号授权成功，更多功能敬请期待。</li>
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
								<h3 class="list-group-item-heading" style="color:blue;">已经公众号授权</h3>
								<p class="list-group-item-text">
									<ul class="unstyled">
										<li>
											<label class="control-label" style="font-size:16px;">用户昵称:</label>
											<span class="control-label">${item.nickName }</span>
										</li>
										<li>
											<label class="control-label" style="font-size:16px;">公众号:</label>
											<span class="control-label">${item.alias }</span>
										</li>
										<li>
											<label class="control-label" style="font-size:16px;">授权状态:</label>
											<span class="control-label" style="color:red;">已授权</span>
										</li>
										<li>
											<label class="control-label" style="font-size:16px;">账号类型:</label>
											<c:choose>
												<c:when test="${item.serviceTypeInfo==2}">
													<span class="control-label">服务号</span>
												</c:when>
												<c:otherwise>
													<span class="control-label" style="color:red;">订阅号</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<label class="control-label" style="font-size:16px;">账号类型:</label>
											<c:choose>
												<c:when test="${item.verifyTypeInfo>=0}">
													<span class="control-label" style="color:blue;">已认证</span>
												</c:when>
												<c:otherwise>
													<span class="control-label" style="color:red;">未认证</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<label class="control-label" style="font-size:16px;">公众号id:</label>
											<span class="control-label">${item.userName }</span>
										</li>
										<li>
											<label class="control-label" style="font-size:16px;">二维码:</label>
											<span class="control-label"><img src="${item.qrcodeUrl }?wx_fmt=png" width="150" height="150"></span>
										</li>
									</ul>
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
<script >
</script>