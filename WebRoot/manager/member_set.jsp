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
    

    <title>员工身份设置</title>

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
                        <h5>员工身份设置</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>昵称</label>
	                            <div class="col-sm-10">
	                                ${member.nick }|${member.realName }
	                                <input type="hidden" value="${member.id }" id="mid">
	                            </div>
	                        </div>
	                        <div class="form-group">
								<label class="col-sm-2 control-label">
									<font color="red">*</font>
									请选择身份
								</label>
								<div class="col-sm-10">
									<select name="utype" id="utype" class="form-control m-b">
										<option value="0">
											客户
										</option>
										<option value="1">
											商户
										</option>
										<option value="2">
											销售
										</option>
										<option value="3">
											市场
										</option>
										<option value="4">
											物流
										</option>
										<option value="5">
											客服
										</option>
										<option value="99">
											管理员
										</option>
									</select>
								</div>
							</div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_user">设置</button>
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
<script type="text/javascript">
	$(function(){
		$("#add_user").click(function(){
			//id
			var id = $.trim($("#mid").val());
			//utype
			var utype = $.trim($("#utype").val());
			$.ajax({
				url:"${cp}/member/set/"+id,
				type:"post",
				data:{	
					utype:utype
						},
				dataType:"json",
				success:function(data){
					if(data.flag){
						layer.msg(data.msg);
						closeTabAndGo("member");
					}else{
						layer.msg(data.msg);
					}
				}
			});
		});
	});
</script>
</html>
