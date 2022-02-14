/*
 * @(#)UserPwdMngSvc.java     2020-10-27(027) 오전 9:28
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
package com.vertexid.viself.hr;

import javax.annotation.Resource;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;

/**
 * <b>Description</b>
 * <pre>
 *     사용자 패스워드 관리 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class UserPwdMngSvc extends BaseSvc {

    private static final String NAMESPACE = "com.vertexid.viself.hr.UserMng";
    private static final String POST_FIX = "!@#123Pwd";
    private String errMsg;

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    public void setTempPwd(UserDTO params){
        // 1. generate temp pwd
        params.setTempPwd(getTempPwd(params));

        // 2. update temp pwd
        cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateTmpPwd"), params);
    }

    private String getTempPwd(UserDTO params) {
        String orgTmpPwd = params.getUserId() + POST_FIX;
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        return bCryptPasswordEncoder.encode(orgTmpPwd);
    }
}
