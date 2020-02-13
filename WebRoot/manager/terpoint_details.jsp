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
    

    <title>代理信息修改</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>代理信息修改</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>代理名</label>
	                            <div class="col-sm-10">
	                            	<input type="hidden" name="id" value="${terpoint.id }">
	                                <input type="text" class="form-control" name="name" value="${terpoint.name }" >
	                            </div>
	                        </div>
                            <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="phone" value="${terpoint.phone }">
	                           </div>
	                        </div>
                            <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>支付宝</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="zfb" value="${terpoint.zfb}"<c:if test="${!empty terpoint.zfb}">readonly="readonly"</c:if>>
	                           		<br>
	                            	<font style="color: red;">只能保存一次，如要修改，请联系管理员</font>
	                           </div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>支付宝账号真实姓名</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="zfbname" value="${terpoint.zfbname}"<c:if test="${!empty terpoint.zfbname}">readonly="readonly"</c:if>>
	                           		<br>
	                            	<font style="color: red;">只能保存一次，如要修改，请联系管理员</font>
	                           </div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>账户余额</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="money" value="${terpoint.money}"readonly="readonly">
	                           </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                            	<button class="btn btn-primary" type="button" id="update_terpoint">修改</button>
                                <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script type="text/javascript" src="<%=basePath%>manager/js/city.js"></script>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
</body>
<script>
	$(function(){
		$("#update_terpoint").click(function(){
			//商户名
			var name = $.trim($("input[name='name']").val());
			//联系方式
			var phone = $.trim($("input[name='phone']").val());
			//zfb
			var zfb = $.trim($("input[name='zfb']").val());
			//zfbname
			var zfbname = $.trim($("input[name='zfbname']").val());
			//id
			var id = $.trim($("input[name='id']").val());
			 var flag = validate(
						name,"请输入商家名称!",
						phone,"请输入联系方式",
						zfb,"请输入支付宝账号"
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"terPoint/details",
					dataType:"json",
					data:{	_method:"put",
							name:name,
							phone:phone,
							id:id,
							zfb:zfb,
							zfbname:zfbname
							},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("terPoint/details");
						}else{
							layer.msg(data.msg);
						}
					}
				});		 	
		 	}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}
			return true;
		}
	});
	
</script>
</html>
