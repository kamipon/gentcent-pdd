<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>商品详情</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
     <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <script type="text/javascript" src="manager/js/kindeditor-min.js"></script>
</head>
<script type="text/javascript">
		     window.onload=function(){
			var y=Number(200)+Number(${fxzGoods.vertical});
			var x=Number(115)+Number(${fxzGoods.level});
			$("#p").css("top",y+"px");
			$("#p").css("left",x+"px");
		 }
</script>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>商品详情</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" readonly="readonly" class="form-control" name="name" value="${fxzGoods.name }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品页面边框颜色</label>
	                            <div class="col-sm-10">
	                                <input type="color" readonly="readonly"  name="color" value="${fxzGoods.color}" style="width: 30px;height: 30px">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>海报</label>
	                            <div class="col-sm-2">
                                	<img src="${fxzGoods.picUrl }" name="url" id="picUrl" style="height:50px;">
                                </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享图片</label>
	                            <div class="col-sm-2">
	                            	<div style="height:500px;width: 300px;background-image: url('${fxzGoods.picture }');background-repeat: no-repeat;background-size: cover;">
	                            		<div id="p" style="left: 0px;top: 0px;width: 100px;height: 100px;border: 1px solid red;background-color: white;position: absolute;text-align: center;line-height: 100px">
	                            		 二维码
	                            		</div>
	                            	</div>
                                </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否需要核销</label>
	                            <div class="col-sm-10">
	                                否 <input type="radio"  name="isHx" value="1"  <c:if test="${fxzGoods.isHx==1}">checked="checked"</c:if> disabled > &nbsp;&nbsp;
	                                是 <input type="radio"  name="isHx" value="0" <c:if test="${fxzGoods.isHx==0}">checked="checked"</c:if>  disabled>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
	                            <div class="col-sm-10">
	                                <input type="text" readonly="readonly" class="form-control" name="telphone" id="telphone" value="${fxzGoods.telphone }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>价格</label>
	                            <div class="col-sm-10">
	                                <input type="text" readonly="readonly" class="form-control" name="price" id="price" value="${fxzGoods.price }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>佣金</label>
	                            <div class="col-sm-10">
	                                <input type="text" readonly="readonly" class="form-control" name="money" id="money" value="${fxzGoods.money }">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>数量</label>
	                            <div class="col-sm-10">
	                                <input type="text" readonly="readonly" class="form-control" name="num" id="num" value="${fxzGoods.num }">
	                            </div>
	                        </div>
	                       <div class="form-group">
	                            <label class="col-sm-2 control-label">到期时间</label>
	                            <div class="col-sm-10">
	                                <input id="endTime" type="text" name="endTime" readonly="readonly" class="form-control"   size="12" value="<fmt:formatDate type="both" value="${fxzGoods.endTime}" />"/>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label">商品描述</label>
	                            <div class="col-sm-10" style="width: 500px">
	                            	${fxzGoods.desc }
	                            </div>
	                        </div>
                          	<div class="form-group">
	                            <label class="col-sm-2 control-label">活动规则</label>
	                            <div class="col-sm-10">
	                               ${fxzGoods.desc2 }
	                            </div>
	                        </div>
	                       	<div>
								<a href="fxzGoods/list"><button class="btn btn-primary" type="button" id="add_activity">返回</button></a>
	                        </div>
                         </form>
                        </div>
                       
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
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>

</script>
</html>
