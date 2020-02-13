<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>11cms系统-消息列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins" id="editable">
                	<input type="submit" class="btn btn-sm btn-primary" value="全选" id="checkedAll">
                	<input type="submit" class="btn btn-sm btn-primary" value="标记为已读" id="read">
                	<c:forEach items="${list}" var="items">
               			<c:if test="${items.isRead}">
                		<div class="faq-item" >
		                	<div class="row" >
		                   		<div class="col-md-6 form-inline">
			                		<input type="checkbox" name="check_all" value="${items.id }">
		                			<a class="faq-question" href = "${items.url }" style="color: #a0a0a0;margin-top: -24px;margin-left: 19px;">${items.title}</a>
		                   		</div>
		                   		<div class="col-md-5 text-right">
		                   			<span>发布时间:</span>
		                    		${items.addTime }
		                   		</div>
	                   		</div> 
                   		</div>    	
                        </c:if>
                        <c:if test="${!items.isRead}">
                		<div class="faq-item" >
		                	<div class="row" >
		                   		<div class="col-md-6 form-inline">
			                		<input type="checkbox" name="check_all" value="${items.id }">
		                			<a class="faq-question" href = "${items.url }" style="margin-top: -24px;margin-left: 19px;">${items.title}</a>
		                   		</div>
		                   		<div class="col-md-5 text-right">
		                   			<span>发布时间:</span>
		                    		${items.addTime }
		                   		</div>
	                   		</div> 
                   		</div>    	
                        </c:if>
                	</c:forEach>
	                    <div method="post" id="tableForm">
		                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                      <tbody>
		                          <tr>
		                              <td align="center" class="pn-sp">
		                                  <form id="paging" action="${pageContext.request.contextPath }/noticeUserList" method="get">
		                                    <input type="hidden" name="title" value="${title }">
		                                      <%@include file="paging.jsp" %>
		                                  </form>
		                              </td>
		                          </tr>
		                      </tbody>
		                  </table>
		              	</div>	
                    </div>
                </div>
            </div>
        </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    	$(function(){
			//全选		
			$("#checkedAll").click(function(){
				$("#editable").find(":checkbox").prop("checked",true);
			});
			$(".faq-question").click(function(){
				var noticeIds = $.trim($(this).prev().val());
				$.ajax({
					type:"post",
					url:"noticeUserList",
					dataType:"json",
					data:{
							'_method':'delete',
							noticeIds:noticeIds
						},
					success:function(data){
					}
				});
			});
			//标记为已读
			$("#read").click(function(){
				var noticeIds = "";
				$("#editable").find("input[name='check_all']:checked").each(function(){
					noticeIds += $.trim($(this).val())+",";
				});
				if(noticeIds == ''){
					layer.msg("请选择需要标记的消息!");
					return false;
				}
				$.ajax({
					type:"post",
					url:"noticeUserList",
					dataType:"json",
					data:{
							'_method':'delete',
							noticeIds:noticeIds
						},
					success:function(data){
						if(data.flag){
						  	//修改样式
							$(":checked").parent().parent().parent().css("background", "#e0dede");
							
						}
					}
				});
			});
		});
    </script>
</body>
</html>
