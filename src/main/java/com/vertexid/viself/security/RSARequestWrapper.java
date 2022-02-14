/*
 * @(#)RSARequestWrapper.java     2019-12-16 오후 5:41
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

import java.security.PrivateKey;
import java.util.Enumeration;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Sets;
import com.vertexid.viself.base.SystemPropertiesVO;

/**
 * <b>Description</b>
 * <pre>
 *     RSA 복호화를 위한 Request Wrapper
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 * @deprecated com.vertexid.viself.base.CmmRequestWrapper 사용
 */
public class RSARequestWrapper extends HttpServletRequestWrapper {

    @Resource
    SystemPropertiesVO systemPropertiesVO;

    /**
     * logger
     */
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    private PrivateKey privateKey = null;

    private boolean encFlag = false;
    private Set<String> encParamSet;

    /**
     * Constructs a request object wrapping the given request.
     *
     * @param request
     * @throws IllegalArgumentException if the request is null
     */
    public RSARequestWrapper(HttpServletRequest request) {
        super(request);

        // get privateKey
        HttpSession session = request.getSession();

//        log.debug("privateKey?..........................." + privateKey);

        if (null != session.getAttribute(RSAAttributeKey.PRIVATE_KEY)) {
            privateKey = (PrivateKey) session
                    .getAttribute(RSAAttributeKey.PRIVATE_KEY);
        }

        // set encFlag
        String encParameters =
                request.getParameter(RSAAttributeKey.RSA_TARGET_PARAMETERS);
        encFlag = StringUtils.isNotEmpty(encParameters);
        if (encFlag) {
            encParamSet = Sets.newHashSet(encParameters.split(","));
            log.debug("encParamSet..........................." + encParamSet);
            log.debug("privateKey..........................." + privateKey);
        }
//        log.debug("encFlag..........................." + encFlag);

        writeInfor(request);

    }

    private void writeInfor(HttpServletRequest request) {

        StringBuffer logInfo = new StringBuffer();

//        logInfo.append("\n===================================================");
//        logInfo.append("\npath...........").append(request.getRequestURI());
//        logInfo.append("\n---------------------------------------------------");

        Enumeration<String> eName = request.getParameterNames();
        while (eName.hasMoreElements()) {
            String tmpNm = eName.nextElement();
            logInfo.append("\n").append(tmpNm).append("...........");
            String[] tmpVals = request.getParameterValues(tmpNm);
            for(int i = 0; i < tmpVals.length; i += 1){
                logInfo.append("\n\t").append(tmpVals[i]);
            }
        }

//        logInfo.append("\n===================================================");

//        log.info(logInfo.toString());
    }

    @Override
    public String getParameter(String name) {
        String param = super.getParameter(name);

        // 암호화되어있고 암호화된 파라메터일경우 복호화해서 처리
        // [주의] RequestBody 에서는 아래 처리가 소용이 없으니 개별 복호화 처리해야함
        if (encFlag && encParamSet.contains(name)) {
            RSACryptographicSvc rsaCryptographicSvc = new RSACryptographicSvc();
            log.debug("name..........................." + name);
            log.debug("param..........................." + param);
            log.debug("decparam..........................." +
                    rsaCryptographicSvc.decrypt(privateKey, param));
            return rsaCryptographicSvc.decrypt(privateKey, param);
        }

        return param;
    }
}
