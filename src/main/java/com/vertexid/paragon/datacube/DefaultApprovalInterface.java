/*
 * @(#)DefaultApprovalInterface.java     2021-07-16(016) 오후 4:15
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

import com.vertexid.viself.base.BaseSvc;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <b>Description</b>
 * <pre>
 *     기본 결재 인터페이스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class DefaultApprovalInterface extends BaseSvc
        implements ApprovalInterface {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    public static final String INTERFACE_TYPE = "DefaultApprovalInterface";

    @Override
    public String getApprovalInterfaceType() {
        return INTERFACE_TYPE;
    }

    @Override
    public void doWork(Object param) {
        // none....
        log.debug("params............"+param.toString());
    }
}
