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
    

    <title>文章修改</title>

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
                        <h5>文章管理-修改</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                        	<input type="hidden" name="id" value="${article.id }">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>标题</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="title" value = "${article.title}">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label">摘要</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="remark" value = "${article.remark}">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label">标签</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="tag" value = "${article.tag}">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label">类型</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="type" value = "${article.type}">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>内容</label>
	                            <div class="col-sm-10">
	                            	<textarea maxlength="255" name="content" id="content" rows="3" cols="70" style="width:800px;height:400px;visibility:hidden;">${article.content}</textarea>
	                            </div>
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
			//标题
			var title = $.trim($("input[name='title']").val());
			//内容
			var content = $("#content").val();
			//摘要
			var remark = $.trim($("input[name='remark']").val());
			//标签
			var tag = $.trim($("input[name='tag']").val());
			//类型
			var type = $.trim($("input[name='type']").val());
			//id
			var id = $.trim($("input[name='id']").val());
			//url
			var url = $("#url").val();
			var flag = validate(
					title,"请输入标题!",
					content,"请输入内容!",
				);
			if(flag){
				$.ajax({
					url:"article/change",
					type:"post",
					data:{
						_method:"put",
						id : id,
						url : url,
						title : title,
						content : content,
						remark : remark,
						tag : tag,
						type : type
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("article");
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
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
	var editor;
			KindEditor.ready(function(K) {
				K.options.items=['source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
					'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
					'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
					'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
					'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
					'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 
					'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'pagebreak',
					'anchor', 'link', 'unlink', '|', 'about'];
				editor = K.create('textarea[name="content"]', {
					cssPath : '',
					uploadJson : 'plugin/fileUploads',
					allowFileManager : false,
					afterBlur:function(){this.sync();},
				});
			});
</script>