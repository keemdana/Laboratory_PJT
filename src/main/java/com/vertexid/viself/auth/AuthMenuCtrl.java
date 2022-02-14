/*
 * @(#)AuthMenuCtrl.java     2020-09-18(018) 오전 9:52
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

import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.base.ModelAttribute;
import com.vertexid.viself.hr.SysLoginVO;
import com.vertexid.viself.security.SimpleReloadableSecurityMetadataSource;
import com.vertexid.viself.security.SimpleSecureObjectSvc;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;

/**
 * <b>Description</b>
 * <pre>
 *     권한에 따른 메뉴 컨트롤러
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class AuthMenuCtrl extends BaseCtrl {

    @Resource
    private AuthMenuSvc authMenuSvc;

    @Resource
    private SimpleSecureObjectSvc simpleSecureObjectSvc;

    @Resource
    private SimpleReloadableSecurityMetadataSource
            simpleReloadableSecurityMetadataSource;

    /**
     * 권한에 따른 메뉴 조회
     *
     * @param session 세션
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 조회결과 정보
     */
    @RequestMapping(value = "/viself/auth/authMenu/list/json",
            method = RequestMethod.POST)
    public String view(HttpSession session, HttpServletRequest req,
            ModelMap model,
            @RequestParam
                    Map<String, Object> params) {

    	SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();
    	params.put("authCds",  loginUser.getAuthCd());
    	params.put("useYn",  "1");

    	log.info("authCd........\n" + loginUser.getLoginId());
    	log.info("params........\n" + params);
    	model.clear();

    	model.addAttribute(ModelAttribute.DATA.getAttributeId(), authMenuSvc.getList(params));

    	return JSON_VIEW.getViewId();
    }


    /**
     * 권한에 따른 메뉴 조회
     *
     * @param session 세션
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 조회결과 정보
     */
    @RequestMapping(value = "/viself/auth/authMenu/allList/json",
            method = RequestMethod.POST)
    public String allList(HttpSession session , HttpServletRequest req,
            ModelMap model,
            @RequestParam
                    Map<String, Object> params) {

        SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();
        params.put("authCd",  loginUser.getAuthLangCd());

        log.info("params........\n" + loginUser.getLoginId());
        log.info("params........\n" + params);

        model.clear();
        model.addAttribute(ModelAttribute.DATA.getAttributeId(), authMenuSvc.getAllList(params));

        return JSON_VIEW.getViewId();
    }

    /**
     * 권한에 따른 메뉴 저장
     *
     * @param session 세션
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 조회결과 정보
     */
    @RequestMapping(value = "/viself/auth/authMenu/insert/json",
    		method = RequestMethod.POST)
    public String insert(HttpSession session , HttpServletRequest req,
    		ModelMap model,
    		@RequestBody
            AuthMenuDTO params) throws Exception {

//    	SysLoginModel loginUser = (SysLoginModel)SessionUtils.getLoginVO();
//    	params.put("loginInfo",  loginUser);

    	log.info("params........\n" + params);

    	model.clear();
    	model.addAttribute(ModelAttribute.DATA.getAttributeId(), authMenuSvc.insertMenus(params));

        // reload
        simpleReloadableSecurityMetadataSource.setSecureObjectSvc(simpleSecureObjectSvc);
        simpleReloadableSecurityMetadataSource.reload();

    	return JSON_VIEW.getViewId();
    }

    /**
     * 권한에 따른 메뉴 저장
     *
     * @param session 세션
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 조회결과 정보
     */
    @RequestMapping(value = "/viself/auth/authMenu/delete/json",
            method = RequestMethod.POST)
    public String delete(HttpSession session , HttpServletRequest req,
            ModelMap model,
            @RequestBody
                    AuthMenuDTO params) throws Exception {

//    	SysLoginModel loginUser = (SysLoginModel)SessionUtils.getLoginVO();
//    	params.put("loginInfo",  loginUser);

        log.info("params........\n" + params);

        model.clear();
        model.addAttribute(ModelAttribute.DATA.getAttributeId(), authMenuSvc.delete(params));

        // reload
        simpleReloadableSecurityMetadataSource.setSecureObjectSvc(simpleSecureObjectSvc);
        simpleReloadableSecurityMetadataSource.reload();

        return JSON_VIEW.getViewId();
    }
}
