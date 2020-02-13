/*
 * 积分商城api
 * 
 * @Version 1.0.0
 * @Author chen.yong
 * @Date 2017-04-27
 * 
 */
(function($){
	
	$.extend({
		jfMall : {
			
			/** 基本配置 */
			settings : {
				errorCodes : {
					'E00502020' : '您今日次数已经使用完，请明天再来~', //当日参与次数已达上限
					'E00502021' : '您的积分账户余额不足' //账户余额不足
				},
				host : undefined,//积分商城域名
				debug : false ,//debug模式，debug模式下会打印日志
				devModel : false //开发者模式，开发者模式下，不再调用$.ajax()发起远程请求，而是使用默认数据
			},
			
			/** 设置默认值 */
			setDefaults : function(settings){
				this.settings = $.extend(this.settings,settings||{});
			},
			
			
			/** 初始化 */
			init : function(settings){
				this.settings.showErrorMsg = this.showErrorMsg;//错误消息
				this.settings.showSuccessMsg = this.showSuccessMsg;//显示成功消息
				this.settings.notLogin = this.notLogin;//登录失效或者未登录时处理函数
				this.settings.ajax = this.ajax;//ajax调用
			},
			
			/**
			 * ajax远程调用 
			 * 
			 * @param options 请求参数
			 * 			<br>options.data ajax请求参数
			 * 			<br>options.sucFunc 请求成功处理，该方法会被options.success覆盖 function(datas){}
			 * 			<br>option.errFunc 请求失败处理，业务请求失败，即result.success为false function(msg,errorCode){}
			 * 			<br>options.notLogin 用户登录失效处理，该方法会被options.success覆盖 function(msg){}
			 * 			<br>options.action 请求action
			 * 			<br>options.success 请求成功处理函数，$.ajax.success function(result){}
			 * 			<br>options.error 请求失败处理函数，$.ajax.error function(e){}
			 */
			ajax : function(options){
				_this = this;
				
				if(!options.action) return;//未配置action
				
				options.errFunc = options.errFunc || _this.settings.showErrorMsg;
				
				//默认请求成功处理
				options.success = options.success || function(result){
					
					if(_this.settings.debug) console.log(result);
					
					if(result.success){
						if(options.sucFunc) options.sucFunc.call(_this,result.datas);
					}else if('E00502006'==result.code){//登录失效
						if(options.notLogin) options.notLogin.call(_this,result.message,result.code);
						else if(_this.settings.notLogin) _this.settings.notLogin.call(_this,result.message,result.code);
					}else{
						if(options.errFunc) options.errFunc.call(_this,result.message,result.code);
					}
				};
				
				//默认请求失败处理
				options.error = options.error || function(e){
					
					if(_this.settings.debug) console.log(e);
					
					if(_this.settings.showErrorMsg) _this.settings.showErrorMsg.call(_this,'请求失败');
				};
				
				//请求参数
				options.data = options.data || {};
				options.async = options.async || true;
				options.complete = options.complete || function(){};
				
				/* 开启了开发者模式，系统会跳过远程请求，直接从$.jfMallDevModel获取结果，开发者模式仅限调试过程使用，开发者模式需要引入jfMall-dev.js */
				if(_this.settings.devModel==true && $.jfMallDevModel){
					var result = $.jfMallDevModel.getResult[options.action];
					if(_this.settings.debug) console.log(result);
					
					options.complete.call(_this);
					return;
				}
				
				if(!_this.settings.host) return;//未配置活动域名
				
				var url = _this.settings.host + options.action;
				
				$.ajax({
					url : url,
					type : 'post',
					data : options.data,
					dataType : 'json',
					async : options.async,
					success : options.success,
					error : options.error,
					complete : function(){
						options.complete.call(_this);
					}
				});
				
			},
			
			/**
			 * 记录日志
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 
			 */
			log : function(options){
				options.action = '/jfMall/log';
				options.success = function(result){};
				options.error = function(e){};
				this.ajax(options);
			},
			
			
			/**
			 * 加载积分活动列表
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data.jfMallId 积分商城id
			 * 				options.data.types 积分活动类型，多个类型使用英文逗号分隔，例如'兑换,抽奖,拉霸机'，非必填，默认所有类型
			 * 				options.data['page.currentPage'] 当前页码，非必填，默认1
			 * 				options.data['page.showCount'] 每页显示内容，非必填，默认15
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.page 分页内容
			 * 					datas.page.currentPage 当前页码
			 * 					datas.page.showCount 每页显示数量
			 * 					datas.page.totalResult 记录总数
			 * 					datas.page.list 结果列表
			 * 						datas.page.list.jfActivityId 积分活动id
			 * 						datas.page.list.name 积分活动名称
			 * 						datas.page.list.type 积分活动类型[兑换,抽奖,秒杀,签到,老虎机,拉霸机砸金蛋]
			 * 						datas.page.list.imageUrl 积分活动缩略图 
			 * 						datas.page.list.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 						datas.page.list.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 						datas.page.list.jfCost 消耗积分，抽奖和兑换类
			 * 						datas.page.list.total 库存总数，-1表示不限，抽奖和兑换类
			 * 						datas.page.list.quantity 剩余库存，-1表示不限，抽奖和兑换类
			 * 						datas.page.list.usedQuantity 已消耗库存，抽奖和兑换类
			 */
			loadJfActivityList : function(options){
				options.action = '/jfMall/loadJfActivityList';
				this.ajax(options);
			},
			
			/**
			 * 加载活动详情
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data.jfMallId 积分商城id
			 * 				options.data.jfActivityId 积分活动id
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.jfActivity 积分活动
			 * 					datas.jfActivity.jfActivityId 积分活动id
			 * 					datas.jfActivity.name 积分活动名称
			 * 					datas.jfActivity.type 积分活动类型[兑换,抽奖,秒杀,签到,老虎机,拉霸机砸金蛋]
			 * 					datas.jfActivity.kvImageUrl 积分活动kv图 
			 * 					datas.jfActivity.imageUrl 积分活动缩略图 
			 * 					datas.jfActivity.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfActivity.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfActivity.jfCost 消耗积分，抽奖和兑换类
			 * 					datas.jfActivity.total 库存总数，-1表示不限，抽奖和兑换类
			 * 					datas.jfActivity.quantity 剩余库存，-1表示不限，抽奖和兑换类
			 * 					datas.jfActivity.usedQuantity 已消耗库存，抽奖和兑换类
			 * 				datas.extendParams 其他参数，格式{"key1":[{"name1":"value1","name2":"value2"}],"key2":[{"name3":"value4"}]}
			 * 					datas.extendParams.
			 * 
			 */
			loadJfActivityDetail : function(options){
				options.action = '/jfMall/loadJfActivityDetail';
				this.ajax(options);
			},
			
			
			/**
			 * 加载积分用户信息
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.jfUser 积分用户信息
			 * 					datas.jfUser.jfUserId 积分用户id
			 * 					datas.jfUser.jfMallId 积分商城id		
			 * 					datas.jfUser.name 用户姓名
			 * 					datas.jfUser.phone 手机号码	
			 * 					datas.jfUser.wxNick 微信昵称
			 * 					datas.jfUser.wxOpenId 微信openId
			 * 					datas.jfUser.wxHeadUrl 微信头像
			 * 					datas.jfUser.jfActivityCount 参与次数
			 * 					datas.jfUser.awardCount 中奖次数
			 * 					datas.jfUser.balance 账户余额	
			 * 					datas.jfUser.signinCount 连续签到次数
			 * 					datas.jfUser.signinTime 最后一次签到时间
			 * 				datas.extendParams 积分用户额外信息
			 * 					datas.extendParams.email 邮箱
			 * 					datas.extendParams.city 城市
			 * 					datas.extendParams.birthday 生日
			 * 					datas.extendParams.sex 性别 '1'-男,'2'-女
			 */
			loadJfUserInfo : function(options){
				options.action='/jfMall/loadJfUserInfo';
				this.ajax(options);
			},
			
			
			/**
			 * 保存积分用户信息
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data.name 积分用户姓名
			 * 				options.data.phone 积分用户手机号码
			 * 				options.data.extendParams 积分用户其他参数，json对象，值必须为字符串类型，例如{email:'test@links-e.com',sex:'1'}
			 * 			options.sucFunc 处理函数 function(datas){}
			 */
			saveJfUserInfo : function(options){
				options.action='/jfMall/saveJfUserInfo';
				this.ajax(options);
			},
			
			
			/**
			 * 加载积分明细
			 * 
			 * @param options
			 * 			options.data 请求参数
			 * 				options.data['page.currentPage'] 当前页码，非必填，默认1
			 * 				options.data['page.showCount'] 每页显示数量，非必填，默认15，范围3-100
			 * 			options.sucFunc 处理函数(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.jfUser 积分用户信息
			 * 					datas.jfUser.jfUserId 积分用户id
			 * 					datas.jfUser.jfMallId 积分商城id		
			 * 					datas.jfUser.name 用户姓名
			 * 					datas.jfUser.phone 手机号码	
			 * 					datas.jfUser.wxNick 微信昵称
			 * 					datas.jfUser.wxOpenId 微信openId
			 * 					datas.jfUser.wxHeadUrl 微信头像
			 * 					datas.jfUser.jfActivityCount 参与次数
			 * 					datas.jfUser.awardCount 中奖次数
			 * 				datas.page 分页内容
			 * 					datas.page.currentPage 当前页面
			 * 					datas.page.totalPage 总页数
			 * 					datas.page.totalResult 记录总数
			 * 					datas.page.shouCount 每页显示数量
			 * 					datas.page.list 积分明细列表
			 * 						datas.page.list.jfAccountDetailId 积分账户明细id
			 * 						datas.page.list.jfMallId 积分商城id
			 * 						datas.page.list.jfUserId 积分用户id
			 * 						datas.page.list.jfAccountId 积分账户id
			 * 						datas.page.list.accountType 积分账户类型[JF-积分账户,WXLJ-微信红包-立即发放,WXZT-微信红包-用户自提]，当前接口只返回JF类型记录
			 * 						datas.page.list.traceNo 交易号
			 * 						datas.page.list.amount 交易金额
			 * 						datas.page.list.balance 交易完成后账户余额
			 * 						datas.page.list.jfActivityId 积分活动id
			 * 						datas.page.list.jfActivityName 积分活动名称
			 * 						datas.page.list.jfActivityType 积分活动类型[HD-活动,JF-积分商城活动]
			 * 						datas.page.list.type 出入账类型[in-入账,out-出账]
			 * 						datas.page.list.remark 备注
			 * 						datas.page.list.createTime 记录生成时间
			 */
			loadJfDetail : function(options){
				options.action='/jfMall/loadJfDetail';
				this.ajax(options);
			},
			
			
			/**
			 * 
			 * 加载中奖列表
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data['page.currentPage'] 当前页码，非必填，默认1
			 * 				options.data['page.showCount'] 每页显示数量，非必填，默认15，范围3-100
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.jfUser 积分用户信息
			 * 					datas.jfUser.jfUserId 积分用户id
			 * 					datas.jfUser.jfMallId 积分商城id		
			 * 					datas.jfUser.name 用户姓名
			 * 					datas.jfUser.phone 手机号码	
			 * 					datas.jfUser.wxNick 微信昵称
			 * 					datas.jfUser.wxOpenId 微信openId
			 * 					datas.jfUser.wxHeadUrl 微信头像
			 * 					datas.jfUser.jfActivityCount 参与次数
			 * 					datas.jfUser.awardCount 中奖次数
			 * 				datas.page 分页内容
			 * 					datas.page.currentPage 当前页面
			 * 					datas.page.totalPage 总页数
			 * 					datas.page.totalResult 记录总数
			 * 					datas.page.shouCount 每页显示数量
			 * 					datas.page.list 中奖奖品列表
			 * 						datas.page.list.jfAwardRecordId 中奖记录id
			 * 						datas.page.list.prizeName 奖品名称
			 * 						datas.page.list.sendType 发放类型[HF-话费,LL-流量,ZT-自提,WL-物流,JYK-加油卡,WX-微信红包,QQ-Q币，等等]
			 * 						datas.page.list.isCompleted 是否完善信息，1-是，0-否
			 * 						datas.page.list.createTime 记录生成时间
			 */
			loadPrizeList : function(options){
				options.action='/jfMall/loadPrizeList';
				this.ajax(options);
			},
			
			
			/**
			 * 
			 * 加载奖品详情
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data.jfAwardRecordId 中奖记录id
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.detail 中奖记录
			 * 					detail.jfAwardRecordId 中奖记录id
			 * 					detail.prizeId 奖品id
			 * 					detail.prizeName 奖品名称
			 * 					detail.sendType 发放类型[HF-话费,LL-流量,ZT-自提,WL-物流,JYK-加油卡,WX-微信红包,QQ-Q币，等等]
			 * 					detail.isCompleted 是否完善信息，1-是，0-否
			 * 					detail.createTime 记录生成时间
			 * 					detail.extendParams 其他参数，json
			 * 						detail.extendParams.phone 手机号码
			 * 						detail.extendParams.couponCode 优惠券码，自提码，优惠券类、自提类
			 * 						detail.extendParams.ztUrl 自提链接地址，自提类
			 * 						detail.extendParams.recName 收货人姓名，物流类
			 * 						detail.extendParams.recPhone 收货人手机号码，物流类
			 * 						detail.extendParams.recProvince 收货地址-省份，物流类
			 * 						detail.extendParams.recCity 收货地址-城市，物流类
			 * 						detail.extendParams.recCounty 收货地址-县，物流类
			 * 						detail.extendParams.recTown 收货地址-镇，物流类
			 * 						detail.extendParams.recAddress 收货地址-详细地址，物流类
			 * 						detail.extendParams.qq QQ号码,Q币类
			 * 						detail.extendParams.jyk 加油卡号,加油卡类
			 */
			loadPrizeDetail : function(options){
				options.action='/jfMall/loadPrizeDetail';
				this.ajax(options);
			},
			
			
			/**
			 * 加载门店列表
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data.prizeId 奖品id
			 * 				options.data.name 区域名称
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.list 门店列表,array
			 * 					datas.list.name 门店名称
			 * 					datas.list.phone 联系方式
			 * 					datas.list.area 区域
			 * 					datas.list.province 省份
			 * 					datas.list.city 城市 
			 * 					datas.list.county 县
			 * 					datas.list.town 乡镇
			 * 					datas.list.address 详细地址
			 */
			loadUserStoreList : function(options){
				options.action='/jfMall/loadUserStoreList';
				this.ajax(options);
			},
			
			
			/**
			 * 
			 * 加载用户参与记录列表
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data['page.currentPage'] 当前页码，非必填，默认1
			 * 				options.data['page.showCount'] 每页显示数量，非必填，默认15，范围3-100
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.jfUser 积分用户信息
			 * 					datas.jfUser.jfUserId 积分用户id
			 * 					datas.jfUser.jfMallId 积分商城id		
			 * 					datas.jfUser.name 用户姓名
			 * 					datas.jfUser.phone 手机号码	
			 * 					datas.jfUser.wxNick 微信昵称
			 * 					datas.jfUser.wxOpenId 微信openId
			 * 					datas.jfUser.wxHeadUrl 微信头像
			 * 					datas.jfUser.jfActivityCount 参与次数
			 * 					datas.jfUser.awardCount 中奖次数
			 * 				datas.page 分页内容
			 * 					datas.page.currentPage 当前页面
			 * 					datas.page.totalPage 总页数
			 * 					datas.page.totalResult 记录总数
			 * 					datas.page.shouCount 每页显示数量
			 * 					datas.page.list 参与记录列表
			 * 						datas.page.list.jfActivityRecordId 参与记录id
			 * 						datas.page.list.jfActivityType 积分活动类型
			 * 						datas.page.list.jfActivityName 积分活动名称
			 * 						datas.page.list.wxOpenId 微信openId
			 * 						datas.page.list.wxNick 微信昵称
			 * 						datas.page.list.phone 手机号码
			 * 						datas.page.list.jfCost 消耗积分
			 * 						datas.page.list.accountBalance 用户剩余积分
			 * 						datas.page.list.ip 用户ip地址
			 * 						datas.page.list.isAward 是否中奖 0-未中奖，1-中奖
			 * 						datas.page.list.jfPrizePackageId 积分奖项id
			 * 						datas.page.list.jfPrizePackageName 积分奖项名称
			 * 						datas.page.list.createTime 参与时间
			 */
			loadJfActivityRecordList : function(options){
				options.action='/jfMall/loadJfActivityRecordList';
				this.ajax(options);
			},
			
			
			/**
			 * 参与积分活动
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data.jfActivityId 积分活动id
			 * 			options.sucFunc 处理函数funciton(datas){}
			 * 				datas.jfActivityRecord 参与记录
			 * 					datas.jfActivityRecord.jfActivityRecordId 参与记录id
			 * 					datas.jfActivityRecord.jfActivityType 积分活动类型
			 * 					datas.jfActivityRecord.jfActivityName 积分活动名称
			 * 					datas.jfActivityRecord.wxOpenId 微信openId
			 * 					datas.jfActivityRecord.wxNick 微信昵称
			 * 					datas.jfActivityRecord.phone 手机号码
			 * 					datas.jfActivityRecord.jfCost 消耗积分
			 * 					datas.jfActivityRecord.accountBalance 用户剩余积分
			 * 					datas.jfActivityRecord.ip 用户ip地址
			 * 					datas.jfActivityRecord.isAward 是否中奖 0-未中奖，1-中奖
			 * 					datas.jfActivityRecord.jfPrizePackageId 积分奖项id
			 * 					datas.jfActivityRecord.jfPrizePackageName 积分奖项名称
			 * 					datas.jfActivityRecord.createTime 参与时间
			 * 				datas.jfPrizePackage 积分商城奖项
			 * 					jfPrizePackage.jfPrizePackageId 奖项id
			 * 					jfPrizePackage.name 奖项名称
			 * 					jfPrizePackage.imageUrl 奖项图片地址
			 * 				datas.jfPrizeList 积分活动奖品，如果jfActivityRecord.isAward为1时，并且奖项中包含奖品，jfPrizeList为奖品列表，Array
			 * 					datas.jfPrizeList.jfPrizeId 积分奖品id
			 * 					datas.jfPrizeList.prizeName 奖品名称
			 * 					datas.jfPrizeList.prizePrice 奖品价格
			 * 					datas.jfPrizeList.prizeValue 奖品面额
			 * 					datas.jfPrizeList.prizeSource 奖品来源[MALL-商城,JD-京东,OWN-自有]
			 * 					datas.jfPrizeList.prizeType 奖品类型
			 * 					datas.jfPrizeList.sendType 发放类型[WL-物流,ZT-自提,CODE-串码,HF-话费,LL-流量,YHQ-优惠券,WX-微信红包，其他等等]
			 * 					datas.jfPrizeList.imageUrl 奖品图片地址
			 */
			lottery : function(options){
				options.action='/jfMall/lottery';
				this.ajax(options);
			},
			
			
			/**
			 * 
			 * 加载积分账户信息
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.jfUser 积分用户信息
			 * 					datas.jfUser.jfUserId 积分用户id
			 * 					datas.jfUser.jfMallId 积分商城id		
			 * 					datas.jfUser.name 用户姓名
			 * 					datas.jfUser.phone 手机号码	
			 * 					datas.jfUser.wxNick 微信昵称
			 * 					datas.jfUser.wxOpenId 微信openId
			 * 					datas.jfUser.wxHeadUrl 微信头像
			 * 					datas.jfUser.jfActivityCount 参与次数
			 * 					datas.jfUser.awardCount 中奖次数
			 * 				datas.jfAccount 微信红包账户，如果账户不存在，为null
			 * 					datas.jfAccount.jfAccountId 微信红包账户id
			 * 					datas.jfAccount.accountType 账户类型[WXLJ-微信红包-立即发放,WXZT-微信红包-用户自提]
			 * 					datas.jfAccount.total 账户总额
			 * 					datas.jfAccount.balance 账户余额
			 * 					datas.jfAccount.cost 消耗金额
			 * 
			 */
			loadWxAccount : function(options){
				options.action='/jfMall/loadWxAccount';
				this.ajax(options);
			},
			
			
			/**
			 * 加载微信红包账户明细
			 * 
			 * @param options
			 * 			options.data 请求参数
			 * 				options.data['page.currentPage'] 当前页码，非必填，默认1
			 * 				options.data['page.showCount'] 每页显示数量，非必填，默认15，范围3-100
			 * 			options.sucFunc 处理函数 function(datas){}
			 * 				datas.jfMall 积分商城信息
			 * 					datas.jfMall.jfMallId 积分商城id
			 * 					datas.jfMall.name 积分商城名称
			 * 					datas.jfMall.unit 积分名称
			 * 					datas.jfMall.rate 积分汇率，参考值，1元等价于多少积分
			 * 					datas.jfMall.beginTime 开始时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.endTime 结束时间 yyyy-MM-dd HH:mm:ss
			 * 					datas.jfMall.imageUrl 积分商城图片地址
			 * 				datas.jfUser 积分用户信息
			 * 					datas.jfUser.jfUserId 积分用户id
			 * 					datas.jfUser.jfMallId 积分商城id		
			 * 					datas.jfUser.name 用户姓名
			 * 					datas.jfUser.phone 手机号码	
			 * 					datas.jfUser.wxNick 微信昵称
			 * 					datas.jfUser.wxOpenId 微信openId
			 * 					datas.jfUser.wxHeadUrl 微信头像
			 * 					datas.jfUser.jfActivityCount 参与次数
			 * 					datas.jfUser.awardCount 中奖次数
			 * 				datas.page 分页内容
			 * 					datas.page.currentPage 当前页面
			 * 					datas.page.totalPage 总页数
			 * 					datas.page.totalResult 记录总数
			 * 					datas.page.shouCount 每页显示数量
			 * 					datas.page.list 微信红包账户明细列表 Array
			 * 						datas.page.list.jfAccountDetailId 账户明细记录id
			 * 						datas.page.list.accountType 账户类型[JF-积分账户,WXLJ-微信红包-立即发放,WXZT-微信红包-用户自提]
			 * 						datas.page.list.traceNo 交易号
			 * 						datas.page.list.amount 交易金额
			 * 						datas.page.list.balance 交易完成后账户余额
			 * 						datas.page.list.jfActivityName 活动名称
			 * 						datas.page.list.type 类型[in-入账,out-出账]
			 * 						datas.page.list.operateType 账户操作类型[REDUCE-扣除余额,PRIZE-发奖,SEND-自动发放,GET-手动提取,RETURN-返还退款]
			 * 						datas.page.list.createTime 交易时间 yyyy-MM-dd HH:mm:ss
			 */
			loadWxDetail : function(options){
				options.action='/jfMall/loadWxDetail';
				this.ajax(options);
			},
			
			
			/**
			 * 
			 * 微信提现
			 * 
			 * @param options 参数
			 * 			options.data 请求参数
			 * 				options.data.amount 提现金额，1-200
			 * 			options.sucFunc 处理函数,function(datas){}
			 * 				datas.jfAccountId 积分账户id
			 * 				datas.jfAccountDetailId 积分账户明细id
			 * 				datas.jfAccountWxRecordId 积分商城微信红包发放记录id
			 * 
			 */
			wxzt : function(options){
				options.action='/jfMall/wxzt';
				this.ajax(options);
			},
			
			
			/**
			 * 加载省份列表
			 * 
			 * @param options
			 * 			<br>options.data 请求数据
			 * 			<br>options.sucFunc 加载成功处理 function(datas){}
			 * 				<br>datas.list 省份列表
			 * 				<br>datas.list.name 省份名称
			 * 				<br>datas.list.provinceId 省份id
			 */
			loadProvinceList : function(options){
				options.action='/commons/loadProvinceList';
				this.ajax(options);
			},// 
			
			
			/**
			 * 加载城市列表
			 * 
			 * @param options
			 * 			<br>options.data 请求数据
			 * 				<br>options.data.provinceId 城市id
			 * 			<br>options.sucFunc 加载成功处理 function(datas){}
			 * 				<br>datas.list 城市列表
			 * 				<br>datas.list.name 省份名称
			 * 				<br>datas.list.cityId 城市id
			 */
			loadCityList : function(options){
				options.action='/commons/loadCityList';
				this.ajax(options);
			},// 
			
			/**
			 * 加载县列表
			 * 
			 * @param options
			 * 			<br>options.data 请求数据
			 * 				<br>options.data.cityId 省份id
			 * 			<br>options.sucFunc 加载成功处理 function(datas){}
			 * 				<br>datas.list 县列表
			 * 				<br>datas.list.name 省份名称
			 * 				<br>datas.list.countyId 县id
			 */
			loadCountyList : function(options){
				options.action='/commons/loadCountyList';
				this.ajax(options);
			},// 
			
			/**
			 * 加载镇列表
			 * 
			 * @param options
			 * 			<br>options.data 请求数据
			 * 				<br>options.data.countyId 县id
			 * 			<br>options.sucFunc 加载成功处理 function(datas){}
			 * 				<br>datas.list 乡镇列表
			 * 				<br>datas.list.name 省份名称
			 * 				<br>datas.list.townId 乡镇id
			 */
			loadTownList : function(options){
				options.action='/commons/loadTownList';
				this.ajax(options);
			},// 
			
			
			/**
			 * 初始化省市区下拉框
			 * 
			 * @param options
			 * 			<br>options.province 省份select元素
			 * 			<br>options.city 市select元素
			 * 			<br>options.county 县select元素
			 * 			<br>options.town 镇select元素
			 * 
			 */
			initialArea : function(options){
				
				var _this = this;
				var _selectProvince = $(options.province);
				var _selectCity = $(options.city);
				var _selectCounty = $(options.county);
				var _selectTown = $(options.town);
				
				//加载城市列表
				function loadCityList(provinceId){
					
					if(_selectCity.length==0) return;
					_selectCity.empty();
					_selectCity.show();
					_this.loadCityList({
						data : {
							provinceId : provinceId,
						},
						sucFunc : function(datas){
							for(var i=0;i<datas.list.length;i++){
								var city = datas.list[i];
								_selectCity.append('<option value="'+city.cityId+'">'+city.name+'</option>');
							}
							
							var cityId = _selectCity.val();
							if(cityId == null || cityId == 0 || cityId=='') return;
							loadCountyList(cityId);
						}
					});
				};
				
				//加载县列表
				function loadCountyList(cityId){
					
					if(_selectCounty.length==0) return;
					_selectCounty.empty();
					
					_this.loadCountyList({
						data : {
							cityId : cityId,
						},
						sucFunc : function(datas){
							
							if(datas.list.length==0) {
								_selectCounty.hide();
								return;
							}
							
							_selectCounty.show();
							
							for(var i=0;i<datas.list.length;i++){
								var county = datas.list[i];
								_selectCounty.append('<option value="'+county.countyId+'">'+county.name+'</option>');
							}
							
							var countyId = _selectCounty.val();
							if(countyId == null || countyId == 0 || countyId=='') return;
							loadTownList(countyId);
						}
					});
				};
				
				//加载镇列表
				function loadTownList(countyId){
					
					if(_selectTown.length==0) return;
					_selectTown.empty();
					
					_this.loadTownList({
						data : {
							countyId : countyId,
						},
						sucFunc : function(datas){
							
							if(datas.list.length==0) {
								_selectTown.hide();
								return;
							}
							
							_selectTown.show();
							
							for(var i=0;i<datas.list.length;i++){
								var town = datas.list[i];
								_selectTown.append('<option value="'+town.townId+'">'+town.name+'</option>');
							}
						}
					});
				};
				
				//初始化省
				if(_selectProvince.length>0){
					_this.loadProvinceList({
						sucFunc : function(datas){
							
							for(var i=0;i<datas.list.length;i++){
								var province = datas.list[i];
								_selectProvince.append('<option value="'+province.provinceId+'">'+province.name+'</option>');
							}
							var provinceId = _selectProvince.val();
							loadCityList(provinceId);
						}
					});
					
					_selectProvince.change(function(){
						var provinceId = $(this).val();
						loadCityList(provinceId);
					});
				};
				
				if(_selectCity.length>0){
					
					_selectCity.change(function(){
						var cityId = $(this).val();
						if(cityId == null ||cityId == 0 || cityId=='') return;
						loadCountyList(cityId);
					});
				}
				
				if(_selectCounty.length>0){
					
					_selectCounty.change(function(){
						var countyId = $(this).val();
						if(countyId == null || countyId == 0 || countyId=='') return;
						loadTownList(countyId);
					});
				}
				
			},// 
			
			
			/**
			 * 消费者未登录或者登录失效提示
			 * 
			 * @param msg 提示信息
			 * 
			 */
			notLogin : function(msg,errorCode){
				
				//this.showErrorMsg(msg,errorCode);
				// 重新获取授权
				if(!this.settings.host) return;
				var currentUrl = getCurrentUrl();//jfMall-host.js
				var wxUrl = this.settings.host + '/weixin/ysWxAuthorize';
				gotoUrl(wxUrl,{
					jfMallId : $('#jfMallId').val(),
					uri : currentUrl
				})
				
			},
			
			/**
			 * 错误提示
			 * 
			 * @param msg 提示信息
			 * 
			 */
			showErrorMsg : function(msg,errorCode){
				if(this.settings.errorCodes[errorCode]) msg = this.settings.errorCodes[errorCode];
				else if(errorCode) msg = msg+"[错误:"+errorCode+"]";
				$.alert(msg);
			},//end $.jfMall.showErrorMsg
			
			/**
			 * 错误提示
			 * 
			 * @param msg 提示信息
			 * 
			 */
			showSuccessMsg : function(msg,sucFunc){
				$.alert(msg);
				if(sucFunc) sucFunc.call(this);
			}//end $.jfMall.showErrorMsg
			
		} //end $.jfMall
	});
	
	//初始化配置
	$.jfMall.init();
	
	//设置host，依赖jfMall-host.js
	if(host){
		//设置默认配置
		$.jfMall.setDefaults({
			host : host
		});
		
	}
	
})(jQuery);