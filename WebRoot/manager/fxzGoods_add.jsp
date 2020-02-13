<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>添加商品</title>
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
    <script type="text/javascript" src="${cp }/js/jquery1.9.1.js"></script>
    <script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
    <script type="text/javascript">
    	function ajaxFileUpload1(obj) {
	     $.ajaxFileUpload({  
		     url:'${cp }/plugin/fileUploads',             //需要链接到服务器地址  
		     secureuri:false,  
		     fileElementId:"uploadFileInput",                         //文件选择框的id属性  
		     dataType: 'json',  
		     success: function (data, status){             //相当于java中try语句块的用法  
		     //data是从服务器返回来的值
		     if(data.flag){
				   $("#1").attr("src",data.src);
		     }else{
		    		alert(data.msg);
		     }
		     }, 
		      
	     });
	     
   	     $(".remove_a").removeAttr("href");
	     $(".remove_a").removeAttr("onclick");
	    
	     $(".remove_a").click(function(){
	    	return false;
	     });
	     }
	         	function ajaxFileUpload2(obj) {
	     $.ajaxFileUpload({  
		     url:'${cp }/plugin/fileUploads',             //需要链接到服务器地址  
		     secureuri:false,  
		     fileElementId:"uploadFileInput1",                         //文件选择框的id属性  
		     dataType: 'json',  
		     success: function (data, status){             //相当于java中try语句块的用法  
		     //data是从服务器返回来的值
		     if(data.flag){
				   $("#2").css("background-image","url('"+data.src+"')");
				   $("#i2").attr("src",data.src);
		     }else{
		    		alert(data.msg);
		     }
		     }, 
		      
		     });
		     	     $(".remove_a").removeAttr("href");
	     $(".remove_a").removeAttr("onclick");
	    
	     $(".remove_a").click(function(){
	    	return false;
	     });
	     }
	     function ch(){
	     	var n=0;
	     	var a=$.trim($("#t option:selected").val());
	     	if(a!=""){
	     		n=Number(n)+Number(a);
	     	}
	     	$("#p").css("top",n+"px");
	     }
	     function rh(){
	     	var n=0;
	     	var a=$.trim($("#l option:selected").val());
	     	if(a!=""){
	     		n=Number(n)+Number(a);
	     	}
	     	$("#p").css("left",n+"px");
	     }
	     function ajaxFileMusic(obj) {
	     	$.ajaxFileUpload({  
		     	url:'${cp }/plugin/fileMusic',             //需要链接到服务器地址  
		     	secureuri:false,  
		     	fileElementId:"uploadFileInputM",                         //文件选择框的id属性  
		     	dataType: 'json',  
		     	success: function (data, status){             //相当于java中try语句块的用法  
			     	//data是从服务器返回来的值
			     	if(data.flag){
						   $("#music").attr("value",data.src);
			     	}else{
			    			alert(data.msg);
			     	}
		     	}, 
	     	});
	     };
    </script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>添加商品</h5>
                    </div>
                    <div class="ibox-content">
                    	<form method="post" class="form-horizontal"  >
                    		<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品海报</label>
	                            <div class="col-sm-2" style="width: 154px">
                                	<li class="fileinput-button js-add-image">
	                                	<a class="fileinput-button-icon show_update_imgs" href="javascript:;">+</a>
										<input class="uploadFileInput" type="file" size="45" style="width:100%;" name="uploadFileInput" onchange="ajaxFileUpload1(this)">
										<img  id="1" style="width: 100%;height: 100%;margin-top: -21%">
		                            </li>
                                </div>
                                <font color="red">海报支持自定义大小</font>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品名称</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="name">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>分享内容</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="content">
	                                <br>
	                            	<span style="color: red">*[商品名称],[分享内容],[商品海报]将影响分享活动时的显示内容</span>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                        	<label class="col-sm-2 control-label"></label>
	                            <div class="col-sm-10">
	                            	<img src="./images/goods.png" style="" >
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>活动背景音乐</label>
	                            <div class="col-sm-10">
	                                <input type="text" style="width: 60%" class="form-control" id="music" name="music" disabled="disabled">
									<input class="uploadFileInputM" type="file" size="15" style="width:100%;margin-top: 3px" name="uploadFileInputM" onchange="ajaxFileMusic(this)">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>商品页面边框颜色</label>
	                            <div class="col-sm-10">
	                                <input type="color" name="color" value="#ffffff" style="width: 30px;height: 30px">
	                            </div>
	                             <img src="./images/bk.png" style="margin-left: 20%;margin-top: -4.7%" >
	                        </div>
	                        <div class="form-group" >
	                            <label class="col-sm-2 control-label">分享背景图片</label>
	                            <div class="col-sm-2" >
                                	<li class="fileinput-button js-add-image">
                                	<a class="fileinput-button-icon show_update_imgs" href="javascript:;">+</a>
									<input class="uploadFileInput1" type="file" size="45" style="width:100%;" name="uploadFileInput1" onchange="ajaxFileUpload2(this)">

	                            </li>
	                            <div style="line-height: 30px;margin-top: 10px">
	                            	调整二维码位置：
	                            	<br>
									上下调整
									<select id="t" onchange="ch()">
									<%for(int i=0;i<=435;i++){ %>
										<option   value="<%=i %>" <%if(i==0){ %>selected="selected"<%} %>><%=i %></option>
									<%} %>
									</select>
									<br>
									左右位置
									<select id="l" onchange="rh()">
									<%for(int i=0;i<=235;i++){ %>
										<option   value="<%=i %>" <%if(i==0){ %>selected="selected"<%} %>><%=i %></option>
									<%} %>
									</select>
									</div>
	                            <div style="margin-top: -73%;margin-left: 150px;width: 300px;">
	                            <span ><font color="red">请上传3*5比例大小的图片，不然可能会导致图片变形<br>二维码尺寸为100*100</font></span>
	                            <div id="2" style="width: 300px;height: 500px;background-image:url('./images/bg.png');position: relative; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;}">
	                            	<img id="i2" src="" style="display: none">
	                            	<div id="p" style="width: 100px;height: 100px;background-color: white;position: absolute;left: 100px;top:200px;text-align: center;line-height: 100px;border: 1px solid red;">二维码</div>
	                            </div>
	                            </div>
                                </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>底部购买按钮内容</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="payfont" value="自买省钱">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>底部分享按钮内容</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="sharefont" value="分享赚钱">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                        	<label class="col-sm-2 control-label"></label>
	                            <div class="col-sm-10">
	                            	<img src="./images/font.png" style="" >
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否需要核销</label>
	                            <div class="col-sm-10">
					                                否 <input type="radio"  name="isHx" value="1" checked="checked" > &nbsp;&nbsp;
					                                是 <input type="radio"  name="isHx" value="0">
					                                <span style="margin-left: 10px;color: red">* 开启后用户付款成功将发送核销码给客户，商家可以在【活动订单列表】中核销</span>
	                            </div>
	                        </div>
	                         <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否需要填写地址</label>
	                            <div class="col-sm-10">
					                                否 <input type="radio"  name="isAddress" value="0" checked="checked" > &nbsp;&nbsp;
					                                是 <input type="radio"  name="isAddress" value="1">
					                                <span style="margin-left: 10px;color: red">* 开启后用户需要填写收货地址，应用于商家当前活动需要发货</span>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>是否开启虚拟人数</label>
	                            <div class="col-sm-10">
					                                否 <input type="radio"  name="isTrueman" value="0" checked="checked" > &nbsp;&nbsp;
					                                是 <input type="radio"  name="isTrueman" value="1">
					                                <span style="margin-left: 10px;color: red">* 开启后活动页面显示虚拟支付人数，和虚拟参与人数</span>
	                            </div>
	                        </div>
	                        <div class="form-group" id="truepay" style="display: none">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>虚拟支付人数</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="truemanPay" value="0" onkeyup="this.value=(this.value.match(/\d+(\\d{0,0})?/)||[&#39;&#39;])[0]">
	                            </div>
	                        </div>
	                        <div class="form-group" id="trueopen" style="display: none">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>虚拟参与人数</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="truemanOpen" value="0" onkeyup="this.value=(this.value.match(/\d+(\\d{0,0})?/)||[&#39;&#39;])[0]">
	                            </div>
	                        </div>
                         	<div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="telphone" onkeyup="this.value=(this.value.match(/\d+(\.\d{0,0})?/)||[&#39;&#39;])[0]">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>价格</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="price" id="price" onkeyup="this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[&#39;&#39;])[0]">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>佣金</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="money" id="money" onkeyup="this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[&#39;&#39;])[0]">
	                            	<font color="red">佣金可以为0元, 但不能小于0.3元. 不能大于价格的60%.
	                           		</font>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>数量</label>
	                            <div class="col-sm-10">
	                                <input type="text" class="form-control" name="num" id="num" onkeyup="this.value=(this.value.match(/\d+(\.\d{0,0})?/)||[&#39;&#39;])[0]">
	                            	<font color="red">当前账户余额：<fmt:formatNumber pattern="0.00" value="${yue+money}" maxFractionDigits="2"/>元<br>
	                                              当前账户其他商品预支付佣金:<fmt:formatNumber pattern="0.00" value="${money}" maxFractionDigits="2"/>元 <br>
	                                              此次商品总佣金(金额*数量)设置不可超过<fmt:formatNumber pattern="0.00" value="${yue+money}" maxFractionDigits="2"/>元
	                           		 </font>
	                            </div>
	                        </div>
	                       <div class="form-group">
	                            <label class="col-sm-2 control-label"><font color="red">*</font>到期时间</label>
	                            <div class="col-sm-10">
	                                <input id="endTime"  type="text" name="endTime" readonly="readonly" class="form-control" onClick="WdatePicker()"  size="12"/>
	                            </div>
	                        </div>
                          	<div class="form-group">
	                            <label class="col-sm-2 control-label">商品描述</label>
	                            <div class="col-sm-10">
	                            	<textarea maxlength="255" name="desc" id="desc" rows="3" cols="70" style="width:800px;height:400px;visibility:hidden;"></textarea>
	                            </div>
	                        </div>
                          	<div class="form-group">
	                            <label class="col-sm-2 control-label">活动规则</label>
	                            <div class="col-sm-10">
	                                <textarea maxlength="255" name="desc2" id="desc2" rows="3" cols="70" style="width:800px;height:400px;visibility:hidden;"></textarea>
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
    <script src="js/jquery.min63b9.js"></script>
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
		var radio=$('input[name="isTrueman"]');
		radio.change(function(){
			var values = $(this).val();
			if(values=='0'){
				$("#truepay").css("display","none");
				$("#trueopen").css("display","none");
			}else{
				$("#truepay").css("display","block");
				$("#trueopen").css("display","block");
			}
	  	});
		$("#add_activity").click(function(){
		    var color = $.trim($("input[name='color']").val());
			//商品名称
			var name = $.trim($("input[name='name']").val());
			//背景音乐
			var music = $.trim($("input[name='music']").val());
			//分享内容
			var content = $.trim($("input[name='content']").val());
			//价格
			var price = $.trim($("input[name='price']").val());
			//佣金
			var money = $.trim($("input[name='money']").val());
			//底部购买内容
			var payfont = $.trim($("input[name='payfont']").val());
			//底部分享内容
			var sharefont = $.trim($("input[name='sharefont']").val());
			//联系方式
			var telphone = $.trim($("input[name='telphone']").val());
			//商品数量
			var num = $.trim($("input[name='num']").val());
			//到期时间
			var endTime = $("#endTime").val();
			//商品描述
			var desc = $("#desc").val();
			//商品规则
			var desc2 = $("#desc2").val();
			//商品海报
			var picUrl = $("#1").attr("src");
			//商品图片
			var picture = $("#i2").attr("src");
			//垂直位置
			var vertical=$.trim($("#t option:selected").val());
			//水平位置
			var level=$.trim($("#l option:selected").val());
			//是否是核销商品
			var isHx = $.trim($("input[name='isHx']:checked").val());
			//是否开启收货地址
			var isAddress = $.trim($("input[name='isAddress']:checked").val());
			//是否开启虚拟人
			var isTrueman = $.trim($("input[name='isTrueman']:checked").val());
			//虚拟支付人数
			var truemanPay = $.trim($("input[name='truemanPay']").val());
			//虚拟参与人数
			var truemanOpen = $.trim($("input[name='truemanOpen']").val());
			var flag = validate(
				name,"请输入商品名称!",
				price,"请输入价格,且价格不能为0。",
				money,"请输入佣金",
				telphone,"请输入联系方式",
				picUrl,"请上传图片",
				endTime,"请输入结束时间",
				picture,"请上传图片",
				num,"请输入商品数量",
				"佣金大于价格，请检查。",
				"该商品所需佣金大于余额可使用，请调整佣金或数量。",
				content,"请输入分享内容!",
				truemanPay,"请输入虚拟支付人数",
				truemanOpen,"请输入虚拟参与人数",
				payfont,"请输入底部购买按钮内容",
				sharefont,"请输入底部分享按钮内容"
			); 
			if(flag){
				$.ajax({
					url:"fxzGoods/add",
					type:"post",
					data:{	
						name:name,
						price:price,
						money:money,
						endTime:endTime,
						picUrl:picUrl,
						telphone:telphone,
						desc:desc,
						desc2:desc2,
						picture:picture,
						level:level,
						vertical:vertical,
						num:num,
						color:color,
						isHx:isHx,
						isAddress:isAddress,
						content:content,
						music:music,
						isTrueman:isTrueman,
						truemanPay:truemanPay,
						truemanOpen:truemanOpen,
						payfont:payfont,
						sharefont:sharefont
					},
					dataType:"json",
					success:function(data){
						if(data.flag){
							layer.msg("添加成功");
							setTimeout('goFresh("fxzGoods/list")',1000); 
						}else{
							layer.msg(data.msg);
						}
					}
				});
			}
			return false;
		});
	});
		function validate(date1,msg1,date2,msg2,date3,msg3,date4,msg4,date5,msg5,date6,msg6,date7,msg7,date8,msg8,msg9,msg10,date11,msg11,date12,msg12,date13,msg13,date14,msg14,date15,msg15){
			var yue=${yue};
			if(date1 == ''){
				layer.msg(msg1);
				return false;
			}else if(date2 == ''||date2==0){
				layer.msg(msg2);
				return false;
			}else if(date3 == ''){
				layer.msg(msg3);
				return false;
			}else if(date4 == ''){
				layer.msg(msg4);
				return false;
			}else if(date5 == ''){
				layer.msg(msg5);
				return false;
			}else if(date6 == ''){
				layer.msg(msg6);
				return false;
			}else if(date7 == ''){
				layer.msg(msg7);
				return false;
			}else if(date8 == ''||date8<=0){
				layer.msg(msg8);
				return false;
			}else if(parseFloat(date2)<=parseFloat(date3)){
				layer.msg(msg9);
				return false;
			}else if((date3*date8)>yue){
				layer.msg(msg10);
				return false;
			}else if(date11 == ''){
				layer.msg(msg11);
				return false;
			}else if(date12 == ''){
				layer.msg(msg12);
				return false;
			}else if(date13 == ''){
				layer.msg(msg13);
				return false;
			}else if(date14 == ''){
				layer.msg(msg14);
				return false;
			}else if(date15 == ''){
				layer.msg(msg15);
				return false;
			}
			return true;
		}
		var editor;
			KindEditor.ready(function(K) {
				K.options.items=['source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
					'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
					'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
					'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
					'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
					'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 
					'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'pagebreak',
					'anchor', 'link', 'unlink', '|', 'about'];
				editor = K.create('textarea[name="desc"]', {
					cssPath : 'manager/js/plugins/code/prettify.css',
					uploadJson : '/plugin/fileUploads',
					allowFileManager : false,
					afterBlur:function(){this.sync();},
				});
				editor = K.create('textarea[name="desc2"]', {
					cssPath : 'manager/js/plugins/code/prettify.css',
					uploadJson : '/plugin/fileUploads',
					allowFileManager : false,
					afterBlur:function(){this.sync();},
				});
			});
			Date.prototype.toLocaleString = function() {
         		return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() + " " + this.getHours() + ":" + this.getMinutes() + ":" + this.getSeconds();
         	};
			var da = new Date();
			var end = da.valueOf()+604800000;
			var date1 = new Date(end);
			$("#end").val(date1.toLocaleString());
			
			
</script>
</html>
