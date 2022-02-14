/*
 * @(#)SessionUtils.java     2021-02-02(002) 오전 10:53
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
package com.vertexid.spring.utils;

import com.vertexid.viself.security.SimpleSessionRepository;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;

/**
 * <b>Description</b>
 * <pre>
 *      신현삼(Shin, Hyeon Sam)[mong32@gmail.com]의 EISF3의 Session Util 을 참고
 *      스프링시큐리티와 연동하여 세션의 로그인 관련 정보를 가져오는 등 session 에 관한 유틸
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class SessionUtils {
    private static final Logger log =
            LoggerFactory.getLogger(SessionUtils.class);

    private static final String ORGIN_HEADER = "Origin";
    private static final String X_REQUESTED_WITH_HEADER = "X-Requested-With";
    private static final String JSON_POSTFIX = "/json";

    static SimpleSessionRepository simpleSessionRepository =
            SimpleSessionRepository.getInstance();

    /**
     * 세션객체를 반환
     * (Spring F/W 내에서만 동작)
     * @return 세션
     */
    public static HttpSession getSession() {
        HttpSession session = null;
        if (RequestContextHolder.getRequestAttributes() != null) {
            HttpServletRequest req =
                    ((ServletRequestAttributes) RequestContextHolder
                            .getRequestAttributes()).getRequest();
            session = req.getSession();
        }
        return session;
    }

    /**
     * 사용자 세션상의 모든 authentication(인증정보) 을 반환
     * (Spring Security 사용시 가능)
     * @return authentication
     */
    public static Authentication getAuthentication(){
        if(null != SecurityContextHolder.getContext().getAuthentication()){
            return SecurityContextHolder.getContext().getAuthentication();
        }else{
            log.warn("Not Found Spring Security Authentication");
            return null;
        }
    }

    /**
     * 세션에서 로그인 정보 얻기
     * @return 로그인 정보
     */
    public static Object getLoginVO(){
        if(null != SecurityContextHolder.getContext().getAuthentication()){
            return getAuthentication().getPrincipal();
        }
        log.info("Not Found Spring Security Authentication");
        HttpSession session = getSession();
        Object rtnInfo = simpleSessionRepository.getLoginVO(session);
        return rtnInfo;
    }

    /**
     * 세션에서 로그인 정보 얻기
     * @return 로그인 정보
     */
    public static Object getLoginVO(HttpSession session){
        Object rtnInfo = simpleSessionRepository.getLoginVO(session);
        return rtnInfo;
    }

    /**
     * AJAX 호출여부 반환( HTML5 기준 ) 혹은 JSON 요청여부
     * @param request request
     * @return true: ajax 호출(혹은 JSON 요청), other: 일반호출
     */
    public static boolean isAjaxRequest(HttpServletRequest request){

        String orginHeader = request.getHeader(ORGIN_HEADER);
        String xRequestedWithHeader = request.getHeader(X_REQUESTED_WITH_HEADER);
        String customHeader = request.getHeader("JaYu");
        String reqPath = request.getRequestURI();

        if(StringUtils.isNotEmpty(xRequestedWithHeader)) {
            log.info("x request Header exist");
            return true;
        }
        if(StringUtils.containsIgnoreCase(reqPath, JSON_POSTFIX)){
            log.info("'/json' exist");
            return true;
        }
        if(StringUtils.isNotEmpty(customHeader) && customHeader.equals("YeoYu")) {
            log.info("custom Header exist");
            return true;
        }

//        if(StringUtils.isNotEmpty(orginHeader)) {
//            log.info("orgin Header exist");
//            return true;
//        }

        return false;
    }

    /**
     * 세션 삭제(session.invalidate)
     * @param session session
     */
    public static void clearSession(HttpSession session) {

        Enumeration<String> enuKeys =  session.getAttributeNames();
        while(enuKeys.hasMoreElements()){
            String tmpKey = enuKeys.nextElement();
            session.removeAttribute(tmpKey);
        }
        session.invalidate();

        simpleSessionRepository.removeSession(session.getId());
    }
}
