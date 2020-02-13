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
    

    <title>角色新增</title>

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
                        <h5>角色管理-新增</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">角色名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="roleName">
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                                  <button class="btn btn-primary" type="button" id="add_activity">新增</button>
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
</body>


</html>
<script >
	$(function(){
		$("#add_activity").click(function(){
			//名称
			var roleName = $.trim($("input[name='roleName']").val());
			var flag = validate(
							roleName,"请输入名称!"
						);
			if(flag){
				$.ajax({
					url:"${cp}/role",
					type:"post",
					data:{roleName:roleName},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							closeTabAndGo("role");
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