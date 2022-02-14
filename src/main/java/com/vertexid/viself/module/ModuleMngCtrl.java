/*
 * @(#)ModuleMngCtrl.java     2021-03-16(016) 오후 2:03
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
package com.vertexid.viself.module;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.vertexid.viself.security.SimpleReloadableSecurityMetadataSource;
import com.vertexid.viself.security.SimpleSecureObjectSvc;
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
 *     모듈 관리 컨트롤러
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class ModuleMngCtrl extends BaseCtrl {

    @Resource
    private ModuleMngSvc moduleMngSvc;

    @Resource
    private SimpleSecureObjectSvc simpleSecureObjectSvc;

    @Resource
    private SimpleReloadableSecurityMetadataSource
            simpleReloadableSecurityMetadataSource;

    @RequestMapping(value = "/viself/module/moduleMng/save/json",
            method = RequestMethod.POST)
    public String saveModule(ModelMap model, HttpServletRequest req,
            @RequestBody
                    ModuleDTO params) {

        model.clear();

        String result = moduleMngSvc.save(params);

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

    @RequestMapping(value = "/viself/module/moduleMng/delete/json",
            method = RequestMethod.POST)
    public String deleteModule(ModelMap model,
            @RequestBody
                    ModuleDTO params) throws Exception {
        model.clear();

        String result = moduleMngSvc.delete(params);

        model.addAttribute(ERROR_FLAG.getAttributeId(), ERROR_RESULT);

        if (StringUtils.isEmpty(result)) {
            result = COMPLETE.getMsgCode();
            model.addAttribute(ERROR_FLAG.getAttributeId(), COMPLETE_RESULT);
        } else if (isProd()) {
            result = ERROR.getMsgCode();
        }

        model.addAttribute(MSG.getAttributeId(), result);

        // reload security
        reloadSecurity();

        return JSON_VIEW.getViewId();
    }

    private void reloadSecurity() throws Exception {
        // reload
        simpleReloadableSecurityMetadataSource.setSecureObjectSvc(simpleSecureObjectSvc);
        simpleReloadableSecurityMetadataSource.reload();
    }

    @RequestMapping(value = "/viself/module/moduleMng/saveModuleUrl/json",
            method = RequestMethod.POST)
    public String saveModuleUrl(ModelMap model, HttpServletRequest req,
            @RequestBody
                    ModuleUrlDTO params) throws Exception {
        model.clear();

        String result = moduleMngSvc.saveUrl(params);

        model.addAttribute(ERROR_FLAG.getAttributeId(), ERROR_RESULT);

        if (StringUtils.isEmpty(result)) {
            result = COMPLETE.getMsgCode();
            model.addAttribute(ERROR_FLAG.getAttributeId(), COMPLETE_RESULT);
        } else if (isProd()) {
            result = ERROR.getMsgCode();
        }

        model.addAttribute(MSG.getAttributeId(), result);

        // reload security
        reloadSecurity();

        return JSON_VIEW.getViewId();
    }

    @RequestMapping(value = "/viself/module/moduleMng/deleteModuleUrls/json",
            method = RequestMethod.POST)
    public String deleteModuleUrls(ModelMap model, @RequestBody
            ModuleUrlDTO params) throws Exception {
        model.clear();

        String result = moduleMngSvc.deleteUrls(params);

        model.addAttribute(ERROR_FLAG.getAttributeId(), ERROR_RESULT);

        if (StringUtils.isEmpty(result)) {
            result = COMPLETE.getMsgCode();
            model.addAttribute(ERROR_FLAG.getAttributeId(), COMPLETE_RESULT);
        } else if (isProd()) {
            result = ERROR.getMsgCode();
        }

        model.addAttribute(MSG.getAttributeId(), result);

        // reload security
        reloadSecurity();

        return JSON_VIEW.getViewId();
    }

}
