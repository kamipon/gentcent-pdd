var Form = function() {
	return {
		// form转json
		toJson : function(formid, params) {
			if (!params) {
				params = {};
			}
			var form = formid ? $(formid) : $('form');
			var paramArray = form.serializeArray();

			// normal
			$(paramArray).each(function() {
				params[this.name] = this.value;
			});

			// radio
			form.find("input[type='radio']").each(function() {
				var name = $(this).attr("name");
				var checked = $(this).prop("checked");
				if (name && checked) {
					params[name] = $(this).val();
				}
			});
			
			// checkbox
			form.find("input[type='checkbox']").each(function() {
				var name = $(this).attr("name");
				var checked = $(this).prop("checked");
				if (name && checked) {
					params[name] = $(this).val();
				}
			});
			// select
			form.find("select").each(function() {
				var select = $(this);
				var name = select.attr("name");
				if (name) {
					var val = select.val();
					params[name] = val;
				}
			});
			// other

			// Summernote
			form.find("div[class='summernote']").each(function() {
				var name = $(this).attr("name");
				var id = $(this).attr("id");
				if (name) {
					params[name] = $("#" + id).summernote('code');
				}
			});

			return params;
		}
	};
}();

function changeCaptcha(id) {
	$('#' + id).attr("src", $('#' + id).attr("src") + "?" + Math.random());
}

function ajaxSubmit(formId, captchaImg,success,error) {
	var form = $('#' + formId);
	var url = form.attr('action');
	var captcha = $('#captcha').val();
	var json = Form.toJson('#' + formId);
	json = JSON.stringify(json);
	$.ajax({
		url : url,
		type : "post",
		data : {
			json : json,
			captcha : captcha
		},
		dataType : "json",
		success : success,
		error : error
	});
}

function formSubmit(formId,captchaImg) {
	ajaxSubmit(formId,captchaImg,function(data) {
		changeCaptcha(captchaImg);
		if (data.flag) {
			alert(data.msg);
			window.location.href = window.location.href;
		} else {
			alert(data.msg);
		}
	});
}

function queryCertificate(formId,captchaImg,showId,apiUrl) {
	ajaxSubmit(formId,captchaImg,function(data) {
		changeCaptcha(captchaImg);
		if (data.flag) {
			$('#'+showId).attr('src',apiUrl+"/"+data.src);
		} else {
			$('#'+showId).attr('src','');
			alert(data.msg);
		}
	});
}

function Uploader() {
	
	var source;
	/**
	 * select 			string,必填，选择按钮id
	 * viewDiv 			string,必填，回显数据div
	 * url 				string,必填，上传地址
	 * relPath 			string,必填，控件资源地址
	 * upload 			string,可选，默认选择自动上传。上传按钮id
	 * single 			boolean,可选，是不是只能上传单张
	 * isImage 			boolean,可选，默认false,true会回显图片
	 * progress 		boolean,可选，默认false,true会显示进度条
	 */
	var user_options = {};
	var up_options = {};
	var uploadedCallBack;	//必填 	function，上传完成回调方法
	var removeCallBack;		//可选 	function，删除上传回调方法
	var removeButton = "removeFile_";
	var viewName = "viewName_";
	var progress_ = "progress_";
	var wrap = "wrap_";
	
	//上传参数默认初始化
	up_options.multi_selection = false;	//多选
	up_options.filters = {
			max_file_size : '1mb',		//默认1mb
			prevent_duplicates : true,	//文件不可重复
			mime_types: []
	}
	up_options.resize = {};
	user_options.isImage = false;
	user_options.progress = false;
	/**
	up_options.resize = {
		  width: 200,
		  height: 200,
		  crop: true,
		  quality: 70,
		  preserve_headers: true
	} */
	
	
	/************************/
	
	//删除文件
	var deleteFile = function(uploader, file) {
		uploader.removeFile(file);	//删除文件
		$('#'+wrap+file.id).remove();	//删除显示
	}
	
	
	var copyProperties = function(source,target) {
		for(var key in source) {
			if(source[key]) {
				target[key] = source[key];
			}
		}
	}
	
	var removeOtherFile = function(uploader,file) {
		var _files = uploader.files;
		for(var i = 0;i<_files.length;i++) {
			var _file = _files[i];
			if(_file.id != file.id) {
				deleteFile(uploader, _file);
			}
		}
	}
	
	
	/************************/
	
	var initUploader = function() {
		source = new plupload.Uploader({
			browse_button : user_options.select, 							//触发按钮id
			runtimes : 'html5,flash,silverlight,html4',						//上传方式
			// container: document.getElementById('container'), 			//父容器，不填默认browse_button父元素
			multi_selection : up_options.multi_selection,						//文件不能多选
			url : user_options.url,												//上传地址
			flash_swf_url : user_options.relPath+'/js/plugins/plupload/js/Moxie.swf',		//plugin
			silverlight_xap_url : user_options.relPath+'/js/plugins/plupload/js/Moxie.xap',//plugin
			multipart : true,												//multipart/form-data形式上传
			unique_names : false, 											//自动改名让名称唯一
			filters : up_options.filters,
			resize : up_options.resize,
			init: {
				
			}
		});
		
		//初始化控件
		source.init();
		
		source.bind("PostInit", bindPostInit, uploader);
		source.bind("FilesAdded", bindFilesAdded, uploader);
		source.bind("FileUploaded", bindFileUploaded, uploader);
		if(user_options.progress) {
			
		}
		source.bind("UploadProgress", bindUploadProgress, uploader);
		source.bind("Error", bindError, uploader);
		
		return source;
	}
	
	
	//初始化完成
	var bindPostInit = function(uploader){
		$('#'+user_options.viewDiv).empty();
		
		//如果手动上传不为null
		if(user_options.upload) {
			//绑定上传
			$('#'+user_options.upload).click(function(){
				uploader.start();
			});
		}
	}
	
	//增加文件列表
	var bindFilesAdded = function(uploader, files){
		plupload.each(files, function(file) {
			var deleteButton = "<a id='"+removeButton+file.id+"' href='javascript:void(0)'>删除</a>";
			var spanName = "<span id='"+viewName+file.id +"'>"+file.name+"</span>";
			var spanProgress = "<span id='"+progress_+file.id+"'></span>";
			
			var html = "<div id='"+wrap+file.id +"' >";
			html += spanName
			html += spanProgress;
			html += deleteButton
			html += "</div>";
			
			//如果是单张覆盖，不是追加
			if(user_options.single) {
				$('#'+user_options.viewDiv).html(html);
				//删除队列其他文件
				removeOtherFile(uploader,file);
			}else {
				$('#'+user_options.viewDiv).append(html);
			}
			
			
			//绑定删除文件事件
			$('#'+removeButton+file.id).click(function(){
				//删除之前，调用回调
				if(removeCallBack) {
					removeCallBack(file);
				}
				deleteFile(uploader, file);
			});
			
			//如果手动上传是null，自动上传
			if(!user_options.upload) {
				uploader.start();
			}
		});
	}
	
	//单个上传完成
	var bindFileUploaded = function(uploader, file,response) {
		var data = JSON.parse(response.response);
		data = data.items;
		file.response = data;
		
		//上传出错
		if(data.error == 1) {
			deleteFile(uploader, file);
			alert(data.msg);
		}
		
		$('#'+viewName+file.id).html('');
		var view = file.name;
		//如果是图片，显示预览图
		if(user_options.isImage) {
			view = "<img alt='"+file.name+"' src='"+data.fileUrl+"' style='width:50px;height:50px;'>";
		}
		$('#'+viewName+file.id).html(view);
		
		//处理回调方法处理值
		if(uploadedCallBack) {
			uploadedCallBack(file);
		}
		
	}
	
	//进度条
	var bindUploadProgress = function(uploader, file) {
		$('#'+progress_+file.id).html(file.percent+"%");
	}
	
	//上传出错
	var bindError = function(uploader, err) {
		alert("出错文件：" + err.file.name + "\n 出错信息：" + err.message);
	}
	
	
	/************************/
	
	//初始化控件
	this.init = function(_user_options,_up_options,_uploadedCallBack,_removeCallBack) {
		if (!_user_options.select || !_user_options.viewDiv || !_user_options.url || !_user_options.relPath || !_uploadedCallBack) {
			alert("初始化控件参数出错！");
			return;
		}
		
		//复制参数属性
		copyProperties(_up_options,up_options);
		copyProperties(_user_options,user_options);
		uploadedCallBack = _uploadedCallBack;
		removeCallBack = _removeCallBack;
		
		//是不是图片，图片限制上传类型，图片显示预览图
		if(user_options.isImage) {
			up_options.filters.mime_types = [{title : "Image files", extensions : "jpg,jpeg,gif,png,ico"}];
		}
		
		//是不是单张上传，限制参数
		if(user_options.single) {
			up_options.multi_selection = false;
		}
		initUploader();
		return this;
	}
	
	return this;
}
