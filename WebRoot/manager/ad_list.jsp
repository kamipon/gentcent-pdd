<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>广告列表</title>
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
                        <h5>广告列表</h5>
                        <div class="ibox-tools">
                       		<span class="glyphicon glyphicon-plus"></span> 
                            <a class="J_menuItem" href="manager/ad_add.jsp">广告添加</a>
                        </div>                     
                    </div>
                    <form name="form2" action="" method="post">
						<input type="hidden" name="_method" value="delete" />
					</form>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/user" method="get">
								<div class="row">
									
                 				  </form>
								</div>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead class="pn-lthead">
	                                <tr>
	                                	<th style="width:5%">二维码</th>
	                                    <th style="width:20%">标题</th>
	                                    <th style="width:65%">链接</th>
                                    	<th style="width:10%">操作</th>	                                   
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            	<c:forEach items="${list}" var="items" varStatus="status">
	                            		<tr>
	                            			<td>
			                                	<div class="qrcodeIcon" _style="16" _id="5" onMouseOut="hideImg('${status.index }')"  onmouseover="showImg('${status.index }')"></div>
			                                    <div class="qrcodeBox" style="display: none;" id="wxImg${status.index }">
			                                    	<div class="inIcon"></div>
													<img class="images" alt="Wxmenu" src="wresource/url2?url2=/ads/${items.id }" style="height:100%;width:100%;">
												</div>
                            				</td>
		                            		<td>
		                            			<a class="J_menuItem" href="guanggao/query?id=${items.id}">${items.title }</a>
		                            		</td>
		                            		<td>
		                            			<%=res.getString("project.host")%>/ads/${items.id }
		                            		</td>
		                            		<td>
		                            			
												<a class="pn-opt" href="javascript:void(0);" onclick="del('${items.id}')">删除</a>|
		                                		<a class="J_menuItem" href="guanggao/${items.id}">修改</a>
		                            			
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
		                                    <form id="paging" action="activity" method="get">

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
    	function del(id){
		    swal({
		        title: "您确定要删除这条广告吗？",
		        text: "删除后将无法恢复，请谨慎操作！",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		    	if(isConfirm){
		    		$.ajax({
		    			type:"post",
						url:"guanggao/"+id,
						data:{_method:"delete"},
						dataType:"json",
						success:function(data){
							if(data.flag){
								swal({title:"删除成功！", text:"您已经永久删除这条广告。", type:"success"},function(){
									window.location.reload();
								});
							}else{
								layer.msg(data.msg);
							}

						}
					});
			    }
		    });
		}
    	
		function setPermission(id){
			layer.open({
				type: 2,
				title: '设置权限',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'menu/toMenu?userId='+id
			});	
		}
		function setRole(id){
			layer.open({
				type: 2,
				title: '设置角色',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'role/toCheck?userId='+id
			});	
		}
		function setRedPacket(id,num){
		    		layer.open({
						type: 2,
						title: '增加红包',
						shadeClose: true,
						shade: 0.8,
						area: ['1500px', '50%'],
						content: 'manager/redpacket_num.jsp?id='+id+'&num='+num
					});	
		}
		
    </script>
</body>
</html>