/*
 * @(#)EncodingFilter.java     2019-12-16 오후 5:29
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
package com.vertexid.commons.utils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <b>Description</b>
 * <pre>
 *      UTF-8을 사용하기 위한 필터
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 * @deprecated org.springframework.web.filter.CharacterEncodingFilter 사용
 */
public class EncodingFilter implements Filter {

    /**
     * logger
     */
    private final Logger log = LoggerFactory.getLogger(this.getClass());


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        // character encoding
        setCaracterEncoding(request, response);
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }

    /**
     * character encoding
     * @param request
     * @param response
     * @throws UnsupportedEncodingException
     */
    private void setCaracterEncoding(ServletRequest request, ServletResponse response)
            throws UnsupportedEncodingException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String charSet = "UTF-8";
        httpRequest.setCharacterEncoding(charSet);
        httpResponse.setCharacterEncoding(charSet);
    }
}
