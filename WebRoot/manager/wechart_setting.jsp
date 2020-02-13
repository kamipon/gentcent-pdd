<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="favicon.ico">
	<link href="${cp }/css/bootstrap.minb16a.css" rel="stylesheet">
	<link href="${cp }/css/font-awesome.min93e3.css" rel="stylesheet">
	<link href="${cp }/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
	<link href="${cp }/css/animate.min.css" rel="stylesheet">
	<link href="${cp }/css/style.min1fc6.css" rel="stylesheet">
	<link rel="shortcut icon" href="favicon.ico">
	<link href="${cp }/css/style.min1fc6.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${cp }/css/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" href="${cp }/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link href="${cp }/css/plugins/iCheck/custom.css" rel="stylesheet">
	<link href="${cp }/css/image_plugin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${cp }/js/jquery.js"></script>
	<script type="text/javascript" src="${cp }/js/jquery1.9.1.js"></script>
	<script type="text/javascript" src="${cp }/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.all.min.js"> </script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" src="${cp }/js/layer/layer.js"></script>
	<script type="text/javascript" src="${cp }/js/11cms.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							微信对接支付设置
						</h5>
					</div>
					<div class="ibox-content" style="background-color: white;padding: 20px 5px 0px;">
						<form method="post" class="form-horizontal">
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>appId
								</label>
								<div class="col-sm-10">
									<input type="text"  name="appId"  class="form-control" maxlength="255" value="${config.appId }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>appSecret
								</label>
								<div class="col-sm-10">
									<input type="text"  name="appSecret"  class="form-control" maxlength="255" value="${config.appSecret }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>url
								</label>
								<div class="col-sm-10">
									<input type="text"  name="url"  class="form-control" maxlength="255" value="${config.url }" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>token
								</label>
								<div class="col-sm-10">
									<input type="text"  name="token"  class="form-control" maxlength="255" value="${config.token }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>encodingAESKey
								</label>
								<div class="col-sm-10">
									<input type="text"  name="encodingAESKey"  class="form-control" maxlength="255" value="${config.encodingAESKey }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>商户号
								</label>
								<div class="col-sm-10">
									<input type="text"  name="partner"  class="form-control" maxlength="255" value="${config.partner }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>商户密匙
								</label>
								<div class="col-sm-10">
									<input type="text"  name="partnerkey"  class="form-control" maxlength="255" value="${config.partnerkey }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>微信多客服(开启后，用户留言转入多客服帐号)
								</label>
								<div class="col-sm-10">
									 <label>
                                     	<c:choose>
                                     		<c:when test="${config.isMoreService==true}">
                                     			<input type="radio" checked="checked" value="true" name="isMoreService"><i></i> 开启
                                     			<input type="radio" value="false" name="isMoreService"> <i></i>关闭
                                     		</c:when>
                                     		<c:otherwise>
                                     			<input type="radio" value="true" name="isMoreService"><i></i>开启
                                     			<input type="radio" value="false" name="isMoreService" checked="checked"><i></i> 关闭
                                     		</c:otherwise>
                                     	</c:choose>
	                                  </label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>充值开启
								</label>
								<div class="col-sm-10">
									 <label>
                                     	<c:choose>
                                     		<c:when test="${config.rechargeOpen==true}">
                                     			<input type="radio" checked="checked" value="true" name="rechargeOpen"><i></i> 开启
                                     			<input type="radio" value="false" name="rechargeOpen"> <i></i>关闭
                                     		</c:when>
                                     		<c:otherwise>
                                     			<input type="radio" value="true" name="rechargeOpen"><i></i>开启
                                     			<input type="radio" value="false" name="rechargeOpen" checked="checked"><i></i> 关闭
                                     		</c:otherwise>
                                     	</c:choose>
	                                  </label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>提现开启
								</label>
								<div class="col-sm-10">
									 <label>
                                     	<c:choose>
                                     		<c:when test="${config.rechargeOpen==true}">
                                     			<input type="radio" checked="checked" value="true" name="presentOpen"><i></i> 开启
                                     			<input type="radio" value="false" name="presentOpen"> <i></i>关闭
                                     		</c:when>
                                     		<c:otherwise>
                                     			<input type="radio" value="true" name="presentOpen"><i></i>开启
                                     			<input type="radio" value="false" name="presentOpen" checked="checked"><i></i> 关闭
                                     		</c:otherwise>
                                     	</c:choose>
	                                  </label>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>支付宝支付账号
								</label>
								<div class="col-sm-10">
									<input type="text"  name="payAccount"  class="form-control" maxlength="255" value="${config.payAccount }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>合作账号
								</label>
								<div class="col-sm-10">
									<input type="text"  name="cooperateAccount"  class="form-control" maxlength="255" value="${config.cooperateAccount }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>支付宝密匙
								</label>
								<div class="col-sm-10">
									<input type="text"  name="password"  class="form-control" maxlength="255" value="${config.password }">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>红包单价
								</label>
								<div class="col-sm-10">
									<input type="text"  name="redpacketMoney"  class="form-control" maxlength="255" value="${config.redpacketMoney }">
								</div>
							</div>
							<button class="btn btn-primary" type="button" id="add_detection">
								保存
							</button>
							<button class="btn btn-primary" type="reset" id="remove" value="重置">
								重置
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script src="${cp}/js/jquery.min63b9.js"></script>
		<script src="${cp}/js/layer/layer.js"></script>
		<script type="text/javascript" src="${cp}/js/childrenToMenu.js"></script>
		<jsp:include page="plugin_image.jsp"></jsp:include>
</body>
</html>
<script>
	$(function(){
		$("#add_detection").click(function(){
			//appId
			var appId = $.trim($("input[name='appId']").val());
			//appSecret
			var appSecret = $.trim($("input[name='appSecret']").val());
			//token
			var token = $.trim($("input[name='token']").val());
			//encodingAESKey
			var encodingAESKey = $.trim($("input[name='encodingAESKey']").val());
			//商户号
			var partner = $.trim($("input[name='partner']").val());
			//商户密匙
			var partnerkey = $.trim($("input[name='partnerkey']").val());
			//支付宝支付账号
			var payAccount = $.trim($("input[name='payAccount']").val());
			//合作账号
			var cooperateAccount = $.trim($("input[name='cooperateAccount']").val());
			//支付宝密匙
			var password = $.trim($("input[name='password']").val());
			//充值开启
			var rechargeOpen=$.trim($("input:radio[name=rechargeOpen]:checked").val());
			//多客服
			var isMoreService=$.trim($("input:radio[name=isMoreService]:checked").val());
			//提现开启
			var presentOpen=$.trim($("input:radio[name=presentOpen]:checked").val());
			//红包单价
			var redpacketMoney=$.trim($("input[name=redpacketMoney]").val());
			
			var flag = validate(appId,"请输入appId!",
								appSecret,"请输入appSecret!",
								token,"请输入token!",
								encodingAESKey,"请输入encodingAESKey!",
								partner,"请输入商户号!",
								partnerkey,"请输入商户密匙",
								payAccount,"请输入支付宝支付账号",
								cooperateAccount,"请输入合作账号",
								password,"请输入支付宝密匙",
								redpacketMoney,"请输入红包单价");
			if(flag){
				$.ajax({
					url:"${cp}/wechart_config/add",
					type:"post",
					data:{	
						appId:appId,
						appSecret:appSecret,
						token:token,
						encodingAESKey:encodingAESKey,
						partner:partner,
						partnerkey:partnerkey,
						payAccount:payAccount,
						cooperateAccount:cooperateAccount,
						password:password,
						rechargeOpen:rechargeOpen,
						presentOpen:presentOpen,
						isMoreService:isMoreService,
						redpacketMoney:redpacketMoney
					},
					dataType:"json",
					success:function(data){
						layer.msg(data.message);
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4,date5,msg5,date6,msg6,date7,msg7,date8,msg8,date9,msg9,date10,msg10,date11,msg11,date12,msg12,date13,msg13){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}
			if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			if(date3 == ''){
				layer.msg(msg3);
				return false;
			}
			if(date4 == ''){
				layer.msg(msg4);
				return false;
			}
			if(date5 == ''){
				layer.msg(msg5);
				return false;
			}
			if(date6 == ''){
				layer.msg(msg6);
				return false;
			}
			if(date7 == ''){
				layer.msg(msg7);
				return false;
			}
			if(date8 == ''){
				layer.msg(msg8);
				return false;
			}
			if(date9 == ''){
				layer.msg(msg9);
				return false;
			}
			if(date10 == ''){
				layer.msg(msg10);
				return false;
			}
			if(date11 == ''){
				layer.msg(msg11);
				return false;
			}
			if(date12 == ''){
				layer.msg(msg12);
				return false;
			}
			if(date13 == ''){
				layer.msg(msg13);
				return false;
			}
			return true;
		}
	});
</script>