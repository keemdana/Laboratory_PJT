/*
 * @(#)SimpleSecurityFilter.java     2021-01-20(020) 오후 3:11
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

import javax.annotation.Resource;
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
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Component;

/**
 * <b>Description</b>
 * <pre>
 *      단순 보안 필터
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class SimpleSecurityFilter implements Filter {

    /*
     * copycat SpringSecurity
     *
     * spring security 를 공부하면서 유사하게 구성해봄
     * 이 구조를 보고 spring security 를 보면 초큼은 접근이 쉽지 않을까....
     */

    /**
     * logger
     */
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Resource
    SimpleAccessControlManager simpleAccessControlManager;

    @Resource
    SimpleAccessDeniedHandler simpleAccessDeniedHandler;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info(".......................init Simple Security Filter!!");
    }

    @Override
    public void doFilter(ServletRequest request,
            ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        try {
            if (checkSecurity(request, response)) {
                chain.doFilter(request, response);
            }
        } catch (Exception e) {
            log.debug("!!!!!!!!!!!!!!!"+((HttpServletRequest)request).getRequestURI());
            e.printStackTrace();
            log.error(e.getMessage());
            if(e instanceof AccessDeniedException){
                simpleAccessDeniedHandler.handle((HttpServletRequest) request, (HttpServletResponse) response, (AccessDeniedException) e);
            }else{
                throw new RuntimeException();
            }
        }
    }

    /**
     * 접근 제어 검사
     *
     * @param request  request
     * @param response response
     * @return true: 접근허가, other: 접근 불가
     */
    private boolean checkSecurity(ServletRequest request,
            ServletResponse response) throws IOException, ServletException {

//        log.debug(">>>>>>>>>>>>>>>>"+((HttpServletRequest)request).getRequestURI());

        return simpleAccessControlManager.checkAccess(request, response);
    }

    @Override
    public void destroy() {

    }
}
