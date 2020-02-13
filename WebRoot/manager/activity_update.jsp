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
    

    <title>修改</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>修改</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                        <div class="form-group">
	                        	<input type="hidden" name="id" value="${activity.id }">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商家名</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name" value="${activity.name }">
	                            </div>
	                        </div>
							<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="phone" value="${activity.phone }">
	                            </div>
	                        </div>
	                        <!-- 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享标题</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="title" value="${activity.title }">
	                            </div>
	                        </div>
	                        -->
	                        <!-- 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享链接</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="url" value="${activity.url }">
	                            </div>
	                        </div>
	                        -->
	                        <!-- 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享图片</label>
	                            <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('picUrl')">选择图片</a>
                                	<img src="${activity.picUrl}" name="picUrl" id="picUrl" style="height:50px;">
                                </div>
	                        </div> 
	                        -->
	                        <!-- 
	                        <div class="form-group">
                          		<label class="col-sm-2 control-label"><font color="red">*</font>选择模板</label>
	                       		 <div class="col-sm-10">
									 <select class="form-control m-b" id="muban" name="muban">
									 <c:forEach items="${list}" var="items">
										<option value="${items.id}" <c:if test="${activity.content.id eq items.id}">selected = "selected" </c:if>>${items.title}</option>
									</c:forEach>
									</select>
								</div>
							</div>
							-->
							<!-- 
							<div class="form-group">
	                        	<label class="col-sm-2 control-label">
									<font color="red">*</font>
									商家类型
								</label>
	                            <div class="col-sm-10">
									<select name="type" id="type" class="form-control m-b" onchange="getDaoQi()">
										<c:if test="${ter.type==1}">
											<option value="1" <c:if test="${activity.type==1}">selected="selected"</c:if>>
												正式
											</option>
										</c:if>
										<option value="0" <c:if test="${activity.type==0}">selected="selected"</c:if>>
											试用
										</option>
									</select>
								</div>
	                        </div>
	                        -->
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
	                        <!-- 
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">商品密码</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="hx" value="${activity.hx_password}">
	                            </div>
	                        </div>
	                         -->
							<div class="form-group">
	                            <label class="col-sm-2 control-label">地址</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="address" value="${activity.address}">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">描述</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="desc" value="${activity.desc}">
	                            </div>
	                        </div>
							<div class="form-group">
	                            <label class="col-sm-2 control-label">到期时间</label>
	                            <div class="col-sm-10">
	                                <input type="text" id="end"  name="overTime" value="${over}" readonly="readonly" class="form-control"  class="Wdate" size="12">
	                            </div>
	                        </div>
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                            	<button class="btn btn-primary" type="button" id="redpacktModel">修改</button>
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
    <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/city.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script>
	var city = "${terpoint.city}";
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
                var ci = $("#city option");
				$(ci).each(function(){
			    	if(this.value==city){
			    		$(this).attr("selected","selected");
			    		$("#city").attr("disabled","disabled");  
			    	}
	    		});
	        });  
	        $("#province").change();  
	    })();  
	    var te ="${ter.province}";
	    var selected = $("#province  option");
	    $(selected).each(function(){
	    	if(this.value==te){
	    		$(this).attr("selected","selected");
	    		$("#province").change();
	    		$("#province").attr("disabled","disabled");  
	    	}
	    });
	Date.prototype.toLocaleString = function() {
  		return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() + " " + this.getHours() + ":" + this.getMinutes() + ":" + this.getSeconds();
  	};
  	function getDaoQi(){
  		var da = new Date();
  		var end;
  		if($("#type").val()==0){
			end = da.valueOf()+7*24*3600*1000;
  		}else{
  			end = da.valueOf()+365*24*3600*1000;
  		}
		var date1 = new Date(end);
		$("#end").val(date1.toLocaleString());
		guoQi();
  	}
	function guoQi(){
		if($("#type").val()==0){
			$("#end").removeAttr("onclick");
		}else{
			$("#end").attr("onclick","WdatePicker()");
		}
	}
	$(function() {
		guoQi();
	    $("#model").change(function() {
	        if (this.value == "1") {
	            $("#num").show();
	            
	            ;
	        } else {
	            $("#num").hide();
	           
	        }
	    });
	});
	$(function(){
		$("#redpacktModel").click(function(){
			//商家ID
			var id = $.trim($("input[name='id']").val());
			//商家名称
			var name = $.trim($("input[name='name']").val());
			//联系方式
			var phone = $.trim($("input[name='phone']").val());
			//地址
			var address = $.trim($("input[name='address']").val());
			//到期时间
			var overTime = $.trim($("input[name='overTime']").val());
			//描述
			var desc = $.trim($("input[name='desc']").val());
			/*
			//分享标题
			var title = $.trim($("input[name='title']").val());
			//核销密码
			var hx = $.trim($("input[name='hx']").val());
			//分享地址
			var url = $.trim($("input[name='url']").val());
			//模板的ID
			var muban = $.trim($("#muban option:selected").val());
			//分享图片
			var picUrl = $("#picUrl").attr('src');
			//商家类型
			var type = $("#type").val();
			*/
			 var flag = validate(
						name,"请输入商家名称!",
						phone,"请输入联系方式",
						/*
						title,"请输入分享标题",
						url,"请输入分享地址",
						picUrl,"请选择分享图片",
						muban,"请选择模板"
						*/
					); 
		 	if(flag){
				$.ajax({
					type:"post",
					url:"activity/change",
					dataType:"json",
					data:{	
							_method:"put",
							id:id,
							name:name,
							phone:phone,
							address:address,
							desc:desc,
							overTime:overTime
							/*
							title:title,
							url:url,
							hx:hx,
							type:type,
							picUrl:picUrl,
							muban:muban
							*/
							},
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("activity");
						}else{
							layer.msg(data.msg);
						}
					}
				});		 	
		 	}
			return false;
		});
		function validate(date1,msg1,date2,msg2/*,date3,msg3,date4,msg4,date5,msg5,date6,msg6*/){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			/*
			else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}else if(date4 == ''){
				layer.msg(msg4);
				return false;
			}else if(date5 == ''){
				layer.msg(msg5);
				return false;
			}else if(date6 == ''){
				layer.msg(msg6);
				return false;
			}
			*/
			return true;
		}
	});
	function showImg(imgId){
		var ref=$("#"+imgId);
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(100);
			$(ref).width(100);
		});
	}
</script>
</html>
