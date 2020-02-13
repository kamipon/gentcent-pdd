package com.keji09.erp.utils;

import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import net.sf.json.util.CycleDetectionStrategy;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;

public class JsonUtils {
    
	public static JSONObject toJSONObject(Object obj) {
		return JSONObject.fromObject(obj, getJsonConfig());
	}
	
	public static JSONArray toJSONArray(Object obj) {
		return JSONArray.fromObject(obj, getJsonConfig());
	}
	
	public static <T> List<T> toList(Object obj,Class<T> clazz) {
		JSONArray arr = toJSONArray(obj);
		@SuppressWarnings({ "unchecked", "deprecation" })
		List<T> list = JSONArray.toList(arr, clazz);
		return list;
	}
	
	/**
	 *  2016-03-01 00:00:00 替换为 2016-03-01 <br/>
	 * 如果报错返回原始数据
	 */
	public static JSONObject replaceDateTime(JSONObject source) {
	    JSONObject result = source;
	    try {
            String ss = source.toString();
            String formatJson = ss.replaceAll(" \\d{2}:\\d{2}:\\d{2}", "");
            result = JSONObject.fromObject(formatJson);
        } catch (Exception e) {
        }
	    return result;
	}
	
	
	public static <T> T toObject(String json, Class<T> valueType) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
		DeserializationConfig cfg = mapper.getDeserializationConfig();
		cfg.setDateFormat(DateUtil.SDF_DATETIME);
		mapper.setDeserializationConfig(cfg);
		try {
			return mapper.readValue(json, valueType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static JsonConfig getJsonConfig() {
		JsonConfig config = new JsonConfig();
		//去掉class
		config.setIgnoreDefaultExcludes(false);
		//禁止自包含
		config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		//处理日期转换
		config.registerJsonValueProcessor(Date.class, new Date_JsonValueProcessor());
		return config;
	}
	
}

class Date_JsonValueProcessor implements JsonValueProcessor{

	public Object processArrayValue(Object value, JsonConfig config) {
		return process(value, config);
	}

	public Object processObjectValue(String key, Object value,
			JsonConfig config) {
		return process(value, config);
	};

	private Object process(Object value, JsonConfig config) {
	    if(value == null) {
	        return "";
	    }
		if (value instanceof Date) {
			String date = DateUtil.SDF_DATETIME.format((Date)value);
			return date;
		} else {
			return value == null ? null : value.toString();
		}
	}
	
}