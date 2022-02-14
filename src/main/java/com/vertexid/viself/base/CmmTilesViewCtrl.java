/*
 * @(#)CmmTilesViewCtrl.java     2019-11-19 오후 5:52
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

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <b>Description</b>
 * <pre>
 * URL 패턴에 따른 apache tiles를 활용한 view를 처리하는 공통 컨트롤러
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class CmmTilesViewCtrl extends BaseCtrl {

	private static final String ERROR_TILES = "error.tiles";
    @Resource
    CmmTilesViewSvc cmmTilesViewSvc;

    /**
     * tiles 뷰 처리
     *
     * @param system system
     * @param app application
     * @param module module
     * @param sub submodule
     * @param page page
     * @return tiles view
     */
    @RequestMapping("/{system}/{app}/{module}/{sub}/{page:.+}")
    public String view(
            @PathVariable
                    String system,
            @PathVariable
                    String app,
            @PathVariable
                    String module,
            @PathVariable
                    String sub,
            @PathVariable
                    String page,
            ModelMap model
    		) {

        BaseViewVO viewInfo = new BaseViewVO(system, app, module, sub, page);
        return cmmTilesViewSvc.getTilesView(viewInfo, model);
    }

    /**
     * tiles 뷰 처리
     *
     * @param system system
     * @param app application
     * @param module module
     * @param page page
     * @return tiles view
     */
    @RequestMapping("/{system}/{app}/{module}/{page:.+}")
    public String view(
            @PathVariable
                    String system,
            @PathVariable
                    String app,
            @PathVariable
                    String module,
            @PathVariable
                    String page,
            ModelMap model
    		) {

        BaseViewVO viewInfo = new BaseViewVO(system, app, module, null, page);
        return cmmTilesViewSvc.getTilesView(viewInfo, model);
    }

    /**
     * tiles 뷰 처리
     *
     * @param system system
     * @param app application
     * @param page page
     * @return tiles view
     */
    @RequestMapping("/{system}/{app}/{page:.+}")
    public String view(
            @PathVariable
                    String system,
            @PathVariable
                    String app,
            @PathVariable
                    String page,
            ModelMap model) {
        BaseViewVO viewInfo = new BaseViewVO(system, app, null, null, page);
        return cmmTilesViewSvc.getTilesView(viewInfo, model);
    }

    /**
     * tiles 뷰 처리
     *
     * @param system system
     * @param page page
     * @return tiles view
     */
    @RequestMapping("/{system}/{page:.+}")
    public String view(
            @PathVariable
                    String system,
            @PathVariable
                    String page,
            ModelMap model) {

        log.debug("system.............."+system);
        log.debug("page.............."+page);

        BaseViewVO viewInfo = new BaseViewVO(system, null, null, null, page);
        return cmmTilesViewSvc.getTilesView(viewInfo, model);
    }

    /**
     * tiles 뷰 처리
     *
     * @param page page
     * @return tiles view
     */
    @RequestMapping("/{page:.+}")
    public String view(
            @PathVariable
                    String page,
                    ModelMap model) {

        BaseViewVO viewInfo = new BaseViewVO(null, null, null, null, page);
        return cmmTilesViewSvc.getTilesView(viewInfo, model);
    }

    /**
     * 에러 tiles 뷰 처리
     * @return
     */
    @RequestMapping("/error")
    public String viewError(){
        return ERROR_TILES;
    }
}
