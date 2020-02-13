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
                   		<div class="ibox-content">
	                   		<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid" style="padding-bottom:0px;">
								<form action="redpacket/packetlist" method="get">
									<div class="row">
										<div class="col-sm-8">
											<div id="DataTables_Table_0_filter" class="dataTables_length">
												<div>
													查找：
													<input type="hidden" name="type" value="${redType }">
													<input type="text"  value="${code }" name="code" placeholder="编码查询">
													<input  name="start" value="${start }" placeholder="开始段"  type="text" >
													<input  name="end"  value="${end }"placeholder="结束段"  type="text" >
													<input  name="so"  value="1"   type="hidden" >
													<input class="btn btn-sm btn-primary" value="搜索" type="submit">
													<c:if test="${type==1 }">
														<input id="export" class="btn btn-sm btn-primary" onclick="exportExcel()" value="导出二维码Excle" style="margin-left: 38px;" type="button">
														<input id="export" class="btn btn-sm btn-primary" onclick="exportZip()" value="导出二维码图片" style="margin-left: 38px;" type="button">
														<input class="btn btn-sm btn-primary" onclick="setRedPacketNum()" value="增加红包" style="margin-left: 38px;" type="button">
													</c:if>
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div id="DataTables_Table_0_length" class="dataTables_filter" style="float:left;">
												<label style="font-weight: normal;">
												每页
												<select class="form-control input-sm" aria-controls="DataTables_Table_0" name="pageSize" onchange="javascript:this.form.submit();">
												<option value="20">20</option>
												<option value="10">10</option>
												<option value="25">25</option>
												<option value="50">50</option>
												<option value="100">100</option>
												<option value="1000"> 1000 </option>
												</select>
												条记录
												</label>
											</div>
										</div>
									</div>
	                 			</form>
							</div>  
						</div>             			
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed;">
	                            <thead class="pn-lthead">
	                                <tr >
	                                	<c:if test="${boolean1}"><th style="width: 5%">二维码</th></c:if>
	                                	<th>编码</th>
                                    	<th style="width: 20%">创建时间</th>                              
	                                </tr>
	                            </thead>
	                            <tbody id="user" style="height: 10%">
	                            	<c:forEach items="${list}" var="items" varStatus="status">
	                            		<tr <c:if test="${items.status==1 }">style="color: green;"</c:if> <c:if test="${items.status==2 }">style="color: red;"</c:if> > 
	                            		<c:if test="${boolean1}">
		                            		<td>
			                                	<div class="qrcodeIcon" _style="16" _id="5" onMouseOut="hideImg('${status.index }')"  onmouseover="showImg('${status.index }')"></div>
			                                    <div class="qrcodeBox" style="display: none;" id="wxImg${status.index }">
			                                    	<div class="inIcon"></div>
													<img alt="Wxmenu" src="wresource/url?url=<%=res.getString("project.host")%>/item/${items.id }" style="height:100%;width:100%;">
												</div>
                            				</td>
                           				</c:if>
		                            		<td>
		                            			${items.code }
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime}" dateStyle="long" timeStyle="long"	type="both" />
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
		                                    <form id="paging" action="redpacket/packetlist" method="get">
		                                      <input type="hidden" name="type" value="${redType }">
		                                      <input type="hidden" name="code" value="${code}">
		                                      <input  name="start" value="${start }"   type="hidden" >
											  <input  name="end"  value="${end }"  type="hidden" >
											  <input  name="so"  value="1"  type="hidden" >
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
</body>
	<script>
		var reg =/^[1-9]+[0-9]*]*$/;
		var check1=true;
		var check2=true;
		function show(obj){
			document.getElementById("money1").style.display=(obj.value==1)?"":"none";
			document.getElementById("money").style.display=(obj.value==0)?"":"none";
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
	function exportExcel(){
			var code=$.trim($("input[name='code']").val());
			var start=$.trim($("input[name='start']").val());
			var end=$.trim($("input[name='end']").val());
				swal({
		        title:"是否导出二维码Excle文件？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "导出",
		        closeOnConfirm: false
		    },function (isConfirm) {
		   		 if(isConfirm){
		    		window.location.href="redpacket/export?code="+code+"&start="+start+"&end="+end;
		    		
			    }
		    });
			
		}
		function exportZip(){
			var code=$.trim($("input[name='code']").val());
			var start=$.trim($("input[name='start']").val());
			var end=$.trim($("input[name='end']").val());
				swal({
		        title:"是否导出二维码图片压缩文件？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "导出",
		        closeOnConfirm: false
		    },function (isConfirm) {
		   		 if(isConfirm){
		    		window.location.href="zip/download?code="+code+"&start="+start+"&end="+end;
		    		
			    }
		    });
			
		}
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
	function setRedPacketNum(){
		layer.open({
			type: 2,
			title: '增加红包',
			shadeClose: true,
			shade: 0.8,
			area: ['1500px', '50%'],
			content: 'category/addRed'
		});	
	}
	//选择分类
	function choose(){
	   layer.open({
	        type: 2,
			title: '选择类目',
			shadeClose: true,
			shade: 0.8,
			area: ['800px', '90%'],
			content: '${cp }/manager/category_choose.jsp' //iframe的url
	   });
	}
	</script>
</html>
