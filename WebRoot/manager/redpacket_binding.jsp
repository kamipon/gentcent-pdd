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
	                       
								<span>起始码:</span><input   name="start"  >
								<span>结束码:</span><input  name="end"  />
								
					
							<button class="btn btn-primary" type="button" id="redpacktModel">设置</button>
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
	var flag = true;
	$("#redpacktModel").click(function(){
		//id
		var id = $.trim($("input[name='id']").val());
		var start=$.trim($("input[name='start']").val());
		var end=$.trim($("input[name='end']").val());
		 swal({
	        title:"是否给此代理商绑定红包码？",
	        type: "warning",
        	showCancelButton: true,
	        confirmButtonColor: "#DD6B55",
	        confirmButtonText: "设置",
	        closeOnConfirm: false
	    }, function (isConfirm) {
	    		if(flag){
	    			 if(isConfirm){
	    			 	 flag = false;
				   		 $.ajax({
				    		type:"post",
							url:"terPoint/binding",
							dataType:"json",
							data:{	
								id:id,
								start:start,
								end:end
							},
								success:function(data){
									if(data.flag){
										flag = true;
										swal({title:"成功！",text:"设置成功:"+data.num+"个二维码,失败:"+data.fail+"个二维码",type:"success"},function(){
											window.location.reload();
											});
									}else{
										layer.msg(data.msg);
									}
								}
							});
				    }
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
