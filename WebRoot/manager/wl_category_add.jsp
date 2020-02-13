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
    <title>商品分类添加</title>
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
	<script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
<script type="text/javascript">
   	function showImg(imgId){
		var ref=$("#"+imgId);
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(100);
			$(ref).width(100);
		});
	}
</script>
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
	                                <label class="col-sm-2 control-label"><font color=red>*</font>上级类别</label>
	                                <div class="col-sm-10">
	                                    <input type="text" name="parent" disabled="" class="form-control" value="${parent.name }">
	                                    <input type="hidden" name="parentId" value="${parent.id }" class="form-control">
	                                </div>
	                            </div>
                        	</c:if>
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">logo</label>
                                <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('picUrl')">选择图片</a>
                                	<img  name="picUrl" id="picUrl" style="height:50px;">
                                </div>
                            </div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>名称
								</label>
								<div class="col-sm-10">
									<input type="text" name="name" class="form-control" >
								</div>
							</div>
		                     <div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>编码(建议1位字母)
								</label>
								<div class="col-sm-10">
									<input type="text" name="code" class="form-control">
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
     <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
</body>
</html>
<script>
	$(function(){
		//提交
		$("#add_ter").click(function(){
			//父类别
			var parent = $.trim($("input[name='parentId']").val());
			//类目名称
			var name = $.trim($("input[name='name']").val());
			//标题
			var code = $.trim($("input[name='code']").val());
			//排序
			var order = $.trim($("input[name='order']").val());
			//logo
			var picUrl = $("#picUrl").attr("src");
  			var array=[[name,"请填写类别名称!"],[order,"请填写排序!"],[code,"请填写编号!"]];
  			var flag = validate(array);
			if(flag){
				$.ajax({
					url:"wlcategory",
					type:"post",
					data:{
						parentId:parent,
						name:name,
						order:order,
						code:code,
						picUrl:picUrl
					},
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

<jsp:include page="plugin_image.jsp"></jsp:include>