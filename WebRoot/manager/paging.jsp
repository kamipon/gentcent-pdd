<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="text-align: center;">
	<div style="height: 28px;line-height: 22px;text-align: center;font-size: 12px;">
	共 ${total } 条  页次:<font color="red"> ${pageIndex }</font>/${totalPage }页  每页${pageSize } 条 
 			<c:choose>
 				<c:when test="${pageIndex==1}">
 					首页
 				</c:when>
 				<c:otherwise>
 					<a style="" href='javascript:gotoPage2(1)'>首页</a>
 				</c:otherwise>
 			</c:choose>
 			<c:choose>
 				<c:when test="${pageIndex-1>0}">
 					<a style="" href='javascript:gotoPage2(${pageIndex-1 })'>上一页</a> 
 				</c:when>
 				<c:otherwise>
 					上一页 
 				</c:otherwise>
 			</c:choose>
 			<c:choose>
 				<c:when test="${pageIndex+1<=totalPage}">
			<a style="" href='javascript:gotoPage2(${pageIndex+1 })'>下一页</a>  
 				</c:when>
 				<c:otherwise>
 					下一页 
 				</c:otherwise>
 			</c:choose>
 			<c:choose>
 				<c:when test="${pageIndex==totalPage}">
			尾页
 				</c:when>
 				<c:otherwise>
			<a style="" href='javascript:gotoPage2(${totalPage})'>尾页</a> 
 				</c:otherwise>
 			</c:choose>
 		<input type="hidden" value=${totalPage } id="vtotalPage">
		<input type="hidden" value=${pageSize } name="pageSize">
		<input id="pageIndex" type="hidden" name="pageIndex" value=1/>
	转到：<input id="vpageIndex" type='text' style="width:30px;"/>
		
		<a href="javascript:void(0)" onclick="gotoPage()" id="submitPage">确定</a>
	</div>
</div>
<script src="js/jquery.min63b9.js?v=2.1.4"></script>
<script src="js/layer/layer.js"></script>
<script type="text/javascript">
	 $('#vpageIndex').bind('keydown', function(event) {
        if (event.keyCode == "13") {
            $('#submitPage').click();
        }
    });
	var gotoPage=function(){
		var pageIndex=parseInt(document.getElementById('vpageIndex').value);
		if(isNaN(pageIndex)){
			layer.msg("请输入数字");
			return;
		}else if(pageIndex>parseInt(document.getElementById('vtotalPage').value)||pageIndex<1){
			layer.msg("无此页");
			return;
		}
		document.getElementById("pageIndex").value=pageIndex;
		document.getElementById("paging").submit();
	}
	function gotoPage2(num){
		var pageIndex=num;
		document.getElementById("pageIndex").value=pageIndex;
		document.getElementById("paging").submit();
	}
</script>