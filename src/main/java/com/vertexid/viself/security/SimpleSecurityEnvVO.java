/*
 * @(#)SimpleSecurityEnvVO.java     2021-03-24(024) 오전 11:05
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

import com.vertexid.viself.base.BaseVO;

import java.util.Set;

/**
 * <b>Description</b>
 * <pre>
 *     Simple Security Filter 환경 정보
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class SimpleSecurityEnvVO extends BaseVO {
    private static final long serialVersionUID = -5634534541944914514L;

    private String loginURI = "/login";
    private String loginProcURI = "/login/proc";
    private String logoutURI = "/logout";
    private String expiredURI = "/login";
    private String idParamName = "encId";
    private String pwParamName = "encPw";
    private Set<String> ignoreURIs;
    private boolean csrfYn;
    private boolean allowIfAllAbstainDecisions;
    private Set<String> csrfIgnoreURIs;

    public SimpleSecurityEnvVO(String loginURI, String loginProcURI,
            String logoutURI, String expiredURI, String idParamName,
            String pwParamName, Set<String> ignoreURIs, boolean csrfYn,
            Set<String> csrfIgnoreURIs, boolean allowIfAllAbstainDecisions) {
        this.loginURI = loginURI;
        this.loginProcURI = loginProcURI;
        this.logoutURI = logoutURI;
        this.expiredURI = expiredURI;
        this.idParamName = idParamName;
        this.pwParamName = pwParamName;
        this.ignoreURIs = ignoreURIs;
        this.csrfYn = csrfYn;
        this.csrfIgnoreURIs = csrfIgnoreURIs;
        this.allowIfAllAbstainDecisions = allowIfAllAbstainDecisions;
    }

    public SimpleSecurityEnvVO() {
    }

    public String getLoginURI() {
        return loginURI;
    }

    public void setLoginURI(String loginURI) {
        this.loginURI = loginURI;
    }

    public String getLoginProcURI() {
        return loginProcURI;
    }

    public void setLoginProcURI(String loginProcURI) {
        this.loginProcURI = loginProcURI;
    }

    public String getLogoutURI() {
        return logoutURI;
    }

    public void setLogoutURI(String logoutURI) {
        this.logoutURI = logoutURI;
    }

    public String getExpiredURI() {
        return expiredURI;
    }

    public void setExpiredURI(String expiredURI) {
        this.expiredURI = expiredURI;
    }

    public String getIdParamName() {
        return idParamName;
    }

    public void setIdParamName(String idParamName) {
        this.idParamName = idParamName;
    }

    public String getPwParamName() {
        return pwParamName;
    }

    public void setPwParamName(String pwParamName) {
        this.pwParamName = pwParamName;
    }

    public Set<String> getIgnoreURIs() {
        return ignoreURIs;
    }

    public void setIgnoreURIs(Set<String> ignoreURIs) {
        this.ignoreURIs = ignoreURIs;
    }

    public boolean isAllowIfAllAbstainDecisions() {
        return allowIfAllAbstainDecisions;
    }

    public void setAllowIfAllAbstainDecisions(
            boolean allowIfAllAbstainDecisions) {
        this.allowIfAllAbstainDecisions = allowIfAllAbstainDecisions;
    }

    public boolean isCsrfYn() {
        return csrfYn;
    }

    public void setCsrfYn(boolean csrfYn) {
        this.csrfYn = csrfYn;
    }

    public Set<String> getCsrfIgnoreURIs() {
        return csrfIgnoreURIs;
    }

    public void setCsrfIgnoreURIs(Set<String> csrfIgnoreURIs) {
        this.csrfIgnoreURIs = csrfIgnoreURIs;
    }
}


