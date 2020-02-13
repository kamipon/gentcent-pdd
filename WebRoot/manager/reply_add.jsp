<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 11 Dec 2015 04:46:12 GMT -->
<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <title>关键字回复-添加</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min63b9.js"></script>
	<script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
	<script src="js/layer/layer.js"></script>
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
	</script>

</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight" style="top: 23%">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content" style="background-color: white;padding: 20px 5px 0px;">
                        <form method="post" class="form-horizontal" action="${cp}/reply">
                            <div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>回复类型
								</label>
								<div class="col-sm-10">
									<input name="replytype" type="hidden" value="图文" id="replytype"/>
									<c:choose>
										<c:when test="${reply.replytype=='图文'}">
											图文回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(1)" checked="checked">&nbsp;&nbsp;
											文本回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(2)">&nbsp;&nbsp;
											图片回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(3)"> 
										</c:when>
										<c:when test="${reply.replytype=='文本'}">
											图文回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(1)">&nbsp;&nbsp;
											文本回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(2)" checked="checked">&nbsp;&nbsp;
											图片回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(3)"> 
										</c:when>
										<c:when test="${reply.replytype=='图片'}" >
											图文回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(1)">&nbsp;&nbsp;
											文本回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(2)">&nbsp;&nbsp;
											图片回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(3)" checked="checked"> 
										</c:when>
										<c:otherwise>
											图文回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(1)" checked="checked">&nbsp;&nbsp;
											文本回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(2)">&nbsp;&nbsp;
											图片回复:<input type="radio" name="replytyperadio" onclick="changeReplytype(3)"> 
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>关键字：
								</label>
								<div class="col-sm-10">
									<input type="text" name="key" class="form-control m-b" value="" size="100">
								</div>
							</div>
							<div class="form-group" 
							<c:if test="${reply.replytype=='文本'}">style="display:none"</c:if>
							<c:if test="${reply.replytype=='图片'}">style="display:none"</c:if>
								id="tr1">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>标题：
								</label>
								<div class="col-sm-10">
									<input type="text" name="title" class="form-control m-b">
								</div>
							</div>
							<div class="form-group"
							<c:if test="${reply.replytype=='文本'}">style="display:none"</c:if> 
								id="tr2">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>回复图片：
								</label>
								<div class="col-sm-10">
									<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('icon')">选择图片</a>
                                	<img src="" name="imgUrl" id="icon" style="height:50px;" maxlength="255">
								</div>
							</div>
							<div class="form-group"
								<c:if test="${reply.replytype=='图片'}">style="display:none"</c:if>
								id="tr3">
								<label class="col-sm-2 control-label">
									<font color=red>*</font>内容：
								</label>
								<div class="col-sm-10">
									<textarea rows="20" cols="85" name="content" class="form-control m-b"></textarea>
								</div>
							</div>
							<div class="form-group"
								<c:if test="${reply.replytype=='文本'}">style="display:none"</c:if>
                        		<c:if test="${reply.replytype=='图片'}">style="display:none"</c:if>
                        		id="tr4">
								<label class="col-sm-2 control-label">
									链接地址：
								</label>
								<div class="col-sm-10">
									<input type="text" name="url" value="" size="100" class="form-control m-b">
								</div>
							</div>
							<div style="display:none"
						 		id="tr1"  >
						 		<label class="col-sm-2 control-label" style="width: 257px;">
									<font color=red>*</font>非分销商回复文本*：
								</label>
								<div class="col-sm-10" >
									<input type="text" name="text"  class="form-control m-b" >
								</div>
							</div>
                            <div  style="margin-top: 10px;">
	                             <button class="btn btn-primary" type="button" id="add">保存</button>
	                             <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
    <script src="js/content.mine209.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script src="${cp }/js/jquery1.9.1.js"></script>
</body>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</html>
<script>
    
	function changeReplytype(type){
		if(type==1){
			$("#tr1")[0].style.display="";
			$("#tr2")[0].style.display="";
			$("#tr3")[0].style.display="";
			$("#tr4")[0].style.display="";
			$("#replytype").val("图文");
		}else if(type==2){
			$("#tr1")[0].style.display="none";
			$("#tr2")[0].style.display="none";
			$("#tr3")[0].style.display="";
			$("#tr4")[0].style.display="none";
			$("#replytype").val("文本");
		}else if(type==3){
			$("#tr1")[0].style.display="none";
			$("#tr2")[0].style.display="";
			$("#tr3")[0].style.display="none";
			$("#tr4")[0].style.display="none";
			$("#replytype").val("图片");
		}
	}

	$(function(){
		$("#add").click(function(){
			//类型
			var replytype = $.trim($("input[name='replytype']").val());
			//标题
			var title = $.trim($("input[name='title']").val());
			//text
			var text = $.trim($("input[name='text']").val());
			//key
			var key = $.trim($("input[name='key']").val());
			//图
			var imgUrl = $('#icon').attr("src");
			//内容：
			var content = $.trim($("textarea[name='content']").val());
			//地址:
			var url = $.trim($("input[name='url']").val());
			if(replytype == '图文'){
				var flag = validate(
						title,"请填入标题!",
						key,"请填入关键字",
						content,"请填入内容",
						imgUrl,"请选择图片");
			}else if(replytype == '文本'){
				var flag = validate(
						key,"请填入关键字",
						content,"请填入内容");
			}else if(replytype == '图片'){
				var flag = validate(
						key,"请填入关键字",
						imgUrl,"请选择图片");
			}
			if(flag){
				$.ajax({
					url:"${cp}/reply",
					type:"post",
					data:{	
						replytype:replytype,
						title:title,
						key:key,
						text:text,
						content:content,
						url:url,
						imgUrl:imgUrl
					},
					dataType:"json",
					success:function(data){
						layer.msg(data.msg);
						goFresh("reply");
					}
				});
			}
			return false;
		});
	});
		
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4){
			if(date1 == ''){
				layer.msg(msg1);
				stopPropagation();
			}
			if(date2 == ''){
				layer.msg(msg2);
				stopPropagation();
			}
			if(date3 == ''){
				layer.msg(msg3);
				stopPropagation();
			}
			if(date4 == ''){
				layer.msg(msg4);
				stopPropagation();
			}
			return true;
		}
</script>
