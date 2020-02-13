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
							<form action="redpacket/update" method="post" >
								<input type="hidden" name="_method" value="put" />
								<input type="hidden" name="id" value="${activity.id}">
								<div class="row" style="width: 100%;height:40px">
									<div class="col-sm-3" style="position: relative;margin-top: 10px" >
											<font color="red">*</font>
											选择红包模式
										<select name="state" id="state" onchange="show(this)">
											<option value="1" selected="selected">
												平均分配
											</option>
											<option value="0">
												自定义分配
											</option>
										</select>
										<input  id="money1" name="money1" placeholder="请输入积分" style="width: 80px">
	                           	    </div>
	                           	    <div id="money" style="display: none;margin-top: -7px;margin-left: -158px;position: relative;width:390px" class="col-sm-5">
										<span>起始位置:</span><input  class="start1" name="start1"  placeholder="请输入开始位置编码" style="width:180px" onchange="change1(this)">
										<div style="margin-top: 10px;margin-left: 0px">
										<span>结束位置:</span><input class="end1" name="end1" placeholder="请输入结束位置编码"  style="width: 180px;" onchange="change2(this)"/>
										</div>
										<div style="margin-left: 245px;margin-top: -44px">
										<span>积分:</span><input  name="money2" placeholder="请输入积分" style="width: 80px"/> <br>
										</div>
									</div>
									<div style="margin-left: 10px;">
										<button class="btn btn-primary" type="button" id="redpacktModel">设置</button>
                           	   		 	<button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
	                           	    </div>
	                           	     <div class="col-sm-3" style="margin-left: 33%;margin-top:-35px;width: 45%" id="sear"> 
										<div class="dataTables_length" id="DataTables_Table_0_filter" >
											<label>
												查找：
					                        	<input type="text"  name="redMoney" placeholder="根据红包积分查询">
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
	                           	    <div style="margin-left: 90%;margin-top: -50px">
										<input id="export" class="btn  btn-primary" onclick="exportExcel()" value="导出二维码Excle"  type="button">
										<input id="export" class="btn  btn-primary" onclick="exportZip()" value="导出二维码图片"  type="button">
									</div>
               				  </form>
							</div>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed;">
	                            <thead class="pn-lthead">
	                                <tr >
	                                	<th style="width: 5%">二维码</th>
	                                	<th >序号</th>
	                                    <th>所属活动</th>
                                    	<th>积分</th>
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
		                            			<fmt:parseNumber integerOnly="true" value="${items.money}"></fmt:parseNumber>
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
		                                   	 	<input type="hidden" name="type" value="3">
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
		function isInteger(obj) {
 			return obj%1 === 0
		}
		var reg =/^[1-9]+[0-9]*]*$/;
		var check1=true;
		var check2=true;
		function show(obj)
		{
		 document.getElementById("money1").style.display=(obj.value==1)?"":"none";
		 document.getElementById("money").style.display=(obj.value==0)?"":"none";
		 if(obj.value==0){
			 $("#sear").css("margin-left","55%");
		 }else{
	 		 $("#sear").css("margin-left","35%");
		 }
		}
		
		function change1(obj){
		
		
		 var num=$(".start1").val();
		 if(num<1&&!reg.test(num)){
			
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
			var code = $.trim($("input[name='code']").val());
			window.location.href="redpacket/list?money="+money+"&&code="+code+"&&type=3&&noUse="+noUse;
		}


	$(function(){
		$("#redpacktModel").click(function(){
			var id = $.trim($("input[name='id']").val());
			var state = $("#state").val();
			var money1=$.trim($("input[name='money1']").val());
			var money2=$.trim($("input[name='money2']").val());
			var start1=$.trim($("input[name='start1']").val());
			var end1=$.trim($("input[name='end1']").val());
			 var flag = validate(
						check1,"您输入的开始位置过小，不得小于1",
						money1,"请输入积分",
						money2,"请输入积分",start1,end1
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"redpacket/update",
					dataType:"json",
					async:false,
					data:{	
						jifen:"jifen",
						id:id,
						state:state,
						'_method':'put',
						money1:money1,
						money2:money2,
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
		function validate(date1,msg1,date2,msg2,date3,msg3,start1,end1){
			if(date1 == false){
				layer.msg(msg1);
				return false;
			}else if($("#state").val()==1){
				if(date2==null||date2==""){
					layer.msg("积分不能为空");
					return false;
				} if(date2<0){
					layer.msg("积分必须大于0");
					return false;				
				}if(isNaN(date2)){
					layer.msg("积分为数字");
					return false;
				}
				var fg = isInteger(date2);
				if(!fg){
					layer.msg("积分为整数");
					return false;	
				}
				if(date2==0){
					return true;
				}
				return true;
			}else if($("#state").val()==0){
				if(date3==0){
					return true;
				}
				if(date3==null||date3==""){
					layer.msg("积分不能为空");
					return false;
				}if(date3<0){
					layer.msg("积分必须大于0");
					return false;				
				}if(isNaN(date3)){
					layer.msg("积分为数字");
					return false;
				}
				var fg = isInteger(date3);
				if(!fg){
					layer.msg("积分为整数");
					return false;	
				}
			}
				return true;
		}
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
		    		window.location.href="redpacket/actexport?start="+start+"&end="+end+"&id="+id+"&type=3";
		    		
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
		    		window.location.href="zip/downloadActivity?start="+start+"&end="+end+"&id="+id+"&type=3";
		    		
			    }
		    });
			
		}
</script>
</html>
