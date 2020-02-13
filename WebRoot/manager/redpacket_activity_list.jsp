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
										<input onkeyup="this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[&#39;&#39;])[0]"  id="money1" name="money1" placeholder="请输入金额" style="width: 80px">
	                           	    </div>
	                           	    <div id="money" style="display: none;margin-top: -7px;margin-left: -158px;position: relative;width:390px" class="col-sm-5">
										<span>起始位置:</span><input  class="start1" name="start1"  placeholder="请输入开始位置编码" style="width:180px" onchange="change1(this)">
										<div style="margin-top: 10px;margin-left: 0px">
										<span>结束位置:</span><input class="end1" name="end1" placeholder="请输入结束位置编码"  style="width: 180px;" onchange="change2(this)"/>
										</div>
										<div style="margin-left: 245px;margin-top: -44px">
										<span>金额:</span><input onkeyup="this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[&#39;&#39;])[0]" name="money2" placeholder="请输入金额" style="width: 80px"/> <br>
										</div>
									</div>
									<div style="margin-left: 10px;">
										<button class="btn btn-primary" type="button" id="redpacktModel">设置</button>
                           	   		 	<button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
	                           	    </div>
	                           	     <div class="col-sm-3" style="margin-left: 33%;margin-top:-35px;width: 35%" id="sear"> 
										<div class="dataTables_length" id="DataTables_Table_0_filter" style="width: 150%" >
											<label>
												查找：
					                        	<input value="${money }" type="text"  name="redMoney" placeholder="根据红包金额查询">
					                        	<input type="text"  name="code" placeholder="根据红包码查询">
					                        	<select id="sta" style="height:25px">
					                        		<option value="0">--根据红包状态查询--</option>
					                        		<option value="yes">已领取</option>
					                        		<option value="no">未领取</option>
					                        	</select>
					                        	<input type="button" onclick="query()" class="btn btn-sm btn-primary" value="搜索"> 
					                        	<input type="button" onclick="convert()" class="btn btn-sm btn-primary" value="红包转换"> 
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
                                    	<th>金额</th>
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
	                                   	 		<input type="hidden" value="${activity.id}" name="id">
	                                   	 		<input type="hidden"  value="${noUse }" name="noUse">
	                                   	 		<input type="hidden"  value="${money }" name="money">
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
		var reg =/^[1-9]+[0-9]*]*$/;
		var check1=true;
		var check2=true;
		function show(obj)
		{
		 document.getElementById("money1").style.display=(obj.value==1)?"":"none";
		 document.getElementById("money").style.display=(obj.value==0)?"":"none";
		 if(obj.value==0){
			 $("#sear").css("margin-left","50%");
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
			var money = $.trim($("input[name='redMoney']").val());
			if(isNaN(money)){
				layer.msg("红包金额应为数字");
				return;
			}
			var code = $.trim($("input[name='code']").val());
			var noUse = $("#sta").val();
			window.location.href="redpacket/list?money="+money+"&&code="+code+"&&type=0&&noUse="+noUse;
		}


	$(function(){
		$("#redpacktModel").click(function(){
			//id
			var id = $.trim($("input[name='id']").val());
			var state = $("#state").val();
			var money1=$.trim($("input[name='money1']").val());
			var money2=$.trim($("input[name='money2']").val());
			var start1=$.trim($("input[name='start1']").val());
			var end1=$.trim($("input[name='end1']").val());
			 var flag = validate(
						check1,"您输入的开始位置过小，不得小于1",
						money1,"请输入金额",
						money2,"请输入金额",start1,end1
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"redpacket/update",
					dataType:"json",
					async:false,
					data:{	
						id:id,
						state:state,
						'_method':'put',
						money1:money1,
						money2:money2,
						start1:start1,
						end1:end1,
					},
					success:function(data){
						if(data.toVerify=="yes"){
							check();
							return ; 
						}
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
			}else if(date2 ==""&&date3==""){
				layer.msg("金额不能为空");
				return false;
			}else if(parseFloat(date2)==0||parseFloat(date3)==0){
				return true;
			}else if(parseFloat(date2)>2000||parseFloat(date3)>2000){
					layer.msg("红包金额最高为2000");
					return false;
			}
			else if(parseFloat(date2)<0.3||parseFloat(date3)<0.3){
				var ac = "${activity.id}";
				var boo;
				$.ajax({
					url:"activity/saveMoney",
					type:"get",
					async:false,
					data:{
						id:ac
					},
					success:function(data){
						if(data.flag){
							layer.msg("到账方式为直接转账时，红包金额不能低于0.3元");
							boo = false;
							return;
						}
						boo = true;
					}
				});
				if(boo){
					return true;
				}else{
					return false;
				}
			}
			else{
				return true;
			}
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
		    		window.location.href="redpacket/actexport?start="+start+"&end="+end+"&id="+id+"&type=0";
		    		
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
		    		window.location.href="zip/downloadActivity?start="+start+"&end="+end+"&id="+id+"&type=0";
			    }
		    });
			
		}
		
		function convert(){
			layer.open({
						type: 2,
						title: '转换红包',
						shadeClose: true,
						moveOut: true,
						shade: 0.8,
						area: ['1500px', '90%'],
						content: 'manager/redpacket_convert.jsp',
						end:function(){
							location.reload();
						}
				});	
		}
		//微信验证码
	   	function check(url){
			layer.open({
				type: 2,
				title: '微信验证码',
				shadeClose: true,
				shade: 0.8,
				area: ['800px', '60%'],
				content:"manager/code.jsp"
			});	
	   	}
</script>
</html>
