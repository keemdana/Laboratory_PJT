/*
 * @(#)AuthoritySvc.java     2021-01-13(013) 오전 9:57
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

import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 *     권한 관리 구성시에 권한에 대한 서비스 인터페이스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface AuthoritySvc {

    /**
     * 권한(Role, Authority) 리스트 얻기
     * @param username 사용자 id
     * @param <E> 권한 유형
     * @return 권한리스트
     */
    <E> List<E> getAuthorities(String username);
}
