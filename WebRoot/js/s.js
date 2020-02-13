
/**
 * 显示时间 2016年05月30日 星期一 10:20:01
 */
function showTime(id) {
	var show_day = new Array('星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日');
	var time = new Date();
	var year = time.getFullYear();
	var month = time.getMonth() + 1;
	;
	var date = time.getDate();
	var day = time.getDay();
	var hour = time.getHours();
	var minutes = time.getMinutes();
	var second = time.getSeconds();
	month < 10 ? month = '0' + month : month;
	hour < 10 ? hour = '0' + hour : hour;
	minutes < 10 ? minutes = '0' + minutes : minutes;
	second < 10 ? second = '0' + second : second;
	var now_time = year + '年' + month + '月' + date + '日' + ' ' + show_day[day - 1] + ' ' + hour + ':' + minutes + ':' + second;
	document.getElementById(id).innerHTML = now_time;
	setTimeout("showTime('" + id + "');", 1000);
}

/**
 * 加入收藏
 */
function addFavorite() {
	var url = window.location;
	var title = document.title;
	try {
		window.external.addFavorite(url, title);
	} catch (e) {
		try {
			window.sidebar.addPanel(title, url, "");
		} catch (e) {
			alert("浏览器不支持此操作！");
		}
	}
}

/**
 * 设置首页
 * @param obj
 */
function setHome(event) {
	var url = window.location;
	try {
		event.style.behavior = 'url(#default#homepage)';
		event.setHomePage(url);
	} catch (e) {
		if (window.netscape) {
			try {
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
			} catch (e) {
				alert("浏览器不支持此操作！");
			}
		}else {
			try {
				var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
				prefs.setCharPref('browser.startup.homepage', url);
			} catch (e) {
				alert("浏览器不支持此操作！");
			}
		}
	}
}

function divMenu() {
	$('.menu .sub').css("display", "none");
	$(".menu").find('li').each(function() {
	    $(this).mouseover(function() {
	        $(this).find('.sub').css("display", "block");
	    });
	    $(this).mouseout(function() {
	        $(this).find('.sub').css("display", "none");
	    });
	});
	
	var aPaddingLeft = parseInt($('.menu .sub').find("a:eq(0)").css("paddingLeft").replace('px', ''));
	$('.menu .sub').each(function(index) {
        var subnav = $(this);
        // 删除不包含链接的
        subnav.find(".content:not(:has(a))").remove();
        var maxAWidth = 150,
            maxHeight = 0;
        subnav.find("a").each(function() {
            maxAWidth = Math.max(maxAWidth, $( this).text().length * 15);
            maxAWidth = Math.min(maxAWidth, 180); // 存在英文
        }); 
        var contents = subnav.find('.content');
        contents.each(function(index) {
            $(this).width(maxAWidth);
            $(this).find("a").width(maxAWidth - aPaddingLeft); // 这里padding-left的值会改变整个宽度
            maxHeight = Math.max(maxHeight, $(this).height());
            // 添加分隔栏
            if (index < contents.length - 1) {
                $(this).after("<div class='content dividerBox'><div class='divider'/></div>");
            }
        });
        
    });
}