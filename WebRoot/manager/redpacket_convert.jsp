<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    

    <title>红包转换</title>

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link href="css/reveal.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
   
	
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                         <div class="form-group">
	                         	<div class="col-sm-10"  style="margin-top: 5px">
		                      		<label class="col-sm-2 control-label" style="margin-top: 15px"><font color="red">*</font>红包码段</label>
	                         	 	<input  class="start1" name="start1"  placeholder="请输入开始位置编码" style="width:180px;margin-top: 20px" onchange="change1(this)">
									<input class="end1" name="end1" placeholder="请输入结束位置编码"  style="width: 180px;" onchange="change2(this)"/>
								</div>
	                            <div class="col-sm-10"  style="margin-top:26px">
		                            <label class="col-sm-2 control-label" style="margin-top: -6px"><font color="red">*</font>红包类型</label>
	                           	 	<input class="ra" type="radio" name="type" value="4" checked="checked" />大转盘
	                            	<input class="ra" type="radio" name="type" value="1"/>优惠券
                            		<input class="ra" type="radio" name="type" value="2"/>实物
	                           	 	<input class="ra" type="radio" name="type" value="3"/>积分
	                            </div>
	                        </div>
							<button class="btn btn-primary" type="button" id="add_num">转换</button>
						</form>
							<a href="#" class="big-link" data-reveal-id="myModal" data-animation="fade"></a>
							<div id="myModal" class="reveal-modal">
							    <h1 id="title"></h1>
							</div>
	                    </div>
                  </div>
              </div>
          </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script type="text/javascript" src="js/jquery-1.7.2.js"></script>
    <script src="js/jquery.reveal.js"></script>
    <script src="js/zepto.min.js"></script>
    <script src="js/frozen.js"></script>
</body>
<script type="text/javascript">
		var reg =/^[1-9]+[0-9]*]*$/;
		var check1=true;
		var check2=true;
		function change1(obj){
			 var num=$(".start1").val();
			 if(num<1||reg.test(num)){
				 check1=false;
			 }else{
				 check1=true;
			 }
		}
		
		function change2(obj){
			 var num=$(".end1").val();
			 if(reg.test(num)){
				 check2=false;
			 }else{
				 check2=true;
			 }
		}
		//红包类型
		var type = $.trim($("input[name='type']").val());
		function validate(date1,msg1,date2,msg2){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}
			if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
		$("#add_num").on("click",function(){
			var flag = validate(check1,"起始码错误",check2,"结束码错误");
			var start = $.trim($("input[name='start1']").val());
			var end = $.trim($("input[name='end1']").val());
			if(flag){
				$.ajax({
					url:"redpacket/convert",
					data:{
						type:type,
						start:start,
						end:end
					},
					type:"post",
					success:function(data){
						if(data.flag){
							layer.msg("转换成功!");
							parent.layer.closeAll();
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
		});
	$(".ra").on("click",function(){
		type = $(this).val();
	});
</script>
</html>
