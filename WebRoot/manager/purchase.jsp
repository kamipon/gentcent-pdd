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
    <title>短信购买</title>
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
                        <h5>短信购买</h5>
                    </div>
                    <div class="ibox-content form-horizontal">
                    	<form action=""></form>
                   		<h4>账户信息</h4>
                   		<div class="tasks" style="border-bottom:0px;">
                  				<ul class="listTasks" style="width: 100%;margin-left:30%;">
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${name}</span><span class="text">账户</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${noteTotal}</span><span class="text">总条数</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${residue}</span><span class="text">剩余条数</span></a></li>
								</ul>
						</div>
                        <!-- 虚线效果 -->
						<div class="hr-line-dashed"></div>
						<h4>短信套餐</h4>
                        <div class="form-group">
                        	<table class="table table-striped table-bordered table-hover dataTables-example" id="editable" 
                        	style="table-layout:fixed;">
	                            <thead>
	                                <tr>
	                                    <th>套餐一</th>
	                                    <th>套餐二</th>
                                    	<th>套餐三</th>
                                    	<th>套餐四</th>
	                                </tr>
	                            </thead>
	                            <tbody>
                            		<tr>
                            			<td>100元，1000条</td>
                            			<td>440元，5000条</td>
                            			<td>780元，10000条</td>
                            			<td>3500元，50000条</td>
                            		</tr>
                            		<tr>
                            			<td><input onclick="purchase(1)" name="setMeal" class="btn btn-primary" type="button" value="购买"  id="tao1"/></td>
                            			<td><input onclick="purchase(2)" name="setMeal" class="btn btn-primary" type="button" value="购买"  id="tao2"/></td>
                            			<td><input onclick="purchase(3)" name="setMeal" class="btn btn-primary" type="button" value="购买"  id="tao3"/></td>
                            			<td><input onclick="purchase(4)" name="setMeal" class="btn btn-primary" type="button" value="购买"  id="tao4"/></td>
                            		</tr>
	                            </tbody>
	                        </table>
	                        <div><input style="float:right;" class="btn btn-primary" type="button" value="购买记录" onclick="purchaselist()"/></div>
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
			  title: '购买记录',
			  shadeClose: true,
			  shade: 0.8,
			  area: ['1200px', '90%'],
			  content: 'note/purchaselist' //iframe的url
			});
		}
		function purchase(n){
			var count = 0;
			var price = 0;
			var tao = n;
			if(n==1){
				count = 1000;
				price = 100;
				tao = "一";
			}else if(n==2){
				count = 5000;
				price = 440;
				tao = "二";
			}else if(n==3){
				count = 10000;
				price = 780;
				tao = "三";
			}else if(n==4){
				count = 50000;
				price = 3500;
				tao = "四";
			}
			swal({
		        title: "您确定要购买套餐"+tao+"吗？",
		        text: price+"元，"+count+"条。",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "确定",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
		    	 location.href = "note/pay?price="+price+"&&count="+count;
			    }
		    });
		}
	</script>
</body>
</html>
