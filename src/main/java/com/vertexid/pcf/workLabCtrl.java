package com.vertexid.pcf;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.hr.SysLoginVO;
import com.vertexid.voc.vocProcessSvc;

@Controller
public class workLabCtrl extends BaseCtrl {

	@Resource
	workLabSvc workLabSvc;
	
	@Resource
	vocProcessSvc vocSvc;
		
	@RequestMapping(value = "/pcf/registerPcf/json", method = RequestMethod.POST)
    public String listUrl(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		
		//SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();
        //params.put("loginInfo",  loginUser);
        
		params.put("hcode", "LAB");
		model.addAttribute("data", workLabSvc.getList(params));
        return JSON_VIEW.getViewId();
    }

}
