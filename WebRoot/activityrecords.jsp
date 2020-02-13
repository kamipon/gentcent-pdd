<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>活动列表</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">
		<meta http-equiv="x-dns-prefetch-control" content="on">
        <link rel="stylesheet" href="css/frozen.css">
        <link rel="stylesheet" type="text/css" href="css/mui.min.css">
        <link rel="stylesheet" href="css/demo.css">
        <link rel="stylesheet" type="text/css" href="css/weui.css" />
        <script src="js/zepto.min.js"></script>
        <script src="js/frozen.js"></script>
        <script type="text/javascript" src="js/mui.min.js"></script>
        <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">  
		<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
		<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<style type="text/css">
			.kele:before{ position: absolute; content: " "; border: transparent 14px solid; border-width: 13px 8px ; border-right-color: #CCC; top: 1px; left: -16px; height: 0; width: 0; }
			.kele{ position: relative; width: 40px; height: 28px; background: #dff0d8; border-radius: 5px;  margin: 9px; text-align: center; line-height: 28px; color: #999; font-size: 14px; border: 1px solid #CCC; }
			.kele:after{ position: absolute; content: " "; border: transparent 13px solid;  border-width:  12px 8px; border-right-color: #dff0d8; top: 2px; left: -15px; height: 0; width: 0; }
		</style>
	</head>
	<body style="background-color: #dff0d8">
		<div style="height:30px " class="kele"><a href="userCenter/center" >返回</a></div>
		<table  class="table" >
			<tr class="success">
				<th>商品</th>
				<th>当前价格</th>
				<th>状态</th>
				<th>参加时间</th>
			</tr>
			<c:forEach var="item" items="${list}">
				<tr style="border-bottom: solid 1px;" class="success" onclick="toKan('${item.id }')">
					<td>
						${item.commodity.name }
					</td>
					<td>
						${item.nowPrice }
					</td>
					<td>
						<c:if test="${item.state==0}"><font style="color:red">正在砍价</font></c:if>
						<c:if test="${item.state==1}"><font style="color:green">砍价成功</font></c:if>
						<c:if test="${item.state==2}"><font>已失效</font></c:if>
						<c:if test="${item.state==3}"><font>已收货</font></c:if>
					</td>
					<td><fmt:formatDate type="date" value="${item.createDate }"/></td>
				</tr>
			</c:forEach>	
		</table>
	</body>
	<script type="text/javascript">
		function toKan(id){
			window.location.href = "${cp}/kj/"+id;
		}
	</script>
</html>
