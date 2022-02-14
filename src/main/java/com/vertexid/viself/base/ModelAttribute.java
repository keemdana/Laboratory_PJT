/*
 * @(#)ModelAttribute.java     2019-11-19 오후 5:52
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

/**
 * 모델에서 주로사용하는 속성
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public enum ModelAttribute {
    MSG("msg"),
    DATA("data"),
    ERROR_FLAG("errYn"),
    REQUEST("requestData"),
    RESPONSE("responseData")
    ;

    private final String attributeId;

    ModelAttribute(String attributeId) {
        this.attributeId = attributeId;
    }

    public String getAttributeId() {
        return attributeId;
    }
}
