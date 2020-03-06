package com.keji09.erp.api.service;

import com.keji09.erp.model.DictionaryEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.OrderEntity;
import com.mezingr.dao.HDaoUtils;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.*;
import com.pdd.pop.sdk.http.api.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author zuozhi
 * @since 2020-02-14
 */
@Service
public class MicroService {
	Timer timer;
	public MicroService() {

		timer = new Timer();
        timer.schedule(new RemindTask(),10*1000, 1*1000);
		System.out.println("定时任务启动,准备更新订单！");
	}
	class RemindTask extends TimerTask {
		public void run() {
			System.out.println("更新行情");
		}
	}
}
