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
    

    <title>修改</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>

</head>

<body class="gray-bg">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    	<h5>开发者信息</h5>     
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                        <div class="form-group">
	                        	<input type="hidden" name="id" value="${activity.id }">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>appId</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="appId" readonly="readonly" value="${activity.appId }" >
	                            </div>
	                        </div>
							<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>appsecret</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" id="appsecret" name="appsecret" readonly="readonly" value="${activity.appsecret }">
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                            	<button class="btn btn-primary" type="button" id="redpacktModel">保存</button>
                                <button class="btn btn-primary" type="button" id="reset" value="重置">重置appsecret</button>
                                <button class="btn btn-primary" type="button" onclick="explain()" value="开放平台说明">开放平台说明</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script>
	$(function() {
	    $("#model").change(function() {
	        if (this.value == "1") {
	            $("#num").show();
	            
	            ;
	        } else {
	            $("#num").hide();
	           
	        }
	    });
	});
	$(function(){
		$("#redpacktModel").click(function(){
			//活动的ID
			var id = $.trim($("input[name='id']").val());
			//联系方式
			var appId = $.trim($("input[name='appId']").val());
			//地址
			var appsecret = $.trim($("input[name='appsecret']").val());
			 var flag = validate(
						appId,"请输入appId",
						appsecret,"请输入appsecret"
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"activity/saveDevelop",
					dataType:"json",
					data:{	
							_method:"put",
							id:id,
							appId:appId,
							appsecret:appsecret
							},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							location.reload();
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
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}else if(date4 == ''){
				layer.msg(msg4);
				return false;
			}else if(date5 == ''){
				layer.msg(msg5);
				return false;
			}else if(date6 == ''){
				layer.msg(msg6);
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
	function buyRedPacket(){
		 	layer.open({
			type: 2,
			title: '购买红包码',
			shadeClose: true,
			shade: 0.8,
			area: ['1500px', '50%'],
			content: 'manager/redpacket_buy_activity.jsp'
		});		
	}
	function explain(){
		 	layer.open({
			type: 2,
			title: '开放平台说明',
			shadeClose: true,
			shade: 0.8,
			area: ['1500px', '80%'],
			content: 'manager/activity_develop_explain.jsp'
		});		
	}
	$(function(){
		$("#reset").click(function(){
				$.ajax({
					type:"post",
					url:"activity/reset",
					dataType:"json",
					data:{	
							_method:"put",
							},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
						$("#appsecret").val(data.activity.appsecret);
							window.reload(); 	
						}else{
							layer.msg(data.msg);
						}
					}
				});		 	
		 	
			return false;
		});
	});
</script>
</html>
