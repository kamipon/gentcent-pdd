<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>首页图片管理</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
     <script src="js/jquery.min63b9.js?v=2.1.4"></script>
     <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">

    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min63b9.js"></script>
	<script src="js/layer/layer.js"></script>
	<link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
	<script type="text/javascript" src="/js/11cms.js"></script>
	<script type="text/javascript" src="/manager/js/date/WdatePicker.js"></script>
	<script type="text/javascript" src="js/kindeditor-min.js"></script>
	<script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    		function showImg(imgId){
				var ref=$("#"+imgId);
				render(function(url){
					$(ref).attr("src",url);
					$(ref).removeAttr("style");
					$(ref).addClass("img");
					//修改支付方式logo
					var picUrl = url;
		    		var id= $(ref).attr("payid");
				});
			}
	</script>
    <style>
    	td{word-wrap: break-word;white-space:nowrap; word-break:keep-all; overflow:hidden; text-overflow:ellipsis;}
		.list{ background:none repeat scroll 0 0; margin:0px auto;  width:100%; table-layout:fixed; border:1px solid #a1bcdb; }
		.list td{ border:1px solid #a1bcdb; word-break:break-all; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; -o-text-overflow:ellipsis; }
		.img{height:150px;margin-left: 30px;margin-right: 30px;}
    </style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>首页图片管理</h5>
                        <div class="wrapper wrapper-content animated fadeInRight">
		                    <div class="ibox-content">
		                        <form method="get" class="form-horizontal">
		                        	<span style="font-size: 18px;font-weight: bold;">首页海报</span><br>
		                        	<span style="font-size: 12px;color: red">&nbsp;*&nbsp;管理员可设置前三张海报,首页最多可设置六张海报.</span><br>
		                            <div id="img_div">
		                            	<c:if test="${not empty adminList}">
		                            		<c:forEach items="${adminList}" var="l">
		                            			<div id="del${l.id}">
			                            			<div class="hr-line-dashed"></div>
				                            		<div class="form-group">
				                            			<label class="col-sm-2 control-label"><font color=red></font></label>
						                                <div class="col-sm-10">
						                                    <span data-toggle="modal" class="btn btn-primary disabled" style="background-color: gray;border-color: gray;">默认海报</span>
						                                	<img src="${l.value}" name="image_index_admin" class="img" maxlength="255">
						                                </div>
						                            </div>
					                            	<div class="hr-line-dashed"></div>
						                        </div>
			                            	</c:forEach>
		                            	</c:if>
		                            	<c:forEach items="${list}" var="l">
		                            	<div id="del${l.id}">
	                            			<div class="hr-line-dashed"></div>
		                            		<div class="form-group">
		                            			<label class="col-sm-2 control-label"><font color=red></font></label>
				                                <div class="col-sm-10">
				                                    <a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('image${l.id}')">选择图片</a>
				                                	<img src="${l.value}" name="image_index" id="image${l.id}" class="img" maxlength="255">
				                                	<a onclick="delImg('del${l.id}')">
				                                		<img src='images/del.png' width='20px' />
				                                	</a>
				                                </div>
				                            </div>
			                            	<div class="hr-line-dashed"></div>
				                        </div>
		                            	</c:forEach>
		                            </div>
		                            <div class="form-group" style="margin-left: 7px;margin-top: 30px;">
		                                <label class="col-sm-2 control-label"><font color=red></font></label>
		                                <div id="addBtn" class="col-sm-10" >
		                                    <a class=""onclick="add_img()">
		                                    	<img src="images/add.png" width="40px" height="40px">
		                                    </a>
		                                </div>
		                            </div>
		                            <div class="hr-line-dashed" style="display: none;"></div>
		                            <div style="text-align: center;">
		                            	<input name="id" value="" type="hidden">
			                             <button class="btn btn-primary" type="button" id="save_img">保存内容</button>
		                            </div>
		                        </form>
		                    </div>
                </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" value="${message }" name="message" id="message">
     <jsp:include page="plugin_image.jsp"></jsp:include>
    <script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script>
	    var i = imgCount(); //图片数
		$(function(){
			//初始化
			{
				if(i>=parseInt("${len}")){
					$("#addBtn").hide();
				} else{
					$("#addBtn").show();
				}
			
				if("${empty list}"=="true"){
					add_img();
				}
			}
		
			$("#save_img").click(function(){
	    		var img_list = new Array();
				//内容图
				$("[name=image_index]").each(function () {
					if ($(this).attr('src') != '' && $(this).attr('src') != null) {
						img_list.push($(this).attr('src'));
					}
				});
				i =imgCount();
				
				if(img_list.length==0){
					img_list.push('');
				}
				console.log(img_list);
				$.ajax({
					type:"post",
					url:"/weixin/index_img",
					data:{
						'imgList[]': img_list
					},
					dataType:"json",
					success:function(data){
						layer.msg(data.msg);
					}
				});
			});
		});
		function add_img(){
			if(i>=parseInt("${len}")){
				return;
			} 
		    i+=1;
		    var radomId = Math.random().toString(36).substr(2);
			var html = "<div id='del"+radomId+"'>"+
							'<div class="hr-line-dashed"></div>'+
							'<div class="form-group">'+
			                      '<label class="col-sm-2 control-label"><font color=red></font></label>'+
			                      '<div class="col-sm-10">'+
			                      	'<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg(\'image'+radomId+'\')">选择图片</a>'+
			                      	'<img src="" name="image_index" id="image'+radomId+'" class="img" maxlength="255">'+
			                      	"<a onclick="+"delImg('del"+radomId+"')"+">"+
	                               		"<img src='images/del.png' width='20px' />"+
	                               	'</a>'+
			                      '</div>'+
			                  '</div>'+
			                  '<div class="hr-line-dashed"></div>'+
	                 	'</div>';
			$("#img_div").append(html);
			i=imgCount();
			if(i>=parseInt("${len}")){
				$("#addBtn").hide();
			} else{
				$("#addBtn").show();
			}
			
		}
		
		function delImg(id){
			$("#"+id).remove();
			i=imgCount();
			if(i>=parseInt("${len}")){
				$("#addBtn").hide();
			} else{
				$("#addBtn").show();
			}
		}

		//获取图片数
		function imgCount(){
			var s = 0;	
			$("[name=image_index]").each(function () {
				s += 1;
			});
			$("[name=image_index_admin]").each(function () {
				s += 1;
			});
			return s;
		}

		function aa(){
			$.ajax({
					url:"/contents/"+id,
					type:"post",
					data:{	
							image:image
						},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							var param ="?navId=&name=&pageIndex=&pageSize=";
							goFresh("contents");
						}else{
							layer.msg(data.msg);
						}
					}
				});
		}
	</script>
</body>
</html>