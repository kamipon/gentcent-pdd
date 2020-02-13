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
    

    <title>添加活码</title>

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
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>活码名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">描述</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="desc">
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
		                        		<option>请选择省</option>
		                        	</select>
		                        	<select name="city" id="city">
		                        		<option>请选择市</option>
		                        	</select>
		                        	<select id="area" name="area" >
										<option value="">选择区/县</option>
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
    <script type="text/javascript" src="<%=basePath%>js/distpicker.min_huo.js"></script>
     <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
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
			//活码名称
			var name = $.trim($("input[name='name']").val());
			//活码描述
			var desc = $.trim($("input[name='desc']").val());
			//是否限制省
			var isSheng = $.trim($("input[name='isSheng']").val());
			//是否限制市
			var isShi = $.trim($("input[name='isShi']").val());
			//省
			var province = $("select[name='province']").val();
			//市
			var city = $("select[name='city']").val();
			//区/县
			var area = $("select[name='area']").val();
			if(isSheng==0||isShi==0){
				area = "";
			}
			var flag = validate(
				name,"请输入活码名称!"
			); 
			if(flag){
				$.ajax({
					url:"redAlterable/add",
					type:"post",
					data:{	
						name:name,
						desc:desc,
						isSheng:sheng,
						isShi:shi,
						province:province,
						city:city,
						area :area
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("redAlterable/list");
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
		function validate(date1,msg1){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}
			return true;
		}
	});
</script>
</html>
