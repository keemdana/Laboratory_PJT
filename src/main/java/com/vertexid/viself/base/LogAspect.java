/*
 * @(#)LogAspect.java     2020-10-30(030) 오후 1:17
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

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import net.sf.json.JSONObject;

/**
 * <b>Description</b>
 * <pre>
 *     Request Logging
 *
 *     [참고]
 *        "Spring에서 Request를 우아하게 로깅하기"
 *        (https://taetaetae.github.io/2019/06/30/controller-common-logging/)
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Aspect
@Component
public class LogAspect {

    private static final String PATH_SEPERATOR = "/";
    private static final String PACKAGE_SEPERATOR = ".";
    private static final String JSON_POSTFIX = "json";
    private static final String JSP_ROOT_PATH = "/WEB-INF/jsp";
    private static final String JS_PATH = "/js";
    private Logger log = LoggerFactory.getLogger(this.getClass());

    private static final String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss.SSS";

    @Resource
    SystemPropertiesVO systemPropertiesVO;

    @Pointcut("execution(* com.vertexid..*Ctrl.*(..))")
    public void loggerPointCut(){
    }

    @Around("loggerPointCut()")
    public Object logging(ProceedingJoinPoint proceedingJoinPoint) throws Throwable{
        StopWatch stopWatch = new StopWatch();

        // request 정보를 가져온다.
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
                .getRequestAttributes()).getRequest();
        String controllerName = proceedingJoinPoint.getSignature().getDeclaringTypeName();
//        String controllerName = proceedingJoinPoint.getSignature().getDeclaringType().getSimpleName();
        String methodName = proceedingJoinPoint.getSignature().getName();

        Map<String, Object> params = new HashMap<>();
        params.put("CONTROLLER", controllerName);
        params.put("METHOD", methodName);
        params.put("PARAMS", getParams(request));
        params.put("HEADER INFO", getHeaders(request));
        params.put("LOG_TIME", new DateTime().toString(DATE_FORMAT));
        params.put("CONTEXT PATH", request.getContextPath());
        params.put("REQUEST_URI", request.getRequestURI());
        params.put("CHAR ENCODING", request.getCharacterEncoding());
        params.put("SESSION ID", request.getRequestedSessionId());
        params.put("HTTP_METHOD", request.getMethod());

        loggingInfo(params);

//        log.debug("ST............."+proceedingJoinPoint.getSignature().getDeclaringTypeName()+ " / "+proceedingJoinPoint.getSignature().getName());
        stopWatch.start();
        Object result = proceedingJoinPoint.proceed();
        stopWatch.stop();
//        log.debug("ED............."+proceedingJoinPoint.getSignature().getDeclaringTypeName()+ " / "+proceedingJoinPoint.getSignature().getName());

        params.put("ELAPSED_TIME", stopWatch.getTotalTimeMillis());

        return result;
    }

    private Map<String, Object> getHeaders(HttpServletRequest request) {

        Map<String, Object> rtnHeader = new HashMap<String, Object>();

        if(false) {
            Enumeration<String> enumHeader = request.getHeaderNames();

            while (enumHeader.hasMoreElements()) {
                String name = (String) enumHeader.nextElement();
                rtnHeader.put(name, request.getHeader(name));
            }//end of while

        }else{
            String[] minHeaders = {"x-requested-with", "user-agent", "content-type", "accept-language"};
            int hLen = minHeaders.length;
            for(int i = 0; i < hLen; i += 1){
                rtnHeader.put(minHeaders[i], request.getHeader(minHeaders[i]));
            }
        }

        return rtnHeader;

    }


    /**
     * request 에 담긴 정보를 JSONObject 형태로 반환한다.
     * @param request
     * @return
     */
    private JSONObject getParams(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String param = params.nextElement();
            String replaceParam = param.replaceAll("\\.", "-");
            jsonObject.put(replaceParam, request.getParameter(param));
        }
        return jsonObject;
    }

    private void loggingInfo(Map<String, Object> params) {

        if(systemPropertiesVO.isProd()){
            log.info("Controller Info : {}", params); // param에 담긴 정보들을 한번에 로깅한다.
        }else{
            StringBuffer sbInfo = new StringBuffer();

            String uri = String.valueOf(params.get("REQUEST_URI"));
            String context = String.valueOf(params.get("CONTEXT PATH"));
            String path = StringUtils.remove(uri, context);
            String lastPath = StringUtils.substringAfterLast(path, PATH_SEPERATOR);
            log.debug("lastPath..."+lastPath);
            String jspInfo = JSP_ROOT_PATH+path;
            String jsInfo = JS_PATH+path;

            log.debug("path..."+path);

            if(JSON_POSTFIX.equals(lastPath)){
                jspInfo = "";
                jsInfo = "";
            }else{
                jspInfo += ".jsp";
                jsInfo += ".js";
            }

            String fullCtrl = String.valueOf(params.get("CONTROLLER"));
            String pkg = StringUtils.substringBeforeLast(fullCtrl, PACKAGE_SEPERATOR);
            String ctrl = StringUtils.remove(fullCtrl, pkg+PACKAGE_SEPERATOR);

            sbInfo.append("\n    ============================================");
            sbInfo.append("\n    CONTROLLER INFO");
            sbInfo.append("\n    --------------------------------------------");
            sbInfo.append("\n    SESSION ID : ").append(params.get("SESSION ID"));
            sbInfo.append("\n    CHAR ENCODING : ").append(params.get("CHAR ENCODING"));
            sbInfo.append("\n    CONTEXT PATH : ").append(params.get("CONTEXT PATH"));
            sbInfo.append("\n    REQUEST_URI : ").append(params.get("REQUEST_URI"));
//            sbInfo.append("\n    RELATION PAGE : ").append(jspInfo);
//            sbInfo.append("\n    RELATION JS : ").append(jsInfo);
            sbInfo.append("\n    HTTP_METHOD : ").append(params.get("HTTP_METHOD"));
            sbInfo.append("\n    PACKAGE : ").append(pkg);
            sbInfo.append("\n    CONTROLLER : ").append(ctrl).append(".java");
            sbInfo.append("\n    METHOD : ").append(params.get("METHOD"));
            sbInfo.append("\n    PARAMS : ").append(params.get("PARAMS"));
            sbInfo.append("\n    LOG_TIME : ").append(params.get("LOG_TIME"));
            sbInfo.append("\n    HEADER INFO : ").append(params.get("HEADER INFO"));
            sbInfo.append("\n    ============================================");

            log.info(sbInfo.toString());
        }
    }
}
