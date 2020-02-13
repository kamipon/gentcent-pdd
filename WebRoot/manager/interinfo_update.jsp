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

<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <title>用户信息修改</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript">
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
				editor = K.create('textarea[name="desc"]', {
					cssPath : 'manager/js/plugins/code/prettify.css',
					uploadJson : 'resource/uploadGoodImg',
					allowFileManager : false,
					afterCreate : function() {
						var self = this;
						K.ctrl(document, 13, function() {
							self.sync();
							document.forms['example'].submit();
						});
						K.ctrl(self.edit.doc, 13, function() {
							self.sync();
							document.forms['example'].submit();
						});
					}
				});
			});
	</script>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>用户管理-修改</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" class="form-control" name="id" value="${iie.id}" >
	                    	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>用户名</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="user" value="${iie.user.userName}">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>积分</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="integral" value="${iie.integral}" >
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">描述</label>
	                            <div class="col-sm-10">
	                           		<textarea name="desc" id="desc" class="form-control" style="height:500px;">${iie.desc}</textarea>	                             
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                            	<button class="btn btn-primary" type="button" id="update_integ">修改</button>
                                <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
</body>
<script >
	$(function(){
		$("#update_integ").click(function(){
			//用户名
			var userName = $.trim($("input[name='user']").val());
			var integral = $.trim($("input[name='integral']").val());
			var desc = document.getElementById("desc").value;
			var id = $.trim($("input[name='id']").val());		
			var flag = validate(
							userName,"请输入用户名!",
							integral,"请输入正确积分"
						);
			if(flag){
				$.ajax({
					url:"${cp}/integralInfo/update/"+id,
					type:"post",
					data:{	user:userName,
							integral:integral,
							desc:desc
							},
					dataType:"json",
					success:function(data){
						if(data.flag){
							window.parent.location.reload();							
							layer.msg(data.msg);							
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
			}else if(isNaN(date2)){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
	});
</script>
</html>
