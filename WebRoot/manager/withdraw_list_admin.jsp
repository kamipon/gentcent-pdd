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
							<form action="${pageContext.request.contextPath }/withdraw/listAdmin" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
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
	                                	<th>名称</th>
	                                	<th>类型</th>
	                                    <th>提现金额</th>
	                                    <th>支付宝帐号(打款帐号)</th>
	                                    <th>备注</th>
	                                    <th>状态</th>
	                                    <th>添加时间</th>
                                    	<th>操作</th>                         
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            <c:forEach items="${list}" var="items">
	                            			<td>
		                            			<c:if test="${items.type==1}">${items.activity.name}</c:if>
		                            			<c:if test="${items.type==2}">${items.terpoint.name}</c:if>
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.type==1}">商家</c:if>
		                            			<c:if test="${items.type==2}">代理</c:if>
		                            		</td>
		                            		<td>
		                            			${items.money}
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
			                            		<c:if test="${items.status==0}"><span style="color: red">审核中</span></c:if>
			                            		<c:if test="${items.status==1}"><span style="color: green">已提现</span></c:if>
			                            		<c:if test="${items.status==2}"><span style="color: black">驳回</span></c:if>
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd"	type="both" />
		                            		</td>
		                            		<td>
		                            			<c:if test="${items.status==0}">
													<a class="pn-opt" onclick="pass('${items.id}')">通过</a>
													<a class="pn-opt" onclick="reject('${items.id}')">驳回</a>
													<a class="pn-opt" onclick="hedui('${items.id}')">核对金额</a>
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
		                                    <form id="paging" action="withdraw/listAdmin" method="get">
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
			function hedui(id){
		    		$.ajax({
		    			type:"post",
						url:"withdraw/hedui",
						data:{
							id:id
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
								var msg;
								if(data.type==1){
									msg="当前账户余额:"+data.money.toFixed(2)+"</br>提现中笔数:"+data.shzCount+"</br>提现中金额:"+data.shz
									+"</br>已提现金额:"+data.tx+"</br></br>商家核对【提现中笔数】和【提现中金额】是否与实际相同,【当前账户余额】是否为正数"
									+"</br>";
									if(data.money>=0){
										msg+="【核对通过!】";
									}else{
										msg+="【核对不通过！请勿打款！】";
									}
								}
								if(data.type==2){
									msg="总赚取手续费:"+data.money.toFixed(2)+"</br>提现中笔数:"+data.shzCount+"</br>提现中金额:"+data.shz
									+"</br>已提现金额:"+data.tx+"</br></br>代理核对【提现中金额+已提现金额】是否[≤]【总赚取手续费】"
									+"</br>";
									if((data.shz+data.tx)<=data.money){
										msg+="【核对通过!】";
									}else{
										msg+="【核对不通过！请勿打款！】";
									}
								}
								layer.alert(msg);
							}else{
								layer.alert("核对有误，请刷新重试");
							}

						}
					});
			    }
		  function pass(id){
		    swal({
		        title:"确定通过！",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "确定",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"withdraw/pass?id="+id,
						data:{
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
									swal({title:"审核通过",type:"success"},function(){
										window.location.reload();
									});
							}else{
								layer.msg("失败");
							}

						}
					});
			    }
		    });
		}
	function reject(id){
		swal({ 
 			 title: "确定驳回？", 
 			 text: "请输入驳回原因",
 			 type: "input", 
			  showCancelButton: true, 
			  closeOnConfirm: false, 
 			 animation: "slide-from-top", 
			},function(inputValue){ 
 				 if (inputValue === false) return false; 
 				 $.ajax({
		    			type:"post",
						url:"withdraw/reject?id="+id,
						data:{
							desc:inputValue,
						},
						dataType:"json",
						success:function(data){
							if(data.flag){
									swal({title:"驳回成功。",type:"success"},function(){
										window.location.reload();
									});
							}else{
								layer.msg("失败");
							}

						}
					});
				});
	}
    </script>
</body>
</html>