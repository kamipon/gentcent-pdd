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
    <title>用户列表</title>
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
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/member" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input  type="text"  value="${nick }" name="nick" placeholder="根据昵称查询">
					                        	<select name="utype" id="utype" class="form-control m-b">
													<option value="">
														请选择身份
													</option>
													<option value="0" <c:if  test="${utype==0}">
														selected="selected"
													</c:if>>
														客户
													</option>
													<option value="1" <c:if  test="${utype==1}">
														selected="selected"
													</c:if>>
														商户
													</option>
													<option value="2" <c:if  test="${utype==2}">
														selected="selected"
													</c:if>>
														销售
													</option>
													<option value="3" <c:if  test="${utype==3}">
														selected="selected"
													</c:if>>
														市场
													</option>
													<option value="4" <c:if  test="${utype==4}">
														selected="selected"
													</c:if>>
														物流
													</option>
													<option value="5" <c:if  test="${utype==5}">
														selected="selected"
													</c:if>>
														客服
													</option>
													<option value="99" <c:if  test="${utype==99}">
														selected="selected"
													</c:if>>
														管理员
													</option>
												</select>
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
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead class="pn-lthead">
	                                <tr>
	                                    <th style="width:50px;">头像</th>
	                                    <th>昵称</th>
	                                    <th>用户编号</th>
                                    	<th style="width:50px;">性别</th>
                                    	<th>身份</th>
                                    	<th>操作</th>	                                   
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items">
	                            		<tr>
		                            		<td>
		                            			<img src="${items.picUrl }" style="width:30px;height:30px;">
		                            		</td>
		                            		<td>
		                            			${items.nick }
		                            		</td>
		                            		<td>
		                            			${items.shotId }
		                            		</td>
		                            		<td>
		                            			<c:choose>
		                            				<c:when test="${items.sex=='0'}">
		                            					女
		                            				</c:when>
		                            				<c:when test="${items.sex=='1'}">
		                            					男
		                            				</c:when>
		                            			</c:choose>
		                            		</td>
		                            		<td>
		                            			<c:choose>
		                            				<c:when test="${items.utype=='0'}">
		                            					客户
		                            				</c:when>
		                            				<c:when test="${items.utype=='1'}">
		                            					商户
		                            				</c:when>
		                            				<c:when test="${items.utype=='2'}">
		                            					销售
		                            				</c:when>
		                            				<c:when test="${items.utype=='3'}">
		                            					市场
		                            				</c:when>
		                            				<c:when test="${items.utype=='4'}">
		                            					物流
		                            				</c:when>
		                            				<c:when test="${items.utype=='5'}">
		                            					客服
		                            				</c:when>
		                            				<c:when test="${items.utype=='99'}">
		          	                  					管理员
		                            				</c:when>
		                            				<c:otherwise>
		                            					游客
		                            				</c:otherwise>
		                            			</c:choose>
		                            		</td>
		                            		<td>
												<a class="pn-opt" onclick="set('${items.id }');">设置身份</a>
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
		                                    <form id="paging" action="member" method="get">
												<input type="hidden" name="utype" value="${utype}">
												<input type="hidden" name="nick" value="${nick}">
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
		function set(id){
			layer.open({
				type: 2,
				title: '设置身份',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'member/set/'+id
			});	
		}
    </script>
</body>
</html>