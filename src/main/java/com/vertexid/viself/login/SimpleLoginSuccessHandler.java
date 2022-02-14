/*
 * @(#)SimpleLoginSuccessHandler.java     2021-02-02(002) 오후 3:35
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

import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.security.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * <b>Description</b>
 * <pre>
 *     로그인 성공 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class SimpleLoginSuccessHandler extends BaseSvc
        implements LoginSuccessHandler, AuthenticationSuccessHandler {

    private static final String REFERER = "REFERER";
    private static final int USE_TARGET_URL = 1;
    private static final int USE_SESSION_URL = 2;
    private static final int USE_REFERER_URL = 3;
    private static final int USE_DEFAULT_URL = 0;

    private String targetUrlParameter;

    private String defaultUrl;

    private boolean useReferer;

    private boolean useSessionUrl;

    private RedirectStrategy redirectStrategy = new SimpleRedirectStrategy();

    private RequestCache requestCache = new HttpSessionRequestCache();

    public SimpleLoginSuccessHandler() {
        targetUrlParameter = "";
        defaultUrl = "/main";
        useReferer = false;
        useSessionUrl = false;
    }

    public String getTargetUrlParameter() {
        return targetUrlParameter;
    }

    public void setTargetUrlParameter(String targetUrlParameter) {
        this.targetUrlParameter = targetUrlParameter;
    }

    public String getDefaultUrl() {
        return defaultUrl;
    }

    public void setDefaultUrl(String defaultUrl) {
        this.defaultUrl = defaultUrl;
    }

    public boolean isUseReferer() {
        return useReferer;
    }

    public void setUseReferer(boolean useReferer) {
        this.useReferer = useReferer;
    }

    public boolean isUseSessionUrl() {
        return useSessionUrl;
    }

    public void setUseSessionUrl(boolean useSessionUrl) {
        this.useSessionUrl = useSessionUrl;
    }

    @Override
    public <T> void successProc(HttpServletRequest request,
            HttpServletResponse response, T loginInfo) throws IOException {

        clearAuthenticationAttributes(request);

        // TODO 계정잠금 초기화
//        resetUserLock(request);

        // TODO 로그인 기록

        // 로그인 저장소에 로그인설정
        setLoginInfo(request, loginInfo);

        redirectPage(request, response);
    }

    /**
     * 페이지 리다이렉트
     * @param request request
     * @param response response
     */
    private void redirectPage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int iRedirectStrategy = decideRedirectStrategy(request, response);

        log.debug("redirect........."+ iRedirectStrategy);

        switch (iRedirectStrategy) {
            case USE_TARGET_URL:
                useTargetUrl(request, response);
                break;
            case USE_SESSION_URL:
                useSessionUrl(request, response);
                break;
            case USE_REFERER_URL:
                useRefererUrl(request, response);
                break;
            default:
                useDefaultUrl(request, response);
                break;
        }
    }

    /**
     * 세션과 세션관련 저장소에 로그인 정보를 추가한다.
     * @param request request
     * @param loginInfo login info
     * @param <T> BaseLoginDTO를 상속받은 login info
     */
    protected <T> void setLoginInfo(HttpServletRequest request, T loginInfo) {

        HttpSession session = request.getSession();

        // [주의] 세션이 초기화 됨
        SessionUtils.clearSession(session);
        session = request.getSession();

        SimpleLoginVO loginVO;
        if(loginInfo instanceof SimpleLoginVO){

            loginVO = (SimpleLoginVO)loginInfo;
            log.info("(^_^)b.........login success.");
            if(StringUtils.isNotEmpty(loginVO.getTempPwd())){
                log.info("(^_^;).........But change your password!");
                loginVO.setCredentialsNonExpired(false);
                defaultUrl = "/pw";
            }
        }

        SimpleSessionRepository simpleSessionRepository =
                SimpleSessionRepository.getInstance();
        simpleSessionRepository.setLoginVO(session, (BaseLoginDTO) loginInfo);
    }

    /**
     * 기본URL로 가기
     *
     * @param request  request
     * @param response response
     * @throws IOException
     */
    private void useDefaultUrl(HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        redirectStrategy.sendRedirect(request, response, defaultUrl);
    }

    /**
     * REFERER URL로 가기
     *
     * @param request  request
     * @param response response
     * @throws IOException
     */
    private void useRefererUrl(HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        String tagetUrl = request.getHeader(REFERER);
        redirectStrategy.sendRedirect(request, response, tagetUrl);
    }

    /**
     * 세션 URL로 가기
     *
     * @param request
     * @param response
     * @throws IOException
     */
    private void useSessionUrl(HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        SavedRequest savedRequest = requestCache.getRequest(request, response);

        String targetUrl = savedRequest.getRedirectUrl();

        // DEBUG
        if (log.isDebugEnabled()) {
            log.debug("SESSION_URL.........." + targetUrl);
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    /**
     * 지정된 URL로 가기
     *
     * @param request
     * @param response
     * @throws IOException
     */
    private void useTargetUrl(HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        SavedRequest savedRequest = requestCache.getRequest(request, response);

        if (savedRequest != null) {
            requestCache.removeRequest(request, response);
        }

        String targetUrl = request.getParameter(targetUrlParameter);
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    /**
     * 전달정책 결정
     *
     * @param request
     * @param response
     * @return
     */
    private int decideRedirectStrategy(HttpServletRequest request,
            HttpServletResponse response) {

        int result;

        SavedRequest savedRequest = requestCache.getRequest(request, response);

        if (StringUtils.isNoneEmpty(targetUrlParameter)) {
            String targetUrl = request.getParameter(targetUrlParameter);

            // DEBUG
            if (log.isDebugEnabled()) {
                log.debug("TARGET_URL.........." + targetUrl);
            }

            if (StringUtils.isNotEmpty(targetUrl)) {
                result = USE_TARGET_URL;
            } else {

                if (useSessionUrl && savedRequest != null) {
                    result = USE_SESSION_URL;
                } else {

                    String refererUrl = request.getHeader(REFERER);

                    if (useReferer && StringUtils.isNotEmpty(refererUrl)) {
                        result = USE_REFERER_URL;
                    } else {
                        result = USE_DEFAULT_URL;
                    }
                }
            }

            return result;
        }

        if (useSessionUrl && savedRequest != null) {
            result = USE_SESSION_URL;
            return result;
        }

        String refererUrl = request.getHeader(REFERER);

        if (useReferer && StringUtils.isNotEmpty(refererUrl)) {

            // DEBUG
            if (log.isDebugEnabled()) {
                log.debug("REFERER_URL.........." + refererUrl);
            }

            result = USE_REFERER_URL;
        } else {
            result = USE_DEFAULT_URL;
        }

        return result;
    }

//    private void resetUserLock(HttpServletRequest req) {
//    }

    /**
     * 인증 실패속성 삭제
     *
     * @param request
     */
    private void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {

        successProc(request, response, authentication.getPrincipal());
    }
}
