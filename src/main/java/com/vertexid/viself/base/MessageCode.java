/*
 * @(#)MessageCode.java     2020-04-23 오후 4:05
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
 * <b>Description</b>
 * 메시지 코드
 * @author Yang, Ki Hwa
 */
public enum MessageCode {

    COMPLETE("S", "M.처리_되었습니다"), ERROR("E", "M.처리중_오류발생");

    private final String msgCode;
    private final String resultCode;

    MessageCode(String resultCode, String msgCode) {
        this.resultCode = resultCode;
        this.msgCode = msgCode;
    }

    public String getMsgCode() {
        return msgCode;
    }

    public String getResultCode() {
        return resultCode;
    }
}
