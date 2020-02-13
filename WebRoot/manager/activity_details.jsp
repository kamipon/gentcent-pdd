<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    

    <title>修改</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
   	<link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
	<style type="text/css">
		#_input{
			width: 10%;
			margin-top: -34px;
			margin-left: 0px;
		}
	</style>
</head>

<body class="gray-bg">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    	<h5>个人信息</h5>
                        <div class="ibox-tools">
                        	<!--<span class="glyphicon glyphicon-yen"></span>
                       		<a class="J_menuItem" href="redpacket/list?id=${activity.id}">红包列表</a> 
                       		--><!--<c:if test="${activity.categoryt==1}">
                       		<span class="glyphicon glyphicon-plus"></span>
                       		<a href="javascript:void(0)" onclick="buyRedPacket()">购买红包</a>
                       		</c:if>
                        --></div>             
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                        <div class="form-group">
	                        	<input type="hidden" name="id" value="${activity.id }">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商家名</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name" value="${activity.name }" >
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>支付宝账号
	                            </label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="zfb" value="${activity.zfb}" <c:if test="${!empty activity.zfb}">readonly="readonly"</c:if> >
	                            	<br>
	                            	<font style="color: red;">只能保存一次，如要修改，请联系管理员</font>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>支付宝账号真实姓名
	                            </label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="zfbname" value="${activity.zfbname}" <c:if test="${!empty activity.zfbname}">readonly="readonly"</c:if> >
	                            	<br>
	                            	<font style="color: red;">只能保存一次，如要修改，请联系管理员</font>
	                            </div>
	                        </div>
	                        <!-- 
	                          <div class="form-group">
	                        	<input type="hidden" name="id" value="${activity.id }">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>红包名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="redName" value="<c:if test="${empty activity.redName }">红包派</c:if><c:if test="${!empty activity.redName }">${activity.redName }</c:if>" >
	                            </div>
	                        </div>
	                        -->
							<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="phone" value="${activity.phone }">
	                            </div>
	                        </div>
	                        <!-- 
	                       <div class="form-group">
	                       	  	 <label class="col-sm-2 control-label"><font color="red">*</font>选择活动类型</label>
	                       		 <div class="col-sm-10">
									 <select class="form-control m-b" id="pattern" name="pattern">
										<option value="0" <c:if test="${activity.pattern == 0}">selected="selected"</c:if> id="shareGet"> 分享领取</option>
										<option value="1" <c:if test="${activity.pattern == 1}">selected="selected"</c:if>> 直接领取</option>
										<option value="2" <c:if test="${activity.pattern == 2}">selected="selected"</c:if> id="lookGet"> 关注领取</option>
									</select>
								 </div>
						   </div>
						    -->
						    <!-- 
					 	   <div class="form-group">
                          		<label class="col-sm-2 control-label"><font color="red">*</font>选择到账方式</label>
	                       		 <div class="col-sm-10">
									 <select class="form-control m-b" id="saveType" name=""saveType"">
										<option value="0" <c:if test="${activity.saveType == 0}">selected="selected"</c:if>> 领到余额</option>
										<option value="1" <c:if test="${activity.saveType == 1}">selected="selected"</c:if>> 直接到账</option>
									</select>
								</div>
						   </div>
						   -->
						   <!-- 
						    <div class="form-group">
                          		<label class="col-sm-2 control-label"><font color="red">*</font>是否需要地址</label>
	                       		 <div class="col-sm-10">
									 <select class="form-control m-b" id="isaddress" name=""isaddress"">
										<option value="1" <c:if test="${activity.isaddress == 1||empty activity.isaddress}">selected="selected"</c:if>> 否</option>
										<option value="2" <c:if test="${activity.isaddress == 2}">selected="selected"</c:if>>是</option>
									</select>
								</div>
						   </div>
						   -->
						   <!-- 
	                        <div id="picType" type="" style="display:none"></div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享标题</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="title" value="${activity.title }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享链接</label>
	                            <div class="col-sm-10">
	                            	 <div>
                                		<input type="text" class="form-control"  value="${activity.url }" id="inurl" style="width:500px;"/>
                                		<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="">选择砍价活动</a>
							        </div>  
	                            	<div>
	                            	 	<input type="radio" name="how" id="guang">填写广告链接
	                            	 	<input type="radio" name="how" id="kan" onclick="getUr('kanurl')">选择砍价活动
							            <select  id="kanurl" class="form-control"  onchange="getUr('kanurl')" style="display:none" >
							            	<c:forEach items="${urlList}" var="each">
							            		<option value="${each.url}" id="${each.name}">${each.name }</option>
							            	</c:forEach>  
							            </select>  
                                		<input type="text" class="form-control" style="display:none" value="${activity.url }" id="inurl" onchange="getUr('inurl')">
							        </div>  
	                            </div>
	                        </div>
	                        <div class="form-group">
                          		<label class="col-sm-2 control-label"><font color="red">*</font>选择模板</label>
	                       		 <div class="col-sm-10">
									 <select class="form-control m-b" id="muban" name="muban">
									 <c:forEach items="${list}" var="items">
										<option value="${items.id}" <c:if test="${items.id == activity.content.id}">selected="selected"</c:if>> ${items.title}</option>
									</c:forEach>
									</select>
								</div>
							</div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享图片<p style="color:red;">ps:图片大小限制为200KB</p></label>
	                            <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('shareUrl')">选择图片</a>
                                	<img src="${activity.picUrl}" name="picUrl" id="shareUrl" style="height:50px;">
                                </div>
	                        </div> 
	                       	<div class="form-group">
	                            <label class="col-sm-2 control-label">核销密码</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="hx" value="${activity.hx_password}">
	                            </div>
	                        </div>
	                        -->
							<div class="form-group">
	                            <label class="col-sm-2 control-label">地址</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="address" value="${activity.address}">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">描述</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="desc" value="${activity.desc}">
	                            </div>
	                        </div>
	                        <!-- 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">积分商城地址</label>
	                            <div class="col-sm-10">
	                                <input type="text" readonly="readonly" class="form-control" name="desc" value="http://redpacket.keji09.com:80/myCenter/${activity.id }">
	                            </div>
	                        </div>
	                        -->
	                        <div class="hr-line-dashed"></div>
                        	<div>
                            	<button class="btn btn-primary" type="button" id="redpacktModel">修改</button>
                                <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
 	<script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script>
	var ur = $("#inurl").val();
	$(function() {
	    $("#model").change(function() {
	        if (this.value == "1") {
	            $("#num").show();
	            
	            ;
	        } else {
	            $("#num").hide();
	           
	        }
	    });
	});
	if(${flag}){
	    $("#kanurl").css("display","block");
	   $("#kan").attr("checked","checked");
	   $("#${comId}").attr("selected","selected");
	}else{
 	   $("#guang").attr("checked","checked");
 	   $("#inurl").css("display","block");
	}
	$(function(){
		$("#redpacktModel").click(function(){
			//活动的ID
			var id = $.trim($("input[name='id']").val());
			//活动的名称
			var name = $.trim($("input[name='name']").val());
			//支付宝账号
			var zfb = $.trim($("input[name='zfb']").val());
			//支付宝账号
			var zfbname = $.trim($("input[name='zfbname']").val());
			//联系方式
			var phone = $.trim($("input[name='phone']").val());
			
			/*
			//红包名称
			var redName = $.trim($("input[name='redName']").val());
			//核销密码
			var hx = $.trim($("input[name='hx']").val());
			//分享标题
			var title = $.trim($("input[name='title']").val());
			//分享地址
			var url = ur;
			//分享图片
			var picUrl = $("#shareUrl").attr('src');
			//模板的ID
			var muban = $.trim($("#muban option:selected").val());
			//活动类型
			var pattern = $.trim($("#pattern option:selected").val());
			//实物，优惠券是否需要地址
			var isaddress = $.trim($("#isaddress option:selected").val());
			//到账方式
			var saveType = $.trim($("#saveType option:selected").val());
			*/
			//地址
			var address = $.trim($("input[name='address']").val());
			//描述
			var desc = $.trim($("input[name='desc']").val());
			
			 var flag = validate(
			 			name,"请输入商家名",
						phone,"请输入联系方式",
						zfb,"请输入支付宝账号。"
						/*
						title,"请输入分享标题",
						url,"请输入分享地址",
						picUrl,"请选择分享图片",
						muban,"请选择模板"
						*/
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"activity/details",
					dataType:"json",
					data:{	
							_method:"put",
							name:name,
							phone:phone,
							address:address,
							desc:desc,
							id:id,
							zfb:zfb,
							zfbname:zfbname
							/*
							title:title,
							url:url,
							isaddress:isaddress,
							redName:redName,
							hx:hx,
							picUrl:picUrl,
							muban:muban,
							pattern:pattern,
							saveType:saveType
							*/
							},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg,function(){
								location.reload();
							});
						}else{
							layer.msg(data.msg);
						}
					}
				});		 	
		 	}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}
			return true;
		}
	});
	function showImg(imgId){
		var ref=$("#"+imgId);
		if(imgId=="shareUrl"){
			$("#picType").attr("type","share");
		}else{
			$("#picType").attr("type","twoCode");
		}
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(100);
			$(ref).width(100);
		});
	}
	function buyRedPacket(){
		 	layer.open({
			type: 2,
			title: '购买红包码',
			shadeClose: true,
			shade: 0.8,
			area: ['1500px', '50%'],
			content: 'manager/redpacket_buy_activity.jsp'
		});		
	}
	$("#pattern").on("change",function(){
		var ac = "${activity.id}";
		if($("#pattern").val()==2){
			$.ajax({
				type:"post",
				url:"activity/isAuthorization",
				dataType:"json",
				data:{
					"id":ac
				},
				success:function(data){
					if(!(data.flag)){
						$("#lookGet").removeAttr("selected");
						$("#shareGet").attr("selected","selected");
						layer.msg("请先进行公众号授权");
						return;
					}else{
						if(data.type!=2){
							$("#lookGet").removeAttr("selected");
							$("#shareGet").attr("selected","selected");
							layer.msg("关注领取需要公众号为认证服务号");
						}
					}
				}
			});
		}
	});
	$("#guang").on("click",function(){
		$("#kanurl").css("display","none");
		$("#inurl").css("display","block");
	});
	
	$("#kan").on("click",function(){
		$("#inurl").css("display","none");
		$("#kanurl").css("display","block");
	});
	
	function getUr(id){
		ur = $("#"+id).val();
	}
</script>
</html>
