/**
 * 根据控件id获取控件名称
 */
function getWidgetTypeName(type) {
	if (type == 1) {
		return "内容列表";
	} else if (type == 2) {
		return "图片";
	} else if (type == 3) {
		return "内容 ";
	} else if (type == 4) {
		return "栏目列表";
	} else if (type == 5) {
		return "当前位置";
	} else if (type == 6) {
		return "简介";
	} else if (type == 7) {
		return "栏目信息";
	} else if (type == 8) {
		return "文本";
	} else if (type == 9) {
		return "翻页内容列表";
	} else if (type == 10) {
		return "推荐文章";
	} else if (type == 11) {
		return "权限树";
	} else if (type == 12) {
		return "权限输出";
	} else if (type == 13) {
		return "内容信息";
	} else if (type == 14) {
		return "表单信息";
	} else if (type == 15) {
		return "防伪码";
	} else if (type == 16) {
		return "授权查询";
	} else {
		return type;
	}
}