package com.vertexid.paragon.hr;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.base.ModelAttribute;
import com.vertexid.viself.hr.SysLoginVO;

@Controller
public class HrMngCtrl extends BaseCtrl {


	@Resource
	private HrMngSvc hrMngSvc;
	/**
     * 사용자 권한 정보 조회
     *
     * @param status 세션 상태
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 처리결과 정보
     */
    @RequestMapping(value = "/paragon/hr/hrMng/userList/json",
            method = RequestMethod.POST)
    public String getUser(ModelMap model,
    		@RequestBody HrMngDTO params) {

        log.info("params........\n" + params.toString());
        model.clear();
        model.addAttribute(ModelAttribute.DATA.getAttributeId(), hrMngSvc.getList(params));

        return JSON_VIEW.getViewId();
    }
    /**
     * 기본 결재선 조회
     *
     * @param status 세션 상태
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 처리결과 정보
     */
    @RequestMapping(value = "/paragon/hr/hrMng/getDefaultLine",
    		method = RequestMethod.POST)
    public String getDefaultLine(ModelMap model,
    		@RequestParam Map<String, Object> params) {

    	log.info("params........\n" + params.toString());
    	model.clear();
    	model.addAttribute(ModelAttribute.DATA.getAttributeId(), hrMngSvc.getDefaultLine(params));

    	return JSON_VIEW.getViewId();
    }
    /**
     * 사용자 권한 정보 수정
     *
     * @param status 세션 상태
     * @param req    request
     * @param model  모델
     * @param params 파라메터
     * @return 처리결과 정보
     */
    @RequestMapping(value = "/paragon/hr/hrMng/update/json",
    		method = RequestMethod.POST)
    public String update(ModelMap model,
    		@RequestBody HrMngDTO params) {

    	log.info("params........\n" + params.toString());
    	String result = hrMngSvc.update(params);
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
