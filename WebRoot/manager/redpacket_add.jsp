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
    

    <title>红包增加</title>

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <link href="css/reveal.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
   
	
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>增加红包</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
                       		<div class="form-group">
	                            <label class="col-sm-2 control-label">
	                            	<font color="red">*</font>
									<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="choose()">选择分类</a>
								</label>
								<div class="col-sm-10">
									<input type="hidden" name="parentId" id="navId">
									<span id="navName"></span>
								</div>
							</div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>红包数量</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="redpacketNum" placeholder="请输入红包数量">
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>红包类型</label>
	                            <div class="col-sm-10"  style="margin-top: 5px">
	                            	<input class="ra" type="radio" name="type" value="0" checked="checked"/>现金
	                            	<input class="ra" type="radio" name="type" value="1"/>优惠券
                            		<input class="ra" type="radio" name="type" value="2"/>实物
	                           	 	<input class="ra" type="radio" name="type" value="3"/>积分
	                           	 	<input class="ra" type="radio" name="type" value="4"/>大转盘
	                            </div>
	                        </div>
							<button class="btn btn-primary" type="button" id="add_num">新增</button>
                            <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
						</form>
							<a href="#" class="big-link" data-reveal-id="myModal" data-animation="fade"></a>
							<div id="myModal" class="reveal-modal">
							    <h1 id="title"></h1>
							</div>
	                    </div>
                  </div>
              </div>
          </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script type="text/javascript" src="js/jquery-1.7.2.js"></script>
    <script src="js/jquery.reveal.js"></script>
    <script src="js/zepto.min.js"></script>
    <script src="js/frozen.js"></script>
</body>
<script type="text/javascript">
		//选择分类
	function choose(){
	   layer.open({
	        type: 2,
			title: '选择类目',
			shadeClose: true,
			shade: 0.8,
			area: ['800px', '90%'],
			content: '${cp }/manager/category_choose.jsp' //iframe的url
	   });
	}
	//红包类型
	var type = $.trim($("input[name='type']").val());
	$(function(){
		$("#add_num").click(function(){
			//id
			var id = $.trim($("input[name='id']").val());
			//红包类别
			var parent = $.trim($("input[name='parentId']").val());
			//红包数量
			var redpacketNum = $.trim($("input[name='redpacketNum']").val());
			var num=Math.ceil(redpacketNum/1000); 
			var flag = validate(
					 redpacketNum,"请输入红包数量",parent,"请选择分类"
			); 
			if(flag){
				loadData(redpacketNum,1,parent,type);
				//loadData(redpacketNum,redpacketNum,parent);
			}
			return false;
		});
		function loadData(redpacketNum,index,parent,type){
			var num=Math.ceil(redpacketNum/1000); 
			if(index<=num){
				var count=0;
				if(index<num){
					count=1000;
				}else if(index=num){
					count=redpacketNum-(index-1)*1000;
				}
				$.ajax({
					url:"redpacket/add",
					type:"post",
					data:{
						redpacketNum:count,
						category:parent,
						type:type
					},
					param:{
						index:index
					},
					dataType:"json",
					success:function(data){
					$(".big-link").click();
						if(data.flag){
							if(this.param.index<num){
								var temp=this.param.index+1;
								loadData(redpacketNum,temp,parent,type);
								$("#title").html("已经载入"+this.param.index*1000);
							}else{
								$("#title").html("已经载入"+redpacketNum);
								layer.msg(data.msg);
								window.parent.location.reload();
								var index = window.parent.layer.getFrameIndex(window.name); 
								window.parent.layer.close(index);
							}
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}	
			/**
			$.ajax({
					url:"redpacket/add",
					type:"post",
					data:{
						redpacketNum:index,
						category:parent
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg("载入成功");
						}else{
							layer.msg(data.msg);
						}
					}
				});
				*/
		}
		function validate(date1,msg1,date2,msg2){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}
			if(date2 == ''){
				layer.msg(msg2);
				return false;
			}
			return true;
		}
	});
	$(".ra").on("click",function(){
		type = $(this).val();
	});
</script>
</html>
