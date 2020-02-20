package com.keji09.erp.service;

import com.keji09.erp.model.DictionaryEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.OrderEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.mezingr.dao.HDaoUtils;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkOrderListIncrementGetRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkOrderListIncrementGetResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

@Service
public class OrderTask extends XDAOSupport {

    @Autowired
    private PopHttpClient client;

    Timer timer;
    public OrderTask() {

        timer = new Timer();
        //timer.schedule(new RemindTask(),10*1000, 100*1000);
        System.out.println("定时任务启动,准备更新订单！");
    }

    class RemindTask extends TimerTask {
        public void run() {
            Integer pageSize =40;
            Integer page =1;
            //当前时间
            Long date1 = new Date().getTime()/1000;
            //查询字典 获取上次更新时间
            DictionaryEntity dic = getDictionaryEntityDAO().findUnique(HDaoUtils.eq("key","orderLastDate").toCondition());
            Long LastDate =null;
            if(dic==null){
                LastDate = date1 - 86400L;
                dic = new DictionaryEntity();
                dic.setKey("orderLastDate");
                dic.setValue(LastDate.toString());
                dic.setDesc("记录订单最后的更新时间");
                getDictionaryEntityDAO().create(dic);
            }else{
                LastDate = Long.valueOf(dic.getValue());
            }
            //通过上次更新时间 和当前时间进行查询 如果上次的查询时间和当前时间的间隔大于24小时则只查询24小时
            if(date1-LastDate>86400L){
                date1 = LastDate+86400L;
            }
            boolean flag =true;//判断是否已经查询完毕
            while (flag){//循环查询
                PddDdkOrderListIncrementGetRequest request = new PddDdkOrderListIncrementGetRequest();
                request.setStartUpdateTime(LastDate);
                request.setEndUpdateTime(date1);
                request.setPageSize(pageSize);
                request.setPage(page);
                request.setReturnCount(true);//是否返回总条数
                PddDdkOrderListIncrementGetResponse response = null;
                try {
                    response = response = client.syncInvoke(request);
                } catch (Exception e) {
                    System.out.println("查询失败");
                    e.printStackTrace();
                    flag = false;
                    break;
                }
                response.getOrderListGetResponse().getOrderList();//获取数据
                //数据的总数
                long totalCount =  response.getOrderListGetResponse().getTotalCount();
                for (PddDdkOrderListIncrementGetResponse.OrderListGetResponseOrderListItem o :response.getOrderListGetResponse().getOrderList()) {
                    //查询数据库里是否已经存在
                    OrderEntity order = getOrderEntityDAO().findUnique(HDaoUtils.eq("goodsId",o.getGoodsId()).toCondition());
                    if(order==null){//数据库不存创建订单
                        //通过pid查询所属的用户 ,如果不存在就跳过
                        MemberEntity member =  getMemberEntityDAO().findUnique(HDaoUtils.eq("pid",o.getPId()).toCondition());
                        if(member!=null){
                            order =new OrderEntity();
                            order.setMemberId(member.getId());
                            order.setActivityId(member.getActivity().getId());
                            order.setTepId(member.getTerpointId());
                            order.setO(o);
                            getOrderEntityDAO().create(order);
                        }
                    }else{//存在更新订单
                        order.setO(o);
                        getOrderEntityDAO().update(order);
                    }
                }
                if(page*pageSize>totalCount){
                    //查询完成后更新<<上次更新时间>>
                    dic.setValue(date1.toString());
                    getDictionaryEntityDAO().update(dic);
                    flag = false;
                    System.out.println("订单更新成功,更新数量:"+totalCount);
                }else{
                    page+=1;
                }
            }
        }
    }
}
