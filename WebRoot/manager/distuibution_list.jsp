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
    <title>红包码分配记录</title>
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
    </style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>红包码分配记录</h5>
	                    <form name="form2" action="" method="post">
							<input type="hidden" name="_method" value="delete"/>
						</form>
                    	<div class="ibox-content" style="padding: 3px 17px 17px;">
							<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid" style="padding-bottom:15px;">
								<form action="${pageContext.request.contextPath }/distribution" method="get">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="DataTables_Table_0_filter" style="width:700px;">
												<label>
					                        		查找：
					                        		<c:if test="${type==1}">
						                        		<input type="text" name="ter"  class="form-control" placeholder="代理商名称"  />
						                        	</c:if>
						                        	<input type="text" name="act"  class="form-control" placeholder="商家名称"  />
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
                 				  	</form>
								</div>
							</div>
	                      	<table class="table table-striped table-bordered table-hover dataTables-example" id="editable">
	                            <thead>
	                                <tr>
                                    	<th>分配时间</th>
                                    	<th>起始码</th>
                                    	<th>结束码</th>
                                    	<th>代理商名称</th>
                                    	<th>商家名称</th>
                                    	<th>备注</th>
                                    	<th>成功数量</th>
                                    	<th>失败数量</th>
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal" class="list">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			<fmt:formatDate value="${items.createDate}" pattern="yyyy-MM-dd HH:mm:ss"	type="both" />
		                            		</td>
		                            		<td>
		                            			${items.start}
		                            		</td>
		                            		<td>
		                            			${items.end}
		                            		</td>
		                            		<td>
		                            			${items.ter_name}
		                            		</td>
	                            			<td>
		                            			${items.activity_name}
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.look==0}">给代理</c:if>
		                            			<c:if test="${items.look==1}">给商家</c:if>
		                            		</td>
		                            		<td>
		                            			${items.success_count}
		                            		</td>
		                            		<td>
		                            			${items.fail_count}
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
		                                    <form id="paging" action="distribution" method="get">
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
    </script>
</body>
</html>