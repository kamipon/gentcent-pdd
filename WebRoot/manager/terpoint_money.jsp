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
    

    <title>代理商余额管理</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>代理商管理-余额</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商家名</label>
	                            <div class="col-sm-10">
	                            	<input type="hidden" name="id" value="${terpoint.id }">
	                                <input type="text" class="form-control" name="name" value="${terpoint.name }" readonly="readonly">
	                            </div>
	                        </div>
	                        
                            <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="phone" value="${terpoint.phone }" readonly="readonly">
	                           </div>
	                        </div>
	                        <div class="form-group">
                                <label class="col-sm-2 control-label"><font color="red">*</font>账户状态</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="state" readonly="readonly" value=" <c:if test="${terpoint.status=='0' }">正常</c:if><c:if test="${terpoint.status=='1' }">冻结</c:if>">                           
                                </div>
                            </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label">余额</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="money" value="${terpoint.money }" readonly="readonly">
	                           </div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label">充值</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="pay" >
	                           </div>
	                        </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">到期时间</label>
                                <div class="col-sm-10">
                                    <input type="text" name="overTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" size="12" value="<fmt:formatDate value="${terpoint.overTime}" pattern="yyyy-MM-dd" />">
                                </div>
                            </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                            	<button class="btn btn-primary" type="button" id="update_terpoint">充值</button>
                                <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
</body>
<script>
	$(function(){
		$("#update_terpoint").click(function(){
			//状态
			var state = $("#state").val();
			//充值金额
			var pay = $.trim($("input[name='pay']").val());
			//到期时间
			var overTime = $.trim($("input[name='overTime']").val());
			//id
			var id = $.trim($("input[name='id']").val());
			  swal({
		        title:"确定给此代理商充值"+pay+"元？",
		        type: "warning",
	         	showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "充值",
		        closeOnConfirm: false
		    }, function (isConfirm) {
		   		 if(isConfirm){
		    		$.ajax({
					type:"post",
					url:"terPoint/changeMoney",
					dataType:"json",
					data:{	_method:"put",
							id:id,
							pay:pay
							},
					success:function(data){
						if(data.flag){
								swal({title:"充值成功！",type:"success"},function(){
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
		
	});
</script>
</html>
