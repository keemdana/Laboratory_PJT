package com.vertexid.paragon.def.defstumail;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.base.ModelAttribute;

@Controller
public class DefStuMailCtrl extends BaseCtrl{

	@Resource
	private DefStuMailSvc defStuMailSvc;

	@RequestMapping(value = "/commons/def/defstumail/DefStuMail/insert/json",
            method = RequestMethod.POST)
    public String save(SessionStatus status, HttpServletRequest req,
            ModelMap model,
            @RequestBody
                    DefStuMailDTO params) {

        log.info("params........\n" + params.toString());
        model.clear();

        String result = defStuMailSvc.save(params);

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
