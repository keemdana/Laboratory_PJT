/*
 * @(#)BaseDocMasHandler.java     2021-06-30(030) 오후 3:22
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
package com.vertexid.paragon.datacube;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <b>Description</b>
 * <pre>
 *     From 강세원 DocMasHandler
 *     <small>Since 최운수, 이성종, 홍성식 DocMasHandler</small>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseDocMasHandler {
    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * 속성: 관리 MAS UID
     */
    public static final String GWANRI_MAS_UID = "GWANRI_MAS_UID";

    public static final String SOL_MAS_UID = "SOL_MAS_UID";

    public static final String UIROE_NO = "REG_NO";

    public static final String JIJAEGWEON_GBN = "JIJAEGWEON_GBN";
}
