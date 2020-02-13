<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="css/frozen.css">
  	<link rel="stylesheet" href="css/demo.css">
	<link href="css/2.css" rel="stylesheet" type="text/css">
	<link href="css/3.css" rel="stylesheet" type="text/css">
	<link href="css/item1.css" rel="stylesheet" type="text/css">
	<link href="css/item2.css" rel="stylesheet" type="text/css">
	<script src="js/zepto.min.js"></script>
    <script src="js/frozen.js"></script>
    <style type="text/css">
    	#js_content img{
    		width: 100%;
    	}
    </style>
  </head>
  
  <body>
  		<div id="cur2" style="display:block; margin:10px 0;">
		 	<div class="rich_media_inner">
				<div id="page-content">
					<div id="img-content" class="rich_media_area_primary">
						<%-- 正文 --%>
						<div id="js_content" name="content">
							${item.content }
						</div>
			 		</div>
			 	</div>
			</div>
		</div>
		<section class="ui-container">
			<section id="dialog">
				<div class="demo-item" >
					<div class="demo-block">
						<div class="ui-dialog" id="dialog-2">  
					  		<div class="ui-dialog-cnt" style="background-color: #FFFFFF;" >
							    <div class="ui-dialog-bd">
							    	<div style="text-align: right;"><a onclick="hideDiv('dialog-2')">&#215;</a></div>
					                <h3><font color="red"  size="5"><img src="images/red_over.png"/></font></h3>
						            <font size="4">
						            <c:if test="${time=='chongfu'}">
						            	不能重复领取~
						            </c:if>
						            <c:if test="${time=='guangle'}">
					            		红包被抢光了~
					            	</c:if>
					           	    <c:if test="${time=='jihuo'}">
					           	    	该红包未激活~
					            	</c:if>
					            	<c:if test="${time=='no'}">
					           	    	活动不存在~
					            	</c:if>
					            	 <c:if test="${time=='guanbi'}">
					           	    	活动已结束~
					            	</c:if>
						            </font></font><br /><br />
							    </div>
					  	 	</div>
					  	 </div>
					</div>
				</div>
			</section>
        </section>
  </body>	
	<script type="text/javascript">
		$("#dialog-2").dialog("show");
		function hideDiv(id){
			$("#"+id).dialog("hide");
		}
		function tiao(){
			location.href = "${guanggao}";
		}
		setTimeout("tiao()",1000);
	</script>
</html>
