/*
 * @(#)SimpleSecurityEnvSvc.java     2021-03-24(024) 오전 11:20
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

import com.vertexid.spring.utils.BaseProperties;
import com.vertexid.viself.base.BaseSvc;
import org.springframework.stereotype.Service;

import java.util.HashSet;

/**
 * <b>Description</b>
 * <pre>
 *     Simple Security 환경변수 로딩 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
public class SimpleSecurityEnvSvc extends BaseSvc {


    public SimpleSecurityEnvVO getEnv() {

        SimpleSecurityEnvVO envVO = new SimpleSecurityEnvVO();

        envVO.setLoginURI(BaseProperties.get("security.loginURI"));
        envVO.setLoginProcURI(BaseProperties.get("security.loginProcURI"));
        envVO.setLogoutURI(BaseProperties.get("security.logoutURI"));
        envVO.setExpiredURI(BaseProperties.get("security.expiredURI"));
        envVO.setIdParamName(BaseProperties.get("security.idParamName"));
        envVO.setPwParamName(BaseProperties.get("security.pwParamName"));
        envVO.setIgnoreURIs(new HashSet<>(BaseProperties.getList("security.ignoreURIs")));

        String csrfYn = BaseProperties.get("security.csrfYn");
        if (csrfYn.equalsIgnoreCase("Y")) {
            csrfYn = "true";
        }

        envVO.setCsrfYn(Boolean.parseBoolean(csrfYn));

        envVO.setCsrfIgnoreURIs(new HashSet<>(
                BaseProperties.getList("security.csrf.ignoreURIs")));

        envVO.setAllowIfAllAbstainDecisions(Boolean.parseBoolean(
                BaseProperties.get("security.allowIfAllAbstainDecisions")));

        return envVO;
    }
}
