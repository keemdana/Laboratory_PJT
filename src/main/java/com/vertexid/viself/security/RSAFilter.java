/*
 * @(#)RSAFIlter.java     2019-12-16 오후 5:39
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

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <b>Description</b>
 * <pre>
 *     RSA 복호화를 위한 필터
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 * @deprecated com.vertexid.viself.base.CmmFilter 사용
 */
public class RSAFilter implements Filter {

    /**
     * logger
     */
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        // Request Wrapper
        HttpServletRequestWrapper requestWrapper =
                new RSARequestWrapper(((HttpServletRequest) request));

        chain.doFilter(requestWrapper, response);
    }

    @Override
    public void destroy() {

    }
}
