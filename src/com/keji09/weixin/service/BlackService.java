package com.keji09.weixin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.keji09.erp.model.support.XDAOSupport;

/**
 * 黑名单service
 * @author Administrator
 *
 */
@Service
public class BlackService extends XDAOSupport{
	public static Map<String,Integer> map = new ConcurrentHashMap<String,Integer>();
	public static List<String> list = new ArrayList<String>();
	private static Log log = LogFactory.getLog(BlackService.class);
	Timer timer;
	public BlackService(){
//		timer = new Timer();
//		timer.schedule(new RemindTask(),10*1000, 24*3600*1000);
//		log.info("定时任务启动,清空访问ip");
	}
	class RemindTask extends TimerTask {
        public void run() {
        	init();
        }
	}
	/**
	 * 初始化缓存
	 */
	public void init(){
		map.clear();
	}
	
	/**
	 * 动态添加某ip到黑名单
	 */
	public void initBlack(String ip){
	}
	
}
