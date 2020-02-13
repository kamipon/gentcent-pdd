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
    <title>提现申请</title>
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
                        <h5>提现申请</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal"  >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>金额</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="money"onkeyup="this.value=(this.value.match(/\d+(\.\d{0,0})?/)||[&#39;&#39;])[0]">
	                            </div>
	                        </div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_activity">提交</button>
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
		$("#add_activity").click(function(){
			//域名
			var money = $.trim($("input[name='money']").val());
			var flag = validate(
				money,"请输入提现金额"
			); 
			if(flag){
				$.ajax({
					url:"withdraw/add",
					type:"post",
					data:{	
						money:money
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg("申请成功");
							setTimeout('goFresh("withdraw/list")',1000); 
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
	});
		function validate(date1,msg1){
			var re = /^[100-50000]+$/ ;
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(!(/(^[1-9]\d*$)/.test(date1))){
			alert(date1)
				layer.msg("请输入正整数");
				return false;
			}else if(parseInt(date1)<100||parseInt(date1)>50000){
				layer.msg("请输入100-5万之间的金额");
				return false;
			}
			return true;
		}
</script>
</html>
