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
    <title>提现列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <style type="text/css">
    	.qrcodeIcon {
		    background-image: url(images/ermIcon.png?v=201507271756);
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
		.td2_name{
			position: absolute;
			left: 35%;
			text-align: center;
		}
    </style>
    <script type="text/javascript">
    			function showImg(index){
			document.getElementById("wxImg"+index).style.display='block';
		}
		function hideImg(index){
			document.getElementById("wxImg"+index).style.display='none';
		}
		function showURL(id){
			alert("<%=res.getString("project.host")%>/kj/"+id);
		}
    </script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    <h5>提现列表</h5>         
                    </div>
 
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/withdraw/list" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<font size="4px">
											当前提现支付宝帐号:
												<c:if test="${act!=null}">
													<font style="color: red">${act.zfb }&nbsp;(${act.zfbname })</font>
													&nbsp;&nbsp;
													<a href="<%=basePath%>/activity/details">前往设置</a>
												</c:if>
												<c:if test="${ter!=null}">
													<font style="color: red">${ter.zfb }&nbsp;(${ter.zfbname })</font>
													&nbsp;&nbsp;
													<a href="<%=basePath%>/terPoint/details">前往设置</a>
												</c:if>
											</font>
											<br>
											<font size="5px">余额：<fmt:formatNumber value="${yue}" pattern="0.00"/>元&nbsp;&nbsp;
											正在提现：<fmt:formatNumber value="${dtx}" pattern="0.00"/>元&nbsp;&nbsp;
											已提现:<fmt:formatNumber value="${ytx}" pattern="0.00"/>元&nbsp;&nbsp;</font>&nbsp;&nbsp;
											<input type="button" onclick="tx()"  class="btn btn-sm btn-primary" value="提现申请"> 
											<br>
											<div style="color: red">*提现48小时内到账,每次提现金额限制100-50000元。</div>
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
	                                    <th>提现金额</th>
	                                    <th>状态</th>
	                                    <th>类型</th>
	                                    <th>支付宝帐号</th>
	                                    <th>备注</th> 
	                                    <th>添加时间</th>                     
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            <c:forEach items="${list}" var="items">
		                            		<td>
		                            			${items.money}
		                            		</td>
		                            		<td>
		                            		<c:if test="${items.status==0}">审核中</c:if>
		                            		<c:if test="${items.status==1}">已提现</c:if>
		                            		<c:if test="${items.status==2}">驳回</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.type==1}">商家</c:if>
		                            			<c:if test="${items.type==2}">代理</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.type==1}">
		                            			(${items.zfbname})<br>
		                            			${items.zfb}</c:if>
		                            			<c:if test="${items.type==2}">
		                            			(${items.zfbname})<br>
		                            			${items.zfb}</c:if>
		                            		</td>
		                            		<td>
		                            			${items.desc}
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd"	type="both" />
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
		                                    <form id="paging" action="withdraw/list" method="get">
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
	function tx(){
		var act = "${act}";
		var ter = "${ter}";
		var bol = false;
		if(act!=null){
			var zfb = "${act.zfb}";
			var zfbname = "${act.zfbname}";
			if(zfb!=""&&zfbname!=""){
				bol=true;
			}
		}
		if(ter!=null){
			var zfb = "${ter.zfb}";
			var zfbname = "${ter.zfbname}";
			if(zfb!=""&&zfbname!=""){
				bol=true;
			}
		}
		if(bol){
			swal({ 
	 			 title: "提现申请", 
	 			 text: "请输入提现金额",
	 			 type: "input", 
				  showCancelButton: true, 
				  closeOnConfirm: false, 
	 			 animation: "slide-from-top", 
				},function(inputValue){ 
	 				if (inputValue === false) return false; 
	 				 if(!(/(^[1-9]\d*$)/.test(inputValue))){
						layer.msg("请输入正整数");
						return false;
					}else if(parseInt(inputValue)<100||parseInt(inputValue)>50000){
						layer.msg("请输入100-5万之间的金额");
						return false;
					}
					$.ajax({
						url:"withdraw/add",
						type:"post",
						data:{	
							money:inputValue
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
								layer.msg("申请成功");
								setTimeout('goFresh("withdraw/list")',1000); 
							}else{
								layer.msg(data.msg);
							}
						}
					});
				});
		}else{
			alert("请完善您的提现支付宝帐号");
		}
	}
    </script>
</body>
</html>