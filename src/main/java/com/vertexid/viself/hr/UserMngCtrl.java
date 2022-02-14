/*
 * @(#)UserMngCtrl.java     2020-10-19(019) 오후 2:47
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

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

import java.security.PrivateKey;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.security.RSAAttributeKey;
import com.vertexid.viself.security.RSACryptographicSvc;

/**
 * <b>Description</b>
 * <pre>
 *     사용자 등록 컨트롤러
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class UserMngCtrl extends BaseCtrl {

    @Resource
    private UserMngSvc userMngSvc;

    @Resource
    private RSACryptographicSvc rsaCryptographicSvc;

    @RequestMapping(value = "/viself/hr/userMng/save/json",
            method = RequestMethod.POST)
    public String saveUser(ModelMap model, HttpServletRequest req,
            @RequestBody
                    UserDTO params) {

        // decrypt rsa
        decryptParams(req, params);
        log.info("params....................\n" + params);

        model.clear();

        String result = userMngSvc.save(params);

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

    private void decryptParams(HttpServletRequest req, UserDTO params) {
        HttpSession session = req.getSession();
        if (null != session.getAttribute(RSAAttributeKey.PRIVATE_KEY)) {
            PrivateKey privateKey = (PrivateKey) session
                    .getAttribute(RSAAttributeKey.PRIVATE_KEY);

            params.setUserId(
                    rsaCryptographicSvc.decrypt(privateKey, params.getUserId()));
            params.setUserNm(
                    rsaCryptographicSvc.decrypt(privateKey, params.getUserNm()));
        }
    }
}
