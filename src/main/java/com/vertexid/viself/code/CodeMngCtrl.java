/*
 * @(#)CodeMngCtrl.java     2020-09-24(024) 오전 10:30
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

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vertexid.viself.base.BaseCtrl;

/**
 * <b>Description</b>
 * <pre>
 *
 *     코드관리 컨트롤러
 *
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class CodeMngCtrl extends BaseCtrl {

    @Resource
    private CodeTypeSvc codeTypeSvc;

    @Resource
    private CodeSvc codeSvc;


    /**
     * 상세 코드 저장
     *
     * @param model  모델
     * @param params 유형 DTO
     * @return 저장결과 JSON
     */
    @RequestMapping(value = "/viself/code/codeMng/saveCode/json",
            method = RequestMethod.POST)
    public String saveCode(ModelMap model,
            @RequestBody
                    CodeDTO params) {

        model.clear();
        String result = codeSvc.save(params);
        model.addAttribute(ERROR_FLAG.getAttributeId(), ERROR_RESULT);

        if (StringUtils.isEmpty(result)) {
            result = COMPLETE.getMsgCode();
            model.addAttribute(ERROR_FLAG.getAttributeId(), COMPLETE_RESULT);
        } else if (isProd()) {
            result = ERROR.getMsgCode();
        }

        model.addAttribute(MSG.getAttributeId(), result);

        return JSON_VIEW.getViewId();
    }

    /**
     * 코드 삭제: 데이터 삭제 불가-미사용으로 전환
     *
     * @param model  모델
     * @param params 유형 DTO
     * @return 삭제 결과 JSON
     */
    @RequestMapping(value = "/viself/code/codeMng/deleteCode/json",
    		method = RequestMethod.POST)
    public String deleteCode(ModelMap model,
    		@RequestBody
            CodeDTO params) {
        model.clear();

        String result = codeSvc.delete(params);
        model.addAttribute(ERROR_FLAG.getAttributeId(), ERROR_RESULT);

        if (StringUtils.isEmpty(result)) {
            result = COMPLETE.getMsgCode();
            model.addAttribute(ERROR_FLAG.getAttributeId(), COMPLETE_RESULT);
        } else if (isProd()) {
            result = ERROR.getMsgCode();
        }

        model.addAttribute(MSG.getAttributeId(), result);

        return JSON_VIEW.getViewId();
    }

}
