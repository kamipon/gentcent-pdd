<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="${pageContenxt.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="cp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>栏目选择</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link type="text/css" rel="stylesheet" href="manager/css/cms.css">
		<script type="text/javascript" src="manager/js/jquery.js"></script>
		<link href="manager/css/jquery-ui-1.10.0.custom.css" rel="stylesheet" type="text/css" />
		<link type="text/css" rel="stylesheet" href="manager/css/buttons.css">
		<link rel="stylesheet" href="${cp }/manager/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="manager/js/jquery1.9.1.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="js/layer/layer.js"></script>
	</head>
	<script type="text/javascript">
		var setting = {
			view: {
				selectedMulti: false
			},async: {
				enable: true,
				url:"${cp }/menu",
				type:"get",
				autoParam: ["id=parentId"],
				dataFilter: filter
			},
			callback:{
				onClick:zTreeOnClick,
			}
		};
		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			}
			return childNodes;
		}
		
		//获取到每个节点的点击事件
		function zTreeOnClick(event, treeId, treeNode){
			var id = treeNode.id
			var name = treeNode.name;
			parent.document.getElementById('navName').innerHTML=name;
			parent.document.getElementById('navId').value=id;
			var index = parent.layer.getFrameIndex(window.name); 
			parent.layer.close(index);
			
		}
		$(function(){
			
			var id  = $.trim($("input[name='id']").val());
			//ajax便利ztree数据
			var zNodes_list;
			function initDate(){
				$.ajax({
					async:false,
					cache:false,
					url:"${cp }/menu",
					type:"get",
					dataType:"json",
					data:{
						id:id
					},
					error(){
						layer.msg("请求失败");
					},
					success:function(data){
						if(data.flag == "true"){
							zNodes_list = data.treeVal;
						}else if(data.flag){
							layer.msg(data.msg);
						}
					}
				});
			}
			$.fn.zTree.init($("#tree"), setting, zNodes_list);
		});
	</script>
	<body class="gray-bg" style="height: 100%;">
	<div class="wrapper wrapper-content animated fadeInRight">
	<div class="row">
		<div class="dingwei01" style="width:100%; left: 0px;top: 11px;">
            <div class="body-box" >
            	<table >
            		<tbody class="pn-ltbody" id="tb">
						<tr bgcolor="#ffffff">
							<td style="width:100px;" valign="top">
							
							</td>
							<td style="width:94.5%;" valign="top">
								<div id="tree" class="ztree" style=" width:100%; height:446px;">
								</div>
							</td>
						</tr>
					</tbody>
            	</table>
            	
            </div>
       	</div>
      </div>
    </div>
	</body>
</html>

<script>
	$(function(){
		
	});
</script>