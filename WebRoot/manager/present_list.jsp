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
    <title>贵金属交易系统-提现信息列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
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
    </style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>提现信息列表</h5>
	                    <form name="form2" action="" method="post">
							<input type="hidden" name="_method" value="delete"/>
						</form>
                    	<div class="ibox-content" style="padding: 20px 5px 20px;">
							<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid" style="padding-bottom: 0px;">
								<form action="${pageContext.request.contextPath }/present" method="get">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="DataTables_Table_0_filter" style="width:700px;">
												<label>
				                        			查找：
					                        		<input type="text"  value="${nick }" name="nick"  maxlength="255" placeholder="根据用户真实查询..."/>
						                        	<input type="text"  value="${phone }" name="phone"  maxlength="255" placeholder="根据用户手机号查询..."/>
						                        	<input type="text"  value="${code }" name="code"  maxlength="255" placeholder="根据用户上级代理查询"/>
						                        	<select id="status" name="status" style="height: 26px; width: 170px;">
						                        		<option value="" <c:if test="${statusId=='' }">selected = 'selected'</c:if>>
						                        			请选择状态
						                        		</option>
						                        		<option value="已扣款" <c:if test="${statusId=='已扣款' }">selected = 'selected'</c:if>>
						                        			已扣款
						                        		</option>
						                        		<option value="成功" <c:if test="${statusId=='成功' }">selected = 'selected'</c:if>>
						                        			成功
						                        		</option>
						                        		<option value="审核中" <c:if test="${statusId=='审核中' }">selected = 'selected'</c:if>>
						                        			审核中
						                        		</option>
						                        		<option value="失败" <c:if test="${statusId=='失败' }">selected = 'selected'</c:if>>
						                        			失败
						                        		</option>
						                        		<option value="已取消" <c:if test="${statusId=='已取消' }">selected = 'selected'</c:if>>
						                        			已取消
						                        		</option>
						                        	</select> 
						                        	<select id="type" name="type" style="height: 26px; width: 170px;margin-left: 42px;">
						                        		<option value="" <c:if test="${typeId=='' }">selected = 'selected'</c:if>>
						                        			请选择类型
						                        		</option>
						                        		<option value="1" <c:if test="${typeId=='1' }">selected = 'selected'</c:if>>
						                        			用户
						                        		</option>
						                        		<option value="2" <c:if test="${typeId=='2' }">selected = 'selected'</c:if>>
						                        			经纪人
						                        		</option>
						                        	</select>
						                        	<input type="text" name="staticTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" placeholder="开始时间" value="${staticTime }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="height: 26px; width: 170px;"/>
														~
													<input type="text" name="endTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" placeholder="结束时间" value="${endTime }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="height: 26px; width: 170px;"/>
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
									</div>
                 				 </form>
							</div>
						 </div>
	                     <table class="table table-striped table-bordered table-hover dataTables-example" id="editable">
	                     	<span style="font-size:17px;font-weight: bold">提现次数:<span style="color: #E23B07;font-weight: bold">${max }</span>次</span>&nbsp;&nbsp;
	                     	<span style="font-size:17px;font-weight: bold">提现成功金额:<span style="color: #E23B07;font-weight: bold"><fmt:formatNumber value="${money }" pattern="##.##" minFractionDigits="2" ></fmt:formatNumber></span>元</span>
	                     	<input type="button" class="btn btn-sm btn-primary" onclick="updownexel()" value="导出execl表格" style="float: right;"/>
	                     	<thead>
                                <tr>
                                	<th width="2%"><input type="checkbox" name="check_all" id="checkedAll"></th>
                                    <th>用户昵称</th>
                                    <th>用户名称</th>
                                   	<th>用户电话</th>
                                   	<th>身份证号</th>
                                   	<th>银行卡号</th>
                                   	<th>开号银行</th>
                                   	<th>提现金额</th>
                                   	<th width="4%">状态</th>
                                   	<th width="4%">类型</th>
                                   	<th width="4%">上级代理邀请码</th>
                                   	<th>提交时间</th>
                                   	<th>审核理由</th>
                                   	<th>操作</th>
                                </tr>
	                       </thead>
                            <tbody  id="idsVal" class="list">
                            	<c:forEach items="${list}" var="items">
                            		<tr>
	                            		<td><input type="checkbox" name="check_all" value="${items.id }"></td>
	                            		<td>
	                            			${items.member.name}
	                            		</td>
	                            		<td>
	                            			${items.member.realName}
	                            		</td>
	                            		<td>
	                            			${items.member.phone }
	                            		</td>
	                            		<td>
	                            			${items.member.card }
	                            		</td>
	                            		<td>
	                            			${items.member.banknum }
	                            		</td>
	                            		<td>
	                            			${items.member.bankname }
	                            		</td>
	                            		
	                            		<td>
	                            			${items.money }
	                            		</td>
	                            		<td>
	                            			<c:choose>
	                            				<c:when test="${items.status=='成功' }">
	                            					<span style="color: #1CAD1C;font-weight: bold">${items.status }</span>
	                            				</c:when>
	                            				<c:when test="${items.status=='审核中' }">
	                            					<span style="color: #07A4E2;font-weight: bold">${items.status }</span>
	                            				</c:when>
	                            				<c:when test="${items.status=='失败' }">
	                            					<span style="color: #E23B07;font-weight: bold">${items.status }</span>
	                            				</c:when>
	                            				<c:when test="${items.status=='已扣款' }">
	                            					<span style="color: #E23B07;font-weight: bold">${items.status }</span>
	                            				</c:when>
	                            				<c:when test="${items.status=='已取消' }">
	                            					<span style="color: #E2079D;font-weight: bold">${items.status }</span>
	                            				</c:when>
	                            			</c:choose>
	                            		</td>
	                            		<td>
	                            			<c:choose>
	                            				<c:when test="${items.type=='1' }">
	                            					<span style="color: #1CAD1C;font-weight: bold">用户</span>
	                            				</c:when>
	                            				<c:otherwise>
	                            					<span style="color: #07A4E2;font-weight: bold">会员</span>
	                            				</c:otherwise>
	                            			</c:choose>
	                            		</td>
	                            		<td>
	                            			${items.member.agentcode }
	                            		</td>
	                            		<td>
	                            			<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd HH:mm:ss"	type="both" />
	                            		</td>
	                            		<td>
	                            			${items.audit }
	                            		</td>
	                            		<td>
	                            			<c:if test="${loginUser.grade==0}">
		                            			<c:if test="${items.status=='审核中' }">
		                            				<a onclick="audit('${items.id}')">审核</a>
		                            			</c:if>
		                            			<c:if test="${items.status=='成功' }">
		                            				<a onclick="debit('${items.id}','1')">微信支付</a>
		                            				<a onclick="debit('${items.id}','2')">其他方式</a>
		                            			</c:if>
	                            			</c:if>
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
		                                    <form id="paging" action="${pageContext.request.contextPath }/present" method="get">
		                                      <input type="hidden" name="nick" value="${nick }" maxlength="255">
		                                      <input type="hidden" name="phone" value="${phone }"/>
		                                      <input type="hidden" name="status" value="${status }"/>
		                                      <input type="hidden" name="type" value="${type }"/>
		                                      <input type="hidden" name="staticTime" value="${staticTime }"/>
		                                      <input type="hidden" name="endTime" value="${endTime }"/>
		                                      <%@include file="paging.jsp"%>
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
    </div>
    <input type="hidden" value="${message }" name="message" id="message">
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    	var message = $.trim($("input[name='message']").val());
    	if(!message && message!=""){
    		alert(message);
    	}
    	function audit(id){
				layer.open({
				type: 2,
				title: '审核',
				shadeClose: true,
				shade: 0.8,
				area: ['800px', '60%'],
				content: '${cp }/present/goAudit?id='+id
			});	
		}
		function debit(id,model){
			var po = prompt("请输入你的登陆密码:","");
			var p = "${loginUser.password}";
			if(po == p){
				$.ajax({
				url:"present/debit",
					type:"post",
					data:{
						id:id,
						model:model
					},
					dataType:"json",
					success:function(data){
						alert(data.msg);
						location.href="present";
					}
				});	
			}else{
				alert("密码错误");
			}
			   
		}
		$(function(){
			$(".list td").each(function(i){
	            //给td设置title属性,并且设置td的完整值.给title属性.
	        	$(this).attr("title",$(this).text());
	      	});
		});
		function updownexel(){
			window.location.href="excel/present";
    		
    	}
   </script>
</body>
</html>