package com.vertexid.paragon.def.defstumng;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.base.ModelAttribute;

@Controller
public class DefStuMngCtrl extends BaseCtrl{

	@Resource
	private DefStuMngSvc stuMngSvc;

	 /**
     * 상태 정보 저장 처리
     *
     * @param status 세션 상태
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 처리결과 정보
     */
    @RequestMapping(value = "/paragon/def/defstumng/DefStuMng/save/json",
            method = RequestMethod.POST)
    public String save(SessionStatus status, HttpServletRequest req,
            ModelMap model,
            @RequestBody
                    DefStuMngDTO params) {

        log.info("params........\n" + params.toString());
        model.clear();

        String result = stuMngSvc.save(params);

        if (StringUtils.isEmpty(result)) {
            // 정상처리시 메시지 표시
            model.addAttribute(ModelAttribute.MSG.getAttributeId(),
                    COMPLETE.getMsgCode());
        } else {
            if (isNotProd()) {
                // 운영이 아닐 경우 에러 메시지 표시
                model.addAttribute(ModelAttribute.MSG.getAttributeId(), result);
            } else {
                // 운영일 경우 기본 에러 메시지 표시
                model.addAttribute(ModelAttribute.MSG.getAttributeId(),
                        ERROR.getMsgCode());
            }
            model.addAttribute(ModelAttribute.ERROR_FLAG.getAttributeId(),
                    ERROR.getResultCode());
        }

        log.info("result.....\n" + model);

        return JSON_VIEW.getViewId();
    }

    /**
     * 메뉴 정보 저장 처리
     *
     * @param status 세션 상태
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 처리결과 정보
     */
    @RequestMapping(value = "/paragon/def/defstumng/DefStuMng/delete/json",
    		method = RequestMethod.POST)
    public String delete(HttpServletRequest req,
    		ModelMap model,
    		@RequestParam
    		Map<String, Object> params) {

    	log.info("params........\n" + params.toString());
    	model.clear();

    	String result = stuMngSvc.delete(params);

    	if (StringUtils.isEmpty(result)) {
    		// 정상처리시 메시지 표시
    		model.addAttribute(ModelAttribute.MSG.getAttributeId(),
    				COMPLETE.getMsgCode());
    	} else {
    		if (isNotProd()) {
    			// 운영이 아닐 경우 에러 메시지 표시
    			model.addAttribute(ModelAttribute.MSG.getAttributeId(), result);
    		} else {
    			// 운영일 경우 기본 에러 메시지 표시
    			model.addAttribute(ModelAttribute.MSG.getAttributeId(),
    					ERROR.getMsgCode());
    		}
    		model.addAttribute(ModelAttribute.ERROR_FLAG.getAttributeId(),
    				ERROR.getResultCode());
    	}

    	log.info("result.....\n" + model);

    	return JSON_VIEW.getViewId();
    }
}
