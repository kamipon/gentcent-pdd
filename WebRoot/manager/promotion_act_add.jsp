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
    

    <title>添加活动推广</title>

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
                        <h5>添加</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" id="promotion">
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>活动名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>行业</label>
	                            <div class="col-sm-10">
	                            	<select name="work" class="form-control m-b">
	                            		<option value="餐饮美食">餐饮美食</option>
	                            		<option value="服饰鞋帽">服饰鞋帽</option>
	                            		<option value="手机电脑">手机电脑</option>
	                            		<option value="汽车周边">汽车周边</option>
	                            		<option value="教育培训">教育培训</option>
	                            		<option value="休闲娱乐">休闲娱乐</option>
	                            		<option value="本地服务">本地服务</option>
	                            		<option value="其他行业">其他行业</option>
	                            	</select>
	                            </div>
	                        </div>
	                          <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>活动图</label>
	                            <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('shareUrl')">选择图片</a>
                                	<img  name="picUrl" id="shareUrl" style="height:50px;width: 50px">
                                </div>
	                        </div> 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>类型</label>
	                            <div class="col-sm-10">
	                                <select class="form-control" name="type" id="type" >
	                                	<option value="0">现金</option>
	                                	<option value="1">优惠券</option>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>起始号</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="startcode">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>结束号</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="endcode">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>描述</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="desc">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>小程序模板</label>
	                            <div class="col-sm-10">
	                            	<select name="xcx" class="form-control m-b">
	                            		<option value="0">-请选择-</option>
	                            		<c:forEach items="${list}" var="each">
	                            			<option value="${each.id }">${each.modelName }</option>
	                            		</c:forEach>
	                            	</select>
	                            </div>
	                        </div>
	                         <div class="form-group" style="margin-top: 5px">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否开启</label>
	                            <div class="col-sm-10">
	                                <input value="1" type="radio" checked="checked" name="isOpen">是&nbsp;&nbsp;&nbsp;&nbsp;
	                                <input value="0" type="radio" name="isOpen" >否
	                            </div>
	                        </div>
	                         <div  id="sheng" class="form-group" style="margin-top: 5px">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否限制省</label>
	                            <div class="col-sm-10">
	                                <input value="1" type="radio" checked="checked" name="isSheng" onchange="shengshi()">是&nbsp;&nbsp;&nbsp;&nbsp;
	                                <input value="0" type="radio" name="isSheng"  onchange="shengshi()">否
	                            </div>
	                        </div>
	                        <div id="shi" class="form-group" style="margin-top: 5px">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否限制市</label>
	                            <div class="col-sm-10">
	                                <input value="1" type="radio" checked="checked" name="isShi" onchange="shengshi()">是&nbsp;&nbsp;&nbsp;&nbsp;
	                                <input value="0" type="radio" name="isShi" onchange="shengshi()">否
	                            </div>
	                        </div>
	                        <div class="form-group" style="margin-top: 5px"  id="select">
	                        	<label class="col-sm-2 control-label"><font color="red">*</font>选择省市</label>
		                        <div class="selectArea">
		                        	<select name="province" id="province">
		                        		<option>请选择</option>
		                        	</select>
		                        	<select name="city" id="city">
		                        		<option>请选择</option>
		                        	</select>
		                        </div>
	                        </div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_activity">新增</button>
	                            <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
	                        </div>
                         </form>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script type="text/javascript" src="manager/js/jquery1.9.1.js"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/distpicker.data.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/distpicker.min.js"></script>
     <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
    <script src="js/content.mine209.js?v=1.0.0"></script>
</body>
<script type="text/javascript">
var sheng;
var shi;
//省市区初始化方法
$(".selectArea").distpicker({
});
 	
$(document).ready(function() {
		shengshi();
	});
	
	
	function shengshi(){
	 	sheng = $('input[type=radio][name=isSheng]:checked').val();
		shi = $('input[type=radio][name=isShi]:checked').val();
			 if (sheng==1&&shi==1) {
       			  $('#select').show();
       			  $('#city').show();
       			  $('#shi').show();
	       		 $('#province').show();
       		}else if(sheng==1&&shi==0){
	        	   $('#select').show();
       			 $('#shi').show();
	        	  $('#city').hide();
	       		 $('#province').show();
	       		 $("#city").val("");	 
	        }else if(sheng==0&&shi==1){
	        	  $('#select').hide();
	        	 $('#city').hide();
	       		 $('#province').hide();
	       		 $("#sh").attr("check","check");
       		 	$("#city").val("");	   
	       		$("#province").val("");	 
	        }else if(sheng==0&&shi==0){
	        	 $('#select').hide();
	        	 $('#city').hide();
	       		 $('#province').hide();
       		 	 $("#city").val("");	   
	       		 $("#province").val("");	 
	        }
	}

	$(function(){
		$("#add_activity").click(function(){
			//活动名称
			var name = $.trim($("input[name='name']").val());
			//描述
			var desc = $.trim($("input[name='desc']").val());
			//起始号码
			var startcode = $.trim($("input[name='startcode']").val());
			//结束号码
			var endcode = $.trim($("input[name='endcode']").val());
			//活动图
			var img = $("#shareUrl").attr("src");
			//类型
			var type = $("#type").val();
			//所属行业
			var work = $("select[name='work']").val();
			//小程序模板
			var xcx = $("select[name='xcx']").val();
			//是否开启
			var isOpen= $('input[name="isOpen"]:checked ').val();
			//省
			var province= $('#province option:selected').val();
			//市
			var city= $('#city option:selected').val();
			var flag = validate(
				name,"请输入活动名称!",
				desc,"请输入描述",
				startcode,"请输入起始编号",
				endcode,"请输入结束编号",
				work,"所属行业",
				img,"请选择活动图",
				xcx,"请选择小程序模板"
			); 
			if(flag){
				$.ajax({
					url:"promotion/add",
					type:"post",
					data:{
						img:img,
						name:name,
						desc:desc,
						startcode:startcode,
						endcode:endcode,
						type:type,
						xcx:xcx,
						work:work,
						isOpen:isOpen,
						isSheng:sheng,
						isShi:shi,
						province:province,
						city,city
					},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							parent.layer.closeAll();
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4,date5,msg5,date6,msg6){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}
			if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			if(date3 == ''){
				layer.msg(msg3);
				return false;
			}
			if(date4 == ''){
				layer.msg(msg4);
				return false;
			}
			if(typeof(date5)=="undefined"){
				layer.msg(msg5);
				return false;
			}if(date6==0){
				layer.msg(msg6);
			}
			return true;
		}
	});
	
	function showImg(imgId){
		var ref=$("#"+imgId);
		if(imgId=="shareUrl"){
			$("#picType").attr("type","share");
		}else{
			$("#picType").attr("type","twoCode");
		}
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(50);
			$(ref).width(50);
		});
	}
</script>
</html>
