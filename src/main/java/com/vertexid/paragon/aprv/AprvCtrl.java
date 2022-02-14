package com.vertexid.paragon.aprv;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.paragon.datacube.DataCubeDTO;
import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.hr.SysLoginVO;

@Controller
public class AprvCtrl extends BaseCtrl{

	@Resource
	AprvSvc aprvSvc;


	/**
     * 결재 처리 폼
     *
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/aprv/aprv/doAprvProc/json")
    public String doProc(HttpSession session,
            ModelMap model,
            @RequestParam
            	Map<String,Object> params) {

    	SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();

    	params.put("loginId", loginUser.getLoginId());
    	params.put("siteLocale", loginUser.getSiteLocale());
    	params.put("loginUser", loginUser);
        log.debug("params..........??????" + params);
        String result = aprvSvc.doAprProc(params);

        if (StringUtils.isEmpty(result)) {
            result = COMPLETE.getMsgCode();
            model.addAttribute(ERROR_FLAG.getAttributeId(), COMPLETE_RESULT);
        } else if (isProd()) {
            result = ERROR.getMsgCode();
        }

        model.addAttribute(MSG.getAttributeId(), result);


        return JSON_VIEW.getViewId();
    }


    /**
     * 결재선 수정 처리
     *
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/aprv/aprv/doAprvChgProc/json")
    public String doAprvChgProc(HttpSession session,
    		ModelMap model,
    		@RequestBody
    		AprvLineDTO params) {

    	SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();

    	log.debug("params..........??????" + params);
    	String result = aprvSvc.doAprvChgProc(params);

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
