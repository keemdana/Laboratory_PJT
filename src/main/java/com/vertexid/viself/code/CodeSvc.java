/*
 * @(#)DetailCodeSvc.java     2020-09-28(028) 오후 12:58
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
package com.vertexid.viself.code;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;

/**
 * <b>Description</b>
 * <pre>
 *     상세코드 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class CodeSvc extends BaseSvc {

    private static final String NAMESPACE = "com.vertexid.viself.code.CodeMng";
    private String errMsg;

    @Resource(name = "cmmBatchDAO")
    private CmmDAO cmmDAO;

    public String save(CodeDTO params) {
        String result = "";

        List<CodeDTO> list = params.getList();
        String parentCd = params.getParentCd();
        int iSize = (null == list || list.isEmpty()) ? 0 : list.size();
        if (iSize > 0) {

            for (int i = 0; i < iSize; i += 1) {
                CodeDTO tmpDTO = list.get(i);

                if (StringUtils.isNoneEmpty(tmpDTO.getCud())) {
                    tmpDTO.setOrdNo(String.valueOf(i));
                    tmpDTO.setParentCd(parentCd);

                    saveCodeInfo(tmpDTO);

                    if (log.isInfoEnabled()) {
                        log.info("Input parameters............." + tmpDTO);
                    }

                    if (ERROR_RESULT.equals(tmpDTO.getErrCd())) {
                        result = tmpDTO.getErrMsg();
                        log.error(
                                "Error.Input parameters............." + tmpDTO);
                        throw new RuntimeException(result);
                    }
                }
            }// end of for
        }// end of if


        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteVCode"), null);
        cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "selectVInsert"), null);

        return result;
    }

    private void saveCodeInfo(CodeDTO param) {
        if (checkData(param)) {
            cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteDtlCode"),
                    param);
            cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertDtlCode"),
                    param);
        } else {
            param.setErrCd(ERROR_RESULT);
            param.setErrMsg(errMsg);
            param.setErrYn(Boolean.toString(true));
        }
    }

    private boolean checkData(CodeDTO param) {


        if (StringUtils.isEmpty(param.getCd())) {
            errMsg = "There is no cd.";
            return false;
        }

        if (StringUtils.isEmpty(param.getLangCd())) {
            errMsg = "There is no langCd.";
            return false;
        }

        // TODO parentCd 정합성 검사

        return true;
    }

    public String delete(CodeDTO param) {
        String result = "";

        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteCode"), param);

        if (log.isInfoEnabled()) {
            log.info("Input parameters............." + param);
        }

        if (ERROR_RESULT.equals(param.getErrCd())) {
            result = param.getErrMsg();
            log.error("Error.Input parameters............." + param);
            throw new RuntimeException(result);
        }

        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteVCode"), param);
        cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "selectVInsert"), param);


        return result;
    }
}
