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
	<script type="text/javascript" src="${cp }/js/jquery.js"></script>
	<script type="text/javascript" src="${cp }/js/jquery1.9.1.js"></script>
	<script type="text/javascript" src="${cp }/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.all.min.js"> </script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" src="${cp }/js/layer/layer.js"></script>
	<script type="text/javascript" src="${cp }/js/11cms.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							通知设置
						</h5>
					</div>
					<div class="ibox-content">
						<form method="post" class="form-horizontal">
							<c:choose>
								<c:when test="${loginUser.type==1}">
									<c:forEach items="${list}" var="items">
										<div class="form-group">
											<label class="col-sm-2 control-label">
												<font color=red>*</font>${items.wxmodel.name }
											</label>
											<div class="col-sm-10" style="margin-top: 5px">
												<div class="switch">
						                            <div class="onoffswitch">
						                                <input type="checkbox" <c:if test="${items.status==1}">checked="checked"</c:if>  
						                               		onclick="changeStatus('${items.id}')"  class="onoffswitch-checkbox" 
						                                	id="example${items.id}">
						                                <label class="onoffswitch-label" for="example${items.id}">
						                                    <span class="onoffswitch-inner"></span>
						                                    <span class="onoffswitch-switch"></span>
						                                </label>
						                            </div>
						                        </div>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach items="${list}" var="items">
										<c:if test="${items.wxmodel.type==loginUser.type}">
											<div class="form-group">
												<label class="col-sm-2 control-label">
													<font color=red>*</font>${items.wxmodel.name }
												</label>
												<div class="col-sm-10" style="margin-top: 5px">
													<div class="switch">
							                            <div class="onoffswitch">
							                                <input type="checkbox" <c:if test="${items.status==1}">checked="checked"</c:if>  
							                               		onclick="changeStatus('${items.id}')"  class="onoffswitch-checkbox" 
							                                	id="example${items.id}">
							                                <label class="onoffswitch-label" for="example${items.id}">
							                                    <span class="onoffswitch-inner"></span>
							                                    <span class="onoffswitch-switch"></span>
							                                </label>
							                            </div>
							                        </div>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script src="${cp}/js/jquery.min63b9.js"></script>
		<script src="${cp}/js/layer/layer.js"></script>
		<script type="text/javascript" src="${cp}/js/childrenToMenu.js"></script>
		<jsp:include page="plugin_image.jsp"></jsp:include>
</body>
</html>
<script>
	function changeStatus(id){
		$.ajax({
			url:"wxmodel_sms/status/"+id,
			type:"get",
			dataType:"json",
			success:function(data){
			}
		});
	}
	
</script>