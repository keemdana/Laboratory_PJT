package com.vertexid.laboratory.mi;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import static com.vertexid.commons.view.ViewType.JSON_VIEW;

import com.vertexid.viself.base.BaseCtrl;

@Controller
public class labMiCtr extends BaseCtrl{
	
	@Resource
	labMiSvc labMiSvc;
	
	//계측기예약 > 메인 종합 표
	@RequestMapping(value="/mi/requestList/json", method=RequestMethod.POST)
	public String getMainList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getMainList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 메인 공지
	@RequestMapping(value="/mi/noticeList/json", method=RequestMethod.POST)
	public String getNoticeList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getNoticeList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 의뢰현황 리스트
	@RequestMapping(value="/mi/requestStatusList/json", method=RequestMethod.POST)
	public String getRequestList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getRequestList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 의뢰현황 > 계측기 리스트 (select box)
	@RequestMapping(value="/mi/miKeyList/json", method=RequestMethod.POST)
	public String getMiKeyList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getMiKeyList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 의뢰현황 > 상태 리스트 (select box)
	@RequestMapping(value="/mi/statusList/json", method=RequestMethod.POST)
	public String getStatusList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getStatusList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 의뢰현황 > 상세보기
	@RequestMapping(value="/mi/miRqViewList/json", method=RequestMethod.POST)
	public String getViewDetail(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getViewDetail(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 의뢰현황 > 상세보기 > 선택 계측기 리스트
	@RequestMapping(value="/mi/slotList/json", method=RequestMethod.POST)
	public String getSlotList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getSlotList(params));
		return JSON_VIEW.getViewId();
	}
	

	//계측기예약 > 예외현황 리스트
	@RequestMapping(value="/mi/exRequestStatusList/json", method=RequestMethod.POST)
	public String getExRequestList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getExRequestList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 예외현황 > 상세보기
	@RequestMapping(value="/mi/exMiRqViewList/json", method=RequestMethod.POST)
	public String getExViewDetail(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getExViewDetail(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 계측의뢰 > 의뢰항목 리스트
	@RequestMapping(value="/mi/itemList/json", method=RequestMethod.POST)
	public String getItemList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getItemList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기예약 > 계측의뢰 > 포인트 리스트
	@RequestMapping(value="/mi/pointList/json", method=RequestMethod.POST)
	public String getPointList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getPointList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기 예약 insert
	@RequestMapping(value="/mi/insert/json", method=RequestMethod.POST)
	public String mirqInsert(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.mirqInsert(params);
		return JSON_VIEW.getViewId();
	}
	
	//계측기 > 의뢰반려
	@RequestMapping(value="/mi/miRqReject/json", method=RequestMethod.POST)
	public String miRqReject(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqReject(params);
		return JSON_VIEW.getViewId();
	}
	
	//계측기 > 실물접수
	@RequestMapping(value="/mi/miRqReceipt/json", method=RequestMethod.POST)
	public String miRqReceipt(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqReceipt(params);
		return JSON_VIEW.getViewId();
	}	
	
	//계측기예약 > 순서번경 > 순번 가져오기
	@RequestMapping(value="/mi/subunList/json", method=RequestMethod.POST)
	public String getSubunList(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {		
		model.addAttribute("data", labMiSvc.getSubunList(params));
		return JSON_VIEW.getViewId();
	}
	
	//계측기 > 실순서변경
	@RequestMapping(value="/mi/miRqChagne/json", method=RequestMethod.POST)
	public String miRqChagne(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqChagne(params);
		return JSON_VIEW.getViewId();
	}	
	
	//계측기 > 계측시작
	@RequestMapping(value="/mi/miRqStrat/json", method=RequestMethod.POST)
	public String miRqStrat(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqStrat(params);
		return JSON_VIEW.getViewId();
	}
	
	//계측기 > hlod
	@RequestMapping(value="/mi/miRqHold/json", method=RequestMethod.POST)
	public String miRqHold(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqHold(params);
		return JSON_VIEW.getViewId();
	}
	
	//계측기 > 계측종료
	@RequestMapping(value="/mi/miRqEnd/json", method=RequestMethod.POST)
	public String miRqEnd(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqEnd(params);
		return JSON_VIEW.getViewId();
	}
	
	//계측기 > 의뢰취소
	@RequestMapping(value="/mi/miRqCancle/json", method=RequestMethod.POST)
	public String miRqCancle(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqCancle(params);
		return JSON_VIEW.getViewId();
	}
	
	//계측기 > 삭제
	@RequestMapping(value="/mi/miRqDelete/json", method=RequestMethod.POST)
	public String miRqDelete(ModelMap model, HttpServletRequest req, @RequestParam Map<String, Object> params) throws Exception {
		labMiSvc.miRqDelete(params);
		return JSON_VIEW.getViewId();
	}

}
