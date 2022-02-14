/*
 * @(#)SimpleReloadableSecurityMetadataSource.java     2021-03-19(019) 오후 1:46
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * <b>Description</b>
 * <pre>
 *     권한별 접근 제어정보를 가진 저장소
 *     [참고]
 *     com.vertexid.spring.security.CmmReloadableSecurityMetadataSource
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class SimpleReloadableSecurityMetadataSource {
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * 권한메타정보(URL기반)
     */
    private final Map<RequestMatcher, Collection<ConfigAttribute>> requestMap;

    /**
     * 권한메타정보 서비스
     */
    private SimpleSecureObjectSvc simpleSecureObjectSvc;

    public SimpleReloadableSecurityMetadataSource(
            Map<RequestMatcher, Collection<ConfigAttribute>> requestMap) {
        this.requestMap = requestMap;
    }

    public void setSecureObjectSvc(SimpleSecureObjectSvc cmmSecureObjectSvc) {
        this.simpleSecureObjectSvc = cmmSecureObjectSvc;
    }

    /**
     * request에 해당하는 권한 정보 반환
     * @param request request
     * @return 권한 정보
     * @throws IllegalArgumentException request 형식 오류
     */
    public Collection<ConfigAttribute> getAttributes(HttpServletRequest request)
            throws IllegalArgumentException {

        log.debug("request.URI..................." + request.getRequestURI());

        Collection<ConfigAttribute> result = null;

        for (Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : requestMap
                .entrySet()) {

            if (entry.getKey().matches(request)) {
                result = entry.getValue();
                break;
            }
        } // end of for

        log.debug("result......................." + result);
        return result;
    }

    /**
     * 권한메타정보를 리로드한다.
     *
     * @throws Exception
     */
    public void reload() throws Exception {

        // 1. 변경된 Url에 대한 Role 정보를 얻는다.
        LinkedHashMap<RequestMatcher, List<ConfigAttribute>> reloadedMap =
                simpleSecureObjectSvc.getRolesAndUrl();

        // 2. Iterator
        Iterator<Map.Entry<RequestMatcher, List<ConfigAttribute>>> iterator =
                reloadedMap.entrySet().iterator();

        // 3. 기존권한 삭제
        requestMap.clear();

        // 4. 신규권한 설정
        while (iterator.hasNext()) {
            Map.Entry<RequestMatcher, List<ConfigAttribute>> entry =
                    iterator.next();
            requestMap.put(entry.getKey(), entry.getValue());
        } // end of while

        log.info("Secured Url Resources - Role Mapping reloaded at Runtime!");

    }
}
