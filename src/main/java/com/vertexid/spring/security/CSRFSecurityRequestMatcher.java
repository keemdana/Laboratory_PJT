/*
 * @(#)CSRFSecurityRequestMatcher.java     2019-12-17 오후 1:25
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
package com.vertexid.spring.security;

import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.servlet.http.HttpServletRequest;

/**
 * <b>Description</b>
 * <pre>
 *     Spring Security 의 CSRF Token용 커스텀 RequestMatcher
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class CSRFSecurityRequestMatcher implements RequestMatcher {

    @Override
    public boolean matches(HttpServletRequest request) {
//        if(allowedMethods.matcher(request.getMethod()).matches()){
//
//            return false;
//
//        }
//
//
//        return !unprotectedMatcher.matches(request);

        return false;
    }
}
