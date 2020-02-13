//属性值改变
function propChange(event,id) {
	var drag = $('#'+id);
	var propName = $(event).attr('name');
	var val = $(event).val();
	
	if(propName == 'name') {
		
	}else if(propName == 'width') {
		drag.css('width',val);
	}else if(propName == 'height') {
		drag.css('height',val);
	}else if(propName == 'value') {
		drag.text(val);
		drag.val(val);
	}else if(propName == 'fontSize') {
		drag.css('font-size',val+"px");
	}
}

//初始化拾色器，并回显值
function initColorpicker(colorId,id) { 
	$('#'+colorId).colorpicker().on('changeColor', function(ev){
		var drag = $('#'+id);
		var propName = $('#'+colorId).attr('name');
		drag.attr('form-data-'+propName,ev.color.toHex());
		drag.css('color',ev.color.toHex());
	});
}

function removeElement(event,id) {
	removeElementById(id,event);
}

//FormElement
var FE = function() {
	return {
		//绑定元素点击事件，打开属性页面
		bindProp : function(cp,id,type,json) {
			var url = cp+'/store/form/'+type+'.jsp?id='+id;
			if(json) {
				url += "&eleId=" + json.id;
			}
			$('#'+id).webuiPopover({
				type : 'async',
			    url : url,
			    closeable : true,
			    dismissible:false,
			    multi : true,
			    async : {
			    	type : 'GET',
			    	success: function(that, data) {
				    	//如果json不是空,回显数据
						if(json) {
							FormUtil.toForm("#element_"+id,json);
							$('#'+id).webuiPopover('hide');
						}
				    }
			    }
		    });
			//初始化就显示
			$('#'+id).webuiPopover('show');
		},
		//获取对应类型元素
		getElement : function(id,type) {
			var html = "";
			if(type == 'inputText') {
				html = "<input id='"+id+"' type='text' class='form-data draggable form-control' style='position:absolute;width:200px;'>";
			}else if(type == 'label') {
				html = "<label id='"+id+"' class='form-data draggable control-label' style='position:absolute;'>名称</label>";
			}else if(type == 'select') {
				html = "<select id='"+id+"' class='form-data draggable form-control' style='position:absolute;width:200px;'></select>";
			}else if(type == 'checkbox') {
				html = "<input id='"+id+"' type='checkbox' class='form-data draggable form-control' style='position:absolute;width:20px;height:20px;'>";
			}else if(type == 'textArea') {
				html = "<textarea id='"+id+"' class='form-data draggable form-control' style='position:absolute;width:200px;height:100px;'></textarea>";
			}else if(type == 'inputPassword') {
				html = "<input id='"+id+"' type='password' class='form-data draggable form-control' style='position:absolute;width:200px;'>";
			}
			return html;
		},
		//根据int类型获取字符串类型
		getElementTypeString : function(type) {
			//1.inputText,2.textArea3.inputPassword4.radio5.checkbox6.select7.uploadImage8.lable9.container
			switch(type)
			{
			case 1:
			  return "inputText";
			case 2:
				return "textArea";
			case 3:
				return "inputPassword";
			case 4:
				return "radio";
			case 5:
				return "checkbox";
			case 6:
				return "select";
			case 7:
				return "uploadImage";
			case 8:
				return "label";
			case 9:
				return "container";
			default:
				return "";
			}
		}
	};
}();

var FormUtil = function() {
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

			return params;
		},
		toForm : function(formid, json) {
			if (!json) {
				json = {};
			}
			var form = formid ? $(formid) : $('form');
			
			// text
			form.find("input[type='text']").each(function() {
				var name = $(this).attr("name");
				$(this).val(json[name]);
			});
			
			// text
			form.find("textarea").each(function() {
				var name = $(this).attr("name");
				$(this).val(json[name]);
			});
			
			// checkbox
			form.find("input[type='checkbox']").each(function() {
				var name = $(this).attr("name");
				if (json[name]) {
					$(this).attr('checked','checked');
				}
			});
			
			// select
			form.find("select").each(function() {
				var name = $(this).attr("name");
				$(this).val(json[name]);
			});
		}
	};
}();

//FormController
function Form() {
	this.draggies = new ArrayList();
	var cp;
	var formId;
	var addCount = 1;	//id自增
	var attrFormType = "eleType";
	var formContainer = "#formContainer";
	var draggable = ".draggable";
	var webuiPopover = ".webui-popover";
	
	var getId = function() {
		var dragId = "drag_"+addCount++;
		return dragId;
	}
	
	var bindDraggable = function(id,json) {
		var drag = $('#'+id);
		var draggables = drag.draggabilly({
		    containment: true,
		    grid: [ 10, 1 ]
		});
		drag.on('dragEnd', function(event, pointer) {
	    	drag.attr('form-data-x',pointer.x);
			drag.attr('form-data-y',pointer.y);
	    });
		//如果json不是空,回显数据
		if(json) {
			drag.attr('form-data-x',json.x);
			drag.attr('form-data-y',json.y);
		}
	}
	
	//新增元素方法,json回显数据
	var newElement = function(type,json) {
		var id = getId();
		
		var newDrag = FE.getElement(id,type);
		$(formContainer).append(newDrag);
		
		//如果json不是空,回显数据
		if(json) {
			$("#"+id).attr('style',json.css);
			$("#"+id).val(json.value);
			$("#"+id).text(json.value);
		}
		//绑定拖拽
		bindDraggable(id,json);
		//绑定显示属性
		FE.bindProp(cp,id,type,json);
		return id;
	}
	
	var removeFormElement = function(id){
		$(formContainer).find('#'+id).remove();
	}
	
	var removePropElement = function(event){
		$(event).parent('.element').parent().parent().parent().remove();
	}
	
	this.removeElementById = function(id,event){
		removeFormElement(id);
		removePropElement(event);
	}
	
	this.clear = function(data) {
		$(formContainer).empty();
		$(webuiPopover).remove();
	}
	
	this.validate = function(json) {
		var f = true;
		
		for(var i = 0;i<json.length;i++) {
			var item = json[i];
			//检查是空值,类型不是标签
			if(!item.name && item.type != 8) {
				alert("字段名称不能为空！");
				f = false;
				return f;
			}
			
			for(var j = 0;j<json.length;j++) {
				var item2 = json[j];
				//检查名称是不是重复，排除自己
				if(item.type != 8 && i != j && item.name == item2.name ) {
					alert("字段名称不能重复！");
					f = false;
					return f;
				}
			}
		}
		
		return f;
	}
	
	//回显值
	this.echoElements = function(data) {
		//回显清空值
		clear();
		
		for(var i = 0;i<data.length;i++) {
			var json = data[i];
			var id = newElement(FE.getElementTypeString(json.type),json);
		}
	}
	
	//绑定左侧点击新增元素
	this.init = function(path,_formId) {
		cp = path;
		formId = _formId;
		//初始化清空
		clear();
		$("button["+attrFormType+"]").click(function(event){
			var type = $(event.target).attr(attrFormType);
			newElement(type);
		});
		//点击容器，取消显示属性窗口
		$(formContainer).click(function(event){
			$('.draggable').webuiPopover('hide');
		});
	}
	
	//获取数据回显值
	this.ajaxData = function() {
		$.ajax({
			url: cp+"/form_element/json/"+formId,
			type:"post",
			success:function(data){
				if(data.flag){
					//获取表单元素数据，并回显
					echoElements(data.data);
					layer.closeAll('loading');
				}else{
					layer.msg(data.msg);
					layer.closeAll('loading');
				}
			}
		});
	}
	
	//获取所有元素json值
	this.getAllElementsJson = function() {
		var elements = new ArrayList();
		$(formContainer).find('.draggable').each(function(e,i){
			var obj = {};
			var attrs = this.attributes;
			var formId = "element_"+$(this).attr('id');
			obj.x = $(this).attr('form-data-x');
			obj.y = $(this).attr('form-data-x');
			obj.css = $(this).attr('style');
			
			var form = FormUtil.toJson("#"+formId,obj);
			
			//特殊处理options，去掉空格回车
			if(form.options) {
				form.options = form.options.replace(/[\r\n]/g,"");
			}
			
			elements.add(form);
		});
		return elements.datas;
	}
	return this;
}
