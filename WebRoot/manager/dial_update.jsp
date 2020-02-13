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
    

    <title>修改大转盘</title>

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
	<style>
			@font-face {
				font-family: "iconfont";
				src: url('iconfont.eot?t=1510045248760');
				/* IE9*/
				src: url('iconfont.eot?t=1510045248760#iefix') format('embedded-opentype'), /* IE6-IE8 */
				url('data:application/x-font-woff;charset=utf-8;base64,d09GRgABAAAAAAUYAAsAAAAAB4QAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAABHU1VCAAABCAAAADMAAABCsP6z7U9TLzIAAAE8AAAARAAAAFZW7kgFY21hcAAAAYAAAABeAAABhpmkBr5nbHlmAAAB4AAAAUsAAAFwV0YKG2hlYWQAAAMsAAAALwAAADYPbnJ9aGhlYQAAA1wAAAAcAAAAJAfeA4RobXR4AAADeAAAAAwAAAAMC+kAAGxvY2EAAAOEAAAACAAAAAgAdgC4bWF4cAAAA4wAAAAfAAAAIAESAF1uYW1lAAADrAAAAUUAAAJtPlT+fXBvc3QAAAT0AAAAIwAAADTM69t0eJxjYGRgYOBikGPQYWB0cfMJYeBgYGGAAJAMY05meiJQDMoDyrGAaQ4gZoOIAgCKIwNPAHicY2Bk/sE4gYGVgYOpk+kMAwNDP4RmfM1gxMjBwMDEwMrMgBUEpLmmMDgwVDyTZm7438AQw9zA0AAUZgTJAQAlXQyHeJzFkMENgDAMAy9t6QOxQRfgwUC8mKMTd41iQnkwQS05VhxLiQIsQBQPMYFdGA9OueZ+ZHU/eSZLjUBtpXf1nyqiWXYNKplpsHmr/9i87qPTV6iDOrGVl4QbkscL+wAAeJxNj71OwlAYhr/vlNMWhNb+/0CBQ4WjQUmsBQYjLC40DiZOjl6AriwOXUwcHLwGo/EOHAhXAgMxehEMWq0xMb558yzvs7xAAb5ehbngggHbsA/HcAqAYhdbCgmQ8bhHumgxajmmIvCQMyls9YQjdFqiaUeDuOOIkqiignU8YNGA9wjHfjwihxjZAaJX9c/0dk0X7rHk8vpNlpAHtBphTR3tZZPdsRk1DXla1nVP1+9kkVKZkIKq4KVjF2mxJGaPVPWteWOHNLDscf/kvNKs6he38VXQdoqIaYpGtak8jzVfy3vt24buSZsV2fUr4ZaJ0/cN1ygHnTfIU8i/pgUQUhBAAhMYgMEshlqoGQMYdoCLINng9HvIRziso6OgtCTJ5wsmSXuBjNJstVhkK0qRLWZrStezX+JTgrlGko/lz/RfnfxJOeEbzuZNjQB4nGNgZGBgAGKemTkR8fw2Xxm4WRhA4Jr6dAcE/b+BhYG5AcjlYGACiQIA+kwI0gB4nGNgZGBgbvjfwBDDwgACQJKRARUwAwBHCQJsBAAAAAPpAAAEAAAAAAAAAAB2ALh4nGNgZGBgYGYIZGBlAAEmIOYCQgaG/2A+AwAQ9wFwAHicZY9NTsMwEIVf+gekEqqoYIfkBWIBKP0Rq25YVGr3XXTfpk6bKokjx63UA3AejsAJOALcgDvwSCebNpbH37x5Y08A3OAHHo7fLfeRPVwyO3INF7gXrlN/EG6QX4SbaONVuEX9TdjHM6bCbXRheYPXuGL2hHdhDx18CNdwjU/hOvUv4Qb5W7iJO/wKt9Dx6sI+5l5XuI1HL/bHVi+cXqnlQcWhySKTOb+CmV7vkoWt0uqca1vEJlODoF9JU51pW91T7NdD5yIVWZOqCas6SYzKrdnq0AUb5/JRrxeJHoQm5Vhj/rbGAo5xBYUlDowxQhhkiMro6DtVZvSvsUPCXntWPc3ndFsU1P9zhQEC9M9cU7qy0nk6T4E9XxtSdXQrbsuelDSRXs1JErJCXta2VELqATZlV44RelzRiT8oZ0j/AAlabsgAAAB4nGNgYoAALgbsgJmRiZGZkYWBsYItKzMxIzGfgQEAFXMDBwA=') format('woff'), url('iconfont.ttf?t=1510045248760') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/
				url('iconfont.svg?t=1510045248760#iconfont') format('svg');
				/* iOS 4.1- */
			}
			
			.iconfont {
				font-family: "iconfont" !important;
				font-size: 40px;
				font-style: normal;
				-webkit-font-smoothing: antialiased;
				-moz-osx-font-smoothing: grayscale;
				margin-left:680px;
				width:50px;
			}
			
			.icon-jiahao:before {
				content: "\e61b";
			}
			/*减号*/
			@font-face {
				font-family: "iconfont";
				src: url('iconfont.eot?t=1510219442615');
				/* IE9*/
				src: url('iconfont.eot?t=1510219442615#iefix') format('embedded-opentype'), /* IE6-IE8 */
				url('data:application/x-font-woff;charset=utf-8;base64,d09GRgABAAAAAAUMAAsAAAAAB3gAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAABHU1VCAAABCAAAADMAAABCsP6z7U9TLzIAAAE8AAAARAAAAFZW7kgAY21hcAAAAYAAAABeAAABhpmQBr5nbHlmAAAB4AAAAUAAAAFgbk6jQGhlYWQAAAMgAAAALwAAADYPc8NhaGhlYQAAA1AAAAAcAAAAJAfeA4RobXR4AAADbAAAAAwAAAAMC+kAAGxvY2EAAAN4AAAACAAAAAgAdgCwbWF4cAAAA4AAAAAfAAAAIAESAF1uYW1lAAADoAAAAUUAAAJtPlT+fXBvc3QAAAToAAAAJAAAADXT3kp7eJxjYGRgYOBikGPQYWB0cfMJYeBgYGGAAJAMY05meiJQDMoDyrGAaQ4gZoOIAgCKIwNPAHicY2Bk/sE4gYGVgYOpk+kMAwNDP4RmfM1gxMjBwMDEwMrMgBUEpLmmMDgwVDwTY27438AQw9zA0AAUZgTJAQAk/gyCeJzFkMENgDAMAy9t6QPx7gw8GIgXc3TirlFMKA8mqCXHimMpUYAFiOIhJrAL48Ep19yPrO4nz2SpEait9K7+U0U0y65BJTMNNm/1H5vXfXT6CnVQJ7byknADhc8L5wAAeJxNj71Kw1Acxf//e3tvUtsmNt8fTds0tlepBoyxHcR20UFxEDo5+gC61sEhi+Dg4DOI4Au4tS+SqYg+RYdoEAQPh7P8DhwOMIDvD7qkDuiwDftwApcAyIfYU0iAoUhjMkQzZKZtKFREIpSiXkyP0e5xw0pG6cDmEldRwTYehMlIxETgYTohR5hYAaLrezOt39LoM244ov1QnJMXNDtRS53sFWe7UyPp6vK8rmmupj3JnDGZkIqq4I1tVVl1gxevTPXMZWeHdLDuCu/iqtH1tevH9Dbo21XELEPd7ypv06bXLH3vWbrmSpsN2fEa0ZaB86+ao9eDwSeUouXXrAI0gxrY4AOwAYgRjC2wOVAFpTbaExzHiKEZEsiLFecY5jmGnBerfLFmbL34zeKUQAHZf1q26fsfL7O4m5WTP+m6SG14nGNgZGBgAOILB3ZdjOe3+crAzcIAAte07Dch6P8NLAzMDUAuBwMTSBQASrsKvgB4nGNgZGBgbvjfwBDDwgACQJKRARUwAwBHCQJsBAAAAAPpAAAEAAAAAAAAAAB2ALB4nGNgZGBgYGYIZGBlAAEmIOYCQgaG/2A+AwAQ9wFwAHicZY9NTsMwEIVf+gekEqqoYIfkBWIBKP0Rq25YVGr3XXTfpk6bKokjx63UA3AejsAJOALcgDvwSCebNpbH37x5Y08A3OAHHo7fLfeRPVwyO3INF7gXrlN/EG6QX4SbaONVuEX9TdjHM6bCbXRheYPXuGL2hHdhDx18CNdwjU/hOvUv4Qb5W7iJO/wKt9Dx6sI+5l5XuI1HL/bHVi+cXqnlQcWhySKTOb+CmV7vkoWt0uqca1vEJlODoF9JU51pW91T7NdD5yIVWZOqCas6SYzKrdnq0AUb5/JRrxeJHoQm5Vhj/rbGAo5xBYUlDowxQhhkiMro6DtVZvSvsUPCXntWPc3ndFsU1P9zhQEC9M9cU7qy0nk6T4E9XxtSdXQrbsuelDSRXs1JErJCXta2VELqATZlV44RelzRiT8oZ0j/AAlabsgAAAB4nGNgYoAALgbsgJmRiZGZkYWBsYI9KzMxLyMxn4EBABngA3Y=') format('woff'), url('iconfont.ttf?t=1510219442615') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/
				url('iconfont.svg?t=1510219442615#iconfont') format('svg');
				/* iOS 4.1- */
			}
			
			.icon-jianhao:before {
				content: "\e616";
			    position: absolute;
			    left: 339px;
			    top: -10px;
			}
		</style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal" >
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name" value="${item.name }">
	                            </div>
	                        </div>
                          	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>有效期开始时间</label>
	                            <div class="col-sm-10">
	                                <input type="text" name="startTime" readonly="readonly" value="${item.startTime }" class="form-control" onClick="WdatePicker()"  size="12"/>
	                            </div>
	                        </div>
                         	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>有效期结束时间</label>
	                            <div class="col-sm-10">
	                                <input type="text" name="endTime" readonly="readonly" value="${item.endTime }" class="form-control" onClick="WdatePicker()"  size="12"/>
	                            </div>
	                        </div>
	                        	<!-- 奖品列表 -->
	                        <div class="form-group " id="jiangpin"></div>
	                        	<!-- 加号 -->
	                         <div class="iconfont icon-jiahao" id="addAward"></div>
	                       	<div>
								<button class="btn btn-primary" type="button" id="add_activity">修改</button>
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
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
     <script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
	<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
    <jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(function(){
		//数据回填
		var awards = ${awards};
		$.each(awards, function(j, v){
			var j = j+1;
			//添加奖品
			addaward(j);
			//隐藏所有奖品类型
			hideAll(j);
			//回填数据
			 $("#myid"+j).val(v.id);
			//等级
			 $("#level"+j+" option[value='"+v.level+"'] ").attr("selected",true);
			//类型
			 $("#type"+j+" option[value='"+v.type+"'] ").attr("selected",true);
			//奖品类型
			if(v.type=="0"){
				$("#money"+j).children().val(v.money);
				show("money"+j);
			}
			if(v.type=="1"){
				$("#coupon"+j+" option[value='"+v.coupon+"'] ").attr("selected",true);
				show("coupon"+j);
			}
			if(v.type=="2"){
				$("#goods"+j+" option[value='"+v.goods+"'] ").attr("selected",true);
				show("goods"+j);
			}
			if(v.type=="3"){
				$("#jifen"+j).children().val(v.integral);
				show("jifen"+j);
			}
			//奖品名
			$("#desc"+j).val(v.desc);
		});
		//添加奖品
		$("#addAward").click(function(){
			var _len = $("#jiangpin .row").length+1;
			addaward(_len);
			//设置默认奖品等级
			$("#level"+_len+" option[value="+_len+"]").attr("selected",true);
		});
		//提交
		$("#add_activity").click(function(){
			//名称
			var name = $.trim($("input[name='name']").val());
			//开始时间
			var startTime = $.trim($("input[name='startTime']").val());
			//结束时间
			var endTime = $.trim($("input[name='endTime']").val());
			//id
			var id = '${item.id}';
			//奖品数组
			var aws = [];
			var flag = false;
			flag = validate(
				name,"请输入名称!",
				startTime,"请输入开始时间!",
				endTime,"请输入结束时间!"
			);
			if(!flag){
				return false;
			}
			var _len = $("#jiangpin .row").length;
			for(var j=1;j<=_len;j++){
				var aid = $("#myid"+j).val();
				//几等奖
				var level = $("#level"+j).val();
				//奖品名称
				var desc = $.trim($("#desc"+j).val());
				//类型
				var type = $.trim($("#type"+j).val());
				var awardtype;
				var msg;
				if(type=="0"){
					//现金
					awardtype = $.trim($("#money"+j).children().val());
					msg = "请输入奖品"+j+"的奖品金额!";
				}else if(type=="1"){
					//优惠券
					awardtype = $.trim($("#coupon"+j).children().val());
					msg = "请选择奖品"+j+"的优惠券！";
				}else if(type=="2"){
					//实物
					awardtype = $.trim($("#goods"+j).children().val());
					msg = "请选择奖品"+j+"的实物!";
				}else if(type=="3"){
					//积分
					awardtype = $.trim($("#jifen"+j).children().val());
					msg = "请输入奖品"+j+"的积分数量!";
				}
				flag = validate2(
					level,"请选择奖品"+j+"的奖品等级!",
					type,"请选择奖品"+j+"的奖品类型!",
					awardtype,msg,
					desc,"请输入奖品"+j+"的奖品名称!"
				);
				if(!flag){
				return false;
			}
				//奖品
				var award = {"aid":aid,"level":level,"awardtype":awardtype,"type":type,"desc":desc};
				aws.push(award);
			}
			//JSON转字符串
			var awards = JSON.stringify(aws);
			if(flag){
				$.ajax({
					url:"dial",
					type:"post",
					data:{	
						_method:"put",
						id:id,
						name:name,
						startTime:startTime,
						endTime:endTime,
						awards:awards
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
		
	});
	function addaward(i){
		var se ='<div class="row" id = '+i+'>'+
	                 	'<label class="col-sm-2 control-label"><font color="red">*</font>奖品'+i+'</label>'+
	                 			'<div>'+
	                 				'<input type="hidden" id="myid'+i+'"/>'+
	                            '</div>'+
	                     		'<div class="col-sm-2">'+
	                              	'<select class="form-control"  id="level'+i+'">'+
	                            		'<option value="1">一等奖</option>'+
	                            		'<option value="2">二等奖</option>'+
	                            		'<option value="3">三等奖</option>'+
	                            		'<option value="4">四等奖</option>'+
	                            		'<option value="5">五等奖</option>'+
	                            		'<option value="6">六等奖</option>'+
		                            	'<option value="7">七等奖</option>'+
	                            	'</select>'+
	                            '</div>'+
	                            '<div class="col-sm-2">'+
	                               '<select class="form-control" id="type'+i+'"onchange=ch("type'+i+'")>'+
	                            		'<option value="0">现金</option>'+
	                            		'<option value="1">优惠券</option>'+
	                            		'<option value="2">实物</option>'+
	                            		'<option value="3">积分</option>'+
	                            	'</select>'+
	                           ' </div>'+
				               ' <div class="form-group col-sm-3" id="money'+i+'">'+
		                         '       <input placeholder="请输入奖品金额" type="text" class="form-control"  size="12" '+
		                         			' oninput=document.getElementById('+"'desc"+i+"'"+').value=this.value+"元现金";'+ 
				                        	' onpropertychange=document.getElementById('+"'desc"+i+"'"+').value=this.value+"元现金";/>'+
		                       ' </div>'+
		                       ' <div class="form-group col-sm-3" style="display: none" id="coupon'+i+'">'+
		                            	'<select class="form-control" name="coupon" '+
			                            	'oninput="document.getElementById('+"'desc"+i+"'"+').value=this.options[this.selectedIndex].text;" '+
				                        	'onpropertychange="document.getElementById('+"'desc"+i+"'"+').value=this.options[this.selectedIndex].text;">'+
		                            		'<c:forEach items="${couList}" var="each">'+
		                            		'	<option value="${each.id }">${each.title }</option>'+
		                            		'</c:forEach>'+
		                            	'</select>'+
		                      '  </div>'+
		                       ' <div class="form-group col-sm-3" style="display: none" id="goods'+i+'">'+
		                             '	<select class="form-control" name="goods"'+
			                            	'oninput="document.getElementById('+"'desc"+i+"'"+').value=this.options[this.selectedIndex].text;" '+
				                        	'onpropertychange="document.getElementById('+"'desc"+i+"'"+').value=this.options[this.selectedIndex].text;">'+
		                            	'	<c:forEach items="${goodsList}" var="each">'+
		                            	'		<option value="${each.id }">${each.title }</option>'+
		                            	'	</c:forEach>'+
		                            	'</select>'+
		                       ' </div>'+
	                         	'<div class="form-group col-sm-3" id="jifen'+i+'" style="display:none">'+
		                               ' <input placeholder="请输入积分数量" type="text" class="form-control"  size="12"'+
			                                'oninput="document.getElementById('+"'desc"+i+"'"+').value=this.value'+"+'积分'"+';" '+
				                        	'onpropertychange="document.getElementById('+"'desc"+i+"'"+').value=this.value'+"+'积分'"+';"/>'+
		                        '</div>'+
		                        '<div class="form-group col-sm-2" >'+
		                        	'<input placeholder="请输入奖品名称" type="text" class="form-control" id="desc'+i+'" />'+
		                        	'<div class="iconfont icon-jianhao" id="deleteAward'+i+'" onclick="del('+i+')"></div>'+
		                        '</div>'+
	                 '</div>';
			$("#jiangpin").append(se);
	}
	//删除奖品
	function del(index){
		var _len = $("#jiangpin .row").length+1;
		if(_len < 5){
			layer.msg("至少添加三个奖品");
			return false;
		}
		//删除当前行
		$("#"+index).remove();
		//重新写入奖品 i表示下一个元素的下标
		for(var i=index+1;i<_len;i++){
			//也可以加括号，先进行数字运算
			//替换后的奖品id
			var k = i-1;
			//等级
			var level = $("#level"+i).val();
			//类型
			var type = $("#type"+i).val();
			//现金
			var money = $("#money"+i).children().val();
			//优惠券
			var coupon = $("#coupon"+i).val();
			//实物
			var goods = $("#goods"+i).val();
			//积分
			var jifen = $("#jifen"+i).children().val();
			//名称
			var desc = $("#desc"+i).val();
			//重新写入奖品
			var jp = '<div class="row" id="'+k+'">'+
                 		'<label class="col-sm-2 control-label" ><font color="red">*</font>奖品'+k+'</label>'+
                    		'<div class="col-sm-2">'+
                             	'<select class="form-control"  id="level'+k+'">'+
                           		'<option value="1">一等奖</option>'+
                           		'<option value="2">二等奖</option>'+
                           		'<option value="3">三等奖</option>'+
                           		'<option value="4">四等奖</option>'+
                           		'<option value="5">五等奖</option>'+
                           		'<option value="6">六等奖</option>'+
                            	'<option value="7">七等奖</option>'+
                           	'</select>'+
                           '</div>'+
                           '<div class="col-sm-2">'+
                              '<select class="form-control" id="type'+k+'"  onchange="ch('+"'type"+k+"'"+')">'+
                           		'<option value="0">现金</option>'+
                           		'<option value="1">优惠券</option>'+
                           		'<option value="2">实物</option>'+
                           		'<option value="3">积分</option>'+
                           	'</select>'+
                          ' </div>'+
		               ' <div class="form-group col-sm-3" id="money'+k+'">'+
                         '       <input placeholder="请输入奖品金额" type="text" class="form-control"  size="12"'+
	                         		' oninput=document.getElementById('+"'desc"+k+"'"+').value=this.value+"元现金";'+ 
		                        	' onpropertychange=document.getElementById('+"'desc"+k+"'"+').value=this.value+"元现金";/>'+
                       ' </div>'+
                       ' <div class="form-group col-sm-3" style="display: none" id="coupon'+k+'">'+
                            	'<select class="form-control" name="coupon" '+
	                            	'oninput="document.getElementById('+"'desc"+k+"'"+').value=this.options[this.selectedIndex].text;" '+
		                        	'onpropertychange="document.getElementById('+"'desc"+k+"'"+').value=this.options[this.selectedIndex].text;">'+
                            		'<c:forEach items="${couList}" var="each">'+
                            		'	<option value="${each.id }">${each.title }</option>'+
                            		'</c:forEach>'+
                            	'</select>'+
                      '  </div>'+
                       ' <div class="form-group col-sm-3" style="display: none" id="goods'+k+'">'+
                            '	<select class="form-control" name="goods"'+
	                            	'oninput="document.getElementById('+"'desc"+k+"'"+').value=this.options[this.selectedIndex].text;" '+
		                        	'onpropertychange="document.getElementById('+"'desc"+k+"'"+').value=this.options[this.selectedIndex].text;">'+
                            	'	<c:forEach items="${goodsList}" var="each">'+
                            	'		<option value="${each.id }">${each.title }</option>'+
                            	'	</c:forEach>'+
                            	'</select>'+
                       ' </div>'+
                        	'<div class="form-group col-sm-3" id="jifen'+k+'" style="display:none">'+
                               ' <input placeholder="请输入积分数量" type="text" class="form-control"  size="12"'+
	                                'oninput="document.getElementById('+"'desc"+k+"'"+').value=this.value'+"+'积分'"+';" '+
		                        	'onpropertychange="document.getElementById('+"'desc"+k+"'"+').value=this.value'+"+'积分'"+';"/>'+
                        '</div>'+
                        '<div class="form-group col-sm-2" >'+
                        	'<input placeholder="请输入奖品名称" type="text" class="form-control" id="desc'+k+'" />'+
                        	'<div class="iconfont icon-jianhao" id="deleteAward'+k+'" onclick="del('+k+')"></div>'+
                        '</div>'+
                 '</div>';
			$("#"+i).replaceWith(jp);
			//应该显示的类型id
			var sid = "";
			if(type=="0"){
				 sid = "money"+k;
			}
			if(type=="1"){
				 sid = "coupon"+k;
			}
			if(type=="2"){
				 sid = "goods"+k;
			}
			if(type=="3"){
				 sid = "jifen"+k;
			}
			hideAll(k);
			show(sid);
			$("#level"+k+" option[value="+level+"]").attr("selected",true);
			$("#type"+k+" option[value="+type+"]").attr("selected",true);
			if(coupon !=""){
				$("#coupon"+k+" option[value="+coupon+"]").attr("selected",true);
			}
			if(goods !=""){
				$("#goods"+k+" option[value="+goods+"]").attr("selected",true);
			}
			$("#money"+k).children().val(money);
			$("#jifen"+k).children().val(jifen);
			$("#desc"+k).val(desc);
		}
	}
	//类型与奖品类型联动
	function ch(id){
		var su = id.substring(id.length-1);
		var type =$("#"+id).val();
		hideAll(su);
		if(type=="0"){
			show("money"+su);
			var desc =$("#money"+su).val();
			$("#desc"+su).val(desc+"元现金");
		}
		if(type=="1"){
			show("coupon"+su);
			var desc =$('#coupon'+su+' option:selected').text();
			$("#desc"+su).val(desc);
		}
		if(type=="2"){
			show("goods"+su);
			var desc =$('#goods'+su+' option:selected').text();
			$("#desc"+su).val(desc);
		}
		if(type=="3"){
			show("jifen"+su);
			var desc =$("#jifen"+su).val();
			$("#desc"+su).val(desc+"积分");
		}
	}
	function hideAll(su){
		$("#money"+su).css("display","none");
		$("#coupon"+su).css("display","none");
		$("#goods"+su).css("display","none");
		$("#jifen"+su).css("display","none");
	}
	function show(id){
		$("#"+id).css("display","block");
	}
	function validate(date1,msg1,date2,msg2,date3,msg3){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}
			return true;
		}
		function validate2(date1,msg1,date2,msg2,date3,msg3,date4,msg4){
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''||date3 == '0'){
				layer.msg(msg3);
				return false;
			}else if(date4 == ''){
				layer.msg(msg4);
				return false;
			}
			return true;
		}
</script>
</html>
