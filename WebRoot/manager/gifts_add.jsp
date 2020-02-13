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
    <title>商品新增</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
     <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
     <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>商品管理-新增</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                          <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品图片</label>
	                            <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('picUrl')">选择图片</a>
                                	<img src="" name="imgUrl" id="picUrl" style="height:50px;">
                                </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>价值</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="price">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>库存</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="inventory">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">商家编码</label>
	                            <div class="col-sm-10">
	                            	<input type="text" class="form-control" name="outid">
	                            </div>
	                        </div>
	                        
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">兑换数量</label>
	                            <div class="col-sm-10">
	                            	<input type="text" class="form-control" name="volume">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">排序</label>
	                            <div class="col-sm-10">
	                            	<input type="text" class="form-control" name="order" value = "99">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>兑换所需积分</label>
	                            <div class="col-sm-10">
	                            	<input type="text" class="form-control" name="integral">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">描述</label>
	                            <div class="col-sm-10">
	                            	<textarea maxlength="255" name="desc" id="desc" rows="3" cols="70" style="width:800px;height:400px;visibility:hidden;"></textarea>
	                            </div>
	                        </div>
                        	<div>
                                  <button class="btn btn-primary" type="button" id="add_gifts">新增</button>
                                  <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>


</html>
<script >
	$(function(){
		$("#add_gifts").click(function(){
			//商品名称
			var name = $.trim($("input[name='name']").val());
			//商品主图
			var imgUrl = $("#picUrl").attr("src");
			//单价
			var price = $.trim($("input[name='price']").val());
			//库存
			var inventory = $.trim($("input[name='inventory']").val());
			//商家编码
			var outid = $.trim($("input[name='outid']").val());
			//描述
			var desc = $("#desc").val();
			//兑换数量
			var volume = $.trim($("input[name='volume']").val());
			//排序
			var order = $.trim($("input[name='order']").val());
			//兑换所需积分
			var integral = $.trim($("input[name='integral']").val());
			var flag = validate(
					name,"请输入商品名称!",
					imgUrl,"请选择商品主图!",
					price,"请输入价值!",
					integral,"请输入兑换所需积分!",
					inventory,"请输入库存"
				);
			
			if(flag){
				$.ajax({
					url:"gifts/add",
					type:"post",
					data:{
						name : name,
						imgUrl : imgUrl,
						price : price,
						inventory : inventory,
						outid : outid,
						desc : desc,
						volume : volume,
						order : order,
						integral : integral
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("gifts");
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}else if(date4 == ''){
				layer.msg(msg4);
				return false;
			}
			return true;
		}
	});
	function showImg(imgId){
		var ref=$("#"+imgId);
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(100);
			$(ref).width(100);
		});
	}
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
					cssPath : '',
					uploadJson : 'plugin/fileUploads',
					allowFileManager : false,
					afterBlur:function(){this.sync();},
				});
			});
</script>