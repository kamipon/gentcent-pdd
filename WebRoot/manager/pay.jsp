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
    

    <title>充值</title>

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
     <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
	
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>充值</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="get" action="alipay/pay" class="form-horizontal" onSubmit="return check()" >
                    		<input name="type" type="hidden" value="${type}">
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>充值账户</label>
			                            <div class="col-sm-10">
			                                <input type="text" class="form-control" value="${list.name}" readonly="readonly">
			                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>账户余额</label>
			                            <div class="col-sm-10">
		                            		 <c:if test="${type==1}">
			                            	 	<input type="text" class="form-control" value="${rest}" readonly="readonly">
			                            	 </c:if>
			                            	  <c:if test="${type==2}">
			                            	 	<input type="text" class="form-control" value="${list.money}" readonly="readonly">
			                            	 </c:if>
			                            </div>
	                        </div>
	                        	<div class="form-group">
	                          		<label class="col-sm-2 control-label"><font color="red">*</font>选择支付平台</label>
	                                <input type="radio"  name="terrace" value="2" checked="checked">
	                                <img src="images/alipay.jpg" width="250px" height="100px">
								</div>    
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>充值金额</label>
	                         
	                            <div class="col-sm-10">
	                               	<c:if test="${type==2}">
	                              		<input type="text" class="form-control" readonly="readonly" name="money" value="充值功能已关闭" id="money" onkeyup="change(this)"style="width:200px;">
	                                </c:if>
                                	<c:if test="${type==1}">
	                              		<input type="text" class="form-control"  name="money"  id="money" onkeyup="change(this)"style="width:200px;">
	                                </c:if>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>实际支付金额</label>
	                            <div class="col-sm-10">
	                                <span id="money2" style="width:200px;color:#f40;font: 700 26px tahoma;"></span>
	                            </div>
	                        </div>   
	                       	<div style="margin-left:17%;">
	                       		<c:if test="${type==2}">
									<input class="btn btn-primary" type="button" value="支付"  id="add_activity"></input>
								</c:if>
								<c:if test="${type==1}">
									<input class="btn btn-primary" type="submit" value="支付"  id="add_activity1"></input>
								</c:if>
	                        </div>
                         </form>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/content.mine209.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
     <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
		$("#add_activity").on("click",function(){
			layer.msg("抱歉，代理充值功能已关闭")
		});
		function check() {
			var reg =/^(?:0|[1-9]\d*)(?:\.\d{1,2})?$/;
			var money=document.getElementById("money").value;
	         if(!reg.test(money)) {
	               layer.msg("请出入正确的金额");
	               return false;
	          }
	        return true;
	        }
	        
		function change(money) {
			var money;
			var money2;
			if(money.value!=""&&money!=null){
				 money=parseFloat(money.value)*parseFloat(1.02);
				 money2=Math.round(money * 100) / 100;
				document.getElementById("money2").innerHTML=money2+"<label><font color='#cccccc' style='font: 700 12px tahoma;'>（含2%手续费）</font></label>";
			}else{
				money2="";
				document.getElementById("money2").innerHTML=money2;
			}
	        }
         		
	</script>
</body>
</html>
