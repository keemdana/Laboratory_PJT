/*
 * @(#)LoginFailHandler.java     2021-02-02(002) 오후 3:22
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
package com.vertexid.viself.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <b>Description</b>
 * <pre>
 *     로그인 실패 처리
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface LoginFailHandler {

    /**
     * 로그인 실패 처리
     * @param request request
     * @param response response
     * @param exception exception
     * @param <E> 실패 오류
     * @throws ServletException redirect 혹은 forward 오류
     * @throws IOException io 오류
     */
    <E> void failureProc(HttpServletRequest request,
            HttpServletResponse response, E exception)
            throws ServletException, IOException;
}
