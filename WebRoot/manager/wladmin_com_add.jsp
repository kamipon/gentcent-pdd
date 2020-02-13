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
    

    <title>佣金设置</title>

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
                        <h5>佣金设置-新增</h5>
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
	                            <label class="col-sm-2 control-label">销售部佣金</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="moneysale">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">市场部佣金</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="moneymarket">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">物流部佣金</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="moneywl">
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                                  <button class="btn btn-primary" type="button" id="add">新增</button>
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
		$("#add").click(function(){
			//名称
			var name = $.trim($("input[name='name']").val());
			var moneysale = $.trim($("input[name='moneysale']").val());
			var moneymarket = $.trim($("input[name='moneymarket']").val());
			var moneywl = $.trim($("input[name='moneywl']").val());
			var flag = validate(
							name,"请输入名称!",
							moneysale,"请输入销售部佣金!",
							moneymarket,"请输入市场部佣金!",
							moneywl,"请输入物流部佣金!"
						);
			if(flag){
				$.ajax({
					url:"${cp}/wladmin/com/add",
					type:"post",
					data:{
						name:name,
						moneysale:moneysale,
						moneymarket:moneymarket,
						moneywl:moneywl
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							closeTabAndGo("wladmin/com");
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4){
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
			return true;
		}
	});
</script>