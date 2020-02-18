<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="cp" value="${pageContenxt.request.contextPath }"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:set var="cp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>菜单管理 - 设置权限</title>
		<link rel="shortcut icon" href="favicon.ico">
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
		<link href="css/font-awesome.min93e3.css" rel="stylesheet">
		<link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
		<link href="css/animate.min.css" rel="stylesheet">
		<link href="css/style.min1fc6.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
		<link rel="stylesheet" href="${cp }/manager/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${cp }/manager/js/jquery1.9.1.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${cp }/js/jquery.ztree.excheck.min.js"></script>
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
	    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
	    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
	    <link href="css/animate.min.css" rel="stylesheet">
	    <link href="css/style.min1fc6.css" rel="stylesheet">
		<link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
		<script src="js/layer/layer.js"></script>
	</head>

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
							<button onclick="bind()">确定选择</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="js/childrenToMenu.js"></script>
	</body>
</html>
<script type="text/javascript">
		var curStatus = "init", curAsyncCount = 0, asyncForAll = false,
		goAsync = false;
		var setting = {
			check: {
		        enable: true,
		        chkboxType: { "Y": "", "N": "" }
		    },
		    async: {
				enable: true,
				url:"${cp }/menu",
				type:"get",
				autoParam: ["id=parentId"],
				dataFilter: filter
			},
			callback: {
				beforeAsync: beforeAsync,
				onAsyncSuccess: onAsyncSuccess,
				onAsyncError: onAsyncError
			}
		};
		function beforeAsync() {
			curAsyncCount++;
		}
		
		function onAsyncSuccess(event, treeId, treeNode, msg) {
			curAsyncCount--;
			if (curStatus == "expand") {
				expandNodes(treeNode.children);
			} else if (curStatus == "async") {
				asyncNodes(treeNode.children);
			}

			if (curAsyncCount <= 0) {
				if (curStatus != "init" && curStatus != "") {
					asyncForAll = true;
				}
				curStatus = "";
			}
			expandAll();
			for(var i=0;i<array.length;i++){
				AssignCheck(array[i].id);
			}
		}
		function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
			curAsyncCount--;

			if (curAsyncCount <= 0) {
				curStatus = "";
				if (treeNode!=null) asyncForAll = true;
			}
		}
		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			}
			return childNodes;
		}
		var array=[];
		$(function(){
			getMenu();
			//ajax便利ztree数据
			initDate();
			function initDate(){
				var zNodes_list;
				$.ajax({
					url:"${cp }/menu",
					type:"get",
					dataType:"json",
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
				 var id = layer.msg('加载中', {
				               icon: 16,
				               shade: 0.4,
				               time:false //取消自动关闭
							});
				setTimeout(function(){
					$.fn.zTree.init($("#tree"), setting, zNodes_list);
					layer.close(id);
				},700);
			}
		});
		function getMenu(){
			$.ajax({
				url:"menu/getMenu",
				data:{
					'userId':'${userId}',
					'roleId':'${roleId}'
				},
				dataType:"json",
				type:"get",
				success:function(res){
					array=res;
				}
			});
		}
		function expandAll() {
			if (!check()) {
				return;
			}
			var zTree = $.fn.zTree.getZTreeObj("tree");
			if (asyncForAll) {
				zTree.expandAll(true);
			} else {
				expandNodes(zTree.getNodes());
				if (!goAsync) {
					curStatus = "";
				}
			}
		}
		function check() {
			if (curAsyncCount > 0) {
				return false;
			}
			return true;
		}
		function expandNodes(nodes) {
			if (!nodes) return;
			curStatus = "expand";
			var zTree = $.fn.zTree.getZTreeObj("tree");
			for (var i=0, l=nodes.length; i<l; i++) {
				zTree.expandNode(nodes[i], true, false, false);
				if (nodes[i].isParent && nodes[i].zAsync) {
					expandNodes(nodes[i].children);
				} else {
					goAsync = true;
				}
			}
		}
		//选中指定的节点
	    function AssignCheck(id) {
	        var treeObj = $.fn.zTree.getZTreeObj("tree");
	        treeObj.checkNode(treeObj.getNodeByParam("id", id, null), true, true);
	    }
		function bind(){
			var id= "";
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			//新菜单
			var nodes = treeObj.getCheckedNodes(true);
			//新增菜单
			var value=[];
			//待删除菜单
			var menuIds_r=[];
			//新菜单ID
			var _nodes = [];
			//旧菜单ID
			var _array = [];
			for(var i = 0;i < nodes.length; i++){
				_nodes.push(nodes[i].id);
			}
			for(var i = 0;i < array.length; i++){
				_array.push(array[i].id);
			}
			for(var i = 0;i < _nodes.length; i++){
				//array中没有则新增，array--旧菜单,没有找到放回-1
				if($.inArray(_nodes[i],_array)== -1){
					value.push(_nodes[i].trim());
				}
			}
			for(var i = 0; i <_array.length; i++){
				//nodes中没有则删除，nodes--新菜单
				if($.inArray(_array[i],_nodes)== -1){
					menuIds_r.push(_array[i].trim());
				}
			}
			var type="${type}";
			var url = "";
			if(type!=""){
				url = "menu/plsetMenu";
			}else{
				//单独设置权限
				url = "menu/setMenu";
				value = _nodes;
			}
	        $.ajax({
				url:url,
				type:"post",
				data:{
					'menuIds_r[]':menuIds_r,
					'menuIds[]':value,
					'userId':'${userId}',
					'roleId':'${roleId}'
				},
				dataType:"json",
				//发送请求之前
				beforeSend:function(XMLHttpRequest){ 
					 id = layer.msg('处理中', {
				               icon: 16,
				               shade: 0.4,
				               time:false //取消自动关闭
							});
		        }, 
				success:function(res){
					if(res.flag){
						layer.msg('绑定成功',{time:1000},function(){
							//获取当前窗口的索引
							var index = parent.layer.getFrameIndex(window.name);
							//关闭当前窗口
							parent.layer.close(index);
						});
					}else{
						layer.msg(res.msg);
					}
				},
				//请求完成之后
				complete:function(XMLHttpRequest,textStatus){
					layer.close(id);//手动关闭
				}
			});
		}
	</script>