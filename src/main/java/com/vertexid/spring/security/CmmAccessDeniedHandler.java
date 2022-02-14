/*
 * @(#)CmmAccessDeniedHandler.java     2021-01-13(013) 오후 5:15
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

import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseHandler;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.csrf.MissingCsrfTokenException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * <b>Description</b>
 * <pre>
 *     TODO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class CmmAccessDeniedHandler extends BaseHandler implements
        AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request,
            HttpServletResponse response, AccessDeniedException exception)
            throws IOException, ServletException {

        log.error("exception......"+ exception.getMessage());

        Authentication authentication = SessionUtils.getAuthentication();



        if (exception instanceof MissingCsrfTokenException) {
            /* Handle as a session timeout (redirect, etc).
            Even better if you inject the InvalidSessionStrategy
            used by your SessionManagementFilter, like this:
            invalidSessionStrategy.onInvalidSessionDetected(request, response);
            */
        } else {
            /* Redirect to a error page, send HTTP 403, etc. */
        }

        throw new RuntimeException("Access Denied");

        // login 일경우.... .....

    }
}
