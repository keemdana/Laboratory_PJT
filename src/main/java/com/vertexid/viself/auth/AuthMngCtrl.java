/*
 * @(#)AuthMngCtrl.java     2021-12-30(030) 오후 4:09
 *
 * Copyright 2021 JAYU.space
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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
 *     권한(Role) 관리 컨트롤러
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class AuthMngCtrl extends BaseCtrl {

    @Resource
    AuthMngSvc authMngSvc;

    @RequestMapping(value = "/viself/auth/authMng/insert/json",
            method = RequestMethod.POST)
    public String insertRole(ModelMap model, AuthMngDTO params) {

        model.clear();

        String result = authMngSvc.insert(params);

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

    @RequestMapping(value = "/viself/auth/authMng/update/json",
            method = RequestMethod.POST)
    public String updateRole(ModelMap model, AuthMngDTO params) {

        model.clear();

        String result = authMngSvc.update(params);

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

    @RequestMapping(value = "/viself/auth/authMng/updateSort/json",
            method = RequestMethod.POST)
    public String updateSortRole(ModelMap model, AuthMngDTO params) {

        model.clear();

        String result = authMngSvc.updateSort(params);

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

    @RequestMapping(value = "/viself/auth/authMng/delete/json",
            method = RequestMethod.POST)
    public String deleteRole(ModelMap model, AuthMngDTO params) {

        model.clear();

        String result = authMngSvc.delete(params);

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
