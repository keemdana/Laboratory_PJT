/*
 * @(#)SimpleRedirectStrategy.java     2021-02-03(003) 오후 12:32
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

import org.springframework.security.web.DefaultRedirectStrategy;

/**
 * <b>Description</b>
 * <pre>
 *     RedirectStrategy
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class SimpleRedirectStrategy extends DefaultRedirectStrategy {

    public SimpleRedirectStrategy() {
        super();
    }

    @Override
    public void sendRedirect(HttpServletRequest request,
            HttpServletResponse response, String url) throws IOException {
        super.sendRedirect(request, response, url);
    }
}
