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
    

    <title>商家信息修改</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>代理管理-修改</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>代理名</label>
	                            <div class="col-sm-10">
	                            	<input type="hidden" name="id" value="${terpoint.id }">
	                                <input type="text" class="form-control" name="name" value="${terpoint.name }" >
	                            </div>
	                        </div>
                            <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="phone" value="${terpoint.phone }">
	                           </div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>支付宝账号</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="zfb" value="${terpoint.zfb }">
	                           </div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>支付宝账号姓名</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="zfbname" value="${terpoint.zfbname }">
	                           </div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label"><font color="red">*</font>用户密码</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="password" value="${terpoint.user.password }">
	                           </div>
	                        </div>
	                        <div class="form-group">
	                        	<label class="col-sm-2 control-label">
									<font color="red">*</font>
									请选择状态
								</label>
	                            <div class="col-sm-10">
									<select name="state" id="state" class="form-control m-b">
										<option value="0" <c:if test="${terpoint.status==0}">selected="selected"</c:if> >
											正常
										</option>
										<option value="1" <c:if test="${terpoint.status==1}">selected="selected"</c:if> >
											冻结
										</option>
									</select>
								</div>
	                        </div>
	                        <div class="form-group">
	                        	<label class="col-sm-2 control-label">
									<font color="red">*</font>
									类型
								</label>
	                            <div class="col-sm-10">
									<select name="type" id="type" class="form-control m-b">
										<option value="1" <c:if test="${terpoint.type==1}">selected="selected"</c:if> >
											正式
										</option>
										<option value="0" <c:if test="${terpoint.type==0}">selected="selected"</c:if>>
											试用
										</option>
									</select>
								</div>
	                        </div>
	                         <div class="form-group">
	                        	<label class="col-sm-2 control-label">
									<font color="red">*</font>
									级别
								</label>
	                            <div class="col-sm-10">
									<select name="type" id="jibie" class="form-control m-b" onchange="show()">
									    <c:if test="${role=='1'}">
											<option value="1" <c:if test="${terpoint.partner==1}">selected="selected"</c:if>>
												城市合伙人
											</option>
										</c:if>
										<option value="0" <c:if test="${terpoint.partner!=1}">selected="selected"</c:if>>
											区域代理
										</option>
									</select>
								</div>
	                        </div>
	                          <c:if test="${role=='1'}">
		                        <div class="form-group" style=<c:if test="${terpoint.partner!=1 }">"display: block"</c:if><c:if test="${terpoint.partner==1 }">"display: none"</c:if> id="no">
		                        	<label class="col-sm-2 control-label">
										<font color="red">*</font>
										城市合伙人
									</label>
		                            <div class="col-sm-10">
										<select name="type" id="shangji" class="form-control m-b">
											<option value="1" <c:if test="${empty terpoint.higher }">selected="selected"</c:if> >
												无
											</option>
											<c:forEach items="${hehuo}" var="each">
												<option value="${each.id }" <c:if test="${terpoint.higher==each.id }">selected="selected"</c:if> >
												   ${each.name }
												</option>
											</c:forEach>
										</select>
									</div>
		                        </div>
		                    </c:if>
		                     <div class="form-group">
	                        	<label class="col-sm-2 control-label">
									<font color="red">*</font>
									省
								</label>
	                            <div class="col-sm-10 selectArea">
									<select name="province" id="province"  class="form-control m-b">
		                        		<option>请选择</option>
		                        	</select>
								</div>
	                        </div>
	                        <div class="form-group">
	                        	<label class="col-sm-2 control-label">
									<font color="red">*</font>
									市
								</label>
	                            <div class="col-sm-10 selectArea">
									<select name="city" id="city" class="form-control m-b">
		                        		<option id="qxz" value="">请选择</option>
		                        	</select>
								</div>
	                        </div>
	                        <div class="form-group">
	                           <label class="col-sm-2 control-label">余额</label>
	                           <div class="col-sm-10">
	                               <input type="text" class="form-control" name="money" readonly="readonly" value="${terpoint.money }">
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
                            	<button class="btn btn-primary" type="button" id="update_terpoint">修改</button>
                                <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
	                     </form>
                    </div>
                </div>
            </div>
    </div>
    <script type="text/javascript" src="<%=basePath%>manager/js/city.js"></script>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
</body>
<script>
	(function(){  
        var pHtmlStr = '';  
        for(var name in pc){  
            pHtmlStr = pHtmlStr + '<option>'+name+'</option>';  
        }  
        $("#province").html(pHtmlStr);  
        $("#province").change(function(){  
            var pname = $("#province option:selected").text();  
            var pHtmlStr = '';  
            var cityList = pc[pname];  
            for(var index in cityList){  
                pHtmlStr = pHtmlStr + '<option>'+cityList[index]+'</option>';  
            }  
            $("#city").html(pHtmlStr);  
        });  
        $("#province").change();  
    })(); 
    var te ="${te.province}";
    var selected = $("#province  option");
    $(selected).each(function(){
    	if(this.value==te){
    		$(this).attr("selected","selected");
    		$("#province").change();  
    		$("#province").attr("disabled","disabled");  
    		$("#city").attr("disabled","disabled");  
    	}
    });
	$(function(){
		$("#update_terpoint").click(function(){
			//商户名password
			var name = $.trim($("input[name='name']").val());
			//联系方式
			var phone = $.trim($("input[name='phone']").val());
			//用户密码
			var password = $.trim($("input[name='password']").val());
			//支付宝
			var zfb = $.trim($("input[name='zfb']").val());
			//支付宝姓名
			var zfbname = $.trim($("input[name='zfbname']").val());
			//状态
			var state = $("#state").val();
			//省
			var province = $("#province").val();
			//市
			var city = $("#city").val();
			//余额
			var money = $.trim($("input[name='money']").val());
			//到期时间
			var overTime = $.trim($("input[name='overTime']").val());
			//id
			var id = $.trim($("input[name='id']").val());
			//类型
			var type = $("#type").val();
				//级别
			var jibie = $("#jibie").val();
			//上级
			var shangji = $("#shangji").val();
			 var flag = validate(
						name,"请输入商家名称!",
						phone,"请输入联系方式",
						state,"请选择状态",
						money,"请输入余额",
						overTime,"请选择到期时间",
						password,"用户密码不能为空"
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"terPoint/"+id,
					dataType:"json",
					data:{	_method:"put",
							name:name,
							phone:phone,
							state:state,
							type:type,
							sheng:province,
							shi:city,
							jibie:jibie,
							shangji:shangji,
							money:money,
							overTime:overTime,
							zfb:zfb,
							zfbname:zfbname,
							password:password
							},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("terPoint");
						}else{
							layer.msg(data.msg);
						}
					}
				});		 	
		 	}
			return false;
		});
		function validate(date1,msg1,date6,msg6,date7,msg7,date8,msg8,date9,msg9,date10,msg10){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date6 == ''){
				layer.msg(msg6);
				return false;
			}else if(date7 == ''){
				layer.msg(msg7);
				return false;
			}else if(date8 == ''){
				layer.msg(msg8);
				return false;
			}else if(date9 == ''){
				layer.msg(msg9);
				return false;
			}else if(date10 == ''){
				layer.msg(msg10);
				return false;
			}
			return true;
		}
	});
	
	function show(){
		var a = $("#jibie").val();
		if(a==0){
			$("#no").css("display","block");
		}else{
			$("#no").css("display","none");
			$("#shangji").val("1");
			console.l
		}
  	}
</script>
</html>
