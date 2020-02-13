<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>修改订单</title>
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
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>修改订单</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>真实姓名</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="realname" value="${fxzGoodsOrder.realname }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>电话</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="phone" id="phone" value="${fxzGoodsOrder.phone }">
	                            </div>
	                        </div>
	                        
	                       
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>电话</label>
	                            <div class="col-sm-10">
	                                 <div class="form-group" style="margin-top: 5px"  id="select">
					                        <div class="xcc">
					                        	<select name="province" id="province" >
					                        		<option>请选择省</option>
					                        	</select>
					                        	<select name="city" id="city" >
					                        		<option>请选择市</option>
					                        	</select>
					                        	<select id="area" name="area"  >
													<option value="">选择区/县</option>
												</select>
					                        </div>
					                    </div>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>地址${fxzGoodsOrder.address}</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="address" id="address" value="${fxzGoodsOrder.address}">
	                            </div>
	                        </div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_activity">修改</button>
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
    
        
    <script type="text/javascript" src="<%=basePath%>/fxz/js/distpicker.data.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/fxz/js/distpicker.min_huo.js"></script>
    
</body>
<script type="text/javascript">
	
	
	if("${fxzGoodsOrder.area}"){
		//省市区初始化方法
		$(".xcc").distpicker({
		
			province:"${fxzGoodsOrder.province}",
			city:"${fxzGoodsOrder.city}",
			district:"${fxzGoodsOrder.area}",
			
		});
	}else{
		//省市区初始化方法
		$(".xcc").distpicker({
			province:"${fxzGoodsOrder.province}",
			city:"${fxzGoodsOrder.city}",
		});
	}

	$(function(){
		$("#add_activity").click(function(){
			//商品名称
			var realname = $.trim($("input[name='realname']").val());
			//价格
			var phone = $.trim($("input[name='phone']").val());
			
			
			var province = $("[name='province']").val();
			var city = $("[name='city']").val();
			var area = $("[name='area']").val();
			var address = $("input[name='address']").val();
			
			var id="${fxzGoodsOrder.id}";
			var flag = validate(
				name,"请输入商品名称!",
				phone,"请输入手机",
			); 
			if(flag){
				$.ajax({
					url:"fxzGoodsOrder/update",
					type:"post",
					data:{	
						_method:"put",
						realname:realname,
						phone:phone,
						province:province,
						city:city,
						area: area,
						address:address,
						id:id,
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg("修改成功");
							setTimeout('goFresh("fxzGoodsOrder/list");',1000); 
							
						}else{
							layer.msg("修改失败");
						}
					}
				});
			}
			return false;
		});
	});
		function validate(date1,msg1,date2,msg2){
			var lowestPrice = $("#lowestPrice").val();
			var price = $("#price").val();
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
</script>
</html>
