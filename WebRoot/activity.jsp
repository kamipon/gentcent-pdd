<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

		<title>${item.name }</title>
	</head>
	<body>
<!--		<iframe src="${item.url }" width="100%" height="100%" scrolling="auto"></iframe>-->
	</body>
	<script type="text/javascript">
		window.location.href="${item.url }";
	</script>
</html>
