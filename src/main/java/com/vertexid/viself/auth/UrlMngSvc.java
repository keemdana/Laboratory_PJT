/*
 * @(#)UrlMngSvc.java     2021-03-31(031) 오후 1:52
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
import com.vertexid.viself.base.CmmDTO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

import static com.vertexid.viself.base.CmmDTO.CudType.CREATE;
import static com.vertexid.viself.base.CmmDTO.CudType.UPDATE;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class UrlMngSvc extends BaseSvc {
    private static final String NAMESPACE = "com.vertexid.viself.auth.UrlMng";
    private String errMsg;

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    public String save(UrlDTO params) {
        String result = "";

        if (log.isInfoEnabled()) {
            log.info("Input parameters............." + params);
        }

        List<UrlDTO> list = params.getList();
        int iSize = (null == list || list.isEmpty()) ? 0 : list.size();

        for (int i = 0; i < iSize; i += 1) {
            UrlDTO tmpDTO = list.get(i);

            if (CREATE.equals(tmpDTO.getCud())) {
                insert(tmpDTO);
            } else if (UPDATE.equals(tmpDTO.getCud())) {
                update(tmpDTO);
            }

            if (ERROR_RESULT.equals(tmpDTO.getErrYn())) {
                result = tmpDTO.getErrMsg();
                log.error("Error.Input parameters............." + tmpDTO);
                throw new RuntimeException(result);
            }
        } // end of for

        return result;
    }

    private void update(UrlDTO params) {
        if (validate(params)) {
            cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateUrl"), params);
        }
    }

    private void insert(UrlDTO params) {
        if (validate(params)) {
            cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertUrl"), params);
        }
    }

    private void setError(CmmDTO params) {
        params.setErrCd(ERROR_RESULT);
        params.setErrMsg(errMsg);
        params.setErrYn(Boolean.toString(true));
    }

    private boolean validate(UrlDTO params) {
        if (StringUtils.isEmpty(params.getAccesUrl())) {
            errMsg = "There is no url.";
            setError(params);
            return false;
        }

        if (StringUtils.isEmpty(params.getAlwDiv())) {
            errMsg = "There is no alw div.";
            setError(params);
            return false;
        }

        return true;
    }

    public String delete(UrlDTO params) {

        String result = "";

        List<UrlDTO> list = params.getList();
        int iSize = (null == list || list.isEmpty()) ? 0 : list.size();

        for (int i = 0; i < iSize; i += 1) {
            UrlDTO tmpDTO = list.get(i);

            deleteUrl(tmpDTO);

            if (ERROR_RESULT.equals(tmpDTO.getErrCd())) {
                result = tmpDTO.getErrMsg();
                log.error("\n    Error.Input parameters: \n    " + tmpDTO);
                throw new RuntimeException(result);
            }

        }// end of for

        return result;
    }

    private void deleteUrl(UrlDTO param) {

        if (checkUrl(param)) {
            cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "delete"), param);
        }

    }

    private boolean checkUrl(UrlDTO params) {

        if (StringUtils.isEmpty(params.getAccesUrl())) {
            errMsg = "There is no url.";
            setError(params);
            return false;
        }

        return true;
    }
}
