<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>分类列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${cp }/manager/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="manager/js/jquery.js"></script>
	<script type="text/javascript" src="manager/js/jquery1.9.1.js"></script>
	<script type="text/javascript" src="${cp }/manager/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${cp }/js/11cms.js"></script>
	<script type="text/javascript" src="${cp }/js/moment.min.js"></script>
	<script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
		var setting = {
			view: {
				selectedMulti: false
			},async: {
				enable: true,
				url:"${cp }/category/ajaxList",
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
		function initTree(){
			var zNodes_list;
			$.ajax({
				async:false,
				cache:false,
				url:"${cp }/category/ajaxList",
				type:"post",
				dataType:"json",
				error:function(data){
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
		
		//获取到每个节点的点击事件
		function zTreeOnClick(event, treeId, treeNode){
			var navId = treeNode.id
			var name = treeNode.name;
			var param = {navId:navId};
			ajaxContentList(param);
			//重新绑定J_menu按钮
			$.getScript('js/childrenToMenu.js',function(){});
		}
		var page = {};
		function refreshCoutentList() {
			ajaxContentList(getPageParam());
		}
		function getPageParam() {
			var param = {pageIndex:page.pageIndex,pageSize:$('#pageSize').val()};
			try {
				//搜索name
				var name = $('#name').val();
				param.name = name;
				//树点击naviId
				var zTree = $.fn.zTree.getZTreeObj("tree");
				var nodes = zTree.getSelectedNodes();
				if(nodes){
					var node = nodes[0];
					param.navId = node.id;
				}
			}catch(e) {
			}
			return param;
		};
		function ajaxContentList(param) {
			$.ajax({
				async:false,
				cache:false,
				url:"${cp }/category/ajax/"+param.navId,
				type:"post",
				dataType:"json",
				error:function(data){
					layer.msg("请求失败");
				},
				success:function(data){
					$(".col-sm-8").removeClass("hide");
					var entity = data.entity;
					$("#navId").val(entity.parentId);
					//上级类目名称
					if(entity.parentName!=null){
						$("#navName").text(entity.parentName);
					}else{
						$("#navName").text("");
					}
					$("input[name='name']").val(entity.name);
					$("input[name='order']").val(entity.order);
					$("input[name='code']").val(entity.code);
					$("input[name='id']").val(entity.id);
				}
			});
		}
		
		$(function(){
			initTree();
		});
		
		//添加分类(父节点)
		$("#add_fath_article").click(function(){
		   layer.open({
		      type:2,
		      title:'添加类别',
		      shadeClose: true,
		      shade: 0.8,
		      area: ['1200px', '90%'],
		      content: '${cp }/category/toadd' //iframe的url
		   });
		 });
	</script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>商品分类列表</h5>
                    </div>
                    <div class="ibox-content" style="padding: 3px 17px 0px;">
                    	<form role="form" class="form-inline">
							<button type="button" class="btn btn-w-m btn-info"
								id="add_fath_article">
								添加父分类
							</button>
							<button type="button" class="btn btn-w-m btn-primary"
								id="add_son_article">
								添加子分类
							</button>
							<!--<button type="button" class="btn btn-w-m btn-danger"
								id="delete_article">
								删除菜单
							</button>
						--></form>
						<div class="row border-bottom white-bg dashboard-header">
							<div class="col-sm-3" style="width:14%;">
								<div id="tree" class="ztree ibox-content" style="width:200px;background-color: white;"></div>
							</div>
							<div class="col-sm-8 hide" style="width:86%;border:1px #CCCCCC solid;">
								<div class="col-sm-12">
									<div class="ibox float-e-margins">
										<div class="ibox-content">
											<form method="get" class="form-horizontal" id="modularForm">
												<input type="hidden" name="_method" value="put">
												<div class="form-group">
													<label class="col-sm-2 control-label">
														上级类别
													</label>
													<div class="col-sm-10">
														<a data-toggle="modal" class="btn btn-primary"
															href="javascript:void(0)" onclick="choose()">选择分类</a>
														<input type="hidden" name="parentId" id="navId">
														<span id="navName"></span>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">
														<font color=red>*</font>名称
													</label>
													<div class="col-sm-10">
														<input type="text" name="name" class="form-control" value="">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">
														<font color=red>*</font>排序
													</label>
													<div class="col-sm-10">
														<input type="text" name="order" class="form-control" value="">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">
														<font color=red>*</font>编号
													</label>
													<div class="col-sm-10" >
														<input type="text" name="code" class="form-control">
													</div>
												</div>
												<div>
													<input type="hidden" value="" name="id">
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
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
</body>
</html>
<script type="text/javascript">
	//添加分类(父节点)
	$("#add_fath_article").click(function(){
	   layer.open({
	      type:2,
	      title:'添加商品类别',
	      shadeClose: true,
	      shade: 0.8,
	      area: ['1200px', '90%'],
	      content: '${cp }/category/toadd' //iframe的url
	   });
	 });
	 
			 
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
			  title: '添加类别',
			  shadeClose: true,
			  shade: 0.8,
			  area: ['1200px', '90%'],
			  content: '${cp }/category/toadd?parentId='+idVal //iframe的url
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
			url:"${cp }/category/"+idVal,
			data:{'_method':'delete'},
			dataType:"json",
			success:function(data){
				if(data.flag){
					layer.msg("操作成功");
					zTree.removeNode(nodes[0]);
					location.reload();
				}else{
					layer.msg(data.msg);
				}
			}
		});				
	});
	
	//输入验证
	$("input[name='ratio']").each(function(){
		$(this).keyup(function(){
			$(this).val($(this).val().replace(/[^0-9.]/g,''));
		});
	});
			
	//保存
	$("#add_ter").click(function(){
		//id
		var id = $.trim($("input[name='id']").val());
		//父类别
		var parent = $.trim($("input[name='parentId']").val());
		//类别名称
		var name = $.trim($("input[name='name']").val());
		//序号
		var order = $.trim($("input[name='order']").val());
		//编号
		var code = $.trim($("input[name='code']").val());
		
		var array=[[name,"请填写类别名称!"],[order,"请填写排序!"],[code,"请填写编号!"]];
		var flag = validate(array);
		if(flag){
			$.ajax({
				url:"${cp}/category/"+id,
				type:"post",
				dataType:"json",
				data:{
					name:name,
					parentId:parent,
					code:code,
					order:order
				},
				success:function(data){
					if(data.flag){
						layer.msg(data.msg);
					}else{
						layer.msg(data.msg);
					}
				}
			});
		}
		return false;
	});
		
	//验证信息
	function validate(array){
		var flag=true;
		for(var i=0;i<array.length&&flag;i++){
			if(!array[i][0]){
				layer.msg(array[i][1]);
				flag=false;
			}
		}
		return flag;
	}
		
	//选择分类
	function choose(){
	   layer.open({
	        type: 2,
			title: '选择类目',
			shadeClose: true,
			shade: 0.8,
			area: ['800px', '90%'],
			content: '${cp }/manager/category_choose.jsp' //iframe的url
	   });
	}
	
</script>