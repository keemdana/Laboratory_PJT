/*
 * @(#)DefaultLoginCtrl.java     2021-12-01(001) 오후 4:16
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
package com.vertexid.viself.login;

import com.vertexid.viself.base.BaseCtrl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class DefaultLoginCtrl extends BaseCtrl {

    private static final String LOGIN_FORM_TILES_VIEW = "login.tiles";

    /**
     * 로그인 폼
     *
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/login.do")
    public String loginForm(HttpServletRequest req,
            ModelMap model,
            @RequestParam
                    Map<String, Object> params) {


        log.debug("params..........??????" + params);


        return LOGIN_FORM_TILES_VIEW;
    }
}
