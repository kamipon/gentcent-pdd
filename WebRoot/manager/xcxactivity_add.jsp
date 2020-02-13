<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ResourceBundle res = ResourceBundle.getBundle("11erp");
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
     <link rel="shortcut icon" href="favicon.ico"> 
    <link href="${cp }/css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="${cp }/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${cp }/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="${cp }/css/image_plugin.css" rel="stylesheet" type="text/css" />
    <link href="${cp }/css/animate.min.css" rel="stylesheet">
    <link href="${cp }/css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="${cp }/js/11cms.js"></script>
    <link href="${cp }/css/image_plugin.css" rel="stylesheet" type="text/css" />
    <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
	<script type="text/javascript" src="${cp }/js/jquery1.9.1.js"></script>
	<script type="text/javascript" src="${cp }/manager/js/kindeditor-min.js"></script>
    <script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
  	<script type="text/javascript" src="${cp }/js/childrenToMenu.js"></script>
    <script src="${cp }/js/layer/layer.js"></script>
<title></title>
<style type="text/css">
	*{
	    margin:0px;
	    padding:0px;
	}
	body, button, input, select, textarea {
	    font: 12px/16px Verdana, Helvetica, Arial, sans-serif;
	}
	
	#container {
	   min-width:32%;
	   height:300px;
	}
</style>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<script>
var n=0;
var url1="";
var url2="";
var url3="";
var la="";
var lng="";
var geocoder,map,marker = null;
var init = function() {
    var center = new qq.maps.LatLng(39.916527,116.397128);
    map = new qq.maps.Map(document.getElementById('container'),{
        center: center,
        zoom: 15
    });
    //调用地址解析类
    geocoder = new qq.maps.Geocoder({
        complete : function(result){
            loc = result.detail.location;
            la = loc.lat;
            lng = loc.lng;
            map.setCenter(result.detail.location);
            var marker = new qq.maps.Marker({
                map:map,
                position: result.detail.location
            });
        }
    });
}


function codeAddress() {
    var address = document.getElementById("address").value;
    //通过getLocation();方法获取位置信息值
   	geocoder.getLocation(address);
   	return;
}
      
function ajaxFileUpload(obj) {
	     $.ajaxFileUpload({  
		     url:'/plugin/fileUploads',             //需要链接到服务器地址  
		     secureuri:false,  
		     fileElementId:"uploadFileInput",                         //文件选择框的id属性  
		     dataType: 'json',  
		     success: function (data, status){             //相当于java中try语句块的用法  
		     //data是从服务器返回来的值
		     if(data.flag){
				   $("#"+n).attr("src",data.src);
				   if(n==1){
				   	 url1 = data.src;
				   }else if(n==2){
				   	 url2 = data.src;
				   }else{
				   	 url3 = data.src;
				   }
		     }else{
		    		alert(data.msg);
		     }
		     },  
		     error: function (data, status, e) {           //相当于java中catch语句块的用法  
		        alert(data.msg); 
		     }  
		     });
	     $(".remove_a").removeAttr("href");
	     $(".remove_a").removeAttr("onclick");
	    
	     $(".remove_a").click(function(){
	    	return false;
	     });
     }  
     
     function ch(num){
       n = num;	
     }
     
     function add(){
     		//标题模板
			var title = $.trim($("input[name='modelName']").val());
			//标题内容
			var content = $("#desc").val();
			//地址
			var address = $.trim($("input[name='address']").val());
			//手机号
			var phone = $.trim($("input[name='phone']").val());
			//商家名称
			var name = $.trim($("input[name='name']").val());
			//模板名称
			var modelName = $.trim($("input[name='modelName']").val());
			$.ajax({
				url:"${cp}/xcxActivity/add",
				type:"post",
				data:{	
					title:title,
					content:content,
					address:address,
					phone:phone,
					modelName:modelName,
					name:name,
					url1:url1,
					url2:url2,
					url3:url3,
					la:la,
					lng:lng 
				},
				dataType:"json",
				success:function(data){
					if(data.flag){
						layer.msg("添加成功");
						setTimeout("goFresh('xcxActivity')",1000); 
					}else{
						layer.msg("添加失败");
					}
				}
			});
     }
</script>
</head>
<body onload="init()">
<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>新增</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>模板名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="modelName">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>活动海报</label>
	                            <li class="fileinput-button js-add-image" style="left: 16px"  onclick="ch(1)">
                                	<a class="fileinput-button-icon show_update_imgs" href="javascript:;">+</a>
									<input class="uploadFileInput" type="file" size="45" style="width:100%;" name="uploadFileInput1" onchange="ajaxFileUpload(this)">
									<img  id="1" style="width: 100%;height: 100%;margin-top: -21%">
	                            </li>
	                            <li class="fileinput-button js-add-image" style="margin-top: -80px;margin-left: 24%" onclick="ch(2)">
                                	<a class="fileinput-button-icon show_update_imgs" href="javascript:;" >+</a>
									<input class="uploadFileInput" type="file" size="45" style="width:100%;" name="uploadFileInput2" onchange="ajaxFileUpload(this)">
									<img  id="2" style="width: 100%;height: 100%;margin-top: -21%">
	                            </li>
	                            <li class="fileinput-button js-add-image" style="margin-top: -80px;margin-left: 30.5%" onclick="ch(3)">
                                	<a class="fileinput-button-icon show_update_imgs" href="javascript:;" >+</a>
									<input class="uploadFileInput" type="file" size="45" style="width:100%;" name="uploadFileInput3" onchange="ajaxFileUpload(this)">
									<img  id="3" style="width: 100%;height: 100%;margin-top: -21%">
	                            </li>
                       	      	<div style="position: absolute;left: 38%;top: 12.5%;font-size: 12px;font-weight: bolder;">
                           			<span>「请上传宽375px 高150px的图片」</span>
                           		</div>
	                        </div> 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商家名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商家电话</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="phone">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>地址</label>
	                            <div class="col-sm-4" style="height: 25px">
	                                <input type="text" class="form-control" name="address" id="address" placeholder="如：武汉市黄鹤楼(输入地址后请点击定位)">
                                    <a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="codeAddress()" style="position: relative;left: 103%;top:-33px">定位</a>
	                            </div>
	                        </div>
	                        <div id="container" style="margin-left: 17%"></div>
	                      <div class="form-group" style="margin-top: 25px">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商家介绍</label>
	                            <div class="col-sm-10">
	                            	<textarea maxlength="255" name="content" id="desc" rows="3" cols="70" style="width:100%;height:400px;visibility:hidden;"></textarea>
	                            </div>
	                        </div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_content" onclick="add()">新增</button>
	                            <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
	                        </div>
                         </form>
                        </div>
                       
                    </div>
                </div>
            </div>
    </div>
</div>
</body>
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
		editor = K.create('textarea[name="content"]', {
			cssPath : 'manager/js/plugins/code/prettify.css',
			uploadJson : '/plugin/fileUploads',
			allowFileManager : false,
			afterBlur:function(){this.sync();},
		});
	});
</script>
</html>
