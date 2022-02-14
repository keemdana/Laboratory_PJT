/*
 * @(#)CmmFilter.java     2020-10-30(030) 오전 8:07
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
package com.vertexid.viself.base;

import java.io.IOException;
import java.util.*;

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
import org.springframework.util.AntPathMatcher;

/**
 * <b>Description</b>
 * <pre>
 *     공통 필터
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class CmmFilter implements Filter {

    /**
     * logger
     */
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    private final AntPathMatcher antPathMatcher = new AntPathMatcher();

    private Set<String> excludedUrls;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String excludePattern = filterConfig.getInitParameter("excludedUrls");
        excludedUrls = new HashSet<>();
        excludedUrls.addAll(Arrays.asList(excludePattern.split(",")));
    }

    @Override
    public void doFilter(ServletRequest request,
            ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        try{

            String path = ((HttpServletRequest) request).getServletPath();
            Iterator<String> iterator = excludedUrls.iterator();
            boolean isWrappFlag = true;
            while (iterator.hasNext()) {
                String tmpPattern = iterator.next();
                if (antPathMatcher.match(tmpPattern, path)) {
                    isWrappFlag = false;
                    break;
                }
            }// end of while
            if(isWrappFlag){
                // Request Wrapper
                HttpServletRequestWrapper requestWrapper =
                        new CmmRequestWrapper(((HttpServletRequest) request));

                chain.doFilter(requestWrapper, response);
            }else{
                log.info("no wrapping path......."+path);
                chain.doFilter(request, response);
            }

        }catch(Exception e){
            e.printStackTrace();
            throw new RuntimeException();
        }
    }

    @Override
    public void destroy() {

    }
}
