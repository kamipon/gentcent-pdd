$(document).ready(function(){
	//获得当前时间
	var myDate = new Date();
	//获得年份
	var year = myDate.getFullYear();
	//获得月份
	var month =  myDate.getMonth()+1;
	//获得日期
	var date = myDate.getDate();
	//获得星期
	var day = myDate.getDay();
	switch(day){
		case 1:
			day = "一";
			break;
		case 2:
			day = "二";
			break;
		case 3:
			day = "三";
			break;
		case 4:
			day = "四";
			break;
		case 5:
			day = "五";
			break;
		case 6:
			day = "六";
			break;
		case 7:
			day = "天";
			break;
	}
	$('#time').html("现在时间:"+year+"年"+month+"月"+date+"日     星期"+day);
	var currentId=getCookie("leftfocus");
	if(currentId!=""&&currentId){
		$("#"+currentId).attr("class","focusli");
	}
})
function changeLeftClass(_this){
	setCookie("leftfocus",_this.id);
}