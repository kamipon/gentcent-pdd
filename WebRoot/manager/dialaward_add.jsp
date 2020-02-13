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
    

    <title>添加大转盘奖品</title>

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
	                            <label class="col-sm-2 control-label"><font color="red">*</font>大转盘</label>
	                            <div class="col-sm-10">
	                            	<select name="dial" id="dial"   class="form-control">
	                            		<option value="0">--请选择大转盘--</option>
	                            		<c:forEach items="${dialList}" var="each">
	                            			<option value="${each.id }">${each.name }</option>
	                            		</c:forEach>
	                            	</select>
	                            </div>
	                        </div>
                          	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>几等奖</label>
	                            <div class="col-sm-10">
	                            	<select name="level" id="level"   class="form-control">
	                            			<option value="1">一等奖</option>
	                            			<option value="2">二等奖</option>
	                            			<option value="3">三等奖</option>
	                            			<option value="4">四等奖</option>
	                            			<option value="5">五等奖</option>
	                            	</select>
	                            </div>
	                        </div>
                         	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>奖品内容</label>
	                            <div class="col-sm-10">
	                                <input id="desc"  type="text" name="desc" class="form-control" />
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">奖品图片</label>
	                            <div class="col-sm-2">
                                	<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('picUrl')">选择图片</a>
                                	<img src="" name="url" id="picUrl" style="height:50px;">
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
		$("#add_activity").on("click",function(){
			//大转盘
			var dial = $("#dial").val();
			//几等奖
			var level = $("#level").val();
			//奖品内容
			var desc = $.trim($("input[name='desc']").val());
			//奖品图片
			var url = $("#picUrl").attr("src"); 
			var flag = validate(
				dial,"请选择大转盘!",
				desc,"请输入奖品内容",
			); 
			if(flag){
				$.ajax({
					url:"dialAward/add",
					type:"post",
					data:{	
						dial:dial,
						level:level,
						desc:desc,
						url:url
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
		function validate(date1,msg1,date2,msg2){
			if(date1 ==0){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
	   	
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
