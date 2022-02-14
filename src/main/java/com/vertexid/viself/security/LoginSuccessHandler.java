/*
 * @(#)LoginSuccessHandler.java     2021-02-02(002) 오후 3:19
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <b>Description</b>
 * <pre>
 *     로그인 성공 처리
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface LoginSuccessHandler {

    /**
     * 로그인 성공 처리
     * @param request request
     * @param response response
     * @param loginInfo 로그인 정보
     * @param <T> UserDetails 를 구현한 로그인 정보
     */
    <T> void successProc(HttpServletRequest request, HttpServletResponse response, T loginInfo)
            throws IOException;
}
