/*
 * @(#)RoleType.java     2021-02-02(002) 오전 10:27
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

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

/**
 * <b>Description</b>
 * <pre>
 *     시스템에서 기본으로 제공하고 변경불가한 권한 유형
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public enum RoleType {
    /**
     *  개발자
     */
    DEV("DEV"),
    /**
     * 슈퍼유저
     */
    SUPER("SUPER"),
    /**
     * 게스트
     */
    GUEST("GUEST");

    private final String authority;

    RoleType(String authority) {
        this.authority = authority;
    }

    public GrantedAuthority findBy(String authority){
        for (RoleType roleType : values()) {
            if (StringUtils.equals(roleType.toAuthorityString(), authority) ||
                    StringUtils.containsIgnoreCase(authority,
                            roleType.toAuthorityString())) {
                return roleType.getAuthority();
            }
        }// end of for

        return null;
    }

    public String toAuthorityString(){
        return authority;
    }

    public GrantedAuthority getAuthority(){
        return new SimpleGrantedAuthority(authority);
    }
}
