/*author：snuser  return array ,  need tool about 'dateFormat.js' */

/*

 ex:

 date = new Date();

 console.log( date.dateChange( "lastmonth" ) );

 */

function dateChange(part) {

	var beginTime;

	var now = new Date();

	var month = now.getMonth();

	var year = now.getFullYear();

	var day = now.getDate();

	var wday = now.getDay;

	function unsetTime(thisdate) {

		thisdate.setUTCHours(0);

		thisdate.setUTCMinutes(0);

		thisdate.setUTCSeconds(0);

	}

	switch (part) {

	// 最近7天

	case "lastsevendays":
		now.beginTime = new Date(now.setDate(day - 7)).pattern("yyyy-MM-dd HH:mm:ss");

		now.endTime = new Date(now.setDate(day)).pattern("yyyy-MM-dd HH:mm:ss");

		break;

	// 最近一个月

	case "recentmonth":

		now.endTime = new Date(now.setDate(day)).pattern("yyyy-MM-dd HH:mm:ss");

		now.beginTime = new Date(now.setDate(day - 30)).pattern("yyyy-MM-dd HH:mm:ss");

		break;

	default:

		now.endTime = null;
		now.beginTime = null;

		break;

	}

	return now;

}

Date.prototype.pattern = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, // 月份
		"d+" : this.getDate(), // 日
		"h+" : this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, // 小时
		"H+" : this.getHours(), // 小时
		"m+" : this.getMinutes(), // 分
		"s+" : this.getSeconds(), // 秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
		"S" : this.getMilliseconds()
	// 毫秒
	};
	var week = {
		"0" : "/u65e5",
		"1" : "/u4e00",
		"2" : "/u4e8c",
		"3" : "/u4e09",
		"4" : "/u56db",
		"5" : "/u4e94",
		"6" : "/u516d"
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	if (/(E+)/.test(fmt)) {
		fmt = fmt
				.replace(
						RegExp.$1,
						((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f"
								: "/u5468")
								: "")
								+ week[this.getDay() + ""]);
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}
