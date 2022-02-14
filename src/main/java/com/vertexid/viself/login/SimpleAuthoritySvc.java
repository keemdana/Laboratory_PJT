/*
 * @(#)SimpleAuthoritySvc.java     2021-01-13(013) 오전 10:20
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

import com.vertexid.viself.security.AuthoritySvc;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <b>Description</b>
 * <pre>
 *     권한 정보 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class SimpleAuthoritySvc extends BaseSvc implements AuthoritySvc {

    private static final String NAMESPACE =
            "com.vertexid.viself.auth.AuthMember";
    private String errMsg;

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    @Override
    @Transactional(readOnly = true)
    public <E> List<E> getAuthorities(String username) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("authMemberId", username);
        params.put("authMemberTpCd", "USER");

        return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getAuthorities"),
                params);
    }
}
