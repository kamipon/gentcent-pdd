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
    

    <title>绑定</title>

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
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
                    	<input type="hidden" value="${param.id}" name="id"/>
	                     <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>红包数量</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="redpacketNum" placeholder="请输入红包数量">
	                            </div>
	                        </div>
							<button class="btn btn-primary" type="button" id="redpacketBuy">购买</button>
                       	    <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
	                        </div>
                         </form>
                    </div>
                  </div>
              </div>
          </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
     <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
</body>
<script type="text/javascript">
	$("#redpacketBuy").click(function(){
		//id
		var id = $.trim($("input[name='id']").val());
		var redpacketNum=$.trim($("input[name='redpacketNum']").val());
		 swal({
	        title:"您确定要购买红包吗？",
	        type: "warning",
        	showCancelButton: true,
	        confirmButtonColor: "#DD6B55",
	        confirmButtonText: "购买",
	        closeOnConfirm: false
	    }, function (isConfirm) {
	   		 if(isConfirm){
	   		 $.ajax({
	    		type:"get",
				url:"activity/buy",
				dataType:"json",
				data:{	
					redpacketNum:redpacketNum
				},
					success:function(data){
						if(data.flag){
							swal({title:"成功！",text:"购买成功",type:"success"},function(){
								window.location.reload();
								});
						}else{
							layer.msg(data.msg);
						}
					}
				});
		    }
    	});
	});
		
	$(function(){
		
		function validate(date1,msg1){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}
			return true;
		}
	});
</script>
</html>
