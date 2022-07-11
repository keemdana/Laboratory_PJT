/*
 * @(#)AuthenticationManager.java     2021-02-02(002) 오전 11:32
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
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <b>Description</b>
 * <pre>
 *     인증 매니저 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface AuthenticationManager {


    /**
     * 인증 매니저 서비스 유형 얻기
     * @return 인증 매니저 서비스 유형
     */
    String getAuthenticationManagerType();

    /**
     * 로그인 처리
     * @param req request 
     * @param res response
     * @param params
     */
    void loginProc(HttpServletRequest req, HttpServletResponse res,
            Map<String, Object> params) throws IOException, ServletException;

    /**
     * 로그아웃 처리
     * @param req request
     * @param res response
     */
    void logoutProc(HttpServletRequest req, HttpServletResponse res)
            throws IOException;

    BaseLoginDTO getLoginInfo(HttpServletRequest req);
}
