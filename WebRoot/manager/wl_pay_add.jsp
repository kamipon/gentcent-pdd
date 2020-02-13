<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
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
    <title>用户资料修改</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
	
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/json2.js"></script>
    <script src="js/11cms.js?2"></script>
	<script type="text/javascript" src="js/kindeditor-min.js"></script>
	<script src="js/layer/layer.js"></script>
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
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>支付二维码<small></small></h5>
                    </div>
                    <div class="ibox-content">
                        <form method="post" class="form-horizontal" id="terForm">
                        	<input type="hidden" name="_method" value="put">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">二维码名称</label>
                                <div class="col-sm-2">
                                	<input type="text" name="name" id="name"/>
                                </div>
                            </div>
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">支付二维码</label>
                                <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('picUrl')">选择图片</a>
                                	<img name="picUrl" id="picUrl" style="height:50px;">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div>
	                             <button class="btn btn-primary" type="button" id="add">保存内容</button>
	                             <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
	
    <script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/content.mine209.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
	
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript">
		$(function(){
			$("#add").click(function(){
    				var picUrl = $("#picUrl").attr("src");
    				var name = $("#name").val();
					$.ajax({
						type:"post",
						url:"${cp}/wlpay/add",
						dataType:"json",
						data:{
								url:picUrl,
								name:name
							},
						success:function(data){
							if(data.flag){
								layer.msg(data.msg);
								closeTabAndGo("wlpay/list");
							}else{
								layer.msg(data.msg);
							}
						}
					});	
			});
		});
</script>
</body>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</html>

