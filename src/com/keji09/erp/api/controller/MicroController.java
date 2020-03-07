package com.keji09.erp.api.controller;

import com.keji09.erp.api.service.MicroService;
import com.keji09.erp.model.BillEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.support.XDAOSupport;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/micro_data")
public class MicroController extends XDAOSupport {

    @RequestMapping(value = "getTimeQuotation", method = RequestMethod.GET)
    @ResponseBody
    public Object getTimeQuotation(
            @RequestParam(value = "symbol") String symbol,//商品代码
            @RequestParam(value = "time",defaultValue = "1") String time,//时间间隔
            @RequestParam(value = "count",defaultValue = "100") Integer count,//条数
            HttpServletRequest req, HttpServletResponse resp
            , ModelMap map) {
        if(symbol.equals("")){
            return map;
        }
        if(MicroService.symbolList.contains(symbol)){
            if(time.equals("1W")||time.equals("1M")){
                time="1D";
            }
            if(count>=MicroService.timeQuotation.size()){
                map.put("data", MicroService.timeQuotation.get(symbol+"_"+time));
            }else{
                List data = MicroService.timeQuotation.get(symbol+"_"+time).subList(0,count);
                map.put("data", data);
            }
        }else{//加入缓存列表 通过接口返回数据
            MicroService.symbolList.add(symbol);
            JSONArray data  = MicroService.timeQuotation(symbol,time,count);
            map.put("data", data);
        }
        return map;
    }
}
