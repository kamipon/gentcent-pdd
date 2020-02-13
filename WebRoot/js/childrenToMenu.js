var _e;


$(function () {
	var parent=window.parent.document;
	function t(t) {
		var e = 0;
		return $(t).each(function () {
			e += $(this).outerWidth(!0);
		}), e;
	}
	function e(e) {
		var a = t($(e).prevAll()), i = t($(e).nextAll()), n = t($(".content-tabs",parent).children().not(".J_menuTabs")), s = $(".content-tabs",parent).outerWidth(!0) - n, r = 0;
		if ($(".page-tabs-content",parent).outerWidth() < s) {
			r = 0;
		} else {
			if (i <= s - $(e).outerWidth(!0) - $(e).next().outerWidth(!0)) {
				if (s - $(e).next().outerWidth(!0) > i) {
					r = a;
					for (var o = e; r - $(o).outerWidth() > $(".page-tabs-content",parent).outerWidth() - s; ) {
						r -= $(o).prev().outerWidth(), o = $(o).prev();
					}
				}  
			} else {
				a > s - $(e).outerWidth(!0) - $(e).prev().outerWidth(!0) && (r = a - $(e).prev().outerWidth(!0));
			}
		}
		$(".page-tabs-content",parent).animate({marginLeft:0 - r + "px"}, "fast");
	}
	function a() {
		var e = Math.abs(parseInt($(".page-tabs-content",parent).css("margin-left"))), a = t($(".content-tabs",parent).children().not(".J_menuTabs")), i = $(".content-tabs",parent).outerWidth(!0) - a, n = 0;
		if ($(".page-tabs-content",parent).width() < i) {
			return !1;
		}
		for (var s = $(".J_menuTab:first",parent), r = 0; r + $(s).outerWidth(!0) <= e; ) {
			r += $(s).outerWidth(!0), s = $(s).next();
		}
		if (r = 0, t($(s).prevAll()) > i) {
			for (; r + $(s).outerWidth(!0) < i && s.length > 0; ) {
				r += $(s).outerWidth(!0), s = $(s).prev();
			}
			n = t($(s).prevAll());
		}
		$(".page-tabs-content",parent).animate({marginLeft:0 - n + "px"}, "fast");
	}
	function i() {
		var e = Math.abs(parseInt($(".page-tabs-content",parent).css("margin-left"))), a = t($(".content-tabs",parent).children().not(".J_menuTabs")), i = $(".content-tabs",parent).outerWidth(!0) - a, n = 0;
		if ($(".page-tabs-content",parent).width() < i) {
			return !1;
		}
		for (var s = $(".J_menuTab:first",parent), r = 0; r + $(s).outerWidth(!0) <= e; ) {
			r += $(s).outerWidth(!0), s = $(s).next();
		}
		for (r = 0; r + $(s).outerWidth(!0) < i && s.length > 0; ) {
			r += $(s).outerWidth(!0), s = $(s).next();
		}
		n = t($(s).prevAll()), n > 0 && $(".page-tabs-content",parent).animate({marginLeft:0 - n + "px"}, "fast");
	}
	function n() {
		var t = $(this).attr("href"), a = $(this).data("index"), i = $.trim($(this).text()), n = !0;
		if (void 0 == t || 0 == $.trim(t).length) {
			return !1;
		}
		if ($(".J_menuTab",parent).each(function () {
			return $(this).data("id") == t ? ($(this).hasClass("active") || ($(this).addClass("active").siblings(".J_menuTab").removeClass("active"), e(this), $(".J_mainContent .J_iframe",parent).each(function () {
				return $(this).data("id") == t ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0;
			})), n = !1, !1) : void 0;
		}), n) {
			var s = "<a href=\"javascript:;\" class=\"active J_menuTab\" data-id=\"" + t + "\">" + i + " <i class=\"fa fa-times-circle\"></i></a>";
			$(".J_menuTab",parent).removeClass("active");
			var r = "<iframe class=\"J_iframe\" name=\"iframe" + a + "\" width=\"100%\" height=\"100%\" src=\"" + t;
			if(t.indexOf("?") > 0) {
				r += "&v=4.0&frameborder=\"0\" data-id=\"" + t + "\" seamless></iframe>";
			}else {
				r += "?v=4.0&frameborder=\"0\" data-id=\"" + t + "\" seamless></iframe>";
			}
			$(".J_mainContent",parent).find("iframe.J_iframe").hide().parents(".J_mainContent").append(r);
			//var o = window.parent.layer.load();
			$(".J_mainContent iframe:visible",parent).load(function () {
				layer.close(o);
			}), $(".J_menuTabs .page-tabs-content",parent).append(s), e($(".J_menuTab.active"));
		}
		return !1;
	}
	function s() {
		var t = $(this).parents(".J_menuTab").data("id"), a = $(this).parents(".J_menuTab").width();
		if ($(this).parents(".J_menuTab").hasClass("active")) {
			if ($(this).parents(".J_menuTab").next(".J_menuTab").size()) {
				var i = $(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").data("id");
				$(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").addClass("active"), $(".J_mainContent .J_iframe").each(function () {
					return $(this).data("id") == i ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0;
				});
				var n = parseInt($(".page-tabs-content").css("margin-left"));
				0 > n && $(".page-tabs-content").animate({marginLeft:n + a + "px"}, "fast"), $(this).parents(".J_menuTab").remove(), $(".J_mainContent .J_iframe").each(function () {
					return $(this).data("id") == t ? ($(this).remove(), !1) : void 0;
				});
			}
			if ($(this).parents(".J_menuTab").prev(".J_menuTab").size()) {
				var i = $(this).parents(".J_menuTab").prev(".J_menuTab:last").data("id");
				$(this).parents(".J_menuTab").prev(".J_menuTab:last").addClass("active"), $(".J_mainContent .J_iframe").each(function () {
					return $(this).data("id") == i ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0;
				}), $(this).parents(".J_menuTab").remove(), $(".J_mainContent .J_iframe").each(function () {
					return $(this).data("id") == t ? ($(this).remove(), !1) : void 0;
				});
			}
		} else {
			$(this).parents(".J_menuTab").remove(), $(".J_mainContent .J_iframe").each(function () {
				return $(this).data("id") == t ? ($(this).remove(), !1) : void 0;
			}), e($(".J_menuTab.active"));
		}
		return !1;
	}
	function r() {
		$(".page-tabs-content",parent).children("[data-id]").not(":first").not(".active").each(function () {
			$(".J_iframe[data-id=\"" + $(this).data("id") + "\"]",parent).remove(), $(this).remove();
		}), $(".page-tabs-content",parent).css("margin-left", "0");
	}
	function o() {
		e($(".J_menuTab.active",parent));
	}
	function d() {
		if (!$(this).hasClass("active")) {
			var t = $(this).data("id");
			$(".J_mainContent .J_iframe",parent).each(function () {
				return $(this).data("id") == t ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0;
			}), $(this).addClass("active").siblings(".J_menuTab").removeClass("active"), e(this);
		}
	}
	function c() {
		var t = $(".J_iframe[data-id=\"" + $(this).data("id") + "\"]",parent), e = t.attr("src"), a = layer.load();
		t.attr("src", e).load(function () {
			layer.close(a);
		});
	}
	$(".J_menuItem").each(function (t) {
		$(this).attr("data-index") || $(this).attr("data-index", t);
	}), $(".J_menuItem").on("click", n), $(".J_menuTabs").on("click", ".J_menuTab i", s), $(".J_tabCloseOther").on("click", r), $(".J_tabShowActive").on("click", o), $(".J_menuTabs").on("click", ".J_menuTab", d), $(".J_menuTabs").on("dblclick", ".J_menuTab", c), $(".J_tabLeft").on("click", a), $(".J_tabRight").on("click", i), $(".J_tabCloseAll").on("click", function () {
		$(".page-tabs-content").children("[data-id]").not(":first").each(function () {
			$(".J_iframe[data-id=\"" + $(this).data("id") + "\"]").remove(), $(this).remove();
		}), $(".page-tabs-content").children("[data-id]:first").each(function () {
			$(".J_iframe[data-id=\"" + $(this).data("id") + "\"]").show(), $(this).addClass("active");
		}), $(".page-tabs-content").css("margin-left", "0");
	});
	_e = e;
});



//内部f5刷新内部页面
document.onkeydown = function(e){
	//监控阻止Iframe的f5刷新
  if(e.keyCode == 116){
  	event.keyCode = 0;          
      var menus=$(".J_menuTabs",window.parent.document);
      var _this = menus.find(".J_menuTab.active"); 
      var url = $(_this).attr('data-id');
      if(url) {
    	  event.cancelBubble = true; 
          event.returnValue=false;
    	  goToTab(url);
      }
  }
}

function closeActiveTab() {
	var menus=$(".J_menuTabs",window.parent.document);
	var _this = menus.find(".J_menuTab.active").find("i");
	var t = $(_this).parents(".J_menuTab").data("id"), a = $(_this).parents(".J_menuTab").width();
	$(_this).parents(".J_menuTab").remove(), $(".J_mainContent .J_iframe").each(function () {
		return $(_this).data("id") == t ? ($(_this).remove(), !1) : void 0;
	}), _e($(".J_menuTab.active"));
	return !1;
}

//关闭当前页面，并跳转到指定的url
function closeTabAndGo(url){
	var menus=$(".J_menuTabs",window.parent.document);
	closeActiveTab();
	var menuTab=$("a[href='"+url+"']",window.parent.document);
	menus.find("a[data-id='"+url+"']").find("i").click();
	menuTab[0].click();
}

//刷新当前页面
function goFresh(url,param){
	if(param && param.indexOf("?v=4.0") > 0) {
		param = param.substring(0,param.indexOf("?v=4.0"));
	}else {
		param = "";
	}

	var menus=$(".J_menuTabs",window.parent.document);
	var freams=$(".J_iframe",window.parent.document);
	for(var i=0;i<freams.length;i++){
		if(freams.eq(i).attr("data-id")==url){
			var _location = $(".J_iframe",window.parent.document).eq(1)[0].contentWindow.location;
			var preUrl = _location.origin + _location.pathname;
			var _url = preUrl + param;
			_location.href = _url;
		} 
	}
	
	closeTabAndGo(url);
}
function goToTab(url){
	var menus=$(".J_menuTabs",window.parent.document);
	var obj=$("a[href='"+url+"']",window.parent.document);
	menus.find("a[data-id='"+url+"']").find("i").click();
	obj[0].click();
}