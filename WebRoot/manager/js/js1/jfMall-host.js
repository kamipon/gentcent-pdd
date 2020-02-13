/*
 * 定义积分商城域名 
 * 
 * @Version 1.0.0
 * @Author chen.yong
 * @Date 2017-04-27
 * 
 */
//var host = 'http://127.0.0.1:8180/links-software-web-jf';

var host = getRootPath();

$(function(){
	if($.jfMall){
		//设置默认配置
		$.jfMall.setDefaults({
			host : host
		});
	}
});

function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPath=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/uimcardprj
   
    if(curWwwPath.indexOf('links-software-web-jf')!=-1){
    	localhostPath = localhostPath + '/links-software-web-jf'
    }
    
    return localhostPath;
};

/**
 * 获取当前页面url
 * 
 * @returns
 */
function getCurrentUrl(){
	var curWwwPath=window.document.location.href;
	return curWwwPath;
}

/**
 * 刷新页面
 * 
 */
function refreshPage(){
	var currentPage = getCurrentUrl;
	location.href=currentPage;
}
