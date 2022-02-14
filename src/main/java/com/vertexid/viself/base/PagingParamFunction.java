/*
 * @(#)PagingParamFunction.java     2021-01-07(007) 오후 4:44
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
package com.vertexid.viself.base;

import java.util.Map;

/**
 * <b>Description</b>
 * <pre>
 *     페이징 처리를 위한 파라메터 유틸
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface PagingParamFunction {

    /**
     * order parameter 처리
     * @param params
     */
    void setOrderParam(Map<String, Object> params);
}
