<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 11 Dec 2015 04:46:12 GMT -->
<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>小程序模板消息</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>模板-修改</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" class="form-horizontal" id="modularForm" >
	                        <div class="form-group">
	                        	<input type="hidden" name="id" value="${entity.id }">
	                        	<input type="hidden" name="template_id" value="${entity.templateId }">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>标题</label>
	                            <div class="col-sm-10">
	                                <input readonly="readonly" type="text" class="form-control" name="title" value = "${entity.title}">
	                            </div>
	                        </div>
	                        <div id="data">
		                        <c:forEach items="${data}" var="data" varStatus="st">
		                         	<div class="form-group" >
			                            <label class="col-sm-2 control-label" name="keyword">${data[0]}</label>
			                            <div class="col-sm-10">
			                                <input type="text" class="form-control" name="data" value="${data[1]}">
			                            </div>
		                        	</div>
		                        </c:forEach>
	                        </div>
                        	<div>
                                  <button class="btn btn-primary" type="button" id="update_article">修改</button>
                                  <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
</body>


</html>
<script >
	$(function(){
		$("#update_article").click(function(){
			//id
			var id = $.trim($("input[name='id']").val());
			//template_id
			var template_id = $.trim($("input[name='template_id']").val());
			//标题
			var title = $.trim($("input[name='title']").val());
			//内容
			var data = '\{';
			var keywords = '\{';
			$("#data").find("label[name='keyword']").each(function(i){
					data += '"'+ $.trim($(this).text())+'":\{"value":"'+$.trim($(this).next().children().val())+'"\},';
					keywords += '"keyword'+ (i+1) +'":\{"value":"'+$.trim($(this).next().children().val())+'"\},';
				});
				data = data.substring(0,data.length-1);
				keywords = keywords.substring(0,keywords.length-1);
				data += "\}";
				keywords += "\}";
				$.ajax({
					url:"xcxTemplate/update",
					type:"post",
					data:{
						id: id,
						template_id: template_id,
						title: title,
						keywords: keywords,
						data: data
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							//提示，关闭当前页面，刷新父页面
							layer.msg(data.msg,{time:1000},function(){
								parent.location.reload();
							});
						}else{
							layer.msg(data.msg);
						}
					}
				});
		});
		function validate(date1,msg1,date2,msg2){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
	});
</script>