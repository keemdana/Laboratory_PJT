/*
 * @(#)AuthMemberCtrl.java     2022-02-08(008) 오후 3:32
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

import com.vertexid.viself.base.BaseCtrl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

/**
 * <b>Description</b>
 * <pre>
 *     권한별 사용자 컨트롤러
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class AuthMemberCtrl extends BaseCtrl {

    @Resource
    AuthMemberSvc authMemberSvc;

    @RequestMapping(value = "/viself/auth/authMember/insertAuthUser/json",
            method = RequestMethod.POST)
    public String insertMember(ModelMap model, AuthMemberDTO params) {

        model.clear();

        String result = authMemberSvc.insert(params);

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

    @RequestMapping(value = "/viself/auth/authMember/updateAuthUser/json",
            method = RequestMethod.POST)
    public String updateMember(ModelMap model, AuthMemberDTO params) {

        model.clear();

        String result = authMemberSvc.update(params);

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

    @RequestMapping(value = "/viself/auth/authMember/delete/json",
            method = RequestMethod.POST)
    public String deleteMember(ModelMap model, AuthMemberDTO params) {

        model.clear();

        String result = authMemberSvc.delete(params);

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
