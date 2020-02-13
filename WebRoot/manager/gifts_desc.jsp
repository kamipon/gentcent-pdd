<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<!--声明文档兼容模式，表示使用IE浏览器的最新模式-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<!--设置视口的宽度(值为设备的理想宽度)，页面初始缩放值<理想宽度/可见宽度>-->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
		<title>商品介绍</title>
		<!-- 引入Bootstrap核心样式文件 -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link rel="shortcut icon" href="favicon.ico"> 
	    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
	    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
	    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
	    <link href="css/animate.min.css" rel="stylesheet">
	    <link href="css/style.min1fc6.css" rel="stylesheet">
	    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
	</head>

	<body>
		<div class="container-fluid">
			<div class="col-xs-13 col-sm-13">
				<img src="${gifts.imgUrl }"  style="width:100%;height:250px"/>
			</div>
			<br />
			<div class="col-xs-13 col-sm-13">
				<h3>${gifts.name }</h3>
			</div>
			<br />
			<div class="col-xs-13 col-sm-13">
				兑换方式:&nbsp;<span>积分兑换</span>
			</div>
			<br />
			<div class="col-xs-13 col-sm-13">
				消耗积分:&nbsp;<span>${gifts.integral }积分</span>
			</div>
			<br />
			<div class="col-xs-13 col-sm-13">
				价值:&nbsp;<span>${gifts.price }</span>
			</div>
			<br />
			<div class="col-xs-13 col-sm-13">
				<c:choose>
					<c:when test="${gifts.inventory>0}">
						库存数量:&nbsp;<span>${gifts.inventory }份</span>
					</c:when>
					<c:otherwise>
						库存数量:&nbsp;<span>0份</span>
					</c:otherwise>
				</c:choose>
			</div>
			<br />
			<div class="col-xs-13 col-sm-13">
				<h4><em>奖品介绍</em></h4>
			</div>
			<hr />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${gifts.desc }
		</div>
			<button onclick="convert('${gifts.id }');" type="button" class="btn btn-primary btn-lg btn-block" 
			style="background-color: #ff9a36;border-color:#ff9a36;position: fixed; bottom: 0;left: 0;">立即兑换</button>
		<!-- 引入jQuery核心js文件 -->
		<script src="manager/js/js1/jquery-1.11.3.min.js"></script>
		<!-- 引入BootStrap核心js文件 -->
		<script src="manager/js/js1/bootstrap.min.js"></script>
		 <script src="js/jquery.min63b9.js?v=2.1.4"></script>
		<script type="text/javascript" src="js/childrenToMenu.js"></script>
	    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
	    <script src="js/layer/layer.js"></script>
		<script type="text/javascript">
			function convert(id){
		    swal({
		        title: "您确定要兑换该商品吗",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "兑换",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
		    		$.ajax({
						url:'giftsConvert/add',
						type:"post",
						data:{gid : id},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:data.msg, type:"success"},function(){
									location.href = "giftsConvert/"+data.id;
								});
							}else{
								swal({title:data.msg, type:"error"},function(){});
							}
						}
					});
			    }
		    });
		}
		</script>
	</body>
	
</html>