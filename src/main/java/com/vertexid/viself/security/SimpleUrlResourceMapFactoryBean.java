/*
 * @(#)SimpleUrlResourceMapFactoryBean.java     2021-03-30(030) 오전 10:47
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

import com.vertexid.viself.base.BaseSvc;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 *     UrlResourceMap Factory Bean
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class SimpleUrlResourceMapFactoryBean extends BaseSvc implements
        FactoryBean<LinkedHashMap<RequestMatcher, List<ConfigAttribute>>> {

    private SimpleSecureObjectSvc simpleSecureObjectSvc;

    private LinkedHashMap<RequestMatcher, List<ConfigAttribute>> requestMap;

    public void setSecureObjectSvc(SimpleSecureObjectSvc simpleSecureObjectSvc) {
        this.simpleSecureObjectSvc = simpleSecureObjectSvc;
    }

    public void init() throws Exception{
        requestMap = simpleSecureObjectSvc.getRolesAndUrl();
    }

    @Override
    public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getObject()
            throws Exception {
        if(null == requestMap){
            requestMap = simpleSecureObjectSvc.getRolesAndUrl();
        }

        return requestMap;
    }

    @Override
    public Class<?> getObjectType() {
        return LinkedHashMap.class;
    }

    @Override
    public boolean isSingleton() {
        return true;
    }
}
