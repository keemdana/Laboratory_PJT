/*
 * @(#)MenuSvc.java     2020-09-18(018) 오전 10:00
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import com.vertexid.viself.menu.MenuDTO;

/**
 * <b>Description</b>
 * <pre>
 *     권한관련 메뉴 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class AuthMenuSvc extends BaseSvc {

    private static final String NAMESPACE =
            "com.vertexid.viself.auth.AuthMenu";

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    private String errMsg;

    @Transactional(readOnly = true)
    public <E> List<E> getList(Map<String, Object> params) {

        // 1. 사용자 권한 정보 얻기

        // 2. 권한에 따른 메뉴 정보 얻기
//        params.put("useEnable", "Y");

        log.debug("PARAMS......................................"+params);

        return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "list"), params);
    }

    @Transactional(readOnly = true)
    public <E> List<E> getAllList(Map<String, Object> params) {

        // 1. 사용자 권한 정보 얻기

        // 2. 권한에 따른 메뉴 정보 얻기
//        params.put("useEnable", "Y");

        log.debug("PARAMS......................................"+params);

        return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "allList"), params);
    }

    public String insert(AuthMenuDTO params) {
        String result = "";
        String authCd = params.getAuthCd();
        List<AuthMenuDTO> list = params.getList();
        int iSize = (null == list || list.isEmpty()) ? 0 : list.size();
        if(iSize > 0) {
            for (int i = 0; i < iSize; i += 1) {
                AuthMenuDTO tmpDTO = list.get(i);
                tmpDTO.setAuthCd(authCd);
                cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), tmpDTO);
                if (ERROR_RESULT.equals(tmpDTO.getErrCd())) {
                    result = tmpDTO.getErrMsg();
                    log.error("Error.Input parameters............." + tmpDTO);
                    throw new RuntimeException(result);
                }
            }
        }
        return result;
    }

    /**
     * 메뉴권한 삭제
     * @param params
     * @return
     */
    public String deleteMenu(Map<String, Object> params) {

        String result = "";
        try{
            AuthMenuDTO authMenuDTO = new AuthMenuDTO();
            authMenuDTO.setMenuId((String)params.get("menuId"));

            if(deleteCheck(authMenuDTO)) {
                authMenuDTO.setErrCd(ERROR_RESULT);
                authMenuDTO.setErrMsg(errMsg);
                authMenuDTO.setErrYn(Boolean.toString(true));
            }else {
                cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteForMenuIdPath"), authMenuDTO);
            }

            if (ERROR_RESULT.equals(authMenuDTO.getErrCd())) {
                result = authMenuDTO.getErrMsg();
                log.error(
                        "Error.Delete parameters............." + authMenuDTO);
                new Exception(result);
            }
        } catch (Exception e) {
            log.error("Error............................" + e.getMessage());
            TransactionAspectSupport.currentTransactionStatus()
            .setRollbackOnly();
        }
        return result;
    }

    private boolean deleteCheck(AuthMenuDTO param) {

        // 데이터 존재여부 검사: parentMenuId
        Map<String, Object> tmpParam = new HashMap<String, Object>();
        tmpParam.put("menuId", param.getMenuId());
        List<Object> list = cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "authList"), tmpParam);

        if(null != list && !list.isEmpty() ){
            return false;
        }else {
            errMsg = "It has sub-data.";
            return true;
        }

    }

    public String delete(AuthMenuDTO params) {
        String result = "";

        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "delete"), params);

        if (ERROR_RESULT.equals(params.getErrYn())) {
            result = params.getErrMsg();
            log.error("Error.Input parameters............." + params);
            throw new RuntimeException(result);
        }

        return result;
    }

    public String insertMenus(AuthMenuDTO params) {
        String result = "";

        delete(params);
        insert(params);

        if (ERROR_RESULT.equals(params.getErrYn())) {
            result = params.getErrMsg();
            log.error("Error.Input parameters............." + params);
            throw new RuntimeException(result);
        }

        return result;
    }
}
