Request = {
	QueryString : function(item){
		var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)","i"));
		return svalue ? svalue[1] : svalue;
	}
}
var browser={  
	info:function(){   
		var u = navigator.userAgent, app = navigator.appVersion;   
		return {//移动终端浏览器版本信息   
			kernel:function(){
				if(u.indexOf('Trident') > -1){ //IE内核  
					return "ie";
				}else if(u.indexOf('Presto') > -1){//opera内核  
					return "opera";
				}else if(u.indexOf('AppleWebKit') > -1){//苹果、谷歌内核  
					return "苹果谷歌";
				}else if(u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1){//火狐内核  
					return "火狐";
				}
			}(), 
			systemType:function(){
				//系统类型（android、ios、ipad）
				if(!!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)){
					return "ios";
				}else if(u.indexOf('Android') > -1 || u.indexOf('Linux') > -1){
					return "android";
				}else if(u.indexOf('iPad') > -1){
					return "ipad";
				}else{
					return "web";
				}
			}(),
			isWeb:u.indexOf('Safari') == -1,//是否web
			language:(navigator.browserLanguage || navigator.language).toLowerCase(),//语言
			phoneType:function(){//手机型号
				var pattern_phone = new RegExp("iphone","i");
				var pattern_android = new RegExp("android","i");
				var userAgent = navigator.userAgent.toLowerCase();
				var isAndroid = pattern_android.test(userAgent);
				var isIphone = pattern_phone.test(userAgent);
				var phoneType="phoneType";
				if(isAndroid){ 
					var zh_cnIndex = userAgent.indexOf("-");
					var spaceIndex = userAgent.indexOf("build",zh_cnIndex+4);
					var fullResult = userAgent.substring(zh_cnIndex,spaceIndex);
					phoneType=fullResult.split(";")[1];
				}else if(isIphone){ 
					//6   w=375    6plus w=414   5s w=320     5 w=320
					var wigth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
					if(wigth>400){ 
						phoneType = "iphone6 plus";
					}else if(wigth>370){ 
						phoneType = "iphone6";
					}else if(wigth>315){ 
						phoneType = "iphone5/5s";
					}else{ 
						phoneType = "iphone 4s";
					}
				}else{ 
					phoneType = "未知移动终端或PC端";
				}
				return phoneType;
			}(),
			isMobile:!!u.match(/AppleWebKit.*Mobile.*/)||!!u.match(/AppleWebKit/),//是否为移动终端 
			screenWidth:window.screen.width,
			screenHeight:window.screen.height,
			availWidth:window.screen.availWidth,
			availHeight:window.screen.availHeight,
			title:document.title//页面标题
		};  
	}(),  
	source:"未知来源",
	openid:"",
	picUrl:"",
	address:"",
	nick:"",
	sex:"",
	gameid:"",
	render:function(){
    	var data=this.info;
    	data.source=this.source;
    	data.openid=this.openid;
    	data.picUrl=this.picUrl;
    	data.address=this.address;
    	data.nick=this.nick;
    	data.sex=this.sex;
    	data.gameid=this.gameid;
    	data.channel=Request.QueryString("channel");
    	$.ajax({  
	        type:'get',  
	        url : 'http://tj.vgochina.com/render',  
	        dataType:'JSONP',
			jsonp: "callbackparam",
			jsonpCallback:"jsonpCallback1",
	        data:data
		});  
	}
}  