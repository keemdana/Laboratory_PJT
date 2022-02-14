/*
 * @(#)BaseThrowable.java     2020-10-26(026) 오전 10:33
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
package com.vertexid.viself.base.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseThrowable extends Throwable{
    private static final long serialVersionUID = 2156183760367808922L;

    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    public BaseThrowable() {
    }

    public BaseThrowable(String message) {
        super(message);
    }

    public BaseThrowable(String message, Throwable cause) {
        super(message, cause);
    }

    public BaseThrowable(Throwable cause) {
        super(cause);
    }

    public BaseThrowable(String message, Throwable cause,
            boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
