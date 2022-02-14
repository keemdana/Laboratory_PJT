/*
 * @(#)AuthSvc.java     2021-02-09(009) 오후 2:27
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

import org.springframework.security.access.ConfigAttribute;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface AuthSvc {
    LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndUrl();
}
