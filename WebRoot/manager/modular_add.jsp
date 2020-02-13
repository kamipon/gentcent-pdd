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
    

    <title>菜单添加</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min63b9.js"></script>
	<script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
	<script src="js/layer/layer.js"></script>

</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight" style="top: 23%">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                    	<form method="get" class="form-horizontal" id="modularForm">
							<c:if test="${parent!=null}">
	                        	<div class="form-group">
	                                <label class="col-sm-2 control-label"><font color=red>*</font>父菜单</label>
	                                <div class="col-sm-10">
	                                    <input type="text" name="parent" disabled="" class="form-control" value="${parent.name }">
	                                    <input type="hidden" name="parent" value="${parent.id }" class="form-control">
	                                </div>
	                            </div>
                        	</c:if>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>菜单名称
								</label>
								<div class="col-sm-10">
									<input type="text" name="name" class="form-control" >
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>菜单code
								</label>
								<div class="col-sm-10">
									<input type="text" name="code" class="form-control" value="">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>菜单类型
								</label>
								<div class="col-sm-10">
									 <select class="form-control m-b" id="type" name="type">
										<option value="menu">menu</option>
										<option value="event">event</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									左css
								</label>
								<div class="col-sm-10">
									<input type="text" name="leftCss" class="form-control" >
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									右css
								</label>
								<div class="col-sm-10">
									<input type="text" name="rightCss" class="form-control" >
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>访问地址
								</label>
								<div class="col-sm-10">
									<input type="text" name="url" class="form-control">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>排序
								</label>
								<div class="col-sm-10">
									<input type="text" name="order" class="form-control" onkeyup="value=value.replace(/[^\d]/g,'')" placeholder="请填写数字!">
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div>
								<input type="hidden" value="${navigation.id }" name="id">
								<button class="btn btn-primary" type="button" id="add_ter">
									保存内容
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
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/content.mine209.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script src="${cp }/js/jquery1.9.1.js"></script>
</body>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</html>
<script>
	$(function(){
		$("#add_ter").click(function(){
			//父模板
			var parent = $.trim($("input[name='parentId']").val());
			//模块显示名
			var name = $.trim($("input[name='name']").val());
			//类型
			var type = $("#type").val();
			//模块连接
			var url = $.trim($("input[name='url']").val());
			//排序
			var order = $.trim($("input[name='order']").val());
  			var array=[[name,"请填写模块显示名!"],[type,"请选择类型!"],[url,"请填写模块连接!"],[order,"请填写排序!"]];
  			var flag = validate(array);
			if(flag){
				$.ajax({
					url:"${cp}/menu",
					type:"post",
					data:$("#modularForm").serialize(),
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							window.parent.location.reload();
							var index = window.parent.layer.getFrameIndex(window.name); 
							window.parent.layer.close(index);
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
			
		function validate(array){
			var flag=true;
			for(var i=0;i<array.length&&flag;i++){
				if(!array[i][0]){
					layer.msg(array[i][1]);
					flag=false;
				}
			}
			return flag;
		}
		
		
	});
		
</script>
