/*
 * @(#)AuthMngSvc.java     2022-02-08(008) 오후 3:59
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
package com.vertexid.viself.auth;

import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * <b>Description</b>
 * <pre>
 *     권한(Role) 관리 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class AuthMngSvc extends BaseSvc {

    private static final String NAMESPACE = "com.vertexid.viself.auth.AuthMng";

    @Resource
    private CmmDAO cmmDAO;

    public String insert(AuthMngDTO params) {
        String result = "";

        if(log.isInfoEnabled()){
            log.info("Input parameters............." + params);
        }

        cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), params);

        if (ERROR_RESULT.equals(params.getErrYn())) {
            result = params.getErrMsg();
            log.error("Error.Input parameters............." + params);
            throw new RuntimeException(result);
        }

        return result;
    }

    public String update(AuthMngDTO params) {
        String result = "";

        if(log.isInfoEnabled()){
            log.info("Input parameters............." + params);
        }

        cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), params);

        if (ERROR_RESULT.equals(params.getErrYn())) {
            result = params.getErrMsg();
            log.error("Error.Input parameters............." + params);
            throw new RuntimeException(result);
        }

        return result;
    }

    public String delete(AuthMngDTO params) {
        String result = "";

        if(log.isInfoEnabled()){
            log.info("Input parameters............." + params);
        }

        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "delete"), params);

        if (ERROR_RESULT.equals(params.getErrYn())) {
            result = params.getErrMsg();
            log.error("Error.Input parameters............." + params);
            throw new RuntimeException(result);
        }

        return result;
    }

    public String updateSort(AuthMngDTO params) {
        String result = "";

        if(log.isInfoEnabled()){
            log.info("Input parameters............." + params);
        }

        cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateSort"), params);

        if (ERROR_RESULT.equals(params.getErrYn())) {
            result = params.getErrMsg();
            log.error("Error.Input parameters............." + params);
            throw new RuntimeException(result);
        }

        return result;
    }
}
