package com.vertexid.viself.mlang;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.base.BaseModelVO;

/**
 * 다국어사전관리 컨트롤러
 * @author sitas
 * @since 2020.9.7
 */
@Controller
public class MLangMngCtrl extends BaseCtrl{

	@Resource
	private MLangMngSvc mLangMngSvc;


	/**
     * ㅈ 처리 폼
     *
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
	
	@RequestMapping("/viself/mlang/mLangMng/saveData/json")
    public String saveData(HttpSession session,
            ModelMap model,
            @RequestParam
            	Map<String,Object> params) {

    	BaseModelVO modelInfo =
                new BaseModelVO("viself", "mlang", null , null, "MLangMng", "saveData");
        return getJsonView(modelInfo, model, params);
    }
	
	
    @RequestMapping("/viself/mlang/mLangUpdate/deleteNoLang/json")
    public String deleteNoLang(HttpSession session,
            ModelMap model,
            @RequestParam
            	Map<String,Object> params) {

    	BaseModelVO modelInfo =
                new BaseModelVO("viself", "mlang", null , null, "MLangMng", "deleteNoLang");
        return getJsonView(modelInfo, model, params);
    }

    @RequestMapping("/viself/mlang/mLangUpdate/notYetInsert/json")
    public String notYetInsert(HttpSession session,
    		ModelMap model,
    		@RequestParam
    		Map<String,Object> params) {

    	BaseModelVO modelInfo =
    			new BaseModelVO("viself", "mlang", null , null, "MLangMng", "notYetInsert");
    	return getJsonView(modelInfo, model, params);
    }

    @RequestMapping("/viself/mlang/mLangUpdate/notYetSelectInsert/json")
    public String notYetSelectInsert(HttpSession session,
    		ModelMap model,
    		@RequestParam
    		Map<String,Object> params) {

    	BaseModelVO modelInfo =
    			new BaseModelVO("viself", "mlang", null , null, "MLangMng", "notYetSelectInsert");
    	return getJsonView(modelInfo, model, params);
    }

    @RequestMapping("/viself/mlang/mLangInit/json")
    public String MLangInit(HttpSession session,
    		ModelMap model,
    		@RequestParam
    		Map<String,Object> params) {

    	BaseModelVO modelInfo =
    			new BaseModelVO("viself", "mlang", null , null, "MLangMng", "list");
    	return getJsonView(modelInfo, model, params);
    }

    @RequestMapping("/viself/mlang/mLangUpdate/listMaxVersion/json")
    public String listMaxVersion(HttpSession session,
    		ModelMap model,
    		@RequestParam
    		Map<String,Object> params) {

    	BaseModelVO modelInfo =
    			new BaseModelVO("viself", "mlang", null , null, "MLangMng", "listMaxVersion");
    	return getJsonView(modelInfo, model, params);
    }

}
