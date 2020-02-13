<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>提现申请列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <script type="text/javascript" src="${cp }/manager/js/date/WdatePicker.js"></script>
    <style>
    	td{
			word-wrap: break-word;
			white-space:nowrap; 
			word-break:keep-all; 
			overflow:hidden; 
			text-overflow:ellipsis;
		}
		.list{ background:none repeat scroll 0 0; margin:0px auto;  width:100%; table-layout:fixed; border:1px solid #a1bcdb; }
		.list td{ border:1px solid #a1bcdb; word-break:break-all; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; -o-text-overflow:ellipsis; }
    	.sweet-alert p{
    		margin: 5px;
    		margin-bottom: 10px;
    	}
	    	
		#div1{
	        width: 48px;
	        height: 25px;
	        border-radius: 50px;
	        position: relative;
	    }
	    #div2{
	        width: 23px;
	        height: 20px;
	        border-radius: 48px;
	        position: absolute;
	        background: white;
	        box-shadow: 0px 2px 4px rgba(0,0,0,0.4);
	    }
	    .open1{
	        background: rgba(0,184,0,0.8);
	    }
	    .open2{
	        top: 2px;
	        right: 1px;
	    }
	    .close1{
	        background: rgba(255,255,255,0.4);
	        border:3px solid rgba(0,0,0,0.15);
	        border-left: transparent;
	    }
	    .close2{
	        left: 0px;
	        top: 0px;
	        border:2px solid rgba(0,0,0,0.1);
	    }
	    .button {
		    background-color: #1AB394; /* Green */
		    border: none;
		    color: white;
		    padding: 1px 6px;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		    font-size: 16px;
		    border-radius:4px;
		}
		.myCode{
		    width: 33px;
		    height: 25px;
			padding: 0px;
		}
		.shoukuan{
			display: none;
		}
		.shoukuan {
			z-index: 99;
			display: none;
			background-color: #fff;
			width: 80%;
			position: absolute;
			left: 10%;
			top: 8%;
			border-radius: 5px;
		}
		.qrcodeBox {
		    background-color: #fff;
		    border: 1px solid #cfcfcf;
		    border-radius: 4px;
		    height: 180px;
		    left: 80px;
		    margin-top: -58px;
		    padding: 5px;
		    position: absolute;
		    width: 180px;
		    z-index: 1000;
		}
		.qrcodeIcon {
		    background-image: url("images/ermIcon.png?v=201507271756");
		    background-position: 11px 10px;
		    background-repeat: no-repeat;
		    display: inline-block;
		    height: 25px;
		    width: 33px;
		}
		.all{
			width:100%;
			top:92px;
			left:48px;
			position:absolute;
			float: left;
		}
		.all #deal{
			margin-left: 74%;
			margin-top: 6px;
		}
    </style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>提现申请列表</h5>
	                    <form name="form2" action="" method="post">
							<input type="hidden" name="_method" value="delete"/>
						</form>
                    	<div class="ibox-content" style="padding: 3px 17px 17px;">
							<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid" style="padding-bottom:15px;">
								<form action="${pageContext.request.contextPath }/withdrawalres" method="get">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="DataTables_Table_0_filter" style="width:700px;">
												<label>
					                        		查找：
						                        	<input type="text" name="staticTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" placeholder="提交时间" value="${staticTime }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="height: 26px; width: 170px;"/>
						                        	<input type="submit" class="btn btn-sm btn-primary" value="搜索"> 
												</label>
											</div>
										</div>
										<div class="col-sm-6">
											<div id="DataTables_Table_0_length" class="dataTables_filter"  >
												<label>每页
													<select class="form-control input-sm" aria-controls="DataTables_Table_0" name="pageSize" onchange="javascript:this.form.submit();">
														<c:if test="${pageSize!=null}">
															<option value="${pageSize }">${pageSize }</option>
														</c:if>
														<option value="10">10</option>
														<option value="25">25</option>
														<option value="50">50</option>
														<option value="100">100</option>
													</select> 条记录
												</label>
											</div>
										</div>
										<div class="all">
											<input id="choBu" type="button" class="btn btn-sm btn-primary" value="全选">
											<input id="reserve" type="button" class="btn btn-sm btn-primary" value="反选">
											<input id="deal" type="button" class="btn btn-sm btn-primary" value="批量审核">
										</div>
                 				  	</form>
								</div>
							</div>
	                      	<table class="table table-striped table-bordered table-hover dataTables-example" id="editable">
	                          	<input type="button" class="btn btn-sm btn-primary" onclick="updownexel()" value="导出execl表格" style="float: right;"/>
	                            <thead>
	                                <tr>
                                    	<!--<th>收款码</th>-->
                                    	<th></th>
                                    	<th>提现用户</th>
                                    	<th>提现金额</th>
                                    	<th>提交时间</th>
                                    	<th width="4%">处理</th>
                                    	
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal" class="list">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<!--<td width="60px">
		                            			<div class="qrcodeIcon" _style="16" _id="5" src="images/09143302.png" class="myCode" onmousemove="showImg('${items.id }')" onmouseout="hideImg('${items.id }')"></div>
												<div class="qrcodeBox" style="display:none"  id="code${items.id }"><img src="wresource/url?url=${items.url }" style="height:100%;width:100%;" /></div>
		                            		</td>
		                            		-->
		                            		<td width="30px">
		                            			<input type="checkbox" name="recs" value="${items.id }" class="cho">
		                            		</td>
		                            		<td>
		                            			${items.member.id }
		                            		</td>
		                            		<td>
		                            			${items.money}
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.startDate}" pattern="yyyy-MM-dd HH:mm:ss"	type="both" />
		                            		</td>
		                            		<td>
		                            			<button class="button" onclick="audit('${items.id }')">通过</button>
		                            			<button class="button" onclick="record('${items.id }')">红包记录</button>
		                            		</td>	
	                            		</tr>
	                            	</c:forEach>
	                            </tbody>
	                        </table>
	                        <div method="post" id="tableForm">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        <tbody>
		                            <tr>
		                                <td align="center" class="pn-sp">
		                                    <form id="paging" action="withdrawalres" method="get">
		                                        <%@include file="paging.jsp" %>
		                                    </form>
		                                </td>
		                            </tr>
		                        </tbody>
		                    </table>
	                 	</div>	
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$(".list td").each(function(i){
	            //给td设置title属性,并且设置td的完整值.给title属性.
	        	$(this).attr("title",$(this).text());
	      	});
    	});
    	function updownexel(){
    		var status = $.trim($("input[name='status']").val()); 
    		var num = $.trim($("input[name='num']").val());
    		var staticTime = $.trim($("input[name='staticTime']").val());
    		window.location.href="recharge/out?num="+num+"&status="+status+"&staticTime="+staticTime;
    		
    	}
    	function audit(id){
			swal({
        		title: "您确定要通过这条提现申请么",
       			text: "通过后将不能再做修改，请谨慎操作!",
        		type: "warning",
       			showCancelButton: true,
        		confirmButtonColor: "#DD6B55",
       			confirmButtonText: "通过",
        		closeOnConfirm: false
    		}, function (isConfirm) {
    			post_flag = true;
		    	if(isConfirm){
			       $.ajax({
				   		type:"post",
						url:"${cp}/withdrawalres",
						dataType:"json",
						data:{
							id:id
						},
						success:function(data){
							if(data.flag){
								swal({
									title: "GOOD", 
									text: "审核通过", 
									type: "success",
									confirmButtonText: "是的",
									confirmButtonColor: "#ec6c62"
									}, function() {
										window.location.href="withdrawalres";
								});
							}else{
								 swal({
									title: "审核失败", 
									text: data.msg, 
									type: "error",
									confirmButtonText: "确定",
									confirmButtonColor: "#ec6c62",
									closeOnConfirm: false
									}, function(isConfirm) {
										if(isConfirm){
											location.reload();
										}
								});
							}
						}
					});
			     }
		    });
		}
		function showImg(id){
			$("#code"+id).css("display","block");
		}
		function hideImg(id){
			$("#code"+id).css("display","none");
		}
		var flag = true;
		$(function () {
			//全选或全不选
			$("#choBu").click(function(){   
		    	if(flag){   
		        	$(".cho").prop("checked", true);  
		        	flag = false;
		        	$("#choBu").val("全不选");
		    	}else{   
					$(".cho").prop("checked", false);
					flag = true;
					$("#choBu").val("全选");
		    	}   
 		});
 			
		 	//反选 
		    $("#reserve").click(function () { 
		   		 var  CheckBox=$(".cho");
		   		  for(i=0;i<CheckBox.length;i++){
		   		  	if(CheckBox[i].checked){
		   		  		CheckBox[i].checked = false;
	   		  			$("#choBu").val("全选");
   		  				flag = true;
		   		  	}else{
		   		  		CheckBox[i].checked = true;
	   		  			$("#choBu").val("全选");
   		  				flag = true;
		   		  	}
               }
		    }); 
		    //批量审核
		    $("#deal").click(function () { 
	    	 	swal({
	        		title: "您确定要通过选中的提现申请么",
	       			text: "通过后将不能再做修改，请谨慎操作!",
	        		type: "warning",
	       			showCancelButton: true,
	        		confirmButtonColor: "#DD6B55",
	       			confirmButtonText: "通过",
	        		closeOnConfirm: false
    		}, function (isConfirm) {
		    	if(isConfirm){
	    		   var CheckBox=$(".cho");
	    	 	   var arr = new Array();
    	 	 	   for(i=0;i<CheckBox.length;i++){
   	 	 	       	    arr[i] = CheckBox[i].value;
              	   }
			       $.ajax({
				   		type:"post",
						url:"${cp}/withdrawalres",
						dataType:"json",
						data:{
							"ids":arr
						},
						traditional: true,
						success:function(data){
							if(data.flag){
								swal({
									title: "GOOD", 
									text: "审核通过", 
									type: "success",
									confirmButtonText: "确定",
									confirmButtonColor: "#ec6c62",
									closeOnConfirm: false
									}, function(isConfirm) {
										if(isConfirm){
											location.reload();
										}
								});
							}else{
								 swal({
									title: "审核失败", 
									text: data.msg, 
									type: "error",
									confirmButtonText: "确定",
									confirmButtonColor: "#ec6c62",
									closeOnConfirm: false
									}, function(isConfirm) {
										if(isConfirm){
											location.reload();
										}
								});
							}
						}
					});
			     }
		    });
		    }); 
 		});
 		
		function record(id){
			layer.open({
				type: 2,
				title: '红包记录',
				shadeClose: true,
				moveOut: true,
				shade: 0.8,
				area: ['1500px', '80%'],
				content: "redpacket/rm?id="+id
			});	
		} 		
    </script>
</body>
</html>