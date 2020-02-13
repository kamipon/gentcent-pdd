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
    

    <title>绑定奖品</title>

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
                    <div class="ibox-content">
                   			<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>大转盘</label>
	                            <div class="col-sm-10">
	                            	<select class="form-control" id="dial">
	                            		<option value="0">--请选择大转盘--</option>
	                            		<c:forEach items="${dialList}" var="each">
	                            			<option value="${each.id }">${each.name }</option>
	                            		</c:forEach>
	                            	</select>
	                            </div>
	                        </div>
	                        <div id="dazhuanpan"></div>
							<button class="btn btn-primary" type="button" id="add_num">绑定</button>
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
	var start = "${start}";
	var end = "${end}";
	$('#dial').change(function(){
		var id = $("#dial").val(); 
		if(id==0){
			return;
		}
		$.ajax({
			url:'redpacket/getAward',
			data:{
				id:id
			},
			success:function(data){
			var str = '<div class="form-group"> <label class="col-sm-2 control-label">奖品</label> <div class="col-sm-10"> ';
			 str += '<select class="form-control" id="jiangpin"> <option value="0">--请选择奖项--</option>';
			var $a = $(data.list)
				$.each($a,function(k,v){   			                
						str += '<option value="' +v.id+ '">'+v.desc+'</option> ' 
				});
			str+='</select> </div></div>';
			$("#dazhuanpan").html(str);
			}
		});
	});
	
	$("#add_num").click(function(){
		var dial = $("#dial").val();
		var awardid = $("#jiangpin").val();
		$.ajax({
			url:"redpacket/award",
			type:"post",
			data:{
				dial:dial,
				awardmsg:awardid,
				start:start,
				end:end
			},
			success:function(data){	
				layer.msg(data.msg);
			}
		});
	});
</script>
</html>
