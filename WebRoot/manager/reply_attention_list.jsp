<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
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
    <title>关注时回复</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <style>
    	td{
			word-wrap: break-word;
			white-space:nowrap; 
			word-break:keep-all; 
			overflow:hidden; 
			text-overflow:ellipsis;
		}
		.list{ background:none repeat scroll 0 0; margin:0px auto;  width:100%; table-layout:fixed; border:1px solid #a1bcdb; }
		.list td{ border:1px solid #a1bcdb; word-break:break-all; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; -o-text-overflow:ellipsis; }
    </style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>
							关注时回复
						</h5>
						<div class="ibox-tools">
							<span class="glyphicon glyphicon-plus"></span>
							<a class="J_menuItem" href="manager/reply_attention_add.jsp">添加</a>
						</div>
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content" style="background-color: white;padding: 20px 5px 0px;">
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead>
	                                <tr>
	                                	<th width="4%">回复类型</th>
										<th width="10%">图片</th>
										<th>标题</th>
										<th>回复内容</th>
										<th width="5%">设置时间</th>
										<th width="6%">操作</th>
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal" class="list">
	                            	<c:forEach items="${list}" var="items" varStatus="s">
	                            		<tr>
		                            		<td>
		                            			<c:choose>
		                            				<c:when test="${items.replytype=='图文'}">
		                            					<span style="color: #1CAD1C;font-weight: bold">${items.replytype}</span>
		                            				</c:when>
		                            				<c:when test="${items.replytype=='文本'}">
		                            					<span style="color: #07A4E2;font-weight: bold">${items.replytype}</span>
		                            				</c:when>
		                            				<c:when test="${items.replytype=='图片'}">
		                            					<span style="color: #E60C6F;font-weight: bold">${items.replytype}</span>
		                            				</c:when>
		                            			</c:choose>
		                            		</td>
		                            		<td>
												<img src="${items.imgUrl }" width="100px" height="70px">
		                            		</td>
		                            		<td>
		                            			${items.title}
		                            		</td>
		                            		<td>
		                            			${items.content}
		                            		</td>
		                            		<td>
		                            			${items.addTime}
		                            		</td>
		                            		<td>
		                            			<a class="pn-opt" onclick="delContent('${items.id}')" href="javascript:void(0);">删除</a>
												<a class="J_menuItem" href="reply/toUpdate/${items.id}">修改</a>
		                            		</td>
	                            		</tr>
	                            	</c:forEach>
	                            </tbody>
	                        </table>
                        <div method="post" id="tableForm">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        <tbody>
		                            <tr>
		                                <td align="center" class="pn-sp">
		                                    <form id="paging" action="${pageContext.request.contextPath }/reply/attention" method="get">
		                                      <input type="hidden" name="name" value="${name }">
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
    </div>
    <input type="hidden" id="message" value="${message }" />
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    function delContent(id){
	    swal({
	        title: "您确定要删除这条信息吗",
	        text: "删除后将无法恢复，请谨慎操作！",
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#DD6B55",
	        confirmButtonText: "删除",
	        closeOnConfirm: false
	    }, function (isConfirm) {
	    	if(isConfirm){
		        document.form2.attributes["action"].value = "reply/" + id;
				document.form2.submit();
		        swal("删除成功！", "您已经永久删除了这条信息。", "success");
		        }
	    });
	}
	
	$(function(){
		$(".list td").each(function(i){
           //给td设置title属性,并且设置td的完整值.给title属性.
       		$(this).attr("title",$(this).text());
     	});
	});
	
    </script>
</body>
</html>