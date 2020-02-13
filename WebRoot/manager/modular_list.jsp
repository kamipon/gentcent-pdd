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

		<title>菜单管理 - 列表</title>
		<link rel="shortcut icon" href="favicon.ico">
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
		<link href="css/font-awesome.min93e3.css" rel="stylesheet">
		<link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
		<link href="css/animate.min.css" rel="stylesheet">
		<link href="css/style.min1fc6.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
		<link rel="stylesheet" href="${cp }/manager/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${cp }/manager/js/jquery.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery1.9.1.js"></script>
		<script type="text/javascript" src="${cp }/manager/js/jquery.ztree.core-3.5.js"></script>
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
	    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
	    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
	    <link href="css/animate.min.css" rel="stylesheet">
	    <link href="css/style.min1fc6.css" rel="stylesheet">
		<link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
		<script src="js/layer/layer.js"></script>
		<script type="text/javascript">
		function choose(){
			layer.open({
				type: 2,
				title: '选择菜单',
				shadeClose: true,
				shade: 0.8,
				area: ['800px', '90%'],
				content: '${cp }/menu/content' //iframe的url
			});	
		}
	</script>
	</head>

	<body class="gray-bg">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>
								菜单列表
							</h5>
						</div>

						<div class="ibox-content" style="padding: 3px 17px 0px;">
							<form role="form" class="form-inline">
								<div class="form-group">
									<label for="exampleInputEmail2" class="sr-only">
									</label>
									<input type="text" style="width: 83px;" placeholder="排序顺序"
										name="order" id="exampleInputEmail2"
										onkeyup="value=value.replace(/[^\-?\d.]/g,'')" maxlength="2"
										class="form-control">
								</div>
								<button type="button" class="btn btn-w-m btn-info"
									id="add_fath_article">
									添加父菜单
								</button>
								<button type="button" class="btn btn-w-m btn-primary"
									id="add_son_article">
									添加子菜单
								</button>
								<button type="button" class="btn btn-w-m btn-warning"
									id="update_order">
									修改排序
								</button>
								<button type="button" class="btn btn-w-m btn-danger"
									id="delete_article">
									删除菜单
								</button>
							</form>
							<div class="row border-bottom white-bg dashboard-header">
								<div class="col-sm-3" style="width: 14%;">
									<div id="tree" class="ztree ibox-content"
										style="width: 200px; background-color: white;"></div>
								</div>
								<div class="col-sm-8"
									style="width: 86%; border: 1px #CCCCCC solid;">
									<div class="col-sm-12">
										<div class="ibox float-e-margins">
											<div class="ibox-content">
												<form method="get" class="form-horizontal" id="modularForm">
													<input type="hidden" name="_method" value="put">
													<div class="form-group">
														<label class="col-sm-2 control-label">
															上级菜单
														</label>
														<div class="col-sm-10">
															<a data-toggle="modal" class="btn btn-primary"
																href="javascript:void(0)" onclick="choose()">选择菜单</a>
															<input type="hidden" name="parentId" id="navId">
															<span id="navName"></span>
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">
															<font color=red>*</font>菜单名称
														</label>
														<div class="col-sm-10">
															<input type="text" name="name" class="form-control" value="">
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">
															<font color=red>*</font>菜单code
														</label>
														<div class="col-sm-10">
															<input type="text" name="code" class="form-control" value="">
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">
															<font color=red>*</font>菜单类型
														</label>
														<div class="col-sm-10">
															 <select class="form-control m-b" id="type" name="type">
																<option value="menu">menu</option>
																<option value="event">event</option>
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">
															左css
														</label>
														<div class="col-sm-10">
															<input type="text" name="leftCss" class="form-control" >
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">
															右css
														</label>
														<div class="col-sm-10">
															<input type="text" name="rightCss" class="form-control" >
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">
															<font color=red>*</font>访问地址
														</label>
														<div class="col-sm-10">
															<input type="text" name="url" class="form-control">
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">
															<font color=red>*</font>排序
														</label>
														<div class="col-sm-10">
															<input type="text" name="order" class="form-control" onkeyup="value=value.replace(/[^\d]/g,'')" placeholder="请填写数字!">
														</div>
													</div>
													<div class="hr-line-dashed"></div>
													<div>
														<input type="hidden" value="${modular.id }" name="id">
														<button class="btn btn-primary" type="button" id="add_ter">
															保存内容
														</button>
														<button class="btn btn-primary" type="reset" id="remove" value="重置">
															重置
														</button>
													</div>
												</form>
											</div>
										</div>
									</div>
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
				onClick:zTreeOnClick
			}
		};
		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				if(childNodes[i].name){
					childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
				}
			}
			return childNodes;
		}
		
		//获取到每个节点的点击事件
		function zTreeOnClick(event, treeId, treeNode){
			var id = treeNode.id
			var name = treeNode.name;
			$.ajax({
				url : "${cp }/menu/"+id,
				type : "get",
				dataType : "json",
				success:function(data){
					var entity = data.entity;
					//id
					$("#navId").val(entity.parent);
					//模块名称
					$("#navName").text(entity.parentName);
					var lis = "";
					//模块显示名
					$("input[name='name']").val(entity.name);
					//模块code
					$("input[name='code']").val(entity.code);
					//类型
					$("#type").val(entity.type);
					//模块连接
					$("input[name='url']").val(entity.url);
					//排序
					$("input[name='order']").val(entity.order);
					//id
					$("input[name='id']").val(entity.id);
					//id
					$("input[name='leftCss']").val(entity.leftCss);
					//id
					$("input[name='rightCss']").val(entity.rightCss);
				}
			});
		}
		$(function(){
			//ajax便利ztree数据
			initDate();
			function initDate(){
				var zNodes_list;
				$.ajax({
					async:false,
					cache:false,
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
				$.fn.zTree.init($("#tree"), setting, zNodes_list);
			}
			//添加子节点
			$("#add_son_article").click(function(){
				//排序的值
				var orderVal = $.trim($("input[name='order']").val());
				var zTree = $.fn.zTree.getZTreeObj("tree");
				var nodes = zTree.getSelectedNodes();
				if(nodes == ''){
					layer.msg("请选中需要更改类目!");
					return false;
				}
				var idVal = nodes[0].id;
				layer.open({
				  type: 2,
				  title: '添加模块',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['1200px', '90%'],
				  content: '${cp }/menu/toadd?parentId='+idVal //iframe的url
				});			
			});
			//添加分类(父节点)
			$("#add_fath_article").click(function(){
				layer.open({
				  type: 2,
				  title: '添加模块',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['1200px', '90%'],
				  content: '${cp }/menu/toadd' //iframe的url
				});
			});
			//删除节点
			$("#delete_article").click(function(){
				var zTree = $.fn.zTree.getZTreeObj("tree");
				var nodes = zTree.getSelectedNodes();
				if(nodes == ''){
					layer.msg("请选中需要删除的类目!");
					return false;
				}
				var idVal = nodes[0].id;
				$.ajax({
					type:"post",
					url:"${cp }/menu/"+idVal,
					data:{'_method':'delete'},
					dataType:"json",
					success:function(data){
						if(data.flag){
							zTree.removeNode(nodes[0]);
						}else{
							layer.msg(data.msg);
						}
					}
				});				
			});
			//修改节点的排序值
			$("#update_order").click(function(){
				//排序的值
				var orderVal = $.trim($("input[name='order']").val());
				if(orderVal == ''){
					layer.msg("请输入需要修改的值!");
					return false;
				}
				var zTree = $.fn.zTree.getZTreeObj("tree");
				var nodes = zTree.getSelectedNodes();
				if(nodes == ''){
					layer.msg("请选中需要删除的类目!");
					return false;
				}
				var idVal = nodes[0].id;
				$.ajax({
					type:"post",
					url:"${cp}/menu/update_order/"+idVal,
					data:{'_method':'put','orderVal':orderVal},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
						}else{
							layer.msg(data.msg);
						}
					}
				});
			});
			
			//刷新
			$("#break_article").click(function(){
				var zNodes;
				$.ajax({
					async:false,
					cache:false,
					url:"${cp }/menu/ajaxList",
					type:"post",
					dataType:"json",
					error(){
						layer.msg("请求失败");
					},
					success:function(data){
						if(data.flag == "true"){
							initDate();
						}else if(data.flag){
							layer.msg(data.msg);
						}
					}
				});
			});
			//保存
		$("#add_ter").click(function(){
			//父模块
			var parent = $.trim($("input[name='parentId']").val());
			//模块显示名
			var name = $.trim($("input[name='name']").val());
			//模块code
			var code = $.trim($("input[name='code']").val());
			//类型
			var type = $("#type").val();
			//模块连接
			var url = $.trim($("input[name='url']").val());
			//排序
			var order = $.trim($("input[name='order']").val());
			//id
			var id = $.trim($("input[name='id']").val());
			var flag = validate(name,"请输入标题!");
			if(flag){
				$.ajax({
					url:"${cp}/menu/"+id,
					type:"post",
					data:$("#modularForm").serialize(),
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							var zTree = $.fn.zTree.getZTreeObj("tree");
							var nodes = zTree.getSelectedNodes();
							if(nodes[0].name==data.item.name){
								window.location.reload();
							}else{
								nodes[0].name=data.item.name;
								zTree.updateNode(nodes[0]);
							}
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
			
			function validate(date,msg){
				if(date == ''){
					layer.msg(msg);
					return false;
				}
				return true;
			}
	});
	</script>