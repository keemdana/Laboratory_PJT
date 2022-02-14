/*
 * @(#)JsonUtil.java     2020-10-30(030) 오후 4:29
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */
package com.vertexid.commons.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * <b>Description</b>
 * <pre>
 *     JSON Util
 *
 *     출처: https://androi.tistory.com/335 [안드로이 스토리]
 *     [참고] https://zzznara2.tistory.com/687
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class JsonUtil {
	/**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * Map을 json으로 변환한다.
     *
     * @param map Map<String, Object>.
     * @return JSONObject.
     */
    public static JSONObject getJsonObjectFromMap(Map<String, Object> map) {
        JSONObject jsonObject = new JSONObject();
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
        }

        return jsonObject;
    }
    /**
     * Map을 json으로 변환한다.
     *
     * @param map Map<String, Object>.
     * @return JSONObject.
     */
    public static String getJsonStringFromMap(Map<String, Object> map) {

    	ObjectMapper mapper = new ObjectMapper();
    	String json = "";
    	try {

    		json = mapper.writeValueAsString(map);
    		System.out.println(json); // compact-print
			json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(map);
			System.out.println(json); // pretty-print

		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    	return json;
    }

    /**
     * List<Map>을 jsonArray로 변환한다.
     *
     * @param list List<Map<String, Object>>.
     * @return JSONArray.
     */
    public static JSONArray getJsonArrayFromList(
            List<Map<String, Object>> list) {
        JSONArray jsonArray = new JSONArray();
        for (Map<String, Object> map : list) {
            jsonArray.add(getJsonStringFromMap(map));
        }

        return jsonArray;
    }

    /**
     * List<Map>을 jsonString으로 변환한다.
     *
     * @param list List<Map<String, Object>>.
     * @return String.
     */
    public static String getJsonStringFromList(List<Map<String, Object>> list) {
        JSONArray jsonArray = getJsonArrayFromList(list);
        return jsonArray.toString();
    }

    /**
     * JsonObject를 Map<String, String>으로 변환한다.
     *
     * @param jsonObj JSONObject.
     * @return Map<String, Object>.
     */
    @SuppressWarnings("unchecked")
    public static Map<String, Object> getMapFromJsonObject(JSONObject jsonObj) {
        Map<String, Object> map = null;

        try {

            map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }

        return map;
    }

    /**
     * JsonArray를 List<Map<String, String>>으로 변환한다.
     *
     * @param jsonArray JSONArray.
     * @return List<Map < String, Object>>.
     */
    public static List<Object> getListMapFromJsonArray(
            JSONArray jsonArray) {
        List<Object> list = new ArrayList<Object>();

        if (jsonArray != null) {
            int jsonSize = jsonArray.size();
            for (int i = 0; i < jsonSize; i++) {
                Map<String, Object> map = JsonUtil.getMapFromJsonObject(
                        (JSONObject) jsonArray.get(i));
                list.add(map);
            }
        }

        return list;
    }

    /**
     * parse object to json string
     * @param value
     * @return
     */
    public static String parseJsonString(Object value)
    {
    	try {
    		ObjectMapper mapper = new ObjectMapper().configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
    		return mapper.writeValueAsString(value);
    	} catch (Exception ex) {
    		System.out.println("Connection Exception occurred");
    		return null;
    	}
    }

	@SuppressWarnings("unchecked")
    public static List<Object> parseJsonStringToList(String jsonString) {
    	List<Object> rtnList = null;

    	if(StringUtils.isNotBlank(jsonString)){
    		JSONArray jArr = new JSONArray();
    		rtnList = new ArrayList<Object>();
				ObjectMapper objectMapper = new ObjectMapper();

				try {
					jArr = (JSONArray)objectMapper.readValue(jsonString, JSONArray.class);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

    			for (int i = 0; i < jArr.size(); i++) {
    				ParamMap<String,Object> map = new ParamMap<String, Object>();
    				JSONObject jobj = (JSONObject) jArr.get(i);

    				Set<String> set = jobj.keySet();
    				for (String key : set) {
    					map.put(key, jobj.get(key));
    				}
    				rtnList.add(map);
    			}
    	}
    	return rtnList;
    }
}
