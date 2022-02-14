/*
 * @(#)CmmTilesViewSvc.java     2019-11-19 오후 5:52
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

import com.vertexid.commons.utils.CommonConstants;
import com.vertexid.spring.utils.CmmProperties;
import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.hr.SysLoginVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;


/**
 * <b>Description</b>
 * <pre>
 * 주소 패턴에 따라 해당 뷰를 tiles뷰로 전환하는 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
public class CmmTilesViewSvc extends BaseSvc {

	private static final String PARTICLE_POSTFIX = ".particle";
	private static final String MODAL_POSTFIX = ".modal";
    private static final String POPUP_POSTFIX = ".popup";
    private static final String TILES_POSTFIX = ".tiles";
    private static final char PATH_SEPARATOR = '/';

    /**
     * view 정보를 이용해서 tiles view 패턴을 반환
     * @param viewInfo view info
     * @param model TODO
     * @return tiles view pattern
     */
    String getTilesView(BaseViewVO viewInfo, ModelMap model) {

        if (null == viewInfo) {
            // WARN
            if (log.isWarnEnabled()) {
                log.warn(".......................................NO PAGE INFO");
            }
            return null;
        }

        StringBuffer sbTilesView = new StringBuffer();

        sbTilesView.append(PATH_SEPARATOR);

        // system
        if (StringUtils.isNotEmpty(viewInfo.getSystem())) {
            sbTilesView.append(viewInfo.getSystem()).append(PATH_SEPARATOR);
        }

        // app
        if (StringUtils.isNotEmpty(viewInfo.getApp())) {
            sbTilesView.append(viewInfo.getApp()).append(PATH_SEPARATOR);
        }

        // module
        if (StringUtils.isNotEmpty(viewInfo.getModule())) {
            sbTilesView.append(viewInfo.getModule()).append(PATH_SEPARATOR);
        }

        // sub module
        if (StringUtils.isNotEmpty(viewInfo.getSub())) {
            sbTilesView.append(viewInfo.getSub()).append(PATH_SEPARATOR);
        }

        // typePostfix 붙이기 (.popup , .modal , .include ....)
        if (StringUtils.isNotEmpty(viewInfo.getTypePostfix())) {
        	 sbTilesView.append(viewInfo.getPage()).append(".").append(viewInfo.getTypePostfix())
             .append(TILES_POSTFIX);
        }else {
        	// normal page
            sbTilesView.append(viewInfo.getPage()).append(TILES_POSTFIX);
        }

        // DEBUG
        if (log.isDebugEnabled()) {
            log.debug("view info......................." + viewInfo.toString());
        }

        // INFO
        if (log.isInfoEnabled()) {
            log.info("tiles view..............................." + sbTilesView);
        }

        SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
        model.addAttribute(CommonConstants.SESSION_USER, loginUser);
        model.addAttribute("isProd", CmmProperties.isProd());

        return sbTilesView.toString();
    }
}
