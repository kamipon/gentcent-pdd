<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/ by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 11 Dec 2015 04:45:50 GMT -->
<head>
	<base href="<%=basePath%>">  
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>微信活动系统</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="<%=basePath%>css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element" style="width: 300px;">
                            <span id="info">
                            	<c:choose>
                            		<c:when test="${empty loginUser.picUrl}">
		                            	<img alt="image" class="img-circle" src="images/nohead.png"  style="height:68px ;width: 68px;"/>
                            		</c:when>
                            		<c:otherwise>
                            			<img alt="image" class="img-circle" src="${loginUser.picUrl }"  style="height:68px ;width: 68px;"/>
                            		</c:otherwise>
                            	</c:choose>
                            </span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#"">
                                <span class="clear">
                                <span class="text-muted text-xs block"><strong class="font-bold" >${loginUser.username }<b class="caret"></b></strong></span>
                                </span>
                            </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                            	<li><a class="J_menuItem" href="user/topersonal" id="logo">设置LOGO</a></li>
                                <li><a class="J_menuItem" href="manager/modify.jsp" id="mima">修改密码</a></li>
                                <li class="divider"></li>
                                <li><a href="user/logOut">安全退出</a>
                                </li>
                            </ul>
                        </div>
                        <div class="logo-element">
                        </div>
                    </li>
                     <erp:permissionTree var="tree" userId="${loginUser.id}">
                    	<c:forEach items="${tree}" var="item" varStatus="s">
                    		<!-- 一级菜单 -->
                    		<!-- 如果是控制台特殊设置 -->
                    		<c:if test="${item.name eq '控制台'}">
                    			<li>
			                        <a class="J_menuItem" href="visit/console">
			                            <i class="fa fa-home "></i>
			                            <span class="nav-label">控制台</span>
			                        </a>
			                    </li>
                    		</c:if>
                    		<c:if test="${item.name ne '控制台'}">
                    			<!-- 如果有子栏目 -->
                    			<c:if test="${item.isParent && item.type eq 'menu'}">
	                    			<li>
				                        <a href="${item.url }">
				                            <i class="fa ${item.leftCss } "></i>
				                            <span class="nav-label">${item.name }</span>
				                            <span class="fa ${item.rightCss }"></span>
				                        </a>
			                   	</c:if>    
			                   	<!-- 如果没有子栏目 -->
			                   	<c:if test="${!item.isParent && item.type eq 'menu'}">
	                    			<li>
				                        <a class="J_menuItem" href="${item.url }">
				                            <i class="fa ${item.leftCss } "></i>
				                            <span class="nav-label">${item.name }</span>
				                        </a>
			                        </li>
			                   	</c:if>      
		                        <!-- 二级菜单 -->
	                        	<c:forEach items="${item.children}" var="item2" varStatus="s2">
		                       		<c:if test="${item2.type eq 'menu'}">
				                        <ul class="nav nav-second-level">
				                            <li>
				                                <a class="J_menuItem" href="${item2.url }">${item2.name }</a>
				                            </li>
				                        </ul>
		                        	</c:if>
								</c:forEach>
                    		</c:if>
                    	</c:forEach>
                    </erp:permissionTree>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0;">
                    <div class="navbar-header">
                    	<a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="javascript:void(0)"><i class="fa fa-bars"></i> </a>
                    	<c:if test="${empty ter&&!empty activity}">
	                    	<div style="margin-top:18px;width: 100%">
	                    		<span id="toptip">
									<span id="ti_time_day" style="color:red;">1</span>天
									<span id="ti_time_hour" style="color:red;">23</span>小时
									<span id="ti_time_min" style="color:red;">59</span>分
									<span id="ti_time_sec" style="color:red;">59</span>秒
								</span>
								到期
	                    	</div>
                    	</c:if>
                    </div>
                    <div style="position:absolute;left:80%;top:10px">
                		<button class="btn btn-primary" type="button"  onclick="tologo()">设置logo</button>
						<button class="btn btn-primary" type="button" onclick="tomima()" style="margin-right:20px;" >修改密码</button>
					</div>
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:void(0);" class="active J_menuTab" data-id="index_v1.html">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>
                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a>
                        </li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </div>
                <a href="user/logOut" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="visit/console" frameborder="0" data-id="index_v1.html" seamless>
                </iframe>
            </div><!--
            <div class="footer" align="center">
            	技术支持：武汉零久云科技有限责任公司
            </div>
        --></div>
        <!--右侧部分结束-->
        <!--右侧边栏开始-->
        <div id="right-sidebar">
        </div>
        <!--右侧边栏结束-->
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="js/plugins/layer/layer.min.js"></script>
    <script src="js/hplus.min1fc6.js?v=4.0.0"></script>
    <script type="text/javascript" src="js/contabs.min.js"></script>
    <script src="js/plugins/pace/pace.min.js"></script>
    <script type="text/javascript">
    	var remainingTime='${lastTime}';
		if(remainingTime<0){
			$(document).ready(function(){
				$("#toptip").html("账户到期");
			});
		}else{
			function countDown(){
			    var nRT =remainingTime;
			    var nd=Math.floor((nRT/(1000*60*60)) / 24);
			    var nH=Math.floor(nRT/(1000*60*60)) % 24;
			    var nM=Math.floor(nRT/(1000*60)) % 60;
			    var nS=Math.floor(nRT/1000) % 60;
			    document.getElementById("ti_time_day").innerHTML=nd;
			    document.getElementById("ti_time_hour").innerHTML=nH;
			    document.getElementById("ti_time_min").innerHTML=nM;
			    document.getElementById("ti_time_sec").innerHTML=nS;
			    remainingTime-=1000;
			    setTimeout("countDown()",1000);
			}
			countDown();
		}
		function tologo(){
			$("#logo").click();
		}
		function tomima(){
			$("#mima").click();
		}
    </script>
</body>
</html>