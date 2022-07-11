package com.vertexid.voc.mst;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.voc.prc.vocPrcSvc;
import com.vertexid.voc.sulbi.vocSulbiSvc;

@Controller
public class vocMstCtrl extends BaseCtrl{
	
	@Resource
	vocMstSvc vocMstSvc;	//VOC 마스터 정보
	
	@Resource	
	vocSulbiSvc vocSulbiSvc;	//VOC 연계 설비 정보
	
	@Resource	
	vocPrcSvc vocPrcSvc;	//VOC 처리 정보
	
	//전체 VOC 리스트 조회
	@RequestMapping(value = "/voc/vocList/json", method = RequestMethod.POST)
    public String getVocList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", vocMstSvc.getVocList(params));
        return JSON_VIEW.getViewId();
    }
    
	//기준정보 조회
	@RequestMapping(value = "/voc/getDdList/json", method = RequestMethod.POST)
    public String getDdList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		
		//접수유형
		params.put("hcode", "REG_TYPE");
		model.addAttribute("vocRegType", vocMstSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_PLAN");
		model.addAttribute("prcPlanType", vocMstSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_STATUS");
		model.addAttribute("prcStatus", vocMstSvc.getDdList(params));
		
		return JSON_VIEW.getViewId();
    }
	
	//고객사 조회(ISCM29)
    @RequestMapping(value = "/voc/getCustList/json", method = RequestMethod.POST)
    public String getCustList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocMstSvc.getCustList(params));
        
        return JSON_VIEW.getViewId();
    }
    
	//접수 완료	
    @RequestMapping(value = "/voc/saveMst/json", method = RequestMethod.POST)
    public String vocSave(HttpServletRequest req, ModelMap model, @RequestBody vocMstDTO dto) {
        
    	if(!"".equals(dto.getVocNo())) {	//신규 건이 아닐 경우(임시저장 -> 저장) update 처리한다.
    		if("Y".equals(dto.getRejectFlag())) {	//반려 후 재접수를 위한 임시저장
    			dto.setDelFlag("N");
    			dto.setVocStatus("VOC12");
    		}else {
    			dto.setDelFlag("N");
    			dto.setVocStatus("VOC02");
    		}    		    		
    		vocMstSvc.updateTmpMst(dto);
    		vocSulbiSvc.deleteSulbi(dto);	//설비정보 삭제
    	}else {
    		vocMstSvc.saveMst(dto);	//설비정보 재생성
    	}
    	    	      
    	vocSulbiSvc.saveSulbi(dto);
    	
        return JSON_VIEW.getViewId();
    }
    
    //접수 임시저장	
    @RequestMapping(value = "/voc/saveTmpMst/json", method = RequestMethod.POST)
    public String saveTmpMst(HttpServletRequest req, ModelMap model, @RequestBody vocMstDTO dto) {
        
    	if(!"".equals(dto.getVocNo())) {//신규 건이 아닐 경우 update 처리한다.
    		if("Y".equals(dto.getRejectFlag())) {	//반려 후 재접수를 위한 임시저장
    			dto.setDelFlag("T");
    			dto.setVocStatus("VOC11");
    		}else {
    			dto.setDelFlag("T");
    			dto.setVocStatus("VOC01");
    		}    		
    		vocMstSvc.updateTmpMst(dto);
    		vocSulbiSvc.deleteSulbi(dto);
    	}else {
    		vocMstSvc.saveTmpMst(dto);
        	
    	}
    	    
    	vocSulbiSvc.saveSulbi(dto);
    	
        return JSON_VIEW.getViewId();
    }
	
    //VOC 삭제	
    @RequestMapping(value = "/voc/deleteMst/json", method = RequestMethod.POST)
    public String deleteMst(HttpServletRequest req, ModelMap model, @RequestBody vocMstDTO dto) {
        vocMstSvc.deleteMst(dto);
        vocSulbiSvc.deleteSulbi(dto);
        vocPrcSvc.deleteProcess(dto);
        
        return JSON_VIEW.getViewId();
    }
    
    
    //설비 조회
    @RequestMapping(value = "/voc/getSulbiList/json", method = RequestMethod.POST)
    public String getSulbiList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        String newPage = (String)params.get("newSch");
    	if(newPage.equals("Y")) {
    		params.replace("page", "1");
    	}
        
    	model.addAttribute("data", vocSulbiSvc.getSulbiList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //프로젝트 조회
    @RequestMapping(value = "/voc/getPjtList/json", method = RequestMethod.POST)
    public String getPjtList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocMstSvc.getPjtList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //VOC 세부 정보 조회
  	@RequestMapping(value = "/voc/getSchVocSelectOne/json", method = RequestMethod.POST)
  	public String getSchVocSelectOne(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", vocMstSvc.getSchVocSelectOne(params));		
		model.addAttribute("sulbi", vocSulbiSvc.getSchVocSelectSulbiList(params));
		model.addAttribute("process", vocPrcSvc.getSchVocSelectProcessList(params));
		model.addAttribute("processTot", vocPrcSvc.getSchVocSelectProcessTot(params));
		
		params.put("hcode", "REG_TYPE");	
		model.addAttribute("vocRegType", vocMstSvc.getDdList(params));
		
		params.put("hcode", "REJECT");
		model.addAttribute("regRejectReason", vocMstSvc.getDdList(params));
		
		params.put("hcode", "GRADE_TYPE");
		model.addAttribute("vocGradeType", vocMstSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_PLAN");
		model.addAttribute("prcPlanType", vocMstSvc.getDdList(params));
		
		params.put("hcode", "PROCESS_STATUS");
		model.addAttribute("prcStatus", vocMstSvc.getDdList(params));
		
	    return JSON_VIEW.getViewId();
  	}
  	
  	@RequestMapping(value = "/voc/deptJang/json", method = RequestMethod.POST)
    public String deptJang(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
  		model.addAttribute("dept", vocPrcSvc.getDeptJang(params));
  		
  		return JSON_VIEW.getViewId();
  	}
  	
  	//처리부서 저장
    @RequestMapping(value = "/voc/saveProcess/json", method = RequestMethod.POST)
    public String vocProcessSave(HttpServletRequest req, ModelMap model, @RequestBody vocMstDTO dto) {
        
    	vocPrcSvc.deleteProcess(dto);
		
		if(dto.getRegAcceptYn().equals("Y")) { //진행일 경우
			vocPrcSvc.saveProcess(dto);		//처리부서 저장
		}
		
		vocMstSvc.updateProcessMst(dto);	//진행 or 반려 사항 업데이트
		
		dto.setHisStatus("VOC03");
		vocMstSvc.updateHisStatus(dto);
		
        return JSON_VIEW.getViewId();
    }
  	
    //처리부서 조회(ISCM29)
    @RequestMapping(value = "/voc/getDeptList/json", method = RequestMethod.POST)
    public String getDeptList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocMstSvc.getDeptList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //처리 담당자 조회
    @RequestMapping(value = "/voc/getEmpList/json", method = RequestMethod.POST)
    public String getEmpList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocMstSvc.getEmpList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //ECR 조회
    @RequestMapping(value = "/voc/getEcrList/json", method = RequestMethod.POST)
    public String getEcrList(HttpServletRequest req, ModelMap model, @RequestParam Map<String, Object> params) {
        model.addAttribute("data", vocMstSvc.getEcrList(params));
        
        return JSON_VIEW.getViewId();
    }
    
    //처리 담당자 저장
    @RequestMapping(value = "/voc/saveEmpProcess/json", method = RequestMethod.POST)
    public String saveEmpProcess(HttpServletRequest req, ModelMap model, @RequestBody vocMstDTO dto) {
        
		//vocMstSvc.deleteProcess(dto);
    	vocPrcSvc.saveEmpProcess(dto);		//처리부서 저장
    	
        return JSON_VIEW.getViewId();
    }
  	
    //처리현황 정보 저장
    @RequestMapping(value = "/voc/saveProProcess/json", method = RequestMethod.POST)
    public String saveProProcess(HttpServletRequest req, ModelMap model, @RequestBody vocMstDTO dto) {
        
		//vocSvc.deleteProcess(dto);
    	vocPrcSvc.saveProProcess(dto);		//처리상태 저장
		
        return JSON_VIEW.getViewId();
    }
    
    //처리현황 정보 저장
    @RequestMapping(value = "/voc/prcApproval/json", method = RequestMethod.POST)
    public String prcApproval(HttpServletRequest req, ModelMap model, @RequestBody vocApvDTO dto) {
        
		
    	vocPrcSvc.savePrcApproval(dto);		//처리상태 저장
		
        return JSON_VIEW.getViewId();
    }
    
}
