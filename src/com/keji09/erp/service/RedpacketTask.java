package com.keji09.erp.service;

import com.keji09.erp.model.support.XDAOSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Timer;
import java.util.TimerTask;

@Service
public class RedpacketTask extends XDAOSupport {
	
	Timer timer;
	@Autowired
	RedpacketService redpacketService;
	
	public RedpacketTask() {
		timer = new Timer();
//		timer.schedule(new RemindTask(), 5 * 1000);
	}
	
	class RemindTask extends TimerTask {
		public void run() {
			System.out.println("定时任务启动,准备同步红包派代理！");
			redpacketService.increaseTerpoint();
			System.out.println("定时任务启动,准备同步红包派商家！");
			redpacketService.increaseActivity();
		}
	}
	
}
