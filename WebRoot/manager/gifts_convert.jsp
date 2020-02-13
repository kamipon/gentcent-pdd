<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html id="all">
<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<meta name="viewport" content="width=750,user-scalable=no">
		<!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
		<meta content="telephone=no" name="format-detection">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-touch-fullscreen" content="yes">
		<meta name="full-screen" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">

		<link rel="stylesheet" type="text/css" href="css/css/reset.css">
		<link rel="stylesheet" type="text/css" href="css/css/basic.css">
		<link rel="stylesheet" type="text/css" href="css/css/swiper.css">
		<link rel="stylesheet" type="text/css" href="css/css/layer.css">
		<link rel="stylesheet" type="text/css" href="css/css/mall-index.css">
		
		<script type="text/javascript" src="manager/js/js1/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="manager/js/js1/swiper.js"></script>
		<script type="text/javascript" src="manager/js/js1/util.js"></script>
		<!-- 积分商城api -->
		<script type="text/javascript" src="manager/js/js1/jfMall-host.js"></script>
		<script type="text/javascript" src="manager/js/js1/jfMall-1.0.0.js"></script>
		<script type="text/javascript" src="manager/js/js1/jfMall-utils-1.0.0.js"></script>
		<title>积分商城</title>
		<script type="text/javascript"></script>
</head>
	<body marginwidth="0" marginheight="0" >
		<input type="hidden" id="jfMallId" value="95">
		<div class="container" style="overflow: visible;">			
			<section class="con mall-index" style="transform: scale(0.426667, 0.426667); transform-origin: 0px 0px 0px; width: 750px; overflow: scroll; min-height: 1265.63px; id="ma">
				<div class="top-bar" >
					<div class="bar-bar__name">
						<img class="top-bar__name--img" src="${member.picUrl }" width="82">
						<span class="top-bar__name--txt">${member.nick }</span>	
					</div>
					<div class="top-bar__integral">
						<span class="top-bar__integral--num">
							<c:choose>
								<c:when test="${jifen>0}">积分： ${jifen }分</c:when>
								<c:otherwise>积分： 0分</c:otherwise>
							</c:choose>
						</span>
					</div>
				</div>
				<div class="mall-convert">
					<div class="convert-hd">
						<em class="iconfont"></em><h3 class="tit">热门兑换</h3>
					</div>
				</div>
				
				<div class="mall-convert template-demo none" style="display: block;">
					<div class="convert-bd">
						<div class="convert-bd__list clearfix" style="overflow:hidden;">
							<ul id="paiming">
							 	 <!-- 商品列表 -->
							 	 <c:forEach items="${list}" var="items">
							 	 	<li><a href="giftsConvert/desc/${items.id }">
											<img class="convert-bd__list--pic" src="${items.imgUrl }">
											<span class="convert-bd__list--state"  style="color:#be0000"><em>兑换</em></span>
										 </a>
										 <p class="convert-bd__list--name">${items.name}</p>
										 <p class="convert-bd__list--des">价值：${items.price} </p>
										 <div class="convert-bd__list--spend">
										 <div>剩余：<span>
										 	<c:choose>
										 		<c:when test="${items.inventory>0 }">${items.inventory }</c:when>
										 		<c:otherwise>0</c:otherwise>
										 	</c:choose>
										 		</span>件</div>
										 <strong class="spend-used">${items.integral}</strong>积分
										 </div>
										 
									</li>
							 	 </c:forEach>
							</ul>
						</div>
					</div>
				</div>
		</section>
		</div>
</body>
	<script type="text/javascript">
		var pageIndex = 1;
		var pageSize =20;
  		//滚动查询 
		function paiming(pageIndex,pageSize){
			$.ajax({
				url:"giftsConvert/paiming",
				type:"get",
				data:{
					pageIndex : pageIndex,
					pageSize : pageSize
				},
				dataType:"json",
				success:function(data){
					if(data.flag){
						var inventory =0;
						for(var i=0;i<data.list.length;i++){
							var inven = data.list[i].inventory;
						if(inven>0){
							inventory = inven
						}else {
							inventory= 0;
						}
						var li=	'<li><a'+' href="giftsConvert/desc/"'+data.list[i].id+'>'+
										'<img class="convert-bd__list--pic" src='+data.list[i].imgUrl+'>'+
										'<span class="convert-bd__list--state"><em>兑换</em></span>'+
									 '</a>'+
									 '<p class="convert-bd__list--name">'+data.list[i].name+'</p>'+
									 '<p class="convert-bd__list--des">价值：'+data.list[i].price +'</p>'+
									 '<div class="convert-bd__list--spend">'+
									 '<div>剩余：<span>'+inventory+'</span>件</div><strong class="spend-used">'+data.list[i].integral+'</strong>积分</div>'+
								'</li>';
						$("#paiming").append(li);
						}
					}
				}
			});
		}
		//监听滚动事件
		window.onscroll = function (){
	        var marginBot = 0;
	            var X=document.documentElement.scrollHeight;
	            var Y=document.documentElement.scrollTop+document.body.scrollTop;
	            var Z=document.documentElement.clientHeight;
	            marginBot=X-Y-Z;
	        if(marginBot<=1) {
	        	pageIndex++;
	       		paiming(pageIndex,pageSize);
	        }
    	} 
	</script>
</html>