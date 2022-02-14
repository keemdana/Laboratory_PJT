/*
 * @(#)UrlMngCtrl.java     2021-03-15(015) 오후 4:24
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
import com.vertexid.viself.security.SimpleReloadableSecurityMetadataSource;
import com.vertexid.viself.security.SimpleSecureObjectSvc;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * <b>Description</b>
 * <pre>
 *     URL 관리
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class UrlMngCtrl extends BaseCtrl {

    @Resource
    private UrlMngSvc urlMngSvc;

    @Resource
    private SimpleSecureObjectSvc simpleSecureObjectSvc;

    @Resource
    private SimpleReloadableSecurityMetadataSource simpleReloadableSecurityMetadataSource;



    @RequestMapping(value = "/viself/auth/urlMng/save/json",
            method = RequestMethod.POST)
    public String saveUrl(ModelMap model, HttpServletRequest req,
            @RequestBody
                    UrlDTO params) throws Exception {

        String rtnString = getTransactionJsonView(model, urlMngSvc.save(params));

        // reload
        simpleReloadableSecurityMetadataSource.setSecureObjectSvc(simpleSecureObjectSvc);
        simpleReloadableSecurityMetadataSource.reload();

        return rtnString;
    }

    @RequestMapping(value = "/viself/auth/urlMng/delete/json",
            method = RequestMethod.POST)
    public String deleteUrl(ModelMap model, HttpServletRequest req,
            @RequestBody
                    UrlDTO params) {
        return getTransactionJsonView(model, urlMngSvc.delete(params));
    }
}
