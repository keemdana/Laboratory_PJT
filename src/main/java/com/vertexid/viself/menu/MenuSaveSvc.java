/*
 * @(#)MenuSaveSvc.java     2020-09-17(017) 오후 3:38
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
package com.vertexid.viself.menu;

import java.util.HashMap;
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
 *     메뉴 저장 서비스(No Procedure)
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class MenuSaveSvc extends BaseSvc {

    private static final String NAMESPACE =
            "com.vertexid.viself.menu.MenuMng";
    private static final String ROOT_NODE = "main";
    private static final String MENU_NODE = "menu";

    private String errMsg;

    @Resource
    private CmmDAO cmmDAO;

    /**
     * 메뉴 생성용 임시 메뉴 아이디
     */
    private static final String TEMP_MENU_ID = "TEMP_MENU_ID";

    /**
     * 메뉴 저장
     *
     * @param param 저장 파라메터
     */
    public void saveMenuInfo(MenuDTO param) {

        // 1. check data
        if (checkData(param)) {

        	// 1. 생성
        	cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), param);

        } else {
            param.setErrCd(ERROR_RESULT);
            param.setErrMsg(errMsg);
            param.setErrYn(Boolean.toString(true));
        }
    }

    /**
     * 입력값 검사
     *
     * @param param 입력파라메터
     * @return true: 정상, false: 오류
     */
    private boolean checkData(MenuDTO param) {

        // 필수 검사: menuId, menuNm, parentMenuId
        if (StringUtils.isEmpty(param.getMenuId())) {
            errMsg = "There is no menuId.";
            return false;
        }
//        if (StringUtils.isEmpty(param.getMenuNm())) {
//            errMsg = "There is no menuNm.";
//            return false;
//        }
//        if (StringUtils.isEmpty(param.getParentMenuId())) {
//            errMsg = "There is no parentMenuId.";
//            return false;
//        }

        // 데이터 존재여부 검사: parentMenuId
        if("U".equals(param.getCud())) {
        	Map<String, Object> tmpParam = new HashMap<String, Object>();
        	tmpParam.put("menuId", param.getMenuId());
        	Map<String, Object> rtnData =
        			cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "data"), tmpParam);

        	if (null == rtnData) {
        		errMsg = "There is no parent node.";
        		return false;
        	}
        }

        return true;
    }

}
