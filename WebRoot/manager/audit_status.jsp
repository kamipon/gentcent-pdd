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
    <title>贵金属交易系统-提现信息审核</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <style>
    	td{	height:30px;
    		width:170px;
    		}
    </style>
</head>
  
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>提现信息审核</h5>
                    	<div class="ibox-content" style="padding: 20px 5px 20px;">
                    		<table>
	                    		<tr>
	                    			<td><span style="font-weight: bold;">提现信息</span></td>
	                    		</tr>
	                    		<tr>
	                    			<td>
	                    				<span style="font-weight: bold;">用户昵称:${present.member.nick }</span>
	                    			</td>
	                    			<td>
	                    				<span style="font-weight: bold;">用户电话:${present.member.phone }</span>
	                    			</td>
	                    			<td>
	                    				<span style="font-weight: bold;">提现金额:${present.money }</span>
	                    			</td>
	                    			<td>
	                    				<span style="font-weight: bold;">类型:</span>
	                    				<c:choose>
	                           				<c:when test="${present.type=='1' }">
	                           					<span style="font-weight: bold">用户</span>
	                           				</c:when>
	                           				<c:otherwise>
	                           					<span style="font-weight: bold">经纪人</span>
	                           				</c:otherwise>
	                           			</c:choose>
	                    			</td>
	                    		</tr>
	                    	</table>
	                    	<textarea rows="10px;" cols="100px;" placeholder="如果审核不通过，请填写审核理由" name="audit"></textarea>
	                    	<input type="button" class="btn btn-sm btn-primary" value="通过" onclick="audit('${present.id }',1);">
	                    	<input type="button" class="btn btn-sm btn-primary" value="不通过" onclick="audit('${present.id }',2);">
	                    </div>  
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
    	var index = parent.layer.getFrameIndex(window.name);
    	function audit(id,val){
    		var audit = $.trim($("textarea[name='audit']").val());
    		if(val==2){
    			if(!audit){
    				layer.msg("审核不通过需要填写审核理由");
    				return false;
    			}
    		}
	 		swal({
        		title: "您确定要审核这条提现记录么",
       			text: "审核后将不能再做修改，请谨慎操作!",
        		type: "warning",
       			showCancelButton: true,
        		confirmButtonColor: "#DD6B55",
       			confirmButtonText: "审核",
        		closeOnConfirm: false
    		}, function (isConfirm) {
		    	if(isConfirm){
			       $.ajax({
				   		type:"post",
						url:"${cp}/present/audit",
						dataType:"json",
						data:{	id:id,
								val:val,
								audit:audit},
						success:function(data){
							if(data.flag){
								alert("审核成功!");
								parent.location.reload();
								parent.layer.close(index);
							}else{
								swal("审核失败!", data.msg, "error");
							}
						}
					});
			     }
		    });
		}
    </script> 
</body>
</html>
