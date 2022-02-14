/*
 * @(#)CmmJsonViewSvc.java     2019-11-19 오후 5:52
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

package com.vertexid.viself.base;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <b>Description</b>
 * <pre>
 *     공통 조회뷰
 * </pre>
 */
@Service
@Transactional
public class CmmJsonViewSvc extends BaseSvc {

    @Resource(name = "cmmDAO")
    CmmDAO cmmDAO;

    @Resource
    PagingParamFunction pagingParamFunction;

    /**
     * 데이터 얻기
     * @param modelInfo model info
     * @param params parameters
     * @return data(s)
     */
    @Transactional(readOnly = true)
    public Object getData(BaseModelVO modelInfo, Map<String, Object> params) {
        if (null == modelInfo) {
            // WARN
            if (log.isWarnEnabled()) {
                log.warn("..................................modelInfo is null");
            }
            return null;
        }

        ActionType actionType = modelInfo.getActionType();

        if (actionType == ActionType.DATA) {
            return getOne(modelInfo, params);
        } else if (actionType == ActionType.LIST || actionType == ActionType.SELECT) {
            return getList(modelInfo, params);
        } else {
            // WARN
            if (log.isWarnEnabled()) {
                log.warn(".................................actionType is null");
            }
            return null;
        }
    }

    @Transactional(readOnly = true)
    public <E> List<E> getList(BaseModelVO modelInfo, Map<String, Object> params) {

        pagingParamFunction.setOrderParam(params);
        return cmmDAO.getList(modelInfo, params);
    }

    @Transactional(readOnly = true)
    public <T> T getOne(BaseModelVO modelInfo, Map<String, Object> params) {
        return cmmDAO.getOne(modelInfo, params);
    }

    /**
     * @deprecated transaction 관련 액션은 직접호출 불가 반드시 별도 구현
     */
    public int update(BaseModelVO modelInfo, Map<String, Object> params) {
        return cmmDAO.update(modelInfo, params);
    }

    /**
     * @deprecated transaction 관련 액션은 직접호출 불가 반드시 별도 구현
     */
    public int insert(BaseModelVO modelInfo, Map<String, Object> params) {
        return cmmDAO.insert(modelInfo, params);
    }

    /**
     * @deprecated transaction 관련 액션은 직접호출 불가 반드시 별도 구현
     */
    public int delete(BaseModelVO modelInfo, Map<String, Object> params) {
        return cmmDAO.delete(modelInfo, params);
    }
}
