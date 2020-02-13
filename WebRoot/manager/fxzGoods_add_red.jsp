<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>


<head>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加商品</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
     <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
    <script type="text/javascript" src="${cp }/js/jquery1.9.1.js"></script>
    <script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>扫码红包</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal"  >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否开启扫码红包</label>
	                            <div class="col-sm-10">
		                                否 <input type="radio"  name="isTrueman" value="0" checked="checked" > &nbsp;&nbsp;
		                                是 <input type="radio"  name="isTrueman" value="1">
		                                <span style="margin-left: 10px;color: red">* 分享活动二维码，用户扫码时可以活动即时到账的红包，一个活动仅获得一次</span>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>红包金额</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="money" id="money" onkeyup="this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[&#39;&#39;])[0]">
	                            	<font color="red">不能小于0.3元. 不能大于价格的60%.
	                           		</font>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>红包数量</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="num" id="num" onkeyup="this.value=(this.value.match(/\d+(\.\d{0,0})?/)||[&#39;&#39;])[0]">
	                            	<font color="red">当前账户余额：<fmt:formatNumber pattern="0.00" value="${yue+money}" maxFractionDigits="2"/>元<br>
	                                              当前账户其他商品预支付佣金:<fmt:formatNumber pattern="0.00" value="${money}" maxFractionDigits="2"/>元 <br>
	                                              此次商品总佣金(金额*数量)设置不可超过<fmt:formatNumber pattern="0.00" value="${yue+money}" maxFractionDigits="2"/>元
	                           		 </font>
	                            </div>
	                        </div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_activity">新增</button>
	                            <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
	                        </div>
                         </form>
                        </div>
                       
                    </div>
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
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(function(){
		var radio=$('input[name="isTrueman"]');
		radio.change(function(){
			var values = $(this).val();
			if(values=='0'){
				$("#truepay").css("display","none");
				$("#trueopen").css("display","none");
			}else{
				$("#truepay").css("display","block");
				$("#trueopen").css("display","block");
			}
	  	});
		$("#add_activity").click(function(){
			if(flag){
				$.ajax({
					url:"fxzGoods/addred",
					type:"post",
					data:{	
						name:name,
						price:price
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg("添加成功");
							setTimeout('goFresh("fxzGoods/list")',1000); 
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
	});
			
			
</script>
</html>
