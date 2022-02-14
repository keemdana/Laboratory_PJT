/*
 * @(#)BaseCtrl.java     2018-02-17 오전 7:44
 *
 * Copyright 2018 Yang, Ki Hwa
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

package com.vertexid.viself.base;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;

import com.vertexid.commons.view.ViewType;

import static com.vertexid.viself.base.MessageCode.COMPLETE;
import static com.vertexid.viself.base.MessageCode.ERROR;
import static com.vertexid.viself.base.ModelAttribute.ERROR_FLAG;
import static com.vertexid.viself.base.ModelAttribute.MSG;

/**
 * <b>Description</b>
 * 기본컨트롤러<br>
 * [참고] 신현삼(Shin, Hyeon Sam)[mong32@gmail.com]의 EISF BaseCtr을 참고
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseCtrl {

    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    public static final String ERROR_RESULT = MessageCode.ERROR.getResultCode();
    public static final String COMPLETE_RESULT =
            MessageCode.COMPLETE.getResultCode();

    @Resource
    CmmJsonViewSvc cmmJsonViewSvc;

    @Resource
    SystemPropertiesVO systemPropertiesVO;

    /**
     * 조회서비스를 이용해서 모델에 값을 설정
     *
     * @param modelInfo model info
     * @param model     model
     * @param params    parameters
     * @return JSON view
     */
    protected String getJsonView(BaseModelVO modelInfo, ModelMap model,
            Map<String, Object> params) {


        model.clear();

        ActionType actionType = modelInfo.getActionType();
        //-- Data Select
        if (actionType == ActionType.DATA || actionType == ActionType.LIST ||
                actionType == ActionType.SELECT) {
            model.addAttribute(ModelAttribute.DATA.getAttributeId(),
                    cmmJsonViewSvc.getData(modelInfo, params));
            //-- Data Update
//        } else if (actionType == ActionType.UPDATE ||
//                actionType == ActionType.MODIFY) {
//            // @deprecated transaction 관련 액션은 직접호출 불가 반드시 별도 구현
//            model.addAttribute(ModelAttribute.DATA.getAttributeId(),
//                    cmmJsonViewSvc.update(modelInfo, params));
//            //-- Data Insert
//        } else if (actionType == ActionType.SAVE ||
//                actionType == ActionType.INSERT) {
//            // @deprecated transaction 관련 액션은 직접호출 불가 반드시 별도 구현
//            model.addAttribute(ModelAttribute.DATA.getAttributeId(),
//                    cmmJsonViewSvc.insert(modelInfo, params));
//            //-- Data Delete
//        } else if (actionType == ActionType.DELETE) {
//            // @deprecated transaction 관련 액션은 직접호출 불가 반드시 별도 구현
//            model.addAttribute(ModelAttribute.DATA.getAttributeId(),
//                    cmmJsonViewSvc.delete(modelInfo, params));
        }else{
            throw new RuntimeException("지원하지 않는 액션입니다.:"+actionType);
        }

        model.addAttribute("loginId", params.get("loginId"));
        model.addAttribute("isProd", isProd());
//        log.debug("getJsonView : result........." + model);
        return ViewType.JSON_VIEW.getViewId();
    }

    public String getTransactionJsonView(ModelMap model, String result) {
        model.clear();
        String errorFlag = COMPLETE_RESULT;

        if (StringUtils.isEmpty(result)) {
            result = COMPLETE.getMsgCode();
        } else {

            if (isProd()) {
                result = ERROR.getMsgCode();
            }
            errorFlag = ERROR_RESULT;
        }

        model.addAttribute(ERROR_FLAG.getAttributeId(), errorFlag);
        model.addAttribute(MSG.getAttributeId(), result);
        return ViewType.JSON_VIEW.getViewId();
    }

    protected boolean isNotProd() {
        return systemPropertiesVO.isNotProd();
    }

    protected boolean isProd() {
        return systemPropertiesVO.isProd();
    }

    protected boolean isLocal() {
        return systemPropertiesVO.isLocal();
    }
}
