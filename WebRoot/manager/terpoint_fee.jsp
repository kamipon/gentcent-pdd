<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
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

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>修改手续费</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                    	    <font color="red">请输入0-100之间的正整数，当输入10时，手续费为10%</font><br>
	                    	    <font color="red">修改此处手续费将一键设置【未设置手续费的商家】的手续费</font><br>
	                    	    <font color="red">【已经设置手续费的商家】的手续费将无法修改</font>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>平台手续费</label>
	                        
	                            <div class="col-sm-10">
	                            	<input type="hidden" name="id" value="${terpoint.id }">
	                                <input type="text" class="form-control" name="ptFee" value="${terpoint.ptFee }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>代理手续费</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="terFee" value="${terpoint.terFee }">
	                            </div>
	                        </div>
	                        
                        	<div>
                            	<button class="btn btn-primary" type="button" id="update_activityNum">修改</button>
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
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script>
	$(function(){
		$("#update_activityNum").click(function(){
			//代理手续费
			var terFee = $.trim($("input[name='terFee']").val());
			//平台手续费
			var ptFee = $.trim($("input[name='ptFee']").val());
			//id
			var id = $.trim($("input[name='id']").val());
			 var flag = validate(
						terFee,"请输入正确代理手续费",
						ptFee,"请输入正确平台手续费"						
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"terPoint/upfee",
					dataType:"json",
					data:{	_method:"put",
							terFee:terFee,
							ptFee:ptFee,
							id:id
							},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							setTimeout('window.parent.location.reload()',1000); 
						}else{
							layer.msg(data.msg);
						}
					}
				});		 	
		 	}
			return false;
		});
		function validate(date1,msg1,date2,msg2){
			var re = /^[0-9]+$/; 
			if(date1 == ''||!re.test(date1)||date1>100){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''||!re.test(date2)||date2>100){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
	});
</script>
</html>
