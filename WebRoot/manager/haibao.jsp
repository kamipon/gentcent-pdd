<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
     <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
	<style>
		.top-50{
			margin-top: -200px !important;
			height:480px !important;
		}
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>海报</h5>
                    </div>
                    <div class="ibox-content" style="padding: 20px 5px 20px;">
						<form method="post" class="form-horizontal">
	                    	<div class="form-group">
	                            <label class="col-sm-2 control-label">图片1</label>
	                            <div class="col-sm-10">
	                               	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('imgUrl1')">选择图片</a>
	                               	<img src="${xcx.imgUrl1 }" name="imgUrl1" id="imgUrl1" style="height:50px;">
	                               </div>
	                            <div style="position: absolute;left: 38%;top: 15.5%;font-size: 12px;font-weight: bolder;">
                           			<span style="color: red">「请上传宽375px 高150px的图片」</span>
                           		</div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">链接1</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="url" id="url1" value="${xcx.url1 }">
	                            </div>
	                        </div>
	                    	<div class="form-group">
	                            <label class="col-sm-2 control-label">图片2</label>
	                            <div class="col-sm-10">
	                               	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('imgUrl2')">选择图片</a>
	                               	<img src="${xcx.imgUrl2 }" name=imgUrl2 id="imgUrl2" style="height:50px;">
	                               </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">链接2</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="url" id="url2" value="${xcx.url2 }">
	                            </div>
	                        </div>
	                    	<div class="form-group">
	                            <label class="col-sm-2 control-label">图片3</label>
	                            <div class="col-sm-10">
	                               	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('imgUrl3')">选择图片</a>
	                               	<img src="${xcx.imgUrl3 }" name="imgUrl3" id="imgUrl3" style="height:50px;">
	                               </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">链接3</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="url" id="url3" value="${xcx.url3 }">
	                            </div>
	                        </div>
	                     </form>
	                     <input onclick="baocun()" type="button" value="保存" class="btn btn-primary" style="margin-left: 50%;width: 80px">
                    </div>
                </div>
            </div>
         </div>
    </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/content.mine209.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
     <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function baocun(){
		layer.msg("保存成功！",{
		  icon: 1,
		  time: 1500 //2秒关闭（如果不配置，默认是3秒）
		}, function(){
		  parent.layer.closeAll();
		});
	}
   	function showImg(imgId){
		var ref=$("#"+imgId);
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(100);
			$(ref).width(100);
			var data;
			if(imgId=="imgUrl1"){
				data = {imgUrl1:url};
			}
			if(imgId=="imgUrl2"){
				data = {imgUrl2:url};
			}
			if(imgId=="imgUrl3"){
				data = {imgUrl3:url};
			}
    		$.ajax({
				url:"promotion/haiBao",
				type:"get",
				data:data,
				dataType:"json",						
				success:function(data){
					layer.msg(data.msg);
				}						
			});
		});
	}
	var u1 = "";
	var u2 = "";
	var u3 = "";
	$(function(){
		u1 = $("#url1").val();
		u2 = $("#url2").val();
		u3 = $("#url3").val();
	});
	$("input[name='url']").blur( function () { 
    		var id= $(this).attr("id");
    		var url = $.trim($(this).val());
    		if(""==url){return ;}
    		var data;
   			if(id=="url1"){
   				if(u1==url){return ;}
   				data = {url1:url};
   				u1 = url;
    		}
    		else if(id=="url2"){
    			if(u2==url){return ;}
    			data = {url2:url};
    			u2 = url;
    		}
    		else if(id=="url3"){
    			if(u3==url){return ;}
    			data = {url3:url};
    			u3 = url;
    		}
   			$.ajax({
			url:"promotion/haiBao",
			type:"get",
			data:data,
			dataType:"json",						
			success:function(data){
				layer.msg(data.msg);
				}						
			});
    	});
</script>
</html>
