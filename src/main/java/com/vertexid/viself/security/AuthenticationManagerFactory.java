/*
 * @(#)AuthenticationManagerFactory.java     2021-07-22(022) 오전 9:11
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

import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 *     인증 매니저 팩토리
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class AuthenticationManagerFactory {

    @Resource
    private List<AuthenticationManager> authenticationManagerList;

    public AuthenticationManager getAuthenticationManager(String type) {
        for (AuthenticationManager authenticationManager : authenticationManagerList) {
            if (type.equals(
                    authenticationManager.getAuthenticationManagerType())) {
                return authenticationManager;
            }
        }// end of for
        return null;
    }
}
