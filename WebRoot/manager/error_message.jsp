<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script type="text/javascript" src="manager/js/CJL.0.1.min.js"></script>
	<script type="text/javascript" src="manager/js/AlertBox.js"></script>
	
	<style>
	.lightbox{width:300px;background:#FFFFFF;border:5px solid #ccc;line-height:20px;display:none; margin:0;}
	.lightbox dt{background:#f4f4f4;padding:5px;}
	.lightbox dd{ padding:20px; margin:0;}
	</style>

<dl id="box" class="lightbox" style="top:10%;left:5%;">
	<dt><b>提示</b> </dt>
	<dd>
		<span id="message">${message }</span><br/><br/>
		<input type="button" value="确定" id="cancel" />
	</dd>
</dl>


<script type="text/javascript">
	$(document).ready(function(){
		var message = $('#message').html();
		var ab = new AlertBox("box"), lock = false;

		ab.onShow = function(){
			if ( lock ) {
				$$E.addEvent( document, "keydown", lockup );
				$$E.addEvent( this.box, "keydown", lockout );
				OverLay.show();
			}
		}
		ab.onClose = function(){
			$$E.removeEvent( document, "keydown", lockup );
			$$E.removeEvent( this.box, "keydown", lockout );
			OverLay.close();
		}
		
		//设置遮罩层是否居中
		ab.center = true;
		//设置遮罩层位置是否固定
		ab.fixed = true;
		//锁定键盘
		function lockup(e){ e.preventDefault(); }
		//高亮层不锁定
		function lockout(e){ e.stopPropagation(); }
		//点击弹出遮罩层，设置屏幕锁定
		if(message != ""){
			lock=true;
			ab.show();
		}
		//点击关闭遮罩层，设置屏幕不锁定
		$('#cancel').click(function(){
			lock = false;
			ab.close();
		})
	})
</script>
<%
	request.getSession().removeAttribute("message");
%>

