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
    <title>新增</title>
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
	<script type="text/javascript" src="js/jquery1.9.1.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.all.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="${cp }/js/11cms.js"></script>
    <script type="text/javascript" src="${cp }/js/moment.min.js"></script>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>新增</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" id="actStatistics_add" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>活动名</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                      <div class="form-group">
                                <label class="col-sm-2 control-label">活动开始时间</label>
                                <div class="col-sm-10">
                                	<input onclick="WdatePicker()" type="text" name="startTime" readonly="readonly" class="form-control"  class="Wdate" size="12">
                                </div>
                           </div>
	                      <div class="form-group">
                                <label class="col-sm-2 control-label">活动结束时间</label>
                                <div class="col-sm-10">
                                	<input onclick="WdatePicker()" type="text" name="endTime" readonly="readonly" class="form-control"  class="Wdate" size="12">
                                </div>
                           </div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_content">新增</button>
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
	<script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>

<script type="text/javascript">
		$("#add_content").click(function(){
			//活动名
			var name = $.trim($("input[name='name']").val());
			//开始时间
			var startTime = $.trim($("input[name='startTime']").val());
			var flag = validate(
				name,"请输入活动名!",
				startTime,"请选择开始时间"
			); 
			if(flag){
				$.ajax({
					url:"actStatistics/add",
					type:"post",
					data:$("#actStatistics_add").serialize(),
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							//父页面刷新
							parent.location.reload();
							//获取当前窗口的索引
							var index = parent.layer.getFrameIndex(window.name);
							//关闭当前窗口
							parent.layer.close(index);
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
		function validate(date1,msg1,date2,msg2){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
</script>
</html>
