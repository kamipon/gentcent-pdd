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
    <title>订单列表</title>
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
                    <h5>订单列表</h5>                   
                    </div>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/fxzGoodsOrder/list" method="get">
								<div class="row">
									<div class="col-sm-6" style="width:1000px;">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
												<!-- 
					                        	<input type="text"  value="${code}" name="code" placeholder="根据订单码查询">
					                        	<input type="text"  value="${name}" name="name" placeholder="根据姓名查询">
					                        	 -->
					                        	<input type="text"  value="${code}" name="code" placeholder="订单编号" style="width:130px;">
					                        	<input type="text"  value="${nick}" name="nick" placeholder="微信昵称" style="width:130px;">
					                        	<input type="text"  value="${shotId}" name="shotId" placeholder="用户编码" style="width:130px;">
					                        	<input type="text"  value="${name}" name="name" placeholder="真实姓名" style="width:130px;">
					                        	<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                        	<input type="text"  value="${phone}" name="phone" placeholder="联系方式" style="width:130px;">
					                        	<input type="text"  value="${fxzgoodsName}" name="fxzgoodsName" placeholder="商品名称" style="width:130px;">
					                        	<!-- 
					                        	<input type="text"  value="${status}" name="status" placeholder="订单状态">
					                        	 -->
					                        	<select name = "status" style="width:130px;height:24.5px;">
					                        		<option value = "">请选择订单状态</option>
					                        		<option value = "0" <c:if test="${status eq 0}">selected = "selected"</c:if>>待付款</option>
					                        		<option value = "1" <c:if test="${status eq 1}">selected = "selected"</c:if>>已付款</option>
					                        		<option value = "-1" <c:if test="${status eq -1}">selected = "selected"</c:if>>已失效</option>
					                        	</select>
					                        	<select name = "hx" style="width:130px;height:24.5px;">
					                        		<option value = "">请选择核销状态</option>
					                        		<option value = "0" <c:if test="${hx eq 0}">selected = "selected"</c:if>>未核销</option>
					                        		<option value = "1" <c:if test="${hx eq 1}">selected = "selected"</c:if>>已核销</option>
					                        		<option value = "2" <c:if test="${hx eq 2}">selected = "selected"</c:if>>无需核销</option>
					                        	</select>&nbsp;&nbsp;
					                        	<input type="submit" class="btn btn-sm btn-primary" value="搜索">&nbsp;&nbsp;
					                        	<input type="button" class="btn btn-sm btn-primary" onclick="updownexel()" value="导出execl表格" style="float: right;"/> 
					                        	<br>
					                        	<span style="color: red">* 每日02:00结算已支付订单，并删除未支付订单和佣金记录，返还商品库存。</span>
												<br>
												<span style="color: red">* 2018-12-1起，非核销订单需要用户确认收货，核销订单核销成功后自动收货，订单新增是否收货状态</span>
												<br>
												<span style="color: red">* 2018-12-1起，所有订单需要用户确认收货后才能进入结算，如用户不确认收货，默认15天后自动收货</span>
											</label>
										</div>
									</div>
									<div class="col-sm-6" style="width:200px;position:absolute;right:20px;">
										<div id="DataTables_Table_0_length" class="dataTables_filter">
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
	                                <tr  style="text-align:center">
	                                    <th>订单编号</th>
	                                    <th>微信昵称 | 用户编码</th>
	                                    <th>真实姓名</th>
	                                    <th>电话</th>
                                    	<th>商品名</th>
                                    	<th>价格（元）</th>
                                    	<th>添加时间</th>
                                    	<th>订单状态</th>
                                    	<th>是否核销</th>
                                    	<th>是否收货</th>
                                    	<th>是否填写地址</th>
                                    	<th>地址</th>
                                    	<c:if test="${sessionScope.loginUser.id ne'1'}">
                                    	<th>操作</th>	
                                    	</c:if>                                   
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            <c:forEach items="${list}" var="items">
		                            		<td>
		                            			${items.code }
		                            		</td>
		                            		<td>
		                            		<font color="blue">${items.member.nick}</font> | <font color="red">${items.member.shotId}</font> 
													
		                            		</td>
		                            		
		                            		<td>
		                            			${items.realname}
		                            		</td>
		                            		<td>
		                            			${items.phone}
		                            		</td>
		                            		<td>
		                            		${items.goodname}
		                            		</td>
		                            		<td>
		                            		 <font color="red">${items.price}</font> 
		                            		</td>
		                            		<td>
		                            		<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd HH:mm:ss" type="both" />
		                            		</td>
		                            		<td>
		                            		<c:if test="${items.status==0}">待付款</c:if>
		                            		<c:if test="${items.status==1}">已付款</c:if>
		                            		<c:if test="${items.status==-1}">已失效</c:if>
		                            		</td>
		                            		<td>
			                            		<c:if test="${items.isHx==0}">未核销</c:if>
			                            		<c:if test="${items.isHx==1}">已核销
			                            		</c:if>
			                            		<c:if test="${items.isHx==2}">无需核销</c:if>
			                            		
			                            		<c:if test="${items.checktype==1&&items.isHx==1}">
		                            				</br>15天自动核销
		                            			</c:if>
		                            		</td>
		                            		<td>
			                            		<c:if test="${items.ischeck==0}">未收货</c:if>
			                            		<c:if test="${items.ischeck==1}">已收货</c:if>
			                            		<c:if test="${items.checktype==1}">
			                            			</br>15天自动收货
			                            		</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.isAddress!=1}">否</c:if>
		                            			<c:if test="${items.isAddress==1}">是</c:if>
		                            		</td>
		                            		<td>
		                            			${items.province} ${items.city} ${items.area}-${items.address}
		                            		</td>
		                            		<c:if test="${sessionScope.loginUser.id ne '1'}">
		                            		<td>
		                            		<c:if test="${items.isHx==0}">
		                            			<c:if test="${items.status==1}">
		                            				<a class="J_menuItem" onclick="hx('${items.id}')">核销</a> |
		                            			</c:if>
		                            		</c:if>
		                                		<a class="J_menuItem" href="fxzGoodsOrder/${items.id}">修改</a> |
		                                		<a class="J_menuItem" href="commission/list?goodsCode=${items.code}">查看佣金详情</a>|
		                                		<c:if test="${items.isHx==0}">
			                            			<c:if test="${items.status==1}">
						                            	<br>
			                                			<a class="J_menuItem" href="activity/sendMsg/${items.id}">补发核销码短信</a>
			                                		</c:if>
		                                		</c:if>
		                            		</td>
		                            		</c:if>
	                            		</tr>
	                            	</c:forEach>
	                            </tbody>
	                        </table>
                        <div method="post" id="tableForm">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        <tbody>
		                            <tr>
		                                <td align="center" class="pn-sp">
		                                    <form id="paging" action="fxzGoodsOrder/list" method="get">
		                                    <!-- 
		                                    <input type="hidden" name="name" value="${name}">
		                                    <input type="hidden" name="code" value="${code}">
		                                     -->
		                                    
		                                    <input type="hidden"  value="${code}" name="code">
		                                    <input type="hidden"  value="${nick}" name="nick">
					                        <input type="hidden"  value="${shotId}" name="shotId">
					                        <input type="hidden"  value="${name}" name="name">
					                        <input type="hidden"  value="${phone}" name="phone" >
					                        <input type="hidden"  value="${fxzgoodsName}" name="fxzgoodsName">
					                        <input type="hidden"  value="${status}" name="status">
					                        <input type="hidden"  value="${hx}" name="hx">
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
    </script>
    <script type="text/javascript">
    	function updownexel(){
    		var code = $.trim($("input[name='code']").val()); 
    		var nick = $.trim($("input[name='nick']").val());
    		var shotId = $.trim($("input[name='shotId']").val());
    		var name = $.trim($("input[name='name']").val());
    		var phone = $.trim($("input[name='phone']").val());
    		var fxzgoodsName = $.trim($("input[name='fxzgoodsName']").val());
    		var status = $.trim($("input[name='status']").val());
    		var hx = $.trim($("input[name='hx']").val());
    		window.location.href="fxzGoodsOrder/out?code="+code+"&nick="+nick
    		+"&shotId="+shotId+"&name="+name+"&phone="+phone
    		+"&fxzgoodsName="+fxzgoodsName+"&status="+status+"&hx="+hx;
    		
    	}
	   		function del(id){
		    swal({
		        title:"确定删除此商品？删除后无法恢复！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"fxzGoods/"+id,
						data:{
							_method:"delete"
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"删除成功！",type:"success"},function(){
									window.location.reload();
								});
							}else{
								layer.msg("删除失败");
							}

						}
					});
			    }
		    });
		}
		
		function hx(id){
			swal({
				title:"请输入订单核销码。",
				type:"input",
				showCancelButton: true,
				closeOnConfirm:false,
			},function(inputValue){
					$.ajax({
		    			type:"post",
						url:"fxzGoodsOrder/hx",
						data:{
							id:id,
							code:inputValue,
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"核销成功！",type:"success"},function(){
									window.location.reload();
								});
							}else{
								layer.msg("核销码错误，核销失败");
							}

						}
					});
			});
		}
    </script>
</body>
</html>