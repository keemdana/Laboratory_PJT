/*
 * @(#)SimpleAuthSvc.java     2021-03-10(010) 오전 10:36
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

import com.vertexid.commons.utils.CaseConverter;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.*;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class SimpleAuthSvc extends BaseSvc implements AuthSvc {

    private static final String NAMESPACE = "com.vertexid.viself.auth.AuthMenu";
    private static final String JSON_POST_PATH = "/json";
    private static final String PATH_SEPERATOR = "/";
    private static final String JS_MODULE_ROOT_PATH = "/js/module";
    private static final String JS_EXT = ".js";
    private static final String EXT_POST_PATH = "/**";
    private static final String POST_EXT = ".*";
    private String errMsg;

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    @Override
    public LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndUrl() {

        /*
         * Ant 패턴의 URL별 Role 리스트의 형태로 정보를 가져온다.
         */
        LinkedHashMap<Object, List<ConfigAttribute>> resourcesMap =
                new LinkedHashMap<Object, List<ConfigAttribute>>();

        // DB에서 읽어오기
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("alwYn", "Y");
        List<Map<String, Object>> list = getRoleAndUrlList(param);

        // DEBUG
        log.debug("1. get role and menu(URL) list....\n" + list);

        Iterator<Map<String, Object>> itr = list.iterator();

        Map<String, Object> tmpMap;
        String presentResourceStr;
        Object presentResource;
        while (itr.hasNext()) {
            tmpMap = itr.next();


            String accUrl = (String) tmpMap.get("accesUrl");
            String authCd = (String) tmpMap.get("authCd");
            log.debug("accUrl .........................." + accUrl);

            // TODO URL-권한 정리 필요

            if (accUrl.lastIndexOf(JS_EXT) != -1) {
                // ~.js 로 끝날 경우 /js/module/~.js 로 변경

                String jsUrlPattern = JS_MODULE_ROOT_PATH + accUrl;
                setUrlPattern(jsUrlPattern, resourcesMap, authCd);

            } else if (accUrl.lastIndexOf(JSON_POST_PATH) != -1) {
                // ~/json 로 끝날 경우
                setUrlPattern(accUrl, resourcesMap, authCd);

            } else if (accUrl.lastIndexOf(EXT_POST_PATH) != -1) {
                // ~/** 로 끝날 경우

                String camelPath = toCamelPath(accUrl);
//                String pascaPath = toPascalPath(accUrl);

                // [주의]
                // 아래 순서 중요

                // 1. JS extends: /js/module/~/**
                setUrlPattern(JS_MODULE_ROOT_PATH + camelPath + EXT_POST_PATH,
                        resourcesMap, authCd);

                // 2. extends path: extends path(camel case): ~/**
                if (accUrl.indexOf(camelPath) == -1) {
                    setUrlPattern(camelPath + EXT_POST_PATH, resourcesMap,
                            authCd);
                }

                // 1. default: ~/**
                setUrlPattern(accUrl, resourcesMap, authCd);

            } else {

                // [주의]
                // 아래 순서 중요

                String camelPath = toCamelPath(accUrl);

                // 1. JS(camel case): /js/module/~.*
                setUrlPattern(JS_MODULE_ROOT_PATH + camelPath + JS_EXT,
                        resourcesMap, authCd);

                // 2. JS(camel case) extends: /js/module/~/*.*
                setUrlPattern(JS_MODULE_ROOT_PATH + camelPath + EXT_POST_PATH,
                        resourcesMap, authCd);

                // 3. default
                setUrlPattern(accUrl, resourcesMap, authCd);

                // 4. extends: /~.*
                setUrlPattern(accUrl + POST_EXT, resourcesMap, authCd);

                // 5. extends path: /~/**
                setUrlPattern(accUrl + EXT_POST_PATH, resourcesMap, authCd);
            }
        } // end of while

        log.debug("resourcesMap..........." + resourcesMap.toString());

        return resourcesMap;
    }

    /**
     * url path 를 came case 로 변경하되
     * 최종 경로를 Pascal Case 로 변경해사 반환
     *
     * @param accUrl 원본 Url
     * @return pascal case url (ex: /sss/fff/Test)
     */
    private String toPascalPath(String accUrl) {
        if (StringUtils.isEmpty(accUrl)) {
            return accUrl;
        }

        String[] pathTokens = StringUtils.split(accUrl, PATH_SEPERATOR);
        StringBuilder sb = new StringBuilder();
        int iLen = pathTokens.length;
        int lastIdx = iLen - 1;
        for (int i = 0; i < iLen; i += 1) {

            if (i == lastIdx) {
                sb.append(PATH_SEPERATOR)
                        .append(CaseConverter.pascalCase(pathTokens[i]));
            } else {
                sb.append(PATH_SEPERATOR)
                        .append(CaseConverter.camelCase(pathTokens[i]));
            }

        }// end of for
        return sb.toString();
    }

    /**
     * url path 를 came case 로 변경
     *
     * @param accUrl 원본 Url
     * @return camel case url (ex: /sss/fff/urlTest)
     */
    private String toCamelPath(String accUrl) {
        if (StringUtils.isEmpty(accUrl)) {
            return accUrl;
        }

        String[] pathTokens = StringUtils.split(accUrl, PATH_SEPERATOR);
        StringBuilder sb = new StringBuilder();
        int iLen = pathTokens.length;
        for (int i = 0; i < iLen; i += 1) {
            sb.append(PATH_SEPERATOR)
                    .append(CaseConverter.camelCase(pathTokens[i]));
        }// end of for
        return sb.toString();
    }


    /**
     * @param urlPattern
     * @param resourcesMap
     * @param authId
     */
    private void setUrlPattern(String urlPattern,
            LinkedHashMap<Object, List<ConfigAttribute>> resourcesMap,
            String authId) {

        String presentResourceStr;
        Object presentResource;

        presentResourceStr = urlPattern;
        presentResource = new AntPathRequestMatcher(presentResourceStr);
        List<ConfigAttribute> configList = new LinkedList<ConfigAttribute>();

        if (resourcesMap.containsKey(presentResource)) {
            List<ConfigAttribute> preAuthList =
                    resourcesMap.get(presentResource);
            Iterator<ConfigAttribute> preAuthItr = preAuthList.iterator();

            while (preAuthItr.hasNext()) {

                SecurityConfig tmpConfig = (SecurityConfig) preAuthItr.next();
                configList.add(tmpConfig);

            }// end of while
        }

        configList.add(new SecurityConfig(authId));
        resourcesMap.put(presentResource, configList);

        // DEBUG
        log.debug("2.1 moduleUrl...." + presentResourceStr);
        log.debug("2.2 presentResource: AntPathRequestMatcher...." +
                presentResource);
        log.debug("2.3. configList..." + configList.toString());
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getRoleAndUrlList(
            Map<String, Object> params) {
        return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "authNUrlList"),
                params);
    }
}
