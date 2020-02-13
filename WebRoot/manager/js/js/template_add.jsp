<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>模板管理-新增</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
	
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>模板管理-新增</h5>
                    </div>
                    <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">jsp名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="jspName">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">模板类型</label>
	                            <div class="col-sm-10">
	                                <select class="form-control m-b" id="type" name="type">
										<option value="1" <cp:if test="${item.type == '1'}"></cp:if> 主页</option>
										<option value="2" <cp:if test="${item.type == '2'}"></cp:if> 栏目</option>
										<option value="3" <cp:if test="${item.type == '3'}"></cp:if> 内容</option>
										<option value="4" <cp:if test="${item.type == '4'}"></cp:if> 简介</option>
									</select>
	                            </div>
	                        </div>
	                        
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">浏览模板类型</label>
	                            <div class="col-sm-10">
	                                <select  class="form-control m-b" id="browseType" name="browseType">
										<option value="1" <cp:if test="${item.browseType == '1'}"></cp:if>网页</option>
										<option value="2" <cp:if test="${item.browseType == '2'}"></cp:if>手机</option>
									</select>
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
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
</body>


</html>
<script >
	$(function(){
		$("#add_activity").click(function(){
			//名称
			var name = $.trim($("input[name='name']").val());
			//jsp名称
			var jspName = $.trim($("input[name='jspName']").val());
			//保存路径
			var root = $.trim($("input[name='root']").val());
			//模板类型
			var type = $("#type").val();
			//浏览模板类型
			var browseType=$("#browseType").val();
			
			var flag = validate(
							name,"请输入名称!",
							jspName,"请输入jsp名称!"
						);
			if(flag){
				$.ajax({
					url:"${cp}/template/add",
					type:"post",
					data:{name:name,jspName:jspName,type:type,browseType:browseType},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							closeTabAndGo("template");
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