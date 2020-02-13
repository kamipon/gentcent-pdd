//FormElement
var FE = function() {
	return {
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
		},
		//必填项目没填，边框变红
		bindRequired : function(id,type,json) {
			$('.form-data[required]').focusout(function(){
				if(!$(this).val()) {
					$(this).css('border-color','red');
				}else {
					$(this).css('border-color','');
				}
			});
		},
		getRequired : function(json) {
			if(json.required) {
				return "required='required'";
			}
			return "";
		},
		//初始化对应类型元素 
		initElement : function(id,type,json,formContainer) {
			var html = "";
			if(type == 'inputText') {
				html = "<input id='"+id+"' name='"+json.name+"' type='text' class='form-data form-control' "+FE.getRequired(json)+" style='position:absolute;'>";
				$(formContainer).append(html);
			}else if(type == 'inputPassword') {
				html = "<input id='"+id+"' name='"+json.name+"' type='password' class='form-data form-control' "+FE.getRequired(json)+" style='position:absolute;'>";
				$(formContainer).append(html);
			}else if(type == 'textArea') {
				html = "<textarea id='"+id+"' name='"+json.name+"' class='form-data form-control' "+FE.getRequired(json)+" style='position:absolute;'></textarea>";
				$(formContainer).append(html);
			}else if(type == 'select') {
				html = "<div style='"+json.css+"'>";
					//多选
					if(json.multipart) {
						html += "<select id='"+id+"' name='"+json.name+"' class='form-data' "+FE.getRequired(json)+" multiple='multiple'> ";
					}else {
						html += "<select id='"+id+"' name='"+json.name+"' "+FE.getRequired(json)+" class='form-data'> ";
					}
					var options = json.options.split(",");
					for(var i = 0;i<options.length;i++) {
						//修改回显值，没有值使用默认值
						if(json.update && json.data.indexOf(options[i]) > -1) {
							html += "<option value='"+options[i]+"' selected='selected'>"+options[i]+"</option>";
						}else if(!json.update && options[i] == json.value){//默认值
							html += "<option value='"+options[i]+"' selected='selected'>"+options[i]+"</option>";
						}else {
							html += "<option value='"+options[i]+"'>"+options[i]+"</option>";
						}
					}
					html += "</select>";
				html += "</div>";
				$(formContainer).append(html);
				$('#'+id).SumoSelect();
				//设置样式
				$('#'+id).parent().css('width',json.width).css('height',json.height);
				$('#'+id).parent().find('p.SelectBox').css('width',json.width+"px").css('height',json.height+"px").css('line-height',json.height-10+"px");
				$('#'+id).parent().find('div.optWrapper ul li').css('line-height',json.height-10+"px");
				$('#'+id).parent().find('div.optWrapper ul li label').css('margin-bottom',"0px");
			}else if(type == 'checkbox') {
				//修改回显值，没有值使用默认值
				if(json.update && json.data == "true") {
					html = "<input id='"+id+"' name='"+json.name+"' type='checkbox' checked='checked' class='form-data form-control' style='position:absolute;'>";
				}else if(!json.update && json.value == "true"){//默认值
					html = "<input id='"+id+"' name='"+json.name+"' type='checkbox' checked='checked' class='form-data form-control' style='position:absolute;'>";
				}else {
					html = "<input id='"+id+"' name='"+json.name+"' type='checkbox' class='form-data form-control' style='position:absolute;'>";
				}
				
				$(formContainer).append(html);
			}else if(type == 'label') {
				html = "<label id='"+id+"' class='control-label' style='position:absolute;'></label>";
				$(formContainer).append(html);
			}
			
			//css验证空值
			FE.bindRequired(id,type,json);
		}
	};
}();

//自定义表单专用
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
					params[name] = true;
				}else if(name && !checked) {
					params[name] = false;
				}
			});
			// select 
			form.find("select").each(function() {
				var select = $(this);
				var name = select.attr("name");
				if (name) {
					//多选值为：["B","C"],单选值为："B"
					var val = select.val();
					//是否多选，多选特殊处理值
					if($(this).attr('multiple')) {
						var temp = "";
						for(var v in val) {
							temp += val[v] +",";
						}
						if(temp) {
							temp = temp.substring(0,temp.length-1);
						}
						params[name] = temp;
					}else {
						params[name] = val;
					}
					
					
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
			
			// textarea
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
		},
		validation : function(formid) {
			var form = formid ? $(formid) : $('form');
			var f = true;
			form.find('.form-data[required]').each(function() {
				if (!$(this).val()) {
					$(this).css('border-color','red');
					f = false;
				}else {
					$(this).css('border-color','');
				}
			});
			return f;
		}
	};
}();

//FormController
function Form(_cp,_formId) {
	var cp = _cp;
	var formId = _formId;
	var addCount = 1;	//id自增
	var formContainer = "#formContainer";
	var draggable = ".draggable";
	
	var getId = function() {
		var dragId = "drag_"+addCount++;
		return dragId;
	}
	
	
	//新增元素方法,json回显数据
	var newElement = function(type,json) {
		var id = getId();
		
		//初始化元素
		FE.initElement(id,type,json,formContainer);
		
		//如果json不是空,回显数据
		if(json) {
			if(type != 'select'){
				$("#"+id).attr('style',json.css);
				//修改数据回显值,不是使用默认值
				if(json.update) {
					$("#"+id).val(json.data);
					$("#"+id).text(json.data);
				}else {
					$("#"+id).val(json.value);
					$("#"+id).text(json.value);
				}
			}
			
		}
		return id;
	}
	
	//回显元素值
	this.echoElements = function(data) {
		for(var i = 0;i<data.length;i++) {
			var json = data[i];
			var id = newElement(FE.getElementTypeString(json.type),json);
		}
	}
	
	//获取数据回显值
	this.ajaxData = function(busiId,callBack) {
		var url = cp+"/form_element/json/"+formId;
		if(busiId) {
			//修改回显数据
			url = cp+"/form_element/json/"+busiId+"/"+formId; 
		}
		$.ajax({
			url: url,
			type:"post",
			success:function(data){
				//先清空表单
				$(formContainer).empty();
				if(data.flag){
					//获取表单元素数据，并回显
					echoElements(data.data);
					if(callBack) {
						callBack();
					}
					layer.closeAll('loading');
				}else{
					layer.msg(data.msg);
					layer.closeAll('loading');
				}
			}
		});
	}
	
	this.getJson = function() {
		var elements = FormUtil.toJson('#'+formId,null);
		
		elements = JSON.stringify(elements);
		
		var f = FormUtil.validation('#'+formId);
		if(!f) {
			alert("表单还有必填项！");
			return null;
		}
		
		return elements;
	}
	
	return this;
}
