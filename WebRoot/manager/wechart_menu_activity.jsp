<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
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
		<title>公众号管理</title>
		<link rel="shortcut icon" href="favicon.ico">
		<link href="css/bootstrap.minb16a.css" rel="stylesheet">
		<link href="css/font-awesome.min93e3.css" rel="stylesheet">
		<link href="css/plugins/iCheck/custom.css" rel="stylesheet">
		<link href="css/animate.min.css" rel="stylesheet">
		<link href="css/style.min1fc6.css" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="css/cms.css">
		<link type="text/css" rel="stylesheet" href="manager/css/cms.css">
		<script type="text/javascript" src="manager/js/jquery.js"></script>
		<script type="text/javascript" src="manager/js/jquery.json-2.4.js"></script>
			
		<script type="text/javascript">
			function check(index,a){
				var name=$('#menuName'+index).val();
				var value=$('#menuValue'+index).val();
				var type=$('#menuType'+index).val();
				var childName=$('#menuName'+index+a);
				var childValue=$('#menuValue'+index+a);
				var childType=$('#menuType'+index+a);
				if(name!=""){
					if(value!=""){
						if(type!=""){
							if(childName!=""){
								if(childValue!=""){
									if(childType!=""){
										alert(1);
									}else{
										$('#menuError'+index).html("<font color = 'red'>请选择菜单类别</font>");
									}
								}else{
									$('#menuError'+index).html("<font color = 'red'>菜单值不能为空</font>");
								}
							}else{
								$('#menuError'+index).html("<font color = 'red'>菜单名不能为空</font>");
							}
						}else{
							$('#menuError'+index).html("<font color = 'red'>请选择主菜单类别</font>");
						}
					}else {
						$('#menuError'+index).html("<font color = 'red'>主菜单值不能为空</font>");
					}
				}else{
					$('#menuError'+index).html("<font color = 'red'>主菜单名不能为空</font>");
				}
			}
			
			function clearMenuError(i){
				$('#menuError'+i).html("");
			}
			function addModel(index){
				var a=document.getElementsByName("menuName"+index).length;				
				if($('#menuName'+index).val()==''){
					$('#menuError'+index).html("<font color = 'red'>主菜单不能为空</font>");
					return false;
				}else if($('#menuType'+index).val()!="menu"){
					$('#menuError'+index).html("<font color = 'red'>主菜单类型不能有子菜单</font>");
					return false;
				}
				if($('#menuName'+index+(a-1)).val()==''){
					$('#menuError'+index).html("<font color = 'red'>菜单不能为空</font>");
					return false;
				}
				if(a>4){
					return false;
				}
				var submenu = $('#subMenu'+index);
				var tr="<tr id='tr"+index+a+"'><td><font color=blue >菜单名:</font><input type='text' maxlength='7' name='menuName"+index+"' onfocus='clearMenuError("+index+")' id='menuName"+index+a+"' style='background-color: white; color: black;width: 100px'><font color=green >菜单类型：</font><select name='menuType"+index+"' id='menuType"+index+a+"' style='background-color: white; color: black;width: 100px' ><option value='view'>链接</option><option value='click'>事件</option></select><font color=red >值：</font><input type='text' name='menuValue"+index+"' id='menuValue"+index+a+"' style='background-color: white; color: black;width: 500px'> <a href=\"javascript:void(0)\" onclick=\"removeMenu('tr"+index+a+"')\">╳</a></td></tr>";


				submenu.append(tr);
			}
			function addMenuModel(index){
			var indexs=index+1;

			if(document.getElementById("editable2")){indexs=3;}
			if(document.getElementById("editable3")&&document.getElementById("editable2")){return false;}
			if(document.getElementById("editable3")){
				if(document.getElementById("editable2")){
				}else{
					index=2;
				}
			}
			var tab="<table class='table table-striped table-bordered table-hover dataTables-example' id='editable"+ indexs+"'><thead class='pn-lthead'><tr><th style='background-color:white'><span style='font-size: 19px;'><font color=black >菜单</font>	<div class='ibox-tools'><button class='btn btn-primary' type='button' id='add_ter' id='save222'  onclick='removeAll("+indexs+")'>删除</button><div></span></th></tr></thead><tbody class='pn-ltbody' id='subMenu"+indexs+"'><tr><td><font color=blue >菜单名:</font><input  type='text' style='background-color: white; color: black;width: 100px' maxlength='7' id='menuName"+indexs+"' onfocus='clearMenuError("+indexs+")' ><font color=green >菜单类型：</font><select id='menuType"+indexs+"' style='background-color: white; color: black; width: 100px'  onChange='choose("+indexs+")' ><option value='menu'>父级</option><option value='view'>链接</option><option value='click'>事件</option></select><font color=red >值：</font><input type='text' style='background-color: white; color: black; width: 500px' id='menuValue"+indexs+"' style='width: 500px'></td></tr></tbody><tfoot class='pn-ltbody'><tr><td><div align='center'><img style='margin-top: 5px;' width='20' id='addMenu"+indexs+"' alt='' onclick='addModel("+indexs+")' src='img/down.png'></div></td></tr><tr><td><span id='menuError"+indexs+"'></span></td></tr></tfoot></table><div class='hr-line-dashed'></div>"
 			var submenu = $('#div'+index);
 				submenu.append(tab);
			}
			
			
			
			var menus={
				menus:[]
			}
			function save(){
				menus.menus=[];
				if(document.getElementById("editable1")){
					topMenuStr(1);
				}
				if(document.getElementById("editable2")){
					topMenuStr(2);
					}
				if(document.getElementById("editable3")){
					topMenuStr(3);
				}
				var str=$.toJSON(menus);
				$('#menuString').val(str);
				this.form3.submit();
				
			}
			function topMenuStr(i){
				var name=$('#menuName'+i).val();
				var type=$('#menuType'+i).val();
				var menuValue=$('#menuValue'+i).val();
				var menu={
					name:name,
					type:type
				}
				if(type=='view'){
					menu.url=menuValue;
				}else if(type=='click'){
					menu.key=menuValue;
				}else if(type=='menu'){
					var items=childMenuStr(i);
					menu.items=items;
				}
				menus.menus.push(menu);
			}
			
			function childMenuStr(i){
			    var items=[];
			    var b=document.getElementsByName("menuName"+i);
			    for(var a=0;a<b.length;a++){
			    	var name=document.getElementsByName("menuName"+i)[a].value;
			    	var value=document.getElementsByName("menuValue"+i)[a].value;
			    	var type=document.getElementsByName("menuType"+i)[a].value;
			    	var item={
			    		name:name,
			    		type:type,
			    	}
			    	if(type=="view"){
			    		item.url=value;
			    	}else if(type=="click"){
			    		item.key=value;
			    	}
			    	items.push(item);
			    }
			    return items;
			}
			
			var strMenu=${menuString}
			$(document).ready(function(){
				if(strMenu!=null&&strMenu!=''){
					addTop();
				}
			})
			function addTop(){
				for(var a=1;a<4;a++){
					if(a>1&&strMenu.menus[a-1].name!=''){addMenuModel(1);}
					$('#menuName'+a).val(strMenu.menus[a-1].name);
					$('#menuType'+a).val(strMenu.menus[a-1].type);
					if(strMenu.menus[a-1].type=='view'){
						$('#menuValue'+a).val(strMenu.menus[a-1].url);
					}else if(strMenu.menus[a-1].type=='click'){
						$('#menuValue'+a).val(strMenu.menus[a-1].key);
					}else if(strMenu.menus[a-1].type=='menu'){
						addChild(a);
					}
				}
			}
			function addChild(i){
				var childMenu=strMenu.menus[i-1].items.length;
				for(var a=0;a<childMenu;a++){
					addModel(i);
					var name=$('#menuName'+i+a).val(strMenu.menus[i-1].items[a].name);
					var type=$('#menuType'+i+a).val(strMenu.menus[i-1].items[a].type);
					if(strMenu.menus[i-1].items[a].type=='view'){
						$('#menuValue'+i+a).val(strMenu.menus[i-1].items[a].url);
					}else if(strMenu.menus[i-1].items[a].type=='click'){
						$('#menuValue'+i+a).val(strMenu.menus[i-1].items[a].key);
					}
					
				}
			}
			
			function removeMenu(id){
				 if(window.confirm("确定要删除这个菜单吗？")){
				 alert('#'+id);
				   $('#'+id).remove();
				  }
			}
			function removeAll(id){
				 if(window.confirm("确定要删除整个菜单吗？")){	
					 if(document.getElementById("editable1")||document.getElementById("editable2")){
					 }else{
					 	alert("必须保留一个菜单");
					 	return false;	 				 	
					 }
					  if(document.getElementById("editable1")||document.getElementById("editable3")){
					 }else{
					 	alert("必须保留一个菜单");
					 	return false;	 				 	
					 }
					  if(document.getElementById("editable2")||document.getElementById("editable3")){
					 }else{
					 	alert("必须保留一个菜单");
					 	return false;	 				 	
					 }
				 	var obj = document.getElementById("editable"+id);
        					obj.parentNode.removeChild(obj);
				}
			}
			
		</script>
	</head>
	<body class="gray-bg">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins"  >
						<div class="ibox-title">
							<h5>
								当前位置: 设置 - 微信菜单
							</h5>
						</div>
						<div class="body-box" style="display: inline-block;width: 900px;">
							<form id="jvForm" action="wechart/menu" method="post" name="form3">
								<input type="hidden" name="menuString" value="" id="menuString">
							</form>					
							<div id="nav">
								<button class="btn btn-primary" type="button" id="add_far" onclick="addMenuModel(1)">添加</button>	
								<button class="btn btn-primary" type="button" id="add_ter" id="save" onclick="save()">
									保存
								</button> 
							</div>
							<table class="table table-striped table-bordered table-hover dataTables-example" id="editable1">

								<thead class="pn-lthead">
									<tr>
										<th style="background-color:white">
											<span style="font-size: 19px;">
												<font color=black >菜单</font>
												<div class="ibox-tools">											
												<button class="btn btn-primary" type="button" id="add_ter" id="save"  onclick="removeAll(1)">删除</button> 
												<div>
											</span>
										</th>
									</tr>
								</thead>
								<tbody class="pn-ltbody" id="subMenu1">
									<tr>
										<td>
											<font color=blue >菜单名:</font>
											<input  type="text" maxlength="7" id="menuName1" onfocus="clearMenuError(1)" style="background-color: white; color: black;width: 100px">
											<font color=green >菜单类型：</font>
											<select id="menuType1" onChange="choose(1)" style="background-color: white; color: black;width: 100px">
												<option value="menu">
													父级
												</option>
												<option value="view">
													链接
												</option>
												<option value="click">
													事件
												</option>
											</select>
											<font color=red >值：</font>
											<input type="text" id="menuValue1" style="background-color: white; color: black;width: 500px">
											
										</td>
									</tr>
								</tbody>
								<tfoot class="pn-ltbody">
									<tr>
										<td>
											<div align="center">
												<img style="margin-top: 5px;" width="20" id="addMenu1" alt="" onclick="addModel(1)" src="img/down.png">
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<span id="menuError1"></span>
										</td>
									</tr>
								</tfoot>
							</table>							
							<div id="div1" class="hr-line-dashed"></div>
						</div>
						<div class="body-box" style=" display: inline-block; vertical-align: top; margin-left: 20px;" >
							<h1>注意事项</h1>
							<div>
								<img style="margin: -5px 0 -5px 0;" src="imgmenu/menuAttention.png">
							</div>
				 		</div>
					</div>				
				</div>
			</div>
			<script src="js/layer/layer.js"></script>
			<script type="text/javascript" src="js/childrenToMenu.js"></script>
	</body>
</html>
