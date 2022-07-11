package com.vertexid.laboratory.mi;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vertexid.commons.utils.ParamMap;
import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.base.CmmDAO;

@Service
@Transactional
public class labMiSvc extends BaseCtrl{
	private static final String LAB_MI = "com.vertexid.laboratory.mi.miSql";
	
	@Resource(name="cmmDAO")
	private CmmDAO cmmDAO;
	
	//계측기예약 > 메인 종합 표
	public List<ParamMap<String, Object>> getMainList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "requestList"), params);		
	} 
	
	//계측기예약 > 메인 공지
	public List<ParamMap<String, Object>> getNoticeList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "noticeList"), params);		
	} 
	
	//계측기예약 > 의뢰현황 리스트
	public List<ParamMap<String, Object>> getRequestList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "requestStatusList"), params);		
	} 
	
	//계측기예약 > 계측기 리스트
	public List<ParamMap<String, Object>> getMiKeyList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "miKeyList"), params);		
	} 
	
	//계측기예약 > 의뢰항목 리스트
	public List<ParamMap<String, Object>> getItemList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "itemList"), params);		
	} 
	
	//계측기예약 > point 리스트
	public List<ParamMap<String, Object>> getPointList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "pointList"), params);		
	} 
	
	//계측기예약 > 상태 리스트
	public List<ParamMap<String, Object>> getStatusList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "statusList"), params);		
	} 
	
	//계측기예약 > 의뢰현황 > 상세보기
	public List<ParamMap<String, Object>> getViewDetail(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "miRqViewList"), params);		
	} 
	
	//계측기예약 > 의뢰현황 > 상세보기 > 선택 계측기 리스트
	public List<ParamMap<String, Object>> getSlotList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "slotList"), params);		
	} 

	//계측기예약 > 예외현황 리스트
	public List<ParamMap<String, Object>> getExRequestList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "exRequestStatusList"), params);		
	} 
	
	//계측기예약 > 예외현황 > 상세보기
	public List<ParamMap<String, Object>> getExViewDetail(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "exMiRqViewList"), params);		
	} 
	
	//계측기예약 insert
	public void mirqInsert(Map<String, Object> params) {
		LocalDate now = LocalDate.now();
		int rows;
		String miRqKey;
//		rows = cmmDAO.getOne(cmmDAO.getStmtByNS(LAB_MI, "mirqGetRows"), null);
		
		//miRqKey = "MI-" + now.getYear() + "-" + String.format("%07d",rows);
		
		//params.put("miRqKey", miRqKey);
		
		ObjectMapper objectMapper = new ObjectMapper();
		List slotList = new ArrayList();
		String slot = (String) params.get("slot");
		slot = slot.replace("\\", "");
		try {
			slotList = objectMapper.readValue(slot, List.class);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//계측의뢰 insert
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "mirqInsert"), params);
		
		//miRqKey = params.get("MI_RQ_KEY").toString();
		//params.put("miRqKey", miRqKey);
		
		//선택 slot insert
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "mirqSlotLogInsert"), params);
		
		for(int i=0; i<slotList.size(); i++) {
			String val = slotList.get(i).toString();
			
			if(val.equals("1")) {
				int miSlot = 25;
				params.put("miSlot", miSlot-i);
				cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "mirqSlotInsert"), params);
			}
		}
	}

	//계측기 > 의뢰반려
	public void miRqReject(Map<String, Object> params) {
		
		String status = params.get("status").toString();
		
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqReject"), params);
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "miRqRejectReason"), params);
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "miRqRejectLog"), params);
		
		if(status.equals("4")) {	//실물접수 인 상태에서 반려 시
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqRejectSubun"), params);
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqRejectSubun2"), params);
		}
	}

	//계측기 > 실물접수
	public void miRqReceipt(Map<String, Object> params) {
		
		String miRqG = params.get("miRqG").toString();
		
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqReceipt"), params);
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "miRqReceiptLog"), params);
		
		if(miRqG.equals("Wet Station/WER")) {
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqReceiptSubun1"), params);
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqReceiptSubun2"), params);
		} else {
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqReceiptSubun3"), params);
		}
	}	
	
	//계측기예약 > 순서번경 > 순번 가져오기
	public List<ParamMap<String, Object>> getSubunList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(LAB_MI, "subunList"), params);		
	} 

	//계측기 > 순서번경
	public void miRqChagne(Map<String, Object> params) {
		
		int nowSubun = Integer.parseInt(params.get("nowSubun").toString());
		int miRqSubun = Integer.parseInt(params.get("miRqSubun").toString());
		
		if(nowSubun > miRqSubun) {	// 현재번호가 변경번호보다 클 경우
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqSubunChange1"), params);
		} else {
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqSubunChange2"), params);
		}
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqSubunChange3"), params);

	}

	//계측기 > 계측시작
	public void miRqStrat(Map<String, Object> params) {
		
		String status = params.get("status").toString();
		
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqStrat"), params);
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "miRqInsertLog"), params);
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "startUpdateSubun"), params);
		
		if(!status.equals("6")) { // 이전상태가 홀드 상태가 아닐 경우
			cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqStratH"), params);
		}
	}

	//계측기 > hlod
	public void miRqHold(Map<String, Object> params) {
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqHold"), params);
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "miRqHoldReason"), params);
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "miRqHoldLog"), params);
	}
	
	//계측기 > 계측종료
	public void miRqEnd(Map<String, Object> params) {
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqEnd"), params);
		cmmDAO.insert(cmmDAO.getStmtByNS(LAB_MI, "miRqEndRog"), params);
	}
	
	//계측기 > 의뢰취소
	public void miRqCancle(Map<String, Object> params) {
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqCancle"), params);
	}
	
	//계측기 > 삭제
	public void miRqDelete(Map<String, Object> params) {
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqDelete1"), params);
		cmmDAO.update(cmmDAO.getStmtByNS(LAB_MI, "miRqDelete2"), params);
	}
	
}
