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
    

    <title>用户信息修改</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>用户管理-修改</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>用户名</label>
	                            <div class="col-sm-10">
	                            	<input type="hidden" name="id" value="${user.id }">
	                                <input type="text" class="form-control" name="userName" value="${user.username }" readonly="readonly">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>密码</label>
	                            <div class="col-sm-10">
	                                <input type="password" class="form-control" name="password" value="${user.password }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>真实姓名</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="realName" value="${user.realName }">
	                           </div>
	                        </div>
	                        <div class="form-group">
                                <label class="col-sm-2 control-label"><font color="red">*</font>性别</label>
                                <div class="col-sm-10">
                                    <select id="sex" name="sex">
                                        <option value="0" <c:if test="${user.sex=='1' }">selected</c:if>>
                                          男
                                        </option>
                                        <option value="1" <c:if test="${user.sex=='0' }">selected</c:if>>
                                          女
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>手机号</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="phone" value="${user.phone }">
	                           </div>
	                        </div>
	                        <div class="form-group">
                                <label class="col-sm-2 control-label"><font color="red">*</font>账户状态</label>
                                <div class="col-sm-10">
                                    <select id="status" name="status">
                                        <option value="1" <c:if test="${user.status=='1' }">selected</c:if>>
                                          正常
                                        </option>
                                        <option value="2" <c:if test="${user.status=='2' }">selected</c:if>>
                                          冻结
                                        </option>
                                    </select>
                                </div>
                            </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label">QQ</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="qq" value="${user.qq }">
	                           </div>
	                        </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">离开时间</label>
                                <div class="col-sm-10">
                                    <input type="text " name="leaveTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" size="12" value="<fmt:formatDate value="${user.leaveTime}" pattern="yyyy-MM-dd" />">
                                </div>
                            </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                            	<button class="btn btn-primary" type="button" id="update_user">修改</button>
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
</body>
<script>
	$(function(){
		$("#update_user").click(function(){
			//密码
			var password = $.trim($("input[name='password']").val());
			//真实姓名
			var realName = $.trim($("input[name='realName']").val());
			//手机号
			var phone = $.trim($("input[name='phone']").val());
			//性别
			var sex = $("#sex").val();
			//账户状态
			var status = $("#status").val();
			//QQ
			var qq = $.trim($("input[name='qq']").val());
			//离开时间
			var leaveTime = $.trim($("input[name='leaveTime']").val());
			//id
			var id = $.trim($("input[name='id']").val());
			var flag = validate(
				password,"请输入密码!",
				realName,"请输入真实姓名!",
				phone,"请输入手机号!"
			);
		 	if(flag){
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath }/user/"+id,
					dataType:"json",
					data:{	password:password,
							realName:realName,
							phone:phone,
							qq:qq,
							sex:sex,
							status:status,
							leaveTime:leaveTime,
							_method:"put"},
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
