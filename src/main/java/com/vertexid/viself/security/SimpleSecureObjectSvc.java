/*
 * @(#)SimpleSecureObjectSvc.java     2021-03-30(030) 오전 10:48
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
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.annotation.Resource;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

/**
 * <b>Description</b>
 * <pre>
 *     시스템 권한 체크용 리소스에 대한 전체 목록을 로드하는 서비스.
 *
 *  [참고]
 *  - 신현삼(Shin, Hyeon Sam)[mong32@gmail.com]의 EISF3
 *  - https://zgundam.tistory.com/58?category=430446
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class SimpleSecureObjectSvc extends BaseSvc {
    @Resource
    private AuthSvc authSvc;

    public void setAuthSvc(AuthSvc authSvc) {
        this.authSvc = authSvc;
    }

    public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getRolesAndUrl()
            throws Exception {
        LinkedHashMap<RequestMatcher, List<ConfigAttribute>> ret =
                new LinkedHashMap<RequestMatcher, List<ConfigAttribute>>();

        LinkedHashMap<Object, List<ConfigAttribute>> data =
                authSvc.getRolesAndUrl();
        Set<Object> keys = data.keySet();
        for (Object key : keys) {
            ret.put((AntPathRequestMatcher) key, data.get(key));
        }// end of for

        return ret;
    }
}
