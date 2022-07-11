package com.vertexid.voc;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.commons.utils.ParamMap;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;

@Service
@Transactional
public class vocProcessSvc extends BaseSvc {
	
	private static final String NAMESPACE = "com.vertexid.voc.vocProcess.Voc";
	
	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;
	
	public List<ParamMap<String, Object>> getList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getList"), params);		
	}
	

	/*
	 * 
	
	public ParamMap<String,Object> getSchVocSelectOne(Map<String, Object> params) {
		return cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "getSchVocSelectOne"), params);
	}
	
	public List<ParamMap<String,Object>> getSchVocSelectSulbiList(Map<String, Object> params) {
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getSchVocSelectSulbiList"), params);
	}
	
	public List<ParamMap<String,Object>> getSchVocSelectProcessList(Map<String, Object> params) {
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getSchVocSelectProcessList"), params);
	}
	
	//구분 기준정보 조회
	public List<ParamMap<String, Object>> getDdList(Map<String, Object> params){
		//return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getDdList"), params);		
		return null;
	}
		
	//Master 정보 저장
	public String saveMst(vocProcessDTO dto) {
		
		//VOC 번호 생성
    	String vocNo = this.getVocNo(); 
    	dto.setVocNo(vocNo);
    	
		cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "saveVocMst"), dto);
		return null;
	}
	
	//Master 정보 저장
	public String saveTmpMst(vocProcessDTO dto) {
		
		//VOC 번호 생성
    	String vocNo = this.getVocNo(); 
    	dto.setVocNo(vocNo);
    	
		cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "saveTmpMst"), dto);
		return null;
	}
	
	//Master 정보 임시저장 업데이트
	public void updateTmpMst(vocProcessDTO dto) {
		cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateTmpMst"), dto);
	}
	
	//설비 정보 저장
	public String saveSulbi(vocProcessDTO dto) {
		vocSulbiVo sDto = new vocSulbiVo();
		
		sDto.setCreUser(dto.getCreUser());
		
		int cnt = dto.getSulbiList().size();
		for(int i = 0; i < cnt; i++) {			
			
			sDto.setVocNo(dto.getVocNo());
			sDto.setSeq(i);
			sDto.setLine(dto.getSulbiList().get(i).getLine().toString());
			sDto.setProd(dto.getSulbiList().get(i).getProd().toString());
			sDto.setProcess(dto.getSulbiList().get(i).getProcess().toString());
			
			String pjtNo = dto.getSulbiList().get(i).getVocPjtNo(); 
			if(pjtNo != null) {
				sDto.setVocPjtNo(pjtNo);
			}
			
			cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "saveVocSulbi"), sDto);
		}
		
		return null;
	}
	
	public void deleteMst(vocProcessDTO dto) {
		cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteMst"), dto);		
	}
	
	public void deleteSulbi(vocProcessDTO dto) {
		cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteSulbi"), dto);		
	}
	
	public String getVocNo() {
		String vocNo = ""; 
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMM");
		String yymm = now.format(formatter);//일자포맷변경
		
		String vocSeq = cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "getVocNo"), null);
		
		if(vocSeq == null) {
			vocNo = "VOC"+ yymm + "-0001";
		}else {
			int reVal = Integer.parseInt(vocSeq);
			vocSeq = String.format("%04d", reVal);
			vocNo = "VOC"+ yymm + "-" + vocSeq;
		}
		
		
		return vocNo;
	}
	
	//고객 정보
	public List<ParamMap<String, Object>> getCustList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getCustList"), params);		
	}
	
	//처리부서 정보
	public List<ParamMap<String, Object>> getDeptList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getDeptList"), params);		
	}
		
	//설비 정보
	public List<ParamMap<String, Object>> getSulbiList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getSulbiList"), params);		
	}
	
	//프로젝트 정보
	public List<ParamMap<String, Object>> getPjtList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getPjtList"), params);		
	}
	
	//ECR 정보
	public List<ParamMap<String, Object>> getEcrList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getEcrList"), params);		
	}
		
	//담당자 정보
	public List<ParamMap<String, Object>> getEmpList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "getEmpList"), params);		
	}
	
	//진행 or 반려 사항 업데이트
	public void updateProcessMst(vocProcessDTO dto) {
		dto.setRegIngUser(dto.getLoginUserId());
		cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateProcessMst"), dto);
		
		//접수 수락일 경우 VOC03으로 변경.
		if(dto.getRegIngYn().equals("Y")) {
			dto.setVocStatus("VOC03");
		}else {	//접수 반려일 경우 VOC11로 변경
			dto.setVocStatus("VOC11");
		}
		
		cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateProcessStatus"), dto);
	}
	
	//처리현황 정보 저장
	public String saveProcess(vocProcessDTO dto) {
		vocProcessVo pDto = new vocProcessVo();
		
		pDto.setCreUser(dto.getLoginUserId());
		
		int cnt = dto.getProcessList().size();
		for(int i = 0; i < cnt; i++) {
			
			pDto.setVocNo(dto.getVocNo());
			pDto.setSeq(i);
			pDto.setDept(dto.getProcessList().get(i).getDept().toString());
			pDto.setDeptNm(dto.getProcessList().get(i).getDeptNm().toString());
			pDto.setReqContents(dto.getProcessList().get(i).getReqContents());
			
			if("VOC03".equals(dto.getVocStatus())) {
				pDto.setProcessUserId(dto.getProcessList().get(i).getProcessUserId().toString());
				pDto.setProcessUserNm(dto.getProcessList().get(i).getProcessUserNm().toString());
				pDto.setProcessPlan(dto.getProcessList().get(i).getProcessPlan().toString());
				pDto.setProcessPlanDate(dto.getProcessList().get(i).getProcessPlanDate().toString());
				pDto.setProcessStatus(dto.getProcessList().get(i).getProcessStatus().toString());
				pDto.setEcrNo(dto.getProcessList().get(i).getEcrNo().toString());
				pDto.setAtchFileId(dto.getProcessList().get(i).getAtchFileId().toString());	
				
				//대책수립완료일 경우 처리 테이블 내 PROCESS_COMP_YN 업데이트 처리
				if(pDto.getProcessStatus().equals("103")) {
					pDto.setProcessCompYn("Y");
					cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateProcessCompYn"), pDto);
				}
			}
			
			cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "saveVocProcess"), pDto);			
		}
		
		
		return null;
	}
	
	public void deleteProcess(vocProcessDTO dto) {
		cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteProcess"), dto);		
	}
	
	//처리담당자 정보 저장
	public String saveEmpProcess(vocProcessDTO dto) {
		int cnt = dto.getProcessList().size();
		for(int i = 0; i < cnt; i++) {
			vocProcessVo pDto = new vocProcessVo();
			
			pDto.setCreUser(dto.getLoginUserId());
			pDto.setVocNo(dto.getVocNo());
			pDto.setSeq(i);
			pDto.setDept(dto.getProcessList().get(i).getDept().toString());
			
			String userId = dto.getProcessList().get(i).getProcessUserId().toString();
			if(userId != null && !userId.equals("")) {
				pDto.setProcessUserId(dto.getProcessList().get(i).getProcessUserId().toString());
				pDto.setProcessUserNm(dto.getProcessList().get(i).getProcessUserNm().toString());
			}
			
			cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "saveEmpProcess"), pDto);			
		}
		
		//처리 담당자가 모두 확정되었는지 체크
		String prcessCmpYn = cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "getPrcessCmpYn"), dto);
		if("Y".equals(prcessCmpYn)) {
			dto.setVocStatus("VOC04");		
			cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateProcessStatus"), dto);
		}
		
		return null;
	}
	
	//처리현황 정보 저장
	public String saveProProcess(vocProcessDTO dto) {
		vocProcessVo pDto = new vocProcessVo();
		
		pDto.setCreUser(dto.getLoginUserId());
		
		int cnt = dto.getProcessList().size();
		for(int i = 0; i < cnt; i++) {
			String proEditYn = dto.getProcessList().get(i).getProcessPlan().toString();
			if(proEditYn != null && !proEditYn.equals("")) {
				pDto.setVocNo(dto.getVocNo());
				pDto.setSeq(i);
				pDto.setDept(dto.getProcessList().get(i).getDept().toString());
				pDto.setProcessPlan(dto.getProcessList().get(i).getProcessPlan().toString());
				pDto.setProcessPlanDate(dto.getProcessList().get(i).getProcessPlanDate().toString());
				pDto.setProcessStatus(dto.getProcessList().get(i).getProcessStatus().toString());
				
				String ecrNo = dto.getProcessList().get(i).getEcrNo().toString();
				if(ecrNo != null && !ecrNo.equals("")) {
					pDto.setEcrNo(ecrNo);
				}
				
				String processContents = dto.getProcessList().get(i).getProcessContents().toString();
				if(processContents != null && !processContents.equals("")) {
					pDto.setProcessContents(processContents);
				}
				
				String atchFileId = dto.getProcessList().get(i).getAtchFileId().toString();
				if(atchFileId != null && !atchFileId.equals("")) {
					pDto.setAtchFileId(atchFileId);	
				}
				
				cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "saveProProcess"), pDto);
				//cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "saveProStatusDtl"), pDto);
			}
		}
		
		
		return null;
	}
	
	*/
}
