<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>活动互动系统</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
	<link type="text/css" rel="stylesheet" href="css/cms-css.css">
	<link type="text/css" rel="stylesheet" href="css/index-css.css">
	<script src="js/echarts.js"></script>
	<style type="text/css">
		.choosNian{
			height:50px;
			width: 100%;
			margin-top: 10px;
			margin-left: 144px;
		}
		.nian{
			background-color: #1AB394;
			width:40px;
			height:40px;
			border-radius:50px;
			border:0;
		}
		.choosYue{
			height:50px;
			width: 100%;
			margin-top: 10px;
			margin-left: 144px;
		}
		.yue{
			background-color: #1AB394;
			width:40px;
			height:40px;
			border-radius:50px;
			border:0;
		}
		.loading{
			position: absolute;
			top: 50%;
		}
		input,button,select,textarea{outline:none;}
	</style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>信息统计</h5>
                    </div>
                   	<div class="ibox-content" style="background-color: white;padding: 20px 5px 20px;">
                   		<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
                   			<div class="tiptitle" style="margin-top: 0px;"> <span id="Stitle">你好，${loginUser.username }！</span><br>以下是您的各项信息： </div>
                   			<div class="tasks" >
                   			<c:choose>
							<c:when test="${!empty ter&&empty activity}">
                  				<ul class="listTasks" style="width: 100%;margin-left:20%;">
										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${zhengshi }</span><span class="text">已开通商家数</span></a></li>
										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${ter.activityNum }</span><span class="text">可开通商家总数</span></a></li>
										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${sum}" pattern="0.00"/></span><span class="text">结算总交易额</span></a></li>
										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${jx}" pattern="0.00"/></span><span class="text">结算代理手续费</span></a></li>
										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${tx}" pattern="0.00"/></span><span class="text">已提现金额</span></a></li>
										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${money}" pattern="0.00"/></span><span class="text">账户余额</span></a></li>
<!--									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${terpoint.money}" pattern="0.00"/> </span><span class="text">账户余额</span></a></li>-->
								</ul>
                   			</c:when>
                   			<c:when test="${empty ter&&!empty activity}">
                  				<ul class="listTasks" style="width: 100%;margin-left:20%;">
                  					<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"  title="商家充值的总金额" ><span class="number"><fmt:formatNumber value="${chongzhi }" pattern="0"/></span><span class="text">充值</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"  title="已经结算过的销售额，结算销售额会充入商家余额"><span class="number"><fmt:formatNumber value="${jsxs}" pattern="0.00"/></span><span class="text">结算销售额</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);" title="系统收取的手续费"><span class="number"><fmt:formatNumber value="${jssxf}" pattern="0.00"/></span><span class="text">结算手续费</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);" title="支付给推广人的佣金"><span class="number"><fmt:formatNumber value="${yongjin}" pattern="0.00"/></span><span class="text">支付佣金</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);" title="所有活动预计发出的总佣金"><span class="number"><fmt:formatNumber value="${dongjie}" pattern="0.00"/></span><span class="text">冻结金额</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);" title="提现金额"><span class="number"><fmt:formatNumber value="${actMoney}" pattern="0.00"/></span><span class="text">提现中/已提现金额</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);" title="商家当前账户余额，充值+结算销售额-结算手续费-支付佣金-冻结金额"><span class="number"><fmt:formatNumber value="${chongzhi+jsxs-jssxf-yongjin-dongjie-actMoney}" pattern="0.00"/> </span><span class="text">余额</span></a></li>
								</ul>
								<ul class="listTasks" style="width: 100%;margin-left:20%;">
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${xs}" pattern="0.00"/></span><span class="text">总销售额</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${xs-jsxs}" pattern="0.00"/></span><span class="text">未结算销售额</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${fangwen}" pattern="0"/> </span><span class="text">访问量</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${dingdan }" pattern="0"/></span><span class="text">总订单</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${sdingdan}" pattern="0"/></span><span class="text">支付成功订单数</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number"><fmt:formatNumber value="${(fangwen*100+sdingdan*300+(dingdan-sdingdan)*200)+(fangwen*20+sdingdan*50+(dingdan-sdingdan)*30)+(fangwen*3+sdingdan*8+(dingdan-sdingdan)*5)}" pattern="0"/></span><span class="text">曝光量</span></a></li>
								</ul>
                   			</c:when>
                   			<c:when test="${loginUser.roleName.id==1}">
                   				<ul class="listTasks" style="width: 100%;margin-left:22%;">
<!--									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${terNum}</span><span class="text">代理商数量</span></a></li>-->
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${afangwen}</span><span class="text">访问量</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${members}</span><span class="text">用户数</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${adingdan}</span><span class="text">总订单</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${asdingdan}</span><span class="text">支付成功订单</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${axs}</span><span class="text">总销售额</span></a></li>
									<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${ayongjin}</span><span class="text">支付佣金</span></a></li>
<!--									<li class="wechat"  id="tongji"><a class="listTasks-a"><img src="images/tongji.png" style="width: 40px;height:40px;margin-left: 46px;margin-top:10px"/><span class="text">红包发放统计</span></a></li>-->
<!--									<li class="wechat"  id="more"><a class="listTasks-a" href="tongji/index.jsp" target="_blank"><img src="images/more.png" style="width: 40px;height:40px;margin-left: 46px;margin-top:10px"/><span class="text">查看详情</span></a></li>-->
								</ul>
                   			</c:when>
                   			</c:choose>
							</div>
                   		</div>
                    </div>
                    <c:choose>
                    <c:when test="${empty activity}">
<!--                    	 <div class="ibox-title">-->
<!--	                        <h5>活动统计</h5>-->
<!--	                     </div>-->
<!--	                   	<div class="ibox-content" style="background-color: white;padding: 20px 5px 20px;">-->
<!--	                   		<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">-->
<!--	                   			<div class="tasks" >-->
<!--	                  				<ul class="listTasks" style="width: 100%;margin-left:25%;">-->
<!--	                  					<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${memberNum}</span><span class="text">领奖用户数</span></a></li>-->
<!--	                  					<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${tuihui}</span><span class="text">待退回金额</span></a></li>-->
<!--										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${prePv }</span><span class="text">有效点击量</span></a></li>-->
<!--										<li class="wechat"><a class="listTasks-a" href="javascript:void(0);"><span class="number">${baoguang }</span><span class="text">曝光量</span></a></li>-->
<!--										<c:if test="${!empty activity}">-->
<!--											<li class="wechat"><a class="listTasks-a" id="look"><img src="images/tongji.png" style="width: 40px;height:40px;margin-left: 46px;margin-top: 10px"/><span class="text">查看更多...</span></a></li>-->
<!--										</c:if>-->
<!--									</ul>-->
<!--								</div>-->
<!--	                   		</div>-->
<!--	                    </div>-->
                    </c:when>
                    </c:choose>
                </div>
            </div>
             <c:choose>
      <c:when test="${!empty activity||empty activity&&empty ter}">

<!--		    <div class="choosNian">-->
<!--			    请选择年份-->
<!--			    <input type="button" value="2017" id="2017" class="nian" />-->
<!--			    <input type="button" value="2018" id="2018" class="nian" />-->
<!--		    </div>-->
		    <!-- 从visit控制器获取 -->
<!--		    <c:if test="${empty activity}">-->
<!--				    <div class="" style="margin-left: 75%;margin-top: -40px;">-->
<!--					    <select onchange="query()" class="btn btn-primary" id="statistics" style="background-color:#fff;color:#000;">-->
<!--					    	<option value="-1">请选择活动</option>-->
<!--					    	<c:forEach items="${list}" var="entity">-->
<!--								<option value="${entity.id }">${entity.name }</option>-->
<!--					    	</c:forEach>-->
<!--						</select>  -->
<!--						<input class="btn btn-primary" onclick="add()" type="button" value="添加活动">-->
<!--						<input class="btn btn-primary" onclick="_list()" type="button" value="活动列表">-->
<!--					</div>-->
<!--				</c:if>-->
<!--		    <div class="choosYue">-->
<!--		    请选择月份-->
<!--		    <input type="button" value="1月" class="yue"/>-->
<!--		    <input type="button" value="2月" class="yue"/>-->
<!--		    <input type="button" value="3月" class="yue"/>-->
<!--		    <input type="button" value="4月" class="yue"/>-->
<!--		    <input type="button" value="5月" class="yue"/>-->
<!--		    <input type="button" value="6月" class="yue"/>-->
<!--		    <input type="button" value="7月" class="yue"/>-->
<!--		    <input type="button" value="8月" class="yue"/>-->
<!--		    <input type="button" value="9月" class="yue"/>-->
<!--		    <input type="button" value="10月" class="yue"/>-->
<!--		    <input type="button" value="11月"  class="yue"/>-->
<!--		    <input type="button" value="12月"  class="yue"/>-->
<!--		    </div>  -->
		    </div>
		    <div id="loading" style="width: 100%;height:100px;text-align: center;display: none;z-index: 100">
	    		<img src="js/plugins/layer/skin/default/loading-0.gif" style="margin-top:50px;" />
		    </div>
		   	<div id="b" style="background-color: #fff;height:400px;width:100%;margin: auto;margin-top: 30px;">
		   	</div>
		   	<div id="c" style="height:400px;width:100%;margin: auto;background-color: white"></div>
	</c:when>
    </c:choose>
        </div>
    </div>

	<script src="js/jquery.min63b9.js"></script>
    <script src="js/highcharts.js"></script>
	<script src="js/exporting.js"></script>
	<script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript">
    	function add(){
    		layer.open({
				type: 2,
				title: '活动添加',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'manager/actStatistics_add.jsp'
			});
    	}
    	function _list(){
    		layer.open({
				type: 2,
				title: '活动列表',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'actStatistics/list'
			});
    	}
    	function toUpdate(){
    		var id = $.trim($("#statistics").val());
    		if(id=="-1"){
				layer.msg("请选择活动！");
				return ;
    		}
    		layer.open({
				type: 2,
				title: '活动修改',
				shadeClose: true,
				shade: 0.8,
				area: ['1220px', '90%'],
				content: 'actStatistics/toUpdate?id='+id
			});
    	}
    	function _delete(){
    		var id = $.trim($("#statistics").val());
    		 $.ajax({
		        type: "GET",
		        url: "actStatistics/delete",
		        data: {id:id},
		        dataType: "json",
		        success: function(data){
						layer.msg(data.msg);
		        },
		        error: function(){
		        	layer.msg("发生了一个意外！");
		        }
		    });
    	}
    	$("#look").on("click",function(){
	        $("html, body").animate({
	            scrollTop: $("#tongji").offset().top }, {duration: 500,easing: "swing"});
	        	return false;
    	});
    	var now = new Date();
    	var nian = now.getFullYear();
    	var yue = null;
   		$("#"+nian).css("background-color","#D53A35");
    	$(".nian").on("click",function(){
    		$(".yue").css("background-color","#1AB394");
    		$(".nian").css("background-color","#1AB394");
    		$(this).css("background-color","#D53A35");
    		nian = $(this).val();
   			yue = null;
   			$("#loading").css("display","block");
   			var url;
   			if(${empty activity&&empty ter}){
   				url = "visit/money";
   			}else{
   				url = "visit/between";
   			}
    		mess(nian,yue,url);
    	});
    	$(".yue").on("click",function(){
    		$(".yue").css("background-color","#1AB394");
    		$(this).css("background-color","#D53A35");
    		yue = $(this).val();
   			$("#loading").css("display","block");
   			var url;
   			if(${empty activity&&empty ter}){
   				url = "visit/money";
   			}else{
   				url = "visit/between";
   			}
    		mess(nian,yue,url);
    	});
    	function query(){
	    	var id = $.trim($("#statistics").val());
    		if(id=="-1"){
				layer.msg("请选择活动！");
				return ;
    		}
    		var url = "visit/activity?asId="+id;
    		mess(null,null,url);
    	}
    	function mess(nian,yue,url){
		    $.ajax({
		        type: "GET",
		        url: url,
		        data: {nian:nian, yue:yue,id:"${activity.id}"},
		        dataType: "json",
		        success: function(data){
		       	 $("#loading").css("display","none");
		       	 if(data.flag){
					var myChart = echarts.init(document.getElementById('b'));
			        option2 = {
					    title : {
					        text: '金额',
					        subtext: '(元)'
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['红包领取总额']
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
				      	xAxis : [
					        {
					            type : 'category',
					            data : data.xzhou
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value'
					        }
					    ],
					    series : [
					        {
					            name:'红包领取总额',
					            type:'bar',
					            data:data.dianJi,
					            markPoint : {
					                data : [
					                    {type : 'max', name: '最大值'},
					                    {type : 'min', name: '最小值'}
					                ]
					            },
					            markLine : {
					                data : [
					                    {type : 'average', name: '平均值'}
					                ]
					            }
					        }
					    ]
					};
			        myChart.setOption(option2);
					var myChart = echarts.init(document.getElementById('c'));
			        option3 = {
					    title : {
					        text: '金额',
					        subtext: '(元)'
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['余额转出','直接转出'],
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
				      	xAxis : [
					        {
					            type : 'category',
					            data : data.xzhou
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value'
					        }
					    ],
					    series : [
					    		{
					            name:'直接转出',
					            type:'bar',
					            data:data.zhijie,
					            markPoint : {
					                data : [
					                    {type : 'max', name: '最大值'},
					                    {type : 'min', name: '最小值'}
					                ]
					            },
					            markLine : {
					                data : [
					                    {type : 'average', name: '平均值'}
					                ]
					            }
					        },
					        {
					            name:'余额转出',
					            type:'bar',
					            data:data.yuer,
					            markPoint : {
					                data : [
					                    {type : 'max', name: '最大值'},
					                    {type : 'min', name: '最小值'}
					                ]
					            },
					            markLine : {
					                data : [
					                    {type : 'average', name: '平均值'}
					                ]
					            }
					        }
					    ]
					};
			        myChart.setOption(option3);
			     }else{
			       	var myChart = echarts.init(document.getElementById('b'));
			        option1 = {
					    title : {
					        text: '领奖用户统计',
					        subtext: '(个)'
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['领奖用户']
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            data : data.xzhou,
					            axisTick: {length:1}
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value'
					        }
					    ],
					    series : [
					        {
					            name:'领奖用户',
					            type:'bar',
					            data:data.lingJiang,
				             	barMaxWidth : 60,
					            markPoint : {
					                data : [
					                    {type : 'max', name: '最大值'},
					                    {type : 'min', name: '最小值'}
					                ]
					            },
					            markLine : {
					                data : [
					                    {type : 'average', name: '平均值'}
					                ]
					            }
					        }
					    ]
					};
			        myChart.setOption(option1);

					//有效点击
					var myChart = echarts.init(document.getElementById('c'));
			        option2 = {
					    title : {
					        text: '有效点击统计',
					        subtext: '(次)'
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['有效点击']
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
				      	xAxis : [
					        {
					            type : 'category',
					            data : data.xzhou
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value'
					        }
					    ],
					    series : [
					        {
					            name:'有效点击',
					            type:'bar',
					            data:data.dianJi,
					            barMaxWidth : 60,
					            markPoint : {
					                data : [
					                    {type : 'max', name: '最大值'},
					                    {type : 'min', name: '最小值'}
					                ]
					            },
					            markLine : {
					                data : [
					                    {type : 'average', name: '平均值'}
					                ]
					            }
					        }
					    ]
					};
			        myChart.setOption(option2);
			     }

		        }
	        });
    	}
    	var url;
    	//默认查询当月
    	function cha(){
    		if(${!empty activity}){
	    		url = "visit/between";
		    	mess(nian,yue,url);
	    	}else if(${!empty activity||empty activity&&empty ter}){
	    		url = "visit/money";
	    		mess(nian,yue,url);
	    	}
    	}

    	$("#tongji").on("click",function(){
	   		 layer.open({
					type: 2,
					title: '红包发放统计',
					shadeClose: true,
					moveOut: true,
					shade: 0.8,
					area: ['1500px', '90%'],
					content: 'manager/redpacket_tongji.jsp',
			});
    	});
	</script>
</body>
</html>
