/*
 * @(#)UserMngSvc.java     2019-11-19 오후 5:52
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

import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

import java.util.Map;

import static com.vertexid.viself.base.CmmDTO.CudType.CREATE;

/**
 * 사용자 정보 관리 서비스
 */
@Service
@Transactional
public class UserMngSvc extends BaseSvc {

    private static final String NAMESPACE = "com.vertexid.viself.hr.UserMng";
    private String errMsg;

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    @Resource
    UserPwdMngSvc userPwdMngSvc;

    @Transactional(readOnly = true)
    public <T> T getData(Map<String, Object> params){
        return cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "getData"), params);
    }

    public String save(UserDTO params) {
        String result = "";

        if(StringUtils.isNotEmpty(params.getCud())){
            if (log.isInfoEnabled()) {
                log.info("Input parameters............." + params);
            }

            saveUserInfo(params);

            if (ERROR_RESULT.equals(params.getErrYn())) {
                result = params.getErrMsg();
                log.error(
                        "Error.Input parameters............." + params);
                throw new RuntimeException(result);
            }
        }

        return result;
    }

    private void saveUserInfo(UserDTO params) {
        if(checkData(params)){

            if(CREATE.equals(params.getCud())){
                // 사용자 정보 입력
                cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), params);

                // 임시 PWD 입력
                userPwdMngSvc.setTempPwd(params);

            } else {
                cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), params);
            }

        }else{
            params.setErrCd(ERROR_RESULT);
            params.setErrMsg(errMsg);
            params.setErrYn(Boolean.toString(true));
        }
    }

    private boolean checkData(UserDTO params) {
        if(StringUtils.isEmpty(params.getUserId())){
            errMsg = "There is no userId.";
            return false;
        }

        if(StringUtils.isEmpty(params.getUserNm())){
            errMsg = "There is no userNm.";
            return false;
        }

        return true;
    }
}
