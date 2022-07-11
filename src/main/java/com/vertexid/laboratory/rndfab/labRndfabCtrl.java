package com.vertexid.laboratory.rndfab;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.viself.base.BaseCtrl;

@Controller
public class labRndfabCtrl extends BaseCtrl{
	
	@Resource
	labRndfabSvc labRndfabSvc;
	
	//연구설비 가동현황 main
	@RequestMapping(value="/rndfab/mainStatusChart/json", method=RequestMethod.POST)
	public String getMainStatusChart(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		String chartXml = labRndfabSvc.getMainStatusChart(params);
		chartXml = chartXml.replaceAll("&", "&amp;");
		model.addAttribute("data", chartXml);
//		model.addAttribute("data", labRndfabSvc.getMainStatusChart(params));
		return JSON_VIEW.getViewId();
//		return params;
	}
	

}
