/*
 * @(#)SimpleSecurityEnvMapFactoryBean.java     2021-03-24(024) 오전 11:16
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

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class SimpleSecurityEnvMapFactoryBean extends BaseSvc implements
        FactoryBean<SimpleSecurityEnvVO> {

    private SimpleSecurityEnvVO simpleSecurityEnvVO;

    private SimpleSecurityEnvSvc simpleSecurityEnvSvc;

    public void init(){
        simpleSecurityEnvVO = simpleSecurityEnvSvc.getEnv();
    }

    public void setSimpleSecurityEnvSvc(
            SimpleSecurityEnvSvc simpleSecurityEnvSvc) {
        this.simpleSecurityEnvSvc = simpleSecurityEnvSvc;
    }

    @Override
    public SimpleSecurityEnvVO getObject() throws Exception {
        if(null == simpleSecurityEnvVO){
            init();
        }
        return simpleSecurityEnvVO;
    }

    @Override
    public Class<?> getObjectType() {
        return SimpleSecurityEnvVO.class;
    }

    @Override
    public boolean isSingleton() {
        return true;
    }
}
