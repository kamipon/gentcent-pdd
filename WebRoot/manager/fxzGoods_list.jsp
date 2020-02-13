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
    <title>商品列表</title>
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
                    <h5>商品列表</h5>
                    <c:if test="${sessionScope.loginUser.id ne '1'}">
                        <div class="ibox-tools">
                       			<span class="glyphicon glyphicon-plus"></span>
	                       		<a class="J_menuItem" href="fxzGoods/toAdd">商品添加</a> 
                        </div>   
                        </c:if>                  
                    </div>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/fxzGoods/list" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
												查找：
					                        	<input type="text"  value="${name}" name="name" placeholder="根据商品名查询">
					                        	<input type="text"  value="${telephone}" name="telephone" placeholder="根据联系方式查询">
					                        	&nbsp;&nbsp;
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
	                                	<th>二维码</th>
	                                	<th>活动链接</th>
	                                    <th>商品名称</th>
	                                    <th>分享内容</th>
	                                    <th>商品海报</th>
	                                    <th>联系方式</th>
	                                    <th>商品价格（元）</th>
                                    	<th>佣金（元）</th>
                                    	<th>是否需要填写地址</th>
                                    	<th>是否核销</th>
                                    	<th>到期时间</th>
                                    	<th>添加时间</th>
                                    	
                                    	<c:if test="${sessionScope.loginUser.id ne '1'}">
                                    	<th>操作</th>
                                    	</c:if>
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            <c:forEach items="${list}" var="items">
	                            			<td>
	                            				<div class="qrcodeIcon" _style="16" _id="5" onMouseOut="hideImg('${items.id }')"  onmouseover="showImg('${items.id }')"></div>
			                                    <div class="qrcodeBox" style="display: none;" id="wxImg${items.id }">
			                                    	<div class="inIcon"></div>
													<img alt="Wxmenu" src="wresource/url?url=<%=res.getString("project.host")%>/hd/${items.id }" style="height:100%;width:100%;">
												</div>
												<input type="button"  onClick="downloadss('<%=res.getString("project.host")%>/wresource/url?url=<%=res.getString("project.host")%>/hd/${items.id }','${items.name }.jpg')" value="下载二维码" />
	                            			</td>
	                            			<td style="word-wrap:break-word;">
		                            			<div id="biao1"><%=res.getString("project.host")%>/hd/${items.id }</div>
		                            			<br>
		                            			<input type="button" onClick="copyUrl2('<%=res.getString("project.host")%>/hd/${items.id }')" value="点击复制链接" />
		                            		</td>
		                            		<td>
		                            			${items.name }
		                            		</td>
		                            		<td>
		                            			${items.content }
		                            		</td>
		                            		<td>
		                            			<img src="${items.picUrl }" style="width:50px;height:50px;">
		                            		</td>
		                            		<td>
		                            			${items.telphone}
		                            		</td>
		                            		<td>
		                            			<!-- ¥&nbsp; -->
		                            			${items.price}
		                            		</td>
		                            		<td>
		                            			<!-- ¥&nbsp; -->
		                            		${items.money}
		                            		</td>
		                            		<td>
		                            			<!-- ¥&nbsp; -->
		                            			<c:if test="${items.isAddress==1}">是</c:if>
		                            			<c:if test="${items.isAddress!=1}">否</c:if>
		                            		</td>
		                            		<td>
		                            			<!-- ¥&nbsp; -->
		                            			<c:if test="${items.isHx==0}">是</c:if>
		                            			<c:if test="${items.isHx!=0}">否</c:if>
		                            		</td>
		                            		<td>
		                            		<fmt:formatDate value="${items.endTime }" pattern="yyyy-MM-dd HH:mm:ss" type="both" />
		                            		</td>
		                            		<td>
		                            		<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd HH:mm:ss" type="both" />
		                            		</td>
		                            		<c:if test="${sessionScope.loginUser.id ne '1'}">
		                            		<td>
												<a class="pn-opt" href="fxzGoods/detail?id=${items.id}">查看</a>|
		                                		<a class="J_menuItem" href="fxzGoods/${items.id}">修改</a>|
		                                		<a href="javascript:void(0)" onclick="del('${items.id }')">删除</a>
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
		                                    <form id="paging" action="fxzGoods/list" method="get">
		                                    <input type="hidden" name="name" value="${name}">
		                                    <input type="hidden" name="telephone" value="${telephone}">
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
    		function downloadss(src,imgname) {
				var $a = document.createElement('a');
				$a.setAttribute("href", src);
				$a.setAttribute("download", imgname+ ".jpg");//需要加上后缀名
				document.body.appendChild($a);
				$a.click();
				document.body.removeChild($a);
		    }
		    
    		function copyUrl2(url)
		    {
		        var Url2=url;
		        var oInput = document.createElement('input');
		        oInput.value = Url2;
		        document.body.appendChild(oInput);
		        oInput.select(); // 选择对象
		        document.execCommand("Copy"); // 执行浏览器复制命令
		        oInput.className = 'oInput';
		        oInput.style.display='none';
		        alert('复制成功');
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
    </script>
</body>
</html>