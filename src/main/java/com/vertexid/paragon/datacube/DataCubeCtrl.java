package com.vertexid.paragon.datacube;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.vertexid.viself.hr.SysLoginVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseCtrl;

@Controller
public class DataCubeCtrl extends BaseCtrl {

	@Resource
	DataCubeSvc dataCubeSvc;

    /**
     * 파일 작성 폼
     *
     * @param session
     * @param model
     * @param params
     * @return
     */
    @RequestMapping("/paragon/datacube/DataCube/doProc/json")
    public String doProc(HttpSession session,
            ModelMap model,
            @RequestBody
            	DataCubeDTO params) {

    	SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();

    	params.setRegLoginId(loginUser.getLoginId());
    	params.setUptLoginId(loginUser.getLoginId());
    	params.setSiteLocale(loginUser.getSiteLocale());
    	params.setLoginUser(loginUser);
        log.debug("params..........??????" + params);
        String result = dataCubeSvc.doWriteProc(params);
        log.debug("result..........??????" + result);

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
     * 상태만 변경처리
     * @param model
     * @param params
     * @return
     */
    @RequestMapping("/paragon/datacube/DataCube/doStuProc/json")
    public String doStuProc(ModelMap model,
            @RequestParam
        	Map<String, Object> params) {

    	log.debug("params..........??????" + params);
        String result = dataCubeSvc.doStuProc(params);

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
