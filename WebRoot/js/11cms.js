var Ajax = function() {
	return {
		/**
		 * @param layer
		 *            如果是模态，传入layer
		 */
		ajax : function(url, type,dataType, _async, params, callback, errorCallback, layer) {
			if(!type) {
				type = "POST";
			}
			if(!_async) {
				_async = true;
			}
			if(!params) {
				params = {};
			}
			if (layer) {
				layer.load();
			}
			$.ajax({
				type : type,
				dataType:dataType,
				url : url,
				async : _async,
				data : params,
				cache : false,
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					if (layer) {
						layer.closeAll('loading');
					}
				},
				success : function(response) {
					if (layer) {
						layer.closeAll('loading');
					}
					// session失效
					if (response.msg == "login") {
						window.location.href = window.location.href;
					} else if (callback) {
						callback(response);
					} else {
						alert("成功！");
					}
				},
				error : function(response) {
					if (layer) {
						layer.closeAll('loading');
					}
					// session失效
					if (response.msg == "login") {
						window.location.href = window.location.href;
					} else if (errorCallback) {
						errorCallback(response);
					}else {
						alert("您的网络不稳定，请稍后重新发送");
					}
				}
			});
		},
		post : function(url, params, callback, errorCallback, layer) {
			Ajax.ajax(url, "POST","json", true, params, callback, errorCallback, layer);
		},
		get : function(url, params, callback, errorCallback, layer) {
			Ajax.ajax(url, "GET","json", true, params, callback, errorCallback, layer);
		}
	};
}();

var Page = function() {
	return {

	};
}();

var PageBar = function() {
	return {
		/**
		 * id 外层div id page 翻页信息 callback 回调获取数据方法 param 回调方法的参数
		 */
		init : function(id, page, callback, param) {
			function gotoPage() {
				var pageIndex = parseInt(document.getElementById(id + '_pageIndex').value);
				if (isNaN(pageIndex)) {
					alert("请输入数字");
					return;
				}
				if (pageIndex > page.totalPage || pageIndex < 1) {
					alert("无此页");
					return;
				}
				param.pageIndex = pageIndex;
				callback(param);
			}
			;
			function gotoPage2(pageIndex) {
				param.pageIndex = pageIndex;
				callback(param);
			}
			;
			function buildPage() {
				var container = $('#' + id);
				container.empty();
				var html = "";

				html += "共 " + page.total + "条 页次: <font color='red'> " + page.pageIndex + "</font>/" + page.totalPage + "页 每页" + page.pageSize + "条";
				if (page.pageIndex == 1) {
					html += "首页";
				} else {
					html += "<a id='" + id + "_firstPage' href='javascript:void(0);'>首页</a>";
				}
				if ((page.pageIndex - 1) > 0) {
					html += "<a id='" + id + "_prevPage' href='javascript:void(0);'>上一页</a>";
				} else {
					html += "上一页 ";
				}
				if ((page.pageIndex + 1) <= page.totalPage) {
					html += "<a id='" + id + "_nextPage' href='javascript:void(0);'>下一页</a>";
				} else {
					html += "下一页 ";
				}
				if (page.pageIndex >= page.totalPage) {
					html += "尾页";
				} else {
					html += "<a id='" + id + "_lastPage' href='javascript:void(0);'>尾页</a> ";
				}
				html += "转到： <input id='" + id + "_pageIndex' type='text' style='width: 30px;' /> <a id='" + id + "_jumpPage' href='javascript:void(0)'>确定</a>"

				container.html(html);
				bindEvent();
			}
			;
			function bindEvent() {
				$('#' + id + '_firstPage').click(function() {
					gotoPage2(1);
				});
				$('#' + id + '_lastPage').click(function() {
					gotoPage2(page.totalPage);
				});
				$('#' + id + '_prevPage').click(function() {
					gotoPage2(page.pageIndex - 1);
				});
				$('#' + id + '_nextPage').click(function() {
					gotoPage2(page.pageIndex + 1);
				});
				$('#' + id + '_jumpPage').click(function() {
					gotoPage();
				});
				$('#' + id + '_pageIndex').bind('keypress', function(event) {
					if (event.keyCode == "13") {
						gotoPage();
					}
				});
			}
			buildPage();
		}
	};
}();

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

var Summernote = function() {
	return {
		// form转json
		init : function(id, rootPath) {
			// 初始化文本框编辑器
			$("#" + id).summernote({
				lang : "zh-CN",
				height : 200,
				callbacks : {
					// 修改富文本原有的上传文件
					onImageUpload : function(files) {
						sendFile(files[0], this);
					}
				}
			});
			// 富文本上传图片
			function sendFile(file, el) {
				var formData = new FormData();
				formData.append("photo", file);
				var fileData = URL.createObjectURL(file);
				$(el).summernote('insertImage', fileData, function($image) {
					$.ajax({
						url : rootPath + "/resource/uploadGoodImg",
						data : formData,
						cache : false,
						contentType : false,
						processData : false,
						dataType : "text",
						type : 'POST',
						success : function(data) {
							var datas = eval("(" + data + ")");
							if (datas.error == "1") {
								$image.attr('src', datas.url);
								// alert(datas.url);
							} else {
								$image.attr('src', datas.url);
							}
						}
					});
				});
			}
			;

		}
	};
}();

/**
	<script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${cp }/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
 */
var UEEditor = function() {
	return {
		/**
		 * prefixUrl 项目路径
		 * id	UEEditor id
		 */
		init : function(prefixUrl,id,content) {
			//重新设置上传路径
			function localUploadUrl() {
				UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
				UE.Editor.prototype.getActionUrl = function(action) {
				    if (action == 'uploadimage' || action == 'uploadscrawl') {
				        return prefixUrl+'/upload/image/';
				    } else if (action == 'uploadvideo' || action == 'uploadfile' || action == 'uploadfile') {
				        return prefixUrl+'/upload/file/';
				    } else {
				        return this._bkGetActionUrl.call(this, action);
				    }
				}
			}
			
			localUploadUrl();
			
			var editor = UE.getEditor(id);
			
			
			editor.ready(function(){
				//如果有回显值，回显数据
				if(content) {
					editor.setContent(content);
				}
			})
			
			
			return editor;
		}
	};
}();

/**
 * <link rel="stylesheet" href="${cp }/js/plugins/codemirror/lib/codemirror.css">
	<link rel="stylesheet" href="${cp }/js/plugins/codemirror/addon/display/fullscreen.css">
	<link rel="stylesheet" href="${cp }/js/plugins/codemirror/theme/eclipse.css">
	<script src="${cp }/js/plugins/codemirror/lib/codemirror.js"></script>
	<script src="${cp }/js/plugins/codemirror/addon/fold/xml-fold.js"></script>
	<script src="${cp }/js/plugins/codemirror/addon/edit/matchtags.js"></script>
	<script src="${cp }/js/plugins/codemirror/addon/selection/active-line.js"></script>
	<script src="${cp }/js/plugins/codemirror/mode/xml/xml.js"></script>
	<script src="${cp }/js/plugins/codemirror/addon/display/fullscreen.js"></script>
 */
var CodeView = function() {
	return {
		init : function(id) {
			function makeMarker() {
				var marker = document.createElement("div");
				marker.style.color = "#822";
				marker.innerHTML = "●";
				return marker;
			}

			var editor = CodeMirror.fromTextArea(document.getElementById(id), {
				lineNumbers : true,
				styleActiveLine : true,
				theme : "eclipse",
				matchTags : {
					bothTags : true
				},
				gutters : [ "CodeMirror-linenumbers", "breakpoints" ],
				extraKeys : {
					"F11" : function(cm) {
						cm.setOption("fullScreen", !cm.getOption("fullScreen"));
					},
					"Esc" : function(cm) {
						if (cm.getOption("fullScreen"))
							cm.setOption("fullScreen", false);
					}
				}
			});

			editor.on("gutterClick", function(cm, n) {
				var info = cm.lineInfo(n);
				cm.setGutterMarker(n, "breakpoints", info.gutterMarkers ? null : makeMarker());
			});
			return editor;
		}
	};
}();



/**
 * <link rel="stylesheet" href="${cp }/store/css/zTreeStyle/zTreeStyle.css" type="text/css">
 * <script type="text/javascript" src="${cp }/store/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${cp }/store/js/jquery.ztree.excheck.min.js"></script>
 */
function Tree() {
	
	//zTree原型
	var source;
	/**
	 * options.id			//必填	String		容器id或者form input id
	 * options.type			//可选	String		(tree,form)	默认tree		类型是树，还是表单取值
	 * options.url			//必填	String      获取数据url
	 * options.check		//可选	{}			默认没有		check配置
	 * options.autoParam	//可选	String 		默认[]		是否是异步获取值,	例子：["id=parentId"]
	 * options.expandAll	//可选	boolean		默认false	是否展开所有节点
	 * options.onClick		//onClick function	默认点击内容选中checkNode	点击回调
	 */
	var options = {
		id : '',
		type : 'tree',
		url : '',
		check: {
	        enable: false
	    },
	    autoParam : [],
	    expandAll : false
	    
	};
	var onAsyncSuccess = function(event, treeId, treeNode, msg) {
		if(options.expandAll) {
			source.expandAll(true);
		}
	}
	var onClick = function(e, treeId, treeNode) {
		if(options.check.enable) {
			source.checkNode(treeNode, !treeNode.checked, null, true);
		}
    }
	var beforeClick = function(treeId, treeNode) { }
	var onCheck = function(e, treeId, treeNode) { }
	//扩展tree方法
	/**
	 * 回显选中
	 * data 		list数据
	 * nodeKey		节点比对属性
	 * dataKey		list数据比对属性
	 */
	var reCheck	= function(data,nodeKey,dataKey) {
		var nodes = zTree.transformToArray(zTree.getNodes()); 
		var checkedNodes = [];
		//遍历回显值
		for(var i = 0;i < nodes.length; i++){ 
			var node = nodes[i];
			for(var j = 0;j < data.length; j++) {
				var nav = data[j];
				if(node[nodeKey] == nav[dataKey]){ 
    				node.checked = true; 
    				zTree.updateNode(node);
    				checkedNodes.push(node);
				}
			}
		}
		return checkedNodes;
	}
	
	/************************/
	
	var copyProperties = function(source,target) {
		for(var key in source) {
			if(source[key]) {
				target[key] = source[key];
			}
		}
	}
	
	function onBodyDown(event) {
		//不是内容区域，隐藏
		if (!(event.target.id == options.id || event.target.id == "tree_"+options.id || $(event.target).parents("#treeContainer_"+options.id).length>0)) {
			hideMenu();
		}
	}
	function showMenu() {
		var inputObj = $("#"+options.id);
		var inputOffset = $("#"+options.id).offset();
		$("#treeContainer_"+options.id).css({left:inputOffset.left + "px", top:inputOffset.top + inputObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#treeContainer_"+options.id).fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	
	/************************/
	
	var initTree = function() {
		var setting = {
			check: options.check,
		    async: {
				enable: true,
				url: options.url,
				autoParam: options.autoParam
			},
			callback: {
				onAsyncSuccess: onAsyncSuccess,
				onClick : onClick,
				beforeClick : beforeClick,
				onCheck: onCheck
			}
		};
		
		//如果是表单，构建表单容器
		if(options.type == 'form') {
			var treeUl = "<ul id='tree_"+options.id+"' class='ztree' style='margin-top:0;'></ul>"; 
			
			var treeContainer = "";
			treeContainer += "<div id='treeContainer_"+options.id+"' style='display:none; position: absolute;border: 1px solid gray;z-index: 99999;background-color: white;overflow-y: scroll;overflow-x: auto;height:600px;'>";
			treeContainer += treeUl
			treeContainer += "</div>";
			
			$("body").append(treeContainer);
			
			$("#"+options.id).click(function(){
				showMenu();
			});
			
			source = $.fn.zTree.init($("#tree_"+options.id), setting);
		}else {
			source = $.fn.zTree.init($("#"+options.id), setting);
		}
		
		//扩展回显方法
		source.reCheck = reCheck;
		return source;
	}
	
	/************************/
	
	//初始化控件
	this.init = function(_options) {
		if (!_options.url || !_options.id) {
			alert("初始化控件参数出错！");
			return;
		}
		
		//复制参数属性
		copyProperties(_options,options);
		
		//处理参数
		if(!options.check) {
			options.check = { enable: false }
		}
		
		if(options.onClick) {
			onClick = options.onClick;
		}
		if(options.beforeClick) {
			beforeClick = options.beforeClick;
		}
		if(options.onCheck) {
			onCheck = options.onCheck;
		}
		if(options.onAsyncSuccess) {
			onAsyncSuccess = options.onAsyncSuccess;
		}
		
		return initTree();
	}
	
	return this;
}
