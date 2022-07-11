package com.vertexid.voc;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;

import java.util.HashMap;
import java.util.Map;

import javax.activation.CommandMap;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.viself.base.BaseCtrl;

import net.sf.json.JSONArray;

@Controller
public class vocProcessCtrl extends BaseCtrl{
	
	@Resource
	vocProcessSvc vocSvc;
	
	
	
	//리스트 조회
	@RequestMapping(value = "/voc/schVoc/json", method = RequestMethod.POST)
    public String getList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", vocSvc.getList(params));
        return JSON_VIEW.getViewId();
    }
    
	/*
	
	//VOC 선택 후 조회
	@RequestMapping(value = "/voc/getSchVocSelectOne/json", method = RequestMethod.POST)
    public String getSchVocSelectOne(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", vocSvc.getSchVocSelectOne(params));		
		model.addAttribute("sulbi", vocSvc.getSchVocSelectSulbiList(params));
		model.addAttribute("process", vocSvc.getSchVocSelectProcessList(params));
		
		params.put("hcode", "REG_TYPE");
		model.addAttribute("regType", vocSvc.getDdList(params));
		
		params.put("hcode", "REJECT");
		model.addAttribute("regIngRs", vocSvc.getDdList(params));
		
		params.put("hcode", "GRADE_TYPE");
		model.addAttribute("gradeType", vocSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_PLAN");
		model.addAttribute("processPlan", vocSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_STATUS");
		model.addAttribute("processStatus", vocSvc.getDdList(params));
		
		
		
        return JSON_VIEW.getViewId();
    }
		
	//기준정보 조회
	@RequestMapping(value = "/voc/getDdList_backup/json", method = RequestMethod.POST)
    public String getDdList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		
		//구분
		//params.put("hcode", "VOC01");
		//model.addAttribute("vocTp", vocSvc.getDdList(params));
		//접수유형
		params.put("hcode", "REG_TYPE");
		model.addAttribute("regType", vocSvc.getDdList(params));
		//장비군
		//params.put("hcode", "VOC03");
		//model.addAttribute("prodGroup", vocSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_PLAN");
		model.addAttribute("processPlan", vocSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_STATUS");
		model.addAttribute("processStatus", vocSvc.getDdList(params));
		
		return JSON_VIEW.getViewId();
    }
	
	//VOC 등록	
    @RequestMapping(value = "/voc/saveMst/json", method = RequestMethod.POST)
    public String vocSave(HttpServletRequest req, ModelMap model, @RequestBody vocProcessDTO dto) {
        
    	if(!"".equals(dto.getVocNo())) {//신규 건이 아닐 경우(임시저장 -> 저장) update 처리한다.
    		if("Y".equals(dto.getRejectFlag())) {	//반려 후 재접수를 위한 임시저장
    			dto.setDelFlag("N");
    			dto.setVocStatus("VOC12");
    		}else {
    			dto.setDelFlag("N");
    			dto.setVocStatus("VOC02");
    		}    		    		
    		vocSvc.updateTmpMst(dto);
    		vocSvc.deleteSulbi(dto);
    	}else {
    		vocSvc.saveMst(dto);
        	
    	}
    	    	      
    	vocSvc.saveSulbi(dto);
    	
        return JSON_VIEW.getViewId();
    }
    
    //접수 임시저장	
    @RequestMapping(value = "/voc/saveTmpMst/json", method = RequestMethod.POST)
    public String saveTmpMst(HttpServletRequest req, ModelMap model, @RequestBody vocProcessDTO dto) {
        
    	if(!"".equals(dto.getVocNo())) {//신규 건이 아닐 경우 update 처리한다.
    		if("Y".equals(dto.getRejectFlag())) {	//반려 후 재접수를 위한 임시저장
    			dto.setDelFlag("T");
    			dto.setVocStatus("VOC11");
    		}else {
    			dto.setDelFlag("T");
    			dto.setVocStatus("VOC01");
    		}    		
    		vocSvc.updateTmpMst(dto);
    		vocSvc.deleteSulbi(dto);
    	}else {
    		vocSvc.saveTmpMst(dto);
        	
    	}
    	    
    	vocSvc.saveSulbi(dto);
    	
        return JSON_VIEW.getViewId();
    }
    
    //VOC 삭제	
    @RequestMapping(value = "/voc/deleteMst/json", method = RequestMethod.POST)
    public String deleteMst(HttpServletRequest req, ModelMap model, @RequestBody vocProcessDTO dto) {
        vocSvc.deleteMst(dto);
        vocSvc.deleteSulbi(dto);
        vocSvc.deleteProcess(dto);
        
        return JSON_VIEW.getViewId();
    }
    
    //고객사 조회(ISCM29)
    @RequestMapping(value = "/voc/getCustList/json", method = RequestMethod.POST)
    public String getCustList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocSvc.getCustList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //설비 조회
    @RequestMapping(value = "/voc/getSulbiList/json", method = RequestMethod.POST)
    public String getSulbiList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        String newPage = (String)params.get("newSch");
    	if(newPage.equals("Y")) {
    		params.replace("page", "1");
    	}
        
    	model.addAttribute("data", vocSvc.getSulbiList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //처리부서 조회(ISCM29)
    @RequestMapping(value = "/voc/getDeptList/json", method = RequestMethod.POST)
    public String getDeptList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocSvc.getDeptList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //프로젝트 조회
    @RequestMapping(value = "/voc/getPjtList/json", method = RequestMethod.POST)
    public String getPjtList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocSvc.getPjtList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //처리 담당 조회
    @RequestMapping(value = "/voc/getEmpList/json", method = RequestMethod.POST)
    public String getEmpList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocSvc.getEmpList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //ECR 조회
    @RequestMapping(value = "/voc/getEcrList/json", method = RequestMethod.POST)
    public String getEcrList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocSvc.getEcrList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //처리 저장
    @RequestMapping(value = "/voc/saveProcess/json", method = RequestMethod.POST)
    public String vocProcessSave(HttpServletRequest req, ModelMap model, @RequestBody vocProcessDTO dto) {
        
		vocSvc.deleteProcess(dto);
		
		if(dto.getRegIngYn().equals("Y")) { //진행일 경우
			vocSvc.saveProcess(dto);		//처리부서 저장
		}
		
		vocSvc.updateProcessMst(dto);	//진행 or 반려 사항 업데이트
		
        return JSON_VIEW.getViewId();
    }
    
    //처리 담당자 저장
    @RequestMapping(value = "/voc/saveEmpProcess/json", method = RequestMethod.POST)
    public String saveEmpProcess(HttpServletRequest req, ModelMap model, @RequestBody vocProcessDTO dto) {
        
		//vocSvc.deleteProcess(dto);
		vocSvc.saveEmpProcess(dto);		//처리부서 저장
		//vocSvc.updateProcessMst(dto);	//진행 or 반려 사항 업데이트
		
        return JSON_VIEW.getViewId();
    }
    
    //처리 저장
    @RequestMapping(value = "/voc/saveProProcess/json", method = RequestMethod.POST)
    public String saveProProcess(HttpServletRequest req, ModelMap model, @RequestBody vocProcessDTO dto) {
        
		//vocSvc.deleteProcess(dto);
		vocSvc.saveProProcess(dto);		//처리상태 저장
		
        return JSON_VIEW.getViewId();
    }
    
    */
}
