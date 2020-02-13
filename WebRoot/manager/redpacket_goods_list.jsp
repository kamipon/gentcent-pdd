<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ResourceBundle res = ResourceBundle.getBundle("11erp");
%>
<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <title>红包列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <script type="text/javascript" src="manager/js/jquery.js"></script>
    <style type="text/css">
    	.qrcodeIcon {
		    background-image: url("images/ermIcon.png?v=201507271756");
		    background-position: 11px 10px;
		    background-repeat: no-repeat;
		    display: inline-block;
		    height: 25px;
		    width: 33px;
		}
		.qrcodeBox {
		    background-color: #fff;
		    border: 1px solid #cfcfcf;
		    border-radius: 4px;
		    height: 150px;
		    left: 80px;
		    margin-top: -58px;
		    padding: 5px;
		    position: absolute;
		    width: 150px;
		    z-index: 1000;
		}
    </style>
	<script type="text/javascript">
	function showImg(index){
		document.getElementById("wxImg"+index).style.display='block';
	}
	function hideImg(index){
		document.getElementById("wxImg"+index).style.display='none';
	}
	
	</script>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>红包列表</h5>
                    </div>
                   <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" >
							<form action="redpacket/goods_red" method="post" >
								<input type="hidden" name="_method" value="put" />
								<input type="hidden" name="id" value="${activity.id}">
								<div class="row" style="width: 100%;height:40px">
	                           	    <div id="money" style="margin-top: -7px;margin-left: 10px;position: relative;width:48%;height: 50px" class="col-sm-5">
										<input  class="start1" name="start1"  placeholder="请输入开始位置编码" style="width:180px;margin-top: 20px" onchange="change1(this)">
										<input class="end1" name="end1" placeholder="请输入结束位置编码"  style="width: 180px;" onchange="change2(this)"/>
										<span>实物:</span>
										<select name="coupon" id="coupon">
											<option value="">--请选择实物--</option>
											<c:forEach items="${couList}" var="each">
												<option value="${each.id }">${each.title }</option>
											</c:forEach>
										</select>
										<button class="btn btn-primary" type="button" id="redpacktModel">绑定</button>
									</div>
	                           	     <div class="col-sm-3" style="margin-left: 42%;margin-top:-35px;width:45%" id="sear"> 
										<div class="dataTables_length" id="DataTables_Table_0_filter" >
											<label>
												查找：
					                        	<input type="text"  name="redMoney" placeholder="根据实物价格查询">
					                        	<input type="text"  name="code" placeholder="根据红包码查询">
				                        		<select id="sta" style="height:25px">
					                        		<option value="0">--根据红包状态查询--</option>
					                        		<option value="yes">已领取</option>
					                        		<option value="no">未领取</option>
					                        	</select>
					                        	<input type="button" onclick="query()" class="btn btn-sm btn-primary" value="搜索"> 
											</label>
										</div>
									</div>
	                           	    <div style="margin-left: 90%;margin-top: -9px">
										<input id="export" class="btn  btn-primary" onclick="exportExcel()" value="导出二维码Excle"  type="button">
										<input id="export" class="btn  btn-primary" onclick="exportZip()" value="导出二维码图片"  type="button">
									</div>
               				  </form>
							</div>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed;margin-top: 10px">
	                            <thead class="pn-lthead">
	                                <tr >
	                                	<th style="width: 5%">二维码</th>
	                                	<th >序号</th>
	                                    <th>所属活动</th>
                                    	<th>实物价格</th>
                                    	<th>领取状态</th>    
                                    	<th>领取时间</th>                              
	                                </tr>
	                            </thead>
	                            <tbody id="user" style="height: 10%">
	                            	<c:forEach items="${list}" var="items" varStatus="status">
	                            		<tr  <c:if test="${items.status==1 }">style="color: green;"</c:if> <c:if test="${items.status==2 }">style="color: red;"</c:if> >
		                            		<td>
			                                	<div class="qrcodeIcon" _style="16" _id="5" onMouseOut="hideImg('${status.index }')"  onmouseover="showImg('${status.index }')"></div>
			                                    <div class="qrcodeBox" style="display: none;" id="wxImg${status.index }">
			                                    	<div class="inIcon"></div>
													<img alt="Wxmenu" src="wresource/url?url=<%=res.getString("project.host")%>/item/${items.id }" style="height:100%;width:100%;">
												</div>
                            				</td>
		                            		<td>
		                            			${items.code }
		                            		</td>
		                            		<td>
	                            				${activity.name}           			
	                            			</td>
		                            		<td>
		                            			${items.money}
		                            		</td>
		                            		<td id="status">
		                            		<c:if test="${items.status==1 }">
												未领取
											</c:if>
											<c:if test="${items.status==2 }">
												已领取
											</c:if>
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.overTime}" dateStyle="long" timeStyle="long"	type="both" />
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
		                                    <form id="paging" action="redpacket/list" method="get">
		                                    	<input name="type" value="2" type="hidden" />
		                                    	<input type="hidden"  value="${noUse }" name="noUse">
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
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="js/mui.min.js"></script>
</body>
<script>
		var noUse = $("#sta").val();
		var reg =/^[1-9]+[0-9]*]*$/;
		var check1=true;
		var check2=true;
		function change1(obj){
			 var num=$(".start1").val();
			 if(num<1||reg.test(num)){
				 check1=false;
			 }else{
				 check1=true;
			 }
		}
		
		function change2(obj){
			 var total=${total};
			 var num=$(".end1").val();
			 var num2=$(".start1").val();
			 if(total<num&&num<num2){
				
				 check2=false;
				 
			 }else{
				 check2=true;
			 }
		}
		
		function query(){
			var noUse = $("#sta").val();
			var money = $.trim($("input[name='redMoney']").val());
			if(isNaN(money)){
				layer.msg("实物金额应为数字");
				return;
			}
			var code = $.trim($("input[name='code']").val());
			window.location.href="redpacket/list?money="+money+"&&code="+code+"&&type=2&&noUse="+noUse;
		}


	$(function(){
		$("#redpacktModel").click(function(){
			var coupon = $("#coupon").val();
			var start1=$.trim($("input[name='start1']").val());
			var end1=$.trim($("input[name='end1']").val());
			 var flag = validate(
						check1,"起始码错误",
						check2,"结束码错误",
						coupon,"请选择实物"
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"redpacket/bindGoods",
					dataType:"json",
					async:false,
					data:{	
						coupon:coupon,
						'_method':'put',
						start1:start1,
						end1:end1,
					},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							setTimeout(function(){window.location.reload();},500);
						}else{
							layer.msg(data.msg);
						}
					}
				});		 	
		 	}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3){
			if(!date1){
				layer.msg(msg1);
				return false;
			}
			if(!date2){
				layer.msg(msg2);
				return false;
			}
			if(date3==""){
				layer.msg(msg3);
				return false;
			}
			return true;
		}
	});
	$(function(){
		$(".list td").each(function(i){
            //给td设置title属性,并且设置td的完整值.给title属性.
        	$(this).attr("title",$(this).text());
      	});
	
		//全选		
		$("#checkedAll").click(function(){
			var is = $(this).is(":checked");
			$("#editable").find(":checkbox").prop("checked",is);
		});
		//删除
		$("#delete").click(function(){
			var ids = "";
			$("#idsVal").find("input[name='check_all']:checked").each(function(){
				ids += $.trim($(this).val())+",";
			});
			if(ids == ''){
				layer.msg("请选择需要删除的记录!");
				return false;
			}
			$.ajax({
				type:"post",
				url:"${cp}/template/template_delete",
				dataType:"json",
				data:{id:ids},
				success:function(data){
					if(data.flag){
					  	layer.msg(data.msg);
						location.reload();
					}else{
						layer.msg(data.msg);
					}
				}
			});
		});
	});
	
		function exportExcel(){
			var start=$.trim($("input[name='start1']").val());
			var end=$.trim($("input[name='end1']").val());
			var id=$.trim($("input[name='id']").val());
				swal({
		        title:"是否导出二维码Excel？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "导出",
		        closeOnConfirm: false
		    },function (isConfirm) {
		   		 if(isConfirm){
		    		window.location.href="redpacket/actexport?start="+start+"&end="+end+"&id="+id+"&type=2";
		    		
			    }
		    });
			
		}
		function exportZip(){
			var start=$.trim($("input[name='start1']").val());
			var end=$.trim($("input[name='end1']").val());
			var id=$.trim($("input[name='id']").val());
				swal({
		        title:"是否导出二维码图片？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "导出",
		        closeOnConfirm: false
		    },function (isConfirm) {
		   		 if(isConfirm){
		    		window.location.href="zip/downloadActivity?start="+start+"&end="+end+"&id="+id+"&type=2";
		    		
			    }
		    });
			
		}
</script>
</html>
