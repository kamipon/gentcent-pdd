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
    

    <title>红包发放统计</title>

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
                   		<input id="start" placeholder="开始时间" style="width: 170px;margin-top:-10px;"  type="text" name="startTime" readonly="readonly" class="form-control" onClick="WdatePicker()"  size="4"/>
                   		<input id="end" placeholder="结束时间" style="width: 170px;margin-left: 203px;margin-top: -33" type="text" name="endTime" readonly="readonly" class="form-control" onClick="WdatePicker()"  size="4"/>
                        <button class="btn btn-primary"  id="sear" style="margin-left: 394px;margin-top: -33">查询</button>
                    </div>
                    <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
                    	 <thead>
                          	 <tr>
		                    	<th>排名</th>
		                    	<th>金额</th>
		                    	<th>商家名</th>
		                    	<th>用户名</th>
		                    </tr>
                  		</thead>
                  		<tbody id="shuju">
                  			
                  		</tbody>
                    </table>
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
	$("#sear").on("click",function(){
		var start = $("#start").val();
		var end = $("#end").val();
		if(start==""||start==null){
			layer.msg("请输入开始日期");
			return;
		}
		if(end==""||end==null){
			layer.msg("请输入结束日期");
			return;
		}
		$.ajax({
			url:"visit/faFang",
			data:{
				start:start,
				end:end
			},
			type:"get",
			success:function(data){
				var str = "";
				for(var i=0;i<data.fa.length;i++){
					var ap = "<tr>"+
							 	"<td>"+(i+1)+	
								"</td>"+
								"<td>"+data.fa[i].money+
								"</td>"+
								"<td>"+data.fa[i].name+
								"</td>"+
								"<td>"+data.fa[i].userName+
								"</td>"+
							"</tr>";
					str+=ap;
				}
				$("#shuju").html(str);
			}
		});
	});
</script>
</html>
