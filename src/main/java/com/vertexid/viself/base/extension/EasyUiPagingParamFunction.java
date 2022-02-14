/*
 * @(#)EasyUiPagingParamFunction.java     2021-01-07(007) 오후 4:47
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
package com.vertexid.viself.base.extension;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.vertexid.viself.base.PagingParamFunction;

/**
 * <b>Description</b>
 * <pre>
 *     Easy UI용 페이징 처리
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class EasyUiPagingParamFunction implements PagingParamFunction {

    private static final String STRING_SEPERATOR = ",";

    @Override
    public void setOrderParam(Map<String, Object> params) {
        String tmpSort = (String) params.get("sort");
        String tmpOrder = (String) params.get("order");
//        String sort = "";
//        String order = "";
//        String[] sorts;
//        String[] orders;
//        if(tmpSort.contains(",")) {
//        	params.put("sorts", StringUtils.split(tmpSort, STRING_SEPERATOR));
//        }else {
//        	params.put("sorts", tmpSort);
//        }
//        if(tmpOrder.contains(",")) {
//        	params.put("orders", StringUtils.split(tmpOrder, STRING_SEPERATOR));
//        }else {
//        	params.put("orders", tmpOrder);
//        }

        String[] sorts = (StringUtils.isNotEmpty(tmpSort)) ?
                StringUtils.split(tmpSort, STRING_SEPERATOR) : null;
        String[] orders = (StringUtils.isNotEmpty(tmpOrder)) ?
                StringUtils.split(tmpOrder, STRING_SEPERATOR) : null;

        params.put("sorts", sorts);
        params.put("orders", orders);
    }
}
