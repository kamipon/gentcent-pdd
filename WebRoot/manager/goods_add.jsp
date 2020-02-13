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
    

    <title>添加实物</title>

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
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>标题</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="title">
	                            </div>
	                        </div>
                          	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>有效期开始时间</label>
	                            <div class="col-sm-10">
	                                <input id="end"  type="text" name="startTime" readonly="readonly" class="form-control" onClick="WdatePicker()"  size="12"/>
	                            </div>
	                        </div>
                         	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>有效期结束时间</label>
	                            <div class="col-sm-10">
	                                <input id="end"  type="text" name="endTime" readonly="readonly" class="form-control" onClick="WdatePicker()"  size="12"/>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>实物价格</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="money">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>数量</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="count">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>店铺名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="shopName">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>店铺地址</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="address">
	                            </div>
	                        </div>
                           <div class="form-group">
	                            <label class="col-sm-2 control-label">使用条件(选填)</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="useCondition">
	                            </div>
	                        </div>
                          	<div class="form-group">
	                            <label class="col-sm-2 control-label">实物图片</label>
	                            <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('picUrl')">选择图片</a>
                                	<img src="" name="logo" id="picUrl" style="height:50px;">
                                </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>店铺电话</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="phone">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">店铺详情</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="desc">
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
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script type="text/javascript">
	   	function showImg(imgId){
		var ref=$("#"+imgId);
		render(function(url){
			$(ref).attr("src",url);
			$(ref).removeAttr("style");
			$(ref).height(100);
			$(ref).width(100);
		});
	}
	$(function(){
		$("#add_activity").click(function(){
			//标题
			var title = $.trim($("input[name='title']").val());
			//有效期开始时间
			var startTime = $.trim($("input[name='startTime']").val());
			//有效期结束时间
			var endTime = $.trim($("input[name='endTime']").val());
			//金额
			var money = $.trim($("input[name='money']").val());
			//数量
			var count = $.trim($("input[name='count']").val());
			//使用条件
			var useCondition = $.trim($("input[name='useCondition']").val());
			//店铺名称
			var shopName = $.trim($("input[name='shopName']").val());
			//店铺地址
			var address = $.trim($("input[name='address']").val());
			//实物图片
			var logo = $("#picUrl").attr("src");
			//店铺电话
			var phone = $.trim($("input[name='phone']").val());
			//店铺详情
			var desc = $.trim($("input[name='desc']").val());
			if(title.length>8){
				layer.msg("标题字数过多，可能会导致无法收到短信！");
				return ;
			}
			var flag = validate(
				title,"请输入标题!",
				startTime,"请输入开始时间",
				endTime,"请输入结束时间",
				shopName,"请输入店铺名称",
				address,"请输入店铺地址",
				count,"请输入数量",
				phone,"请输入联系方式"
			); 
			if(flag){
				$.ajax({
					url:"goods/add",
					type:"post",
					data:{	
						title:title,
						startTime:startTime,
						endTime:endTime,
						money:money,
						useCondition:useCondition,
						shopName:shopName,
						address:address,
						logo:logo,
						phone:phone,
						desc:desc,
						count:count
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							parent.layer.closeAll();
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2,date3,msg3,date5,msg5,date6,msg6,date7,msg7,date8,msg8){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}else if(date5 == ''){
				layer.msg(msg5);
				return false;
			}else if(date6 == ''){
				layer.msg(msg6);
				return false;
			}
			else if(date7 == ''){
				layer.msg(msg7);
				return false;
			}
			else if(date8 == ''){
				layer.msg(msg8);
				return false;
			}
			return true;
		}
	});
</script>
</html>
