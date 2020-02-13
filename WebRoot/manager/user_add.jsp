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
    

    <title>游戏互动系统-用户新增</title>

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
	
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>用户管理-新增</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>用户名</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="userName">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>密码</label>
	                            <div class="col-sm-10">
	                                <input type="password" class="form-control" name="password">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>真实姓名</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="realName">
	                            </div>
	                        </div>
	                        <div class="form-group">
								<label class="col-sm-2 control-label">
									<font color="red">*</font>
									请选择性别
								</label>
								<div class="col-sm-10">
									<select name="sex" id="sex" class="form-control m-b">
										<option value="1">
											男
										</option>
										<option value="0">
											女
										</option>
									</select>
								</div>
							</div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>手机号</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="phone">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>加入时间</label>
	                            <div class="col-sm-10">
	                                <input type="text " name="joinTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" size="12">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">QQ</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="qq">
	                            </div>
	                        </div>
	                        
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_user">新增</button>
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
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
</body>
<script type="text/javascript">
	$(function(){
		$("#add_user").click(function(){
			//用户名
			var userName = $.trim($("input[name='userName']").val());
			//密码
			var password = $.trim($("input[name='password']").val());
			//真实姓名
			var realName = $.trim($("input[name='realName']").val());
			//性别
			var sex = $("#sex").val();
			//手机号
			var phone = $.trim($("input[name='phone']").val());
			//加入时间
			var joinTime = $.trim($("input[name='joinTime']").val());
			//QQ
			var qq = $.trim($("input[name='qq']").val());
			
			var flag = validate(
				userName,"请输入用户名!",
				password,"请输入密码!",
				realName,"请输入真实姓名!",
				phone,"请输入手机号!",
				joinTime,"请选择加入时间"
			);
			if(flag){
				$.ajax({
					url:"${cp}/user/add",
					type:"post",
					data:{	userName:userName,
							password:password,
							realName:realName,
							phone:phone,
							qq:qq,
							sex:sex,
							joinTime:joinTime
							},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("user");
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4,date5,msg5){
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
			}
			return true;
		}
	});
</script>
</html>
