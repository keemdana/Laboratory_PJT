/*
 * @(#)CmmRSACtrl.java     2019-10-31 오후 6:09
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

package com.vertexid.viself.security;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.vertexid.commons.view.ViewType;
import com.vertexid.viself.base.BaseCtrl;

/**
 * 공용 RSA 컨트롤러
 * 세션에 신규 RSA 공개키를 전달
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class CmmRSACtrl extends BaseCtrl {

    @Resource
    RSACryptographicSvc rsaCryptographicSvc;

    /**
     * RSA 초기화(Key 재발행)
     * <p>
     * 세션에서 발행하는 공개키가 세션 만료시간이후에는 키도 만료가 되므로
     * 로그인 시에 새로 받아서 처리하는 방식으로 변경
     *
     * @param status 세션상태
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping(value = "/rsa/init", method = RequestMethod.POST)
    public String initRsa(SessionStatus status, HttpServletRequest req,
            ModelMap model,
            @RequestParam
                    Map<String, Object> params) {

        Map<String, Object> newPubKey =
                rsaCryptographicSvc.setRSAKey(req);

        model.clear();
        model.put(RSAAttributeKey.PUBLIC_KEY_MODULUS,
                newPubKey.get(RSAAttributeKey.PUBLIC_KEY_MODULUS));
        model.put(RSAAttributeKey.PUBLIC_KEY_EXPONENT,
                newPubKey.get(RSAAttributeKey.PUBLIC_KEY_EXPONENT));

        return ViewType.JSON_VIEW.getViewId();
    }
}
