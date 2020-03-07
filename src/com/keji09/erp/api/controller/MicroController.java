package com.keji09.erp.api.controller;

import com.keji09.erp.api.service.MicroService;
import com.keji09.erp.model.BillEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.support.XDAOSupport;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/micro_data")
public class MicroController extends XDAOSupport {
    private static List<String> symbolList = new ArrayList<>();
    /**
     * 数据缓存
     */
    private static Map<String,Object> timeQuotation = new HashMap<>();

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
        JSONArray data = null;
        if(MicroService.symbolList.contains(symbol)){
            if(time.equals("1W")||time.equals("1M")){
                time="1D";
            }
            MicroService.timeQuotation.get(symbol+"_"+time);
        }else{//加入缓存列表 通过接口返回数据
            symbolList.add(symbol);
            data = MicroService.timeQuotation(symbol,time,count);
        }
        map.put("data", data);
        return map;
    }
}
