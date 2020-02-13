<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
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


</head>
	<h1 style="text-align:center">
	    <span style="font-family:宋体">红包派开放平台使用文档</span>
	</h1>
	<p style="text-align: center;">
	    <span style="font-family:宋体">通过红包派开放功能进行在线自动发红包的方式，实现起来非常简单，只需要在</span>html<span style="font-family:宋体">界面加入几行代码就可以实现。</span>
	</p>
	<h2 style="text-align: center;">
	    <span style="font-family:黑体">代码示例：</span>
	</h2>
	<h2 style="text-align: center;">
	    <br/><span style="font-family:黑体"></span><img src="images/explain1.png" title="1.png" alt="1.png"/>
	</h2>
	<h2 style="text-align: center;">
	    <br/>
	</h2>
	<h2 style="text-align: center;">
	    <span style="font-family:黑体">后台配置：</span>
	</h2>
	<p style="text-align: center;">
	    <img src="images/explain2.png" title="2.png" alt="2.png"/>
	</p>
	<h2 style="text-align: center;">
	    <span style="font-family:黑体">参数说明：</span>
	</h2>
	<p style="text-align: center;">
	    packet.init:<span style="font-family: 宋体">初始化红包对象，</span>appid<span style="font-family:宋体">和</span>appsecret<span style="font-family:宋体">在商家后台查看</span>
	</p>
	<p style="text-align: center;">
	    packet.debug:<span style="font-family: 宋体">页面开启调试模式，开启后页面会以</span>alert<span style="font-family:宋体">弹出调用结果</span>
	</p>
	<p style="text-align: center;">
	    packet.reader:<span style="font-family:宋体">将红包二维码渲染到</span>div<span style="font-family:宋体">上，这里的参数是</span>div<span style="font-family:宋体">的</span>id
	</p>
	<p style="text-align: center;">
	    &nbsp;
	</p>
	<h2 style="text-align: center;">
	    <span style="font-family:黑体">注意：</span>
	</h2>
	<p style="margin-left: 0px; text-indent: 28px; text-align: center;">
	    1.<span style="font-family: 宋体">执行</span>packet.reader<span style="font-family:宋体">后，领取红包的二维码将直接显示出来，这里应该在领取事件达成时调用，比如支付成功后的通知页面，或者抽奖成功后的提示界面上。</span>
	</p>
	<p style="margin-left: 0px; text-indent: 28px; text-align: center;">
	    2.<span style="font-family: 宋体">只要执行</span>packet.reader<span style="font-family:宋体">后，该二维码将冻结，方便给用户领取的缓冲。如果用户一定时间不领取，这个二维码将解冻，可以<a></a>被其他用户获取。（目前冻结时间为</span>1<span style="font-family:宋体">小时）</span>
	</p>
	<p>
	    <br/>
	</p>
</body>
</html>
