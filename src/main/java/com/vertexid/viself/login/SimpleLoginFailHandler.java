/*
 * @(#)SimpleLoginFailHandler.java     2021-02-03(003) 오전 9:51
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
package com.vertexid.viself.login;

import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.security.LoginFailHandler;
import com.vertexid.viself.security.SimpleSecurityEnvSvc;
import com.vertexid.viself.security.SimpleSecurityEnvVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * <b>Description</b>
 * <pre>
 *     로그인 실패 처리 핸들러
 *         [참고]
 *         - https://zgundam.tistory.com/53?category=430446
 *         - https://to-dy.tistory.com/92?category=720806
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class SimpleLoginFailHandler extends BaseSvc implements
        LoginFailHandler {

//    private static final String MSG_USER_LOCK = "MSG.계정이잠겼습니다.";

    private String loginidname;
    private String loginpasswordname;
    private String logindirectname;
    private String exceptionmsgname;
    private String defaultFailureUrl;
    private String failMsg;

    private SimpleSecurityEnvVO simpleSecurityEnvVO;

    @Resource
    SimpleSecurityEnvSvc simpleSecurityEnvSvc;

    public SimpleLoginFailHandler() {
        loginidname = "encId";
        loginpasswordname = "encPw";
        logindirectname = "loginRedirect";
        exceptionmsgname = "securityexceptionmsg";
        defaultFailureUrl = "/login";
        failMsg = "msg";
    }

    /**
     * 초기화
     */
    private void init() {

        setDefaultProperties();
    }

    private void setDefaultProperties() {
        if (null == simpleSecurityEnvVO) {
            simpleSecurityEnvVO = simpleSecurityEnvSvc.getEnv();
        }
        loginidname = simpleSecurityEnvVO.getIdParamName();
        loginpasswordname = simpleSecurityEnvVO.getPwParamName();
        defaultFailureUrl = simpleSecurityEnvVO.getExpiredURI();
    }

    public String getLoginidname() {
        return loginidname;
    }

    public void setLoginidname(String loginidname) {
        this.loginidname = loginidname;
    }

    public String getLoginpasswordname() {
        return loginpasswordname;
    }

    public void setLoginpasswordname(String loginpasswordname) {
        this.loginpasswordname = loginpasswordname;
    }

    public String getLogindirectname() {
        return logindirectname;
    }

    public void setLogindirectname(String logindirectname) {
        this.logindirectname = logindirectname;
    }

    public String getExceptionmsgname() {
        return exceptionmsgname;
    }

    public void setExceptionmsgname(String exceptionmsgname) {
        this.exceptionmsgname = exceptionmsgname;
    }

    public String getDefaultFailureUrl() {
        return defaultFailureUrl;
    }

    public void setDefaultFailureUrl(String defaultFailureUrl) {
        this.defaultFailureUrl = defaultFailureUrl;
    }

    public String getFailMsg() {
        return failMsg;
    }

    public void setFailMsg(String failMsg) {
        this.failMsg = failMsg;
    }

    @Override
    public <E> void failureProc(HttpServletRequest request,
            HttpServletResponse response, E exception)
            throws ServletException, IOException {

        setDefaultProperties();

        // 계정잠금 처리
//        if(setUserLock(request, exception)){
//            request.setAttribute(failMsg, MSG_USER_LOCK);
//        }

        String loginid = request.getParameter(loginidname);
        String loginpasswd = request.getParameter(loginpasswordname);
        String loginRedirect = request.getParameter(logindirectname);

        // DEBUG
        if (log.isDebugEnabled()) {
            log.debug("loginid..................." + loginid);
            log.debug("ip..................." + request.getRemoteAddr());
        }

        request.setAttribute(loginidname, loginid);
        request.setAttribute(loginpasswordname, loginpasswd);
        request.setAttribute(logindirectname, loginRedirect);

        request.setAttribute(exceptionmsgname, exception.toString());
        request.getRequestDispatcher(defaultFailureUrl)
                .forward(request, response);
    }
}
