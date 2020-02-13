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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>消息推送</title>
    <link href="favicon.ico" rel="shortcut icon"> 
    <link rel="stylesheet" href="css/index-css.css">
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>消息推送</h5>
                    </div>
                    <div class="ibox-content form-horizontal">
                    	<form action=""></form>
                   		<h4>状态</h4>
                   		<div class="tasks" style="border-bottom:0px;">
                  				<ul class="listTasks" style="width: 100%;margin-left:30%;">
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${sum}</span><span class="text">剩余推送次数</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${count}</span><span class="text">当前接收人数</span></a></li>
								</ul>
						</div>
                        <!-- 虚线效果 -->
						<div class="hr-line-dashed"></div>
						<h4>推送</h4>
                         <div class="form-group">
	                       	  	 <label class="col-sm-2 control-label"><font color="red">*</font>选择消息模板</label>
	                       		 <div class="col-sm-8">
									 <select class="form-control m-b" id="pattern" name="id">
										<option value="0">-请选择-</option>
										<c:forEach items="${list}" var ="each">
											<option value="${each.id }">${each.title }</option>
										</c:forEach>
									</select>
								 </div>
								 <div>
	                            	<button class="btn btn-primary" type="button" id="redpacktModel">发送</button>
	                                <button class="btn btn-primary" type="button" onclick="purchaselist()">推送记录</button>
                            	</div>
						   </div>
					</div>
				</div>
			</div>
		</div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
	<script type="text/javascript">
		function purchaselist(){
			layer.open({
			  type: 2,
			  title: '推送记录',
			  shadeClose: true,
			  shade: 0.8,
			  area: ['1200px', '90%'],
			  content: 'push/history' //iframe的url
			});
		}
	
		$("#redpacktModel").on("click",function(){
			var id = $("#pattern").val();
			if(id==0){
				layer.msg("请选择消息模板")
				return;
			}
			if(${sum}==0){
				layer.msg("本月推送次数已用完")
				return;
			}
			if(${count}==0){
				layer.msg("当前接收人数为0")
				return;
			}
			$.ajax({
					url:"${cp}/push/send",
					type:"post",
					data:{	
						id:id
					},
					dataType:"json",
					success:function(data){
						 swal({
						        title: "发送成功,"+data.sum+"人已接收到消息",
						        type: "success",
						        confirmButtonColor: "#DD6B55",
						        confirmButtonText: "确定",
						        closeOnConfirm: false
						    }, function (isConfirm) {
						    	if(isConfirm){
						    		location.reload();
							    }
						    });
					}
				});
			
		});
	</script>
</body>
</html>
