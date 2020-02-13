<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<link rel="shortcut icon" href="favicon.ico">
	<link href="${cp }/css/bootstrap.minb16a.css" rel="stylesheet">
	<link href="${cp }/css/font-awesome.min93e3.css" rel="stylesheet">
	<link href="${cp }/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
	<link href="${cp }/css/animate.min.css" rel="stylesheet">
	<link href="${cp }/css/style.min1fc6.css" rel="stylesheet">
	<link rel="shortcut icon" href="favicon.ico">
	<link href="${cp }/css/style.min1fc6.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${cp }/css/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" href="${cp }/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link href="${cp }/css/plugins/iCheck/custom.css" rel="stylesheet">
	<link href="${cp }/css/image_plugin.css" rel="stylesheet" type="text/css" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							短信通知设置
						</h5>
					</div>
					<div class="ibox-content" style="background-color: white;padding: 20px 5px 0px;">
						<form method="post" class="form-horizontal">
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>核销码通知
								</label>
								<div class="col-sm-10">
                                	<input id="c1" type="radio" value="true" name="isOpenHx" 
                                		<c:if test="${noteSet.isOpenHx==true}">checked="checked"</c:if>>
                                		<label for="c1">开启</label>
                                	<input id="c2" type="radio" value="false" name="isOpenHx"
                                		<c:if test="${noteSet.isOpenHx==false}">checked="checked"</c:if>>
                                		<label  for="c2">关闭</label>
                                	<span style="color: red">&nbsp;&nbsp;&nbsp;* 需要核销的活动，将给客户发送核销通知</span>
								</div>
							</div>
							<!-- 虚线效果 -->
							<!--<div class="hr-line-dashed"></div>-->
							<div style="padding-left: 30%">
								<button class="btn btn-primary" type="button" id="add_detection">
									保存
								</button>
								<button class="btn btn-primary" type="reset" id="remove" value="重置">
									重置
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="${cp }/js/jquery.js"></script>
		<script src="${cp}/js/layer/layer.js"></script>
</body>
</html>
<script>
	$(function(){
		$("#add_detection").click(function(){
			//核销码通知开启
			var isOpenHx=$.trim($("input:radio[name=isOpenHx]:checked").val());
				$.ajax({
					url:"note/setting",
					type:"post",
					data:{
						isOpenHx: isOpenHx
					},
					dataType:"json",
					success:function(data){
						layer.msg(data.msg);
					}
				});
			return false;
		});
	});
</script>