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
    

    <title>模板管理</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/jquery1.9.1.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="${cp }/js/11cms.js"></script>
    <script type="text/javascript" src="${cp }/js/moment.min.js"></script>
	<script type="text/javascript">  
    
      //实例化编辑器  
      //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例  
      $(function(){
    	  var ue = UE.getEditor('editor'); 
    	  UE.getEditor('editor').addListener("ready", function () {
    	    	// editor准备好之后才可以使用
    	    	  var content='${content.content}';
    	    	 	 
    	    	  
    	    	  if(content!=""&&content.length>0){
    	    		//判断ueditor 编辑器是否创建成功
    	    		  
    	    		  // editor准备好之后才可以使用
    	    		  ue.setContent(content);
    	    	
    	    	  }
    	    	});
      });
     
     
      
    
    	 
	
  </script>  
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>模板管理</h5>
                    </div>
                   <div class="ibox-content">
	                    <form method="post" class="form-horizontal" >
	                    	<input type="hidden" name="_method" value="put" />
	                    	<input type="hidden" name="id" value="${content.id }">
	                          <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>模板标题</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="title" value="${content.title}">
	                            </div>
	                        </div>
	                        <div class="form-group">
                                <label class="col-sm-2 control-label">
                                	模板内容
                                	<p style="color:red;">ps:图片大小限制为200KB</p>
                                </label>
                                <input name="replyContent" type="hidden" id="info" >　
                                <div class="col-sm-10">
                                	<script id="editor" type="text/plain" style="width:100%;height:500px;"></script>
                                </div>
                            </div>
	                      
	                      
	                        
	                        <div class="hr-line-dashed"></div>	
                        	<div>
                            	<button class="btn btn-primary" type="button" id="change">修改</button>
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
</body>
<script>
	
	$(function(){
		$("#change").click(function(){
			ue = UEEditor.init('${cp}','editor');
		function getContent() {  
	    	  var content = UE.getEditor('editor').getContent();
	    	  $('#info').val(content);
	    	  document.submit();
      }
			//id
			var id = $.trim($("input[name='id']").val());
			//模板标题
			var title = $.trim($("input[name='title']").val());
			//模板内容
			var content = UE.getEditor('editor').getContent();
			var flag = validate(
				title,"请输入模板标题!",
				content,"请输入模板内容"
			); 
			if(flag){
				$.ajax({
					url:"content/"+id,
					type:"post",
					data:{
						_method:"put",
						id:id,	
						title:title,
						content:content
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg(data.msg);
							goFresh("content");
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
	});
</script>
</html>
