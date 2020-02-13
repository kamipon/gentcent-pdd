<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
<c:set var="cp" value="<%=request.getContextPath()%>"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>">

		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>活动互动系统-订单列表</title>
		<link rel="shortcut icon" href="favicon.ico">
		<link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
		<link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
		<link href="css/plugins/dataTables/dataTables.bootstrap.css"
			rel="stylesheet">
		<link href="css/animate.min.css" rel="stylesheet">
		<link href="css/style.min1fc6.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css"
			href="css/plugins/sweetalert/sweetalert.css">
	</head>
	<body class="gray-bg">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>
								兑奖名单
							</h5>
						</div>
						<form name="form2" action="" method="post">
							<input type="hidden" name="_method" value="delete" />
						</form>
						<div class="ibox-content">
							<div id="DataTables_Table_0_wrapper"
								class="dataTables_wrapper form-inline" role="grid">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
												<input type="text" id="phone" placeholder="根据手机号查询">
												<input type="button" class="btn btn-sm btn-primary"
													value="搜索" id="search">
											</label>
										</div>
									</div>
									<div style="margin-left: 80%; margin-top: 0px">
										<input type="button" class="btn btn-sm btn-primary"
											value="退出登录" id="tuichu">
									</div>
								</div>
							</div>
							<div id="title1">
							</div>
							<table
								class="table table-striped table-bordered table-hover dataTables-example"
								id="editable1" style="table-layout: fixed">
								<thead id='idsTitle'>
								</thead>
								<tbody id="idsVal">
								</tbody>
							</table>
							<div id="title2" style="margin-top:50px">
							</div>
							<table
								class="table table-striped table-bordered table-hover dataTables-example"
								id="editable2" style="table-layout: fixed">
								<thead id="idsTitle2">
								</thead>
								<tbody id="idsVal2">
								</tbody>
							</table>
							<div id="title3" style="margin-top:50px">
							</div>
							<table
								class="table table-striped table-bordered table-hover dataTables-example"
								id="editable3" style="table-layout: fixed">
								<thead id="idsTitle3">
								</thead>
								<tbody id="idsVal3">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<script src="js/jquery.min63b9.js?v=2.1.4"></script>
			<script type="text/javascript" src="js/childrenToMenu.js"></script>
			<script type="text/javascript"
				src="js/plugins/sweetalert/sweetalert.min.js"></script>
			<script src="js/layer/layer.js"></script>
			<script type="text/javascript">
    	Date.prototype.toLocaleString = function() {
  			return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() + " " + this.getHours() + ":" + this.getMinutes() + ":" + this.getSeconds();
  		};
    	$("#search").on("click",function(){
    		var phone = $("#phone").val();
    		var act = "${act}";
    		$.ajax({
    			url:"hx",
    			type:"post",
    			data:{
    				phone:phone,
    				act:act
    			},
 				success:function(data){
	 				if(data.list.length>0){
	 					var htm = "";
	 					var htm2 = "";
	 					var htmA = "<h2 style='text-align:center'>砍价订单</h2>"+"<hr/>";
 						$("#title1").html(htmA);
	 					htm2+="<tr>"
		                           +	"<th>订单码</th>"
		                           + 	"<th>商品名称</th>"
		                           + 	"<th>用户</th>"
		                           + 	"<th>姓名</th>"
		                           + 	"<th>手机号</th>"
		                           + 	"<th>当前金额</th>"
		                           + 	"<th>创建时间</th>"
		                           + 	"<th>到期时间</th>"
		                           + 	"<th>状态</th>"
		                           + 	"<th>操作</th>"	                           
	                      	  +"</tr>"
	                    $("#idsTitle").html(htm2);  	 
	 					var arr = data.list;
	 					for(var i=0;i<arr.length;i++){
	 						eval("var id='"+arr[i].id+"'");
	 						var type = arr[i].state;
	 						var ht;
	 						var inp = "<input type='button' class='btn btn-sm btn-primary'  value='兑换'  onclick=suc('"+id+"',1)>	<input type='button'  class='btn btn-sm btn-primary'  value='失效'  onclick=suc('"+id+"',2)>";
							if(type==0||type==1){
								ht = "<span style='color:green'>未兑奖</span>";
							}else if(type==3){
								ht = "<span style='color:red'>已兑奖</span>"
								inp = "";
							}else{
								ht = "<span style='color:red'>失效</span>";
								inp = "";
							}
	 						var sta = new Date(arr[i].createDate).toLocaleString();
	 						var end = new Date(arr[i].endDate).toLocaleString();
	 						htm+="<tr>"
		                          	+	"<td>"
		                          	+		arr[i].orderCode
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr[i].commodityName
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr[i].memberName
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr[i].name 
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr[i].phone
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr[i].money 
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		sta
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		end
		                          	+	"</td>"
	                          		+	"<td>"
	                          		+		ht
	                            	+	 "</td>"
		                          	+	"<td>"
		                          	+		inp
		                          	+	"</td>"
	                    	  +	"</tr>"
	 					}
	 					$("#idsVal").html(htm);
	 				}
	 					
					if(data.list4.length>0){
						var htm3 = "";
						var htm4 = "";
						var htmB = "<h2 style='text-align:center'>实物订单</h2>"+"<hr/>";
						$("#title2").html(htmB);
						htm4+="</tr>"
		 						 +"<tr>"
		                         +"<th>订单码</th>"
		                         +"<th>实物名称</th>"
		                         +"<th>所属活动</th>"
	                             +"<th>用户</th>"
	                             +"<th>手机号</th>"
	                             +"<th>当前金额</th>"
	                             +"<th>领取时间</th>"
	                             +"<th>状态</th>"
	                             +"<th>操作</th>"	                           
	                   		+ "</tr>"
	                    $("#idsTitle2").html(htm4);
						var arr2 = data.list4;
						for(var i=0;i<arr2.length;i++){
							eval("var id='"+arr2[i].id+"'");
							var type2 = arr2[i].status;
							var ht2;
							var inp2 = "<input type='button' class='btn btn-sm btn-primary'  value='兑换'  onclick=suc('"+id+"',3)>	<input type='button'  class='btn btn-sm btn-primary'  value='失效'  onclick=suc('"+id+"',4)>";
						if(type2==1){
							ht2 = "<span style='color:green'>已领取</span>";
						}else if(type2==2){
							ht2 = "<span style='color:red'>已失效</span>"
							inp2 = "";
						}
							htm3+= 	"<tr>"
							  		+	"<td>"
	                          	+		arr2[i].code
	                          	+	"</td>"
	                          	+	"<td>"
	                          	+		arr2[i].goodsName
	                          	+	"</td>"
	                          	+	"<td>"
	                          	+		arr2[i].activity
	                          	+	"</td>"
	                          	+	"<td>"
	                          	+		arr2[i].memberName
	                          	+	"</td>"
	                          	+	"<td>"
	                          	+		arr2[i]. phone
	                          	+	"</td>"
	                          	+	"<td>"
	                          	+		arr2[i]. money
	                          	+	"</td>"
	                          	+	"<td>"
	                          	+		arr2[i]. addTime
	                          	+	"</td>"
	                         	+	"<td>"
	                         	+		ht2
	                           	+	 "</td>"
	                          	+	"<td>"
	                          	+		inp2
	                          	+	"</td>"
	                        	+	"</tr>"
						}
						$("#idsVal2").html(htm3);
					}
					
					if(data.list7.length>0){
						var htm5 = "";
	 					var htm6 = "";
	 					var htmC = "<h2 style='text-align:center'>优惠券订单</h2>"+"<hr/>";
	 					$("#title3").html(htmC);
	 					htm6+="<tr>"
		                         +"<th>订单码</th>"
		                         +"<th>优惠券名称</th>"
		                         +"<th>所属活动</th>"
	                             +"<th>用户</th>"
	                             +"<th>手机号</th>"
	                             +"<th>当前金额</th>"
	                             +"<th>领取时间</th>"
	                             +"<th>状态</th>"
	                             +"<th>操作</th>"	                           
		                   	+ "</tr>"
		                    $("#idsTitle3").html(htm6);
	 					var arr3 = data.list7;
	 					for(var i=0;i<arr3.length;i++){
	 						eval("var id='"+arr3[i].id+"'");
	 						var type3 = arr3[i].status;
	 						var ht3;
	 						var inp3 = "<input type='button' class='btn btn-sm btn-primary'  value='兑换'  onclick=suc('"+id+"',5)>	<input type='button'  class='btn btn-sm btn-primary'  value='失效'  onclick=suc('"+id+"',6)>";
							if(type3==1){
								ht3 = "<span style='color:green'>已领取</span>";
							}else if(type3==2){
								ht3 = "<span style='color:red'>已失效</span>"
								inp3 = "";
							}
	 						htm5+= 	"<tr>"
	 						  		+	"<td>"
		                          	+		arr3[i].code
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr3[i].couponName
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr3[i].activity
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr3[i].memberName
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr3[i]. phone
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr3[i]. money
		                          	+	"</td>"
		                          	+	"<td>"
		                          	+		arr3[i]. addTime
		                          	+	"</td>"
	                          		+	"<td>"
	                          		+		ht3
	                            	+	 "</td>"
		                          	+	"<td>"
		                          	+		inp3
		                          	+	"</td>"
	                         	+	"</tr>"
	 					}
	 					$("#idsVal3").html(htm5);
					}
 				}   		
    		});
    	});
    	
    	function suc(id,num){
    		var ti =  null;
    		if(num==1||num==3||num==5){
    			ti = "请确认已兑奖";
    		}
    		if(num==2||num==4||num==6){
    			ti = "确认将此订单失效";
    		}
	   		swal({
		        title: ti,
		        type: "warning",
		        showCancelButton:true,
		        closeOnConfirm:false,
		        confirmButtonText:"确认",
		        cancelButtonText:"取消",
		    	},
		    
		    function(){
			    var ti2 = null;
			    if(num==1||num==3||num==5){
    				ti2 = "兑奖成功！";
		   		}
		   		if(num==2||num==4||num==6){
		   			ti2 = "操作成功！";
		   		}
		    	$.ajax({
	    			url:"hx/"+id,
	    			type:"post",
	    			data:{
	    				_method:"put",
	    				num:num
	    			},
	    			success:function(){
	    				swal({title:ti2,type:"success"},function(){
	    						$("#search").click();
							});
	    			}
	    		});
	    		}
    		);
    	};
    	
    	$("#tuichu").on("click",function(){
    		location.href = "user/logOut";
    	});
    </script>
	</body>
</html>