<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
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
    <title>商家手续费设置</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>商家手续费设置</h5>
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/activity/selectAllAc" method="get">
								<div class="row">
									<div class="col-sm-6" style="width: 100%">
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
                 				  </form>
								</div>
								<br><font color="red">请输入0-100之间的正整数，当输入10时，手续费为10%</font><br>
	                    	    <font color="red">修改此处手续费将【单独设置商家手续费】</font><br>
	                    	    <font color="red">【手续费一键设置功能】将无法设置已经设置过手续费的商家</font><br>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead class="pn-lthead">
	                                <tr>
<!--                                	 	<th style="width:100px;">活动图</th>-->
	                                    <th>名称</th>
                                    	<th>联系方式</th>
                                    	<th>平台手续费</th>
                                    	<th>代理手续费</th>
                                    	<th>操作</th>                                 
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items" varStatus="status">
		                            		<td>
		                            			${items.name }
		                            		</td>
		                            		<td>
                            					${items.phone }
		                            		</td>
		                            		<td>
		                            			<input type="text" value="${items.ptFee }" id="ptFee${status.index}" style="width: 80px">	
		                            		</td>
		                            		<td>
		                            			<input type="text" value="${items.terFee }" id="terFee${status.index}" style="width: 80px">	
		                            		</td>
		                            		<td>
		                            			<input type="button"  onclick="setFeeAc('${items.id}','${status.index}')" class="btn btn-sm btn-primary" value="保存"> 
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
		                                    <form id="paging" action="activity/selectAllAc" method="get">
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
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    function setFeeAc(id,index){ 
		    swal({
		        title:"确定设置商家手续费吗？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "确定",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		   		 	var ptFee = $("#ptFee"+index).val();
			   		var terFee = $("#terFee"+index).val();
					var flag = validate(
								terFee,"请输入正确代理手续费",
								ptFee,"请输入正确平台手续费"						
						); 
					function validate(date1,msg1,date2,msg2){
						var re = /^[0-9]+$/; 
						if(date1 == ''||!re.test(date1)||date1>100){
							layer.msg(msg1);
							return false;
						}else if(date2 == ''||!re.test(date2)||date2>100){
							layer.msg(msg2);
							return false;
						}
						return true;
					}
				 	if(flag){
			   		 	
			    		$.ajax({ 
			    			type:"post",
							url:"activity/set_fee",
							data:{
								_method:"put",
								terFee:terFee,
								ptFee:ptFee,
								id:id
							},
							dataType:"json",
							success:function(data){
								if(data.flag){
										alert(data.msg);
										window.location.reload();
								}else{
									layer.msg(data.msg);
								}
	
							}
						});
					}
			    }
		    });
		}
		
		
    </script>
</body>
</html>