<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
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
    <title>领红包列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <style type="text/css">
		.td2_name{
			position: absolute;
			left: 35%;
			text-align: center;
		}
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
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>领红包列表</h5>
                    </div>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/redpacket/lingqu" method="get">
								<div class="row">
								<div class="col-sm-10">
											<label>
												查找：
					                        	<input type="text" value="${nick }" name="nick" placeholder="根据用户昵称查询">
					                        	<input type="submit" class="btn btn-sm btn-primary" value="搜索">
					                        	<input id="export" class="btn btn-sm btn-primary" onclick="exportExcel()" value="导出Excle" style="position: relative;left: 300%" type="button">
											</label>
									</div>
									<div class="col-sm-2">
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
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead>
	                                <tr>
	                                    <th>shotId</th>
	                                    <th>昵称</th>
                                    	<th>领取次数</th>
                                    	<th>价值</th>
                                    	<th>最后扫码时间</th>	   
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			${items.shotId}
		                            		</td>
		                            		<td>
		                            			<c:if test="${!empty items.picUrl || items.picUrl!=''}">
		                            				<img style="height:50px;" src="${items.picUrl}"/>
		                            			</c:if>
		                            			<c:if test="${!empty items.nick || items.nick!=''}">${items.nick}</c:if>
		                            			<c:if test="${empty items.nick || items.nick==''}">未授权</c:if>
		                            		</td>
		                            		<td>
		                            			${items.number }
		                            		</td>
		                            		<td>
		                            			<fmt:formatNumber value="${items.money }" pattern="0.00"/>
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime }" pattern="yyyy-MM-dd" type="both" />
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
		                                    <form id="paging" action="${pageContext.request.contextPath }/redpacket/lingqu" method="get">
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
    	function exportExcel(){
			var code=$.trim($("input[name='code']").val());
			var start=$.trim($("input[name='start']").val());
			var end=$.trim($("input[name='end']").val());
				swal({
		        title:"是否导出Excle文件？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "导出",
		        closeOnConfirm: false
		    },function (isConfirm) {
		   		 if(isConfirm){
		    		window.location.href="redpacket/exportlq";
			    }
		    });
			
		}
    </script>
</body>
</html>