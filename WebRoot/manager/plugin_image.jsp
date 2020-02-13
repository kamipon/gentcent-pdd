<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="${pageContext.request.contextPath}"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<head>
<script type="text/javascript" src="${cp }/js/ajaxfileupload.js"></script>
<style>
.file {
    position: relative;
    display: inline-block;
    background: #D0EEFF;
    border: 1px solid #99D3F5;
    border-radius: 4px;
    padding: 4px 12px;
    overflow: hidden;
    color: #1E88C7;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}

</style>
</head>
<div id="select_imgs" style="display: none;">
	<div class="modal-header">
		<!-- 顶部tab -->
		<ul class="module-nav modal-tab js-modal-tab">
			<li class="js-modal-tab-item js-modal-tab-icon">
				<b style="color: #1ab394" data-pane="icon" id="icons_a" class="icons_a remove_a">图片库</b>
				<span>|</span>
			</li>
			<li class="js-modal-tab-item js-modal-tab-upload">
				<b style="color: #1ab394" data-pane="upload" id="news_img" class="news_img remove_a">新图片</b>
				<span>|</span>
			</li>
			<li class="js-modal-tab-item js-modal-tab-upload">
				<b style="color: #1ab394" data-pane="upload"  class="my_imgs remove_a">我的图片库</b>
			</li>
		</ul>
	</div>
	<%--图片库--%>
	<div class="tab-pane js-tab-pane js-tab-pane-image js-image-region icon_library" id="icon_library" style="display: block;">
		<div class="widget-list">
			<div class="modal-body"  style="height: 66%;">
				<div class="js-list-filter-region clearfix ui-box" style="position: relative; min-height: 28px;">
					<div class="widget-list-filter">
						<div class="widget-image-refresh">
							<span>点击图片即可选中</span>
							<a href="javascript:;" class="js-refresh" style="color: #01AB394;" onclick="getIcons();">刷新</a>
						</div>
					</div>
				</div>
				<div class="ui-box">
					<ul class="js-list-body-region widget-image-list icons">
					</ul>
					<div class="js-list-empty-region"></div>
				</div>
			</div>
			<div class="modal-footer js-list-footer-region">
				<div class="widget-list-footer">
					<div class="pull-left">
						<a href="javascript:;" class="ui-btn ui-btn-primary js-choose-image hide">确定使用</a>
					</div>
					<div class="pagenavi">
						<a class="fetch_page next" data-page-num="2" href="javascript:void(0);" onclick="upSize();">上一页</a>
						<span class="total">共 <span class="iconCount"></span> 条，每页 <span class="iconSize"></span> 条</span>
						<span class="js-goto goto"> <span class="js-goto-input js-jump-page goto-input iconIndex" contenteditable="true" id="iconIndex"></span> <span>/ <span class="iconTotalPage"></span>页</span> </span>
						<a class="fetch_page next" data-page-num="2" href="javascript:void(0);" onclick="nextSize();">下一页</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%--上传图片--%>
	<div class="tab-pane js-tab-pane js-tab-pane-upload js-upload-region new_imgs" id="new_imgs"  style="display: none;">
		<div>
			<div class="js-upload-network-region">
				<div>
					<div class="modal-body">
						<div class="get-web-img js-get-web-img">
							<div class="control-group">
								<ul class="js-upload-image-list upload-image-list clearfix ui-sortable">
		                            <li class="fileinput-button js-add-image" style="margin: 0 0 0 0;">
		                                <a class="fileinput-button-icon show_update_imgs" href="javascript:;">+</a>
										<input class="uploadFileInput" type="file" size="45" style="width:9.5%;" name="uploadFileInput"onchange="ajaxFileUpload(this)" />
		                            </li>
			                        <p class="help-desc" style="margin:29px 0 0 0;font-size:10px;">请上传图片类型为( jpg / gif / png / ico )格式的图片</p>
		                        </ul>
								<div class="controls preview-container"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="js-upload-local-region">
				<div >
					<img src="" class="showImg" style="height:111px;margin: 0px 16px 28px 215px;" id="sss">
				   	<div class="modal-footer" style="height: 5%;">
						 <div class="modal-action pull-right">
					        <input type="button" style="width: 100px;height: 29px;" class="btn btn-primary js-upload-image" data-loading-text="上传中..." value="确定">
					    </div>
					</div>
				</div>
			</div>
		
		</div>
	</div>
	<%--我的图片库---%>
	<div class="tab-pane js-tab-pane js-tab-pane-upload js-upload-region my_icons"   style="display: none;">
		<div class="widget-list">
			<div class="modal-body"  style="height: 66%;overflow: hidden;">
				<div class="js-list-filter-region clearfix ui-box" style="position: relative; min-height: 28px;">
					<div class="widget-list-filter">
						<div class="widget-image-refresh">
							<span>点击图片即可选中</span>
							<a href="javascript:;" class="js-refresh"  onclick="getOwn();">刷新</a>
						</div>
					</div>
				</div>
				<div class="ui-box">
					<ul class="js-list-body-region widget-image-list Owns" style="margin: -27px 0 0 -15px;">
					</ul>
					<div class="js-list-empty-region"></div>
				</div>
			</div>
			<div class="modal-footer js-list-footer-region">
				<div class="widget-list-footer">
					<div class="pagenavi">
						<a class="fetch_page next" data-page-num="2" href="javascript:void(0);" onclick="upSizeOwn();">上一页</a>
						<span class="total">共 <span class="owniconCount"></span> 条，每页 <span class="owniconSize"></span> 条</span>
						<span class="js-goto goto"> <span class="js-goto-input js-jump-page goto-input owniconIndex" contenteditable="true" id="owniconIndex"></span> <span>/ <span class="owniconTotalPage"></span>页</span> </span>
						<a class="fetch_page next" data-page-num="2" href="javascript:void(0);" onclick="nextSizeOwn();">下一页</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	<%--公共图片库--%>
	var start=1;
	var size=28;
	var total=0;
	function getIcons(){
		$.ajax({
			url:"plugin/getIcons",
			type:"get",
			dataType:"json",
			data:{pageIndex:start,pageSize:size},
			success:function(result){
				var lis="";
				for(var i=0;i<result.items.items.length;i++){
					var li='<li class="widget-image-item" style="float:left; border:0px solid #000;padding: 0 22px 0px 0px;">'+
						'<div class="js-choose" title="">'+
							'<img src="'+result.items.items[i].url+'"images="'+result.items.items[i].url+'" class="widget-image-item-content" style="background-size: cover;height: 50px;width: 66px;"/>'+
							'<div class="widget-image-meta" style="text-align:center;">'+
								''+result.items.items[i].width+'x'+result.items.items[i].height+''+
							'</div>'+
							'<div class="selected-style">'+
								'<i class="icon-ok icon-white"></i>'+
							'</div>'+
						'</div>'+
					'</li>';
					lis+=li;
				}
				$(".icons").html(lis);
				total=result.items.totalCount;
				$(".iconCount").html(total);
				$(".iconSize").html(size);
				$(".iconIndex").html(start);
				$(".iconTotalPage").html(Math.ceil(total/size));
				bindIconClick();
			}
		});
	}
	function upSize(){
		if(start>1){
			start-=1;
			getIcons();
		}
	}
	function nextSize(){
		if(start<Math.ceil(total/size)){
			start+=1;
			getIcons();
		}
	}
	$(function(){
		getIcons();
	});
	function bindIconClick(){
		$(".widget-image-item-content").click(function(){
			var url=$(this).attr("images");
			layer.closeAll();
			callback(url);
		});
	}
	var callback;
	function render(call){
		layer.open({
		    type: 1,
		    skin: 'layui-layer-lan', //样式类名
		    closeBtn: 0, //不显示关闭按钮
		    shift: 2,
		    move: true,
		    area: ['700px', '415px'], //宽高
		    shadeClose: true, //开启遮罩关闭
		    content: $("#select_imgs").html()
		});
		//点击图片库
		$(".icons_a").click(function(){
			$(".my_icons").hide();
			$(".new_imgs").hide();
			$(".icon_library").show();
		});
		//点击新图片
		$(".news_img").click(function(){
			$(".icon_library").hide();
			$(".my_icons").hide();
			$(".new_imgs").show();
		});	
		//点击我的图片
		$(".my_imgs").click(function(){
			$(".icon_library").hide();
			$(".new_imgs").hide();
			$(".my_icons").show();
		});
		$(".show_update_imgs").click(function(){
			$(this).next().click();
		});
		callback=call;
		bindIconClick();
		$(".layui-layer-demo").css("top","249px");
	}
	
	<%--用户图片库--%>
	var ownstart=1;
	var ownsize=28;
	var owntotal=0;
	function getOwn(){
		$.ajax({
			url:"plugin/getOwn",
			type:"get",
			dataType:"json",
			data:{pageIndex:ownstart,pageSize:ownsize},
			success:function(result){
				var lis="";
				for(var i=0;i<result.items.items.length;i++){
					var li='<li class="widget-image-item" style="float:left; border:0px solid #000;padding: 0 22px 0px 0px;">'+
						'<div class="js-choose" title="">'+
							'<img src="'+result.items.items[i].url+'"images="'+result.items.items[i].url+'" class="widget-image-item-content" style="background-size: cover;height: 50px;width: 66px;"/>'+
							'<div class="widget-image-meta" style="text-align:center;">'+ ''+result.items.items[i].width+'x'+result.items.items[i].height+''+ '</div>'+
							'<div style="margin: 0 0 0 23px;" class="delete_images"><a href="javascript:void(0);" deletePath="'+result.items.items[i].url+'"><img  src="${cp}/images/delete.png"/></a></div>'+
							'<div class="selected-style">'+
								'<i class="icon-ok icon-white"></i>'+
							'</div>'+
						'</div>'+
					'</li>';
					lis+=li;
				}
				$(".Owns").html(lis);
				owntotal=result.items.totalCount;
				$(".owniconCount").html(owntotal);
				$(".owniconSize").html(ownsize);
				$(".owniconIndex").html(ownstart);
				$(".owniconTotalPage").html(Math.ceil(owntotal/ownsize));
				bindIconClick();
				//删除功能
				$(".delete_images").on("click",function(){
					var path = $(this).find("a").attr("deletePath");
					$.ajax({
						type:"post",
						url:"${cp}/plugin/deleteImges",
						data:{path:path},
						dataType:"json",
						success:function(data){
							if(data.flag){
								layer.msg(data.msg);
								$(".js-refresh").click();
							}else{
								layer.msg(data.msg);
								$(".js-refresh").click();
							}
						}
					});
				});
			}
		});
	}
	function upSizeOwn(){
		if(ownstart>1){
			ownstart-=1;
			getOwn();
		}
	}
	function nextSizeOwn(){
		if(ownstart<Math.ceil(owntotal/ownsize)){
			ownstart+=1;
			getOwn();
		}
	}
	$(function(){
		getIcons();
		getOwn();
	});
	function bindIconClick(){
		$(".widget-image-item-content").click(function(){
			var url=$(this).attr("images");
			layer.closeAll();
			callback(url);
		});
	}
	var callback;
	function render(call){
		layer.open({
		    type: 1,
		    skin: 'layui-layer-demo top-50', //样式类名
		    closeBtn: 0, //不显示关闭按钮
		    shift: 2,
		    move: '.layui-layer-title',
		    area: ['700px', '415px'], //宽高
		    shadeClose: true, //开启遮罩关闭
		    content: $("#select_imgs").html()
		});
		//点击图片库
		$(".icons_a").click(function(){
			$(".my_icons").hide();
			$(".new_imgs").hide();
			$(".icon_library").show();
		});
		//点击新图片
		$(".news_img").click(function(){
			$(".icon_library").hide();
			$(".my_icons").hide();
			$(".new_imgs").show();
		});	
		//点击我的图片
		$(".my_imgs").click(function(){
			$(".icon_library").hide();
			$(".new_imgs").hide();
			$(".my_icons").show();
			$(".js-refresh").click();
		});
		$(".show_update_imgs").click(function(){
			$(this).next().click();
		});
		//shanchu
		
		
		callback=call;
		bindIconClick();
		//设置layer在屏幕固定的高度
		$(".layui-layer-demo").css("top","249px");
		
		//图片上传之后的点击确定功能
		$(".btn.btn-primary.js-upload-image").click(function(){
			var url=$(this).parent().parent().prev().attr("src");
			layer.closeAll();
			callback(url);
		});
	}
	
	<%--图片上传--%>
     function ajaxFileUpload(obj) {
	     $.ajaxFileUpload({  
		     url:'${cp}/plugin/fileUploads',             //需要链接到服务器地址  
		     secureuri:false,  
		     fileElementId:"uploadFileInput",                         //文件选择框的id属性  
		     dataType: 'json',  
		     success: function (data, status){             //相当于java中try语句块的用法  
		     //data是从服务器返回来的值
		     if(data.flag){
				   $(".showImg").attr("src",data.src);
		     }else{
		    		alert(data.msg);
		     }
		     },  
		     error: function (data, status, e) {           //相当于java中catch语句块的用法  
		        alert(data.msg); 
		     }  
		     });
	     $(".remove_a").removeAttr("href");
	     $(".remove_a").removeAttr("onclick");
	    
	     $(".remove_a").click(function(){
	    	return false;
	     });
     }  
</script>