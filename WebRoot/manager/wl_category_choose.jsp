<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>分类管理 - 列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link rel="shortcut icon" href="favicon.ico">
		<link href="css/style.min1fc6.css" rel="stylesheet">
		<link rel="stylesheet" href="${cp }/manager/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${cp }/manager/js/jquery.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery1.9.1.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery.ztree.excheck.min.js"></script>
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
	    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
	    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
		<script src="js/layer/layer.js"></script>
		<script src="js/11cms.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
	</head>
	<script type="text/javascript">
		var zTree;
		
		$(function(){
			zTree = new Tree().init({
				id : 'tree',
				url : '${cp}/wlcategory/ajaxList',
				expandAll : false,
				onClick : function(e, treeId, treeNode) {
					var names = treeNode.name;
					var ids = treeNode.id;
					parent.document.getElementById('navName').innerHTML=names;
					parent.document.getElementById('navId').value=ids;
					var index = parent.layer.getFrameIndex(window.name); 
					parent.layer.close(index);
				}
			});
		});
		
	</script>
	
	
	<body class="gray-bg">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content" style="padding: 3px 17px 0px;">
							<div class="row border-bottom white-bg dashboard-header">
								<div class="col-sm-3" style="width: 100%;min-height:300px;">
									<div id="tree" class="ztree ibox-content"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="js/childrenToMenu.js"></script>
	</body>
	
</html>