package com.vertexid.voc.mst;

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
import com.vertexid.voc.sulbi.vocSulbiVo;

@Service
@Transactional
public class vocMstSvc extends BaseSvc {
	
	private static final String VOC_MST = "com.vertexid.voc.vocProcess.VocMst";
	
	private static final String VOC_SULBI = "com.vertexid.voc.vocProcess.VocSulbi";
	
	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;
	
	//전체 VOC 리스트 조회
	public List<ParamMap<String, Object>> getVocList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_MST, "getVocList"), params);		
	}
	
	//기준정보 조회
	public List<ParamMap<String, Object>> getDdList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_MST, "getDdList"), params);		
	}
	
	//고객 정보
	public List<ParamMap<String, Object>> getCustList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_MST, "getCustList"), params);		
	}
	
	//접수 완료
	public void saveMst(vocMstDTO dto) {
		
		//VOC 번호 생성
    	String vocNo = this.getVocNo(); 
    	dto.setVocNo(vocNo);
    	
		cmmDAO.insert(cmmDAO.getStmtByNS(VOC_MST, "saveVocMst"), dto);
		
		String extYn = this.vocHisExistYn(dto);
		if(extYn != null && !extYn.equals("")) {
			dto.setHisStatus("VOC02");
			this.updateHisStatus(dto);
		}else {
			this.saveHisStatus(dto);
		}
		
	}
	
	//신규 건을 바로 임시저장 경우
	public void saveTmpMst(vocMstDTO dto) {
		
		//VOC 번호 생성
    	String vocNo = this.getVocNo(); 
    	dto.setVocNo(vocNo);
    	
		cmmDAO.insert(cmmDAO.getStmtByNS(VOC_MST, "saveTmpMst"), dto);		
	}
		
	//신규 건이 아닐 경우 임시저장 업데이트
	public void updateTmpMst(vocMstDTO dto) {
		cmmDAO.update(cmmDAO.getStmtByNS(VOC_MST, "updateTmpMst"), dto);
		
		String extYn = this.vocHisExistYn(dto);
		if(extYn != null && !extYn.equals("")) {
			dto.setHisStatus("VOC02");
			this.updateHisStatus(dto);
		}else {
			this.saveHisStatus(dto);
		}
	}

	//VOC 번호 생성
	public String getVocNo() {
		String vocNo = ""; 
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMM");
		String yymm = now.format(formatter);//일자포맷변경
		
		String vocSeq = cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_MST, "getVocNo"), null);
		
		if(vocSeq == null) {
			vocNo = "VOC"+ yymm + "-0001";
		}else {
			int reVal = Integer.parseInt(vocSeq);
			vocSeq = String.format("%04d", reVal);
			vocNo = "VOC"+ yymm + "-" + vocSeq;
		}
		
		return vocNo;
	}
	
	//저장한 이력이 있는 확인
	public String vocHisExistYn(vocMstDTO dto) {
		String extYn = "";
		extYn = cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_MST, "vocHisExistYn"), dto);
		
		return extYn;
	}
	
	//history에 저장 (최초 접수는 insert)
	public void saveHisStatus(vocMstDTO dto) {
		cmmDAO.insert(cmmDAO.getStmtByNS(VOC_MST, "saveHisStatus"), dto);
	}
	
	//history에 저장 (update)
	public void updateHisStatus(vocMstDTO dto) {
		cmmDAO.update(cmmDAO.getStmtByNS(VOC_MST, "updateHisStatus"), dto);
	}
	
	//설비 정보 저장
	public String saveSulbi(vocMstDTO dto) {
		
		int cnt = dto.getSulbiList().size();
		for(int i = 0; i < cnt; i++) {			
			vocSulbiVo sDto = new vocSulbiVo();
			
			sDto.setVocNo(dto.getVocNo());
			sDto.setSeq(i);
			sDto.setLine(dto.getSulbiList().get(i).getLine().toString());
			sDto.setProduct(dto.getSulbiList().get(i).getProduct().toString());
			sDto.setProcess(dto.getSulbiList().get(i).getProcess().toString());
			
			String pjtNo = dto.getSulbiList().get(i).getVocPjtNo(); 
			if(pjtNo != null) {
				sDto.setVocPjtNo(pjtNo);
			}
			
			cmmDAO.insert(cmmDAO.getStmtByNS(VOC_SULBI, "saveVocSulbi"), sDto);
		}
		
		return null;
	}
	
	//프로젝트 정보
	public List<ParamMap<String, Object>> getPjtList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_MST, "getPjtList"), params);		
	}
		
	//VOC 삭제
	public void deleteMst(vocMstDTO dto) {
		cmmDAO.delete(cmmDAO.getStmtByNS(VOC_MST, "deleteMst"), dto);		
	}
	
	//상세조회 시 VOC 정보 조회
	public ParamMap<String,Object> getSchVocSelectOne(Map<String, Object> params) {
		return cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_MST, "getSchVocSelectOne"), params);
	}
	
	//진행 or 반려 사항 업데이트
	public void updateProcessMst(vocMstDTO dto) {
		dto.setRegDecideUser(dto.getLoginUserId());
		cmmDAO.update(cmmDAO.getStmtByNS(VOC_MST, "updateProcessMst"), dto);
		
		//접수 수락일 경우 VOC03으로 변경.
		if(dto.getRegAcceptYn().equals("Y")) {
			dto.setVocStatus("VOC03");
		}else {	//접수 반려일 경우 VOC11로 변경
			dto.setVocStatus("VOC11");
		}
		
		cmmDAO.update(cmmDAO.getStmtByNS(VOC_MST, "updateProcessStatus"), dto);
	}
	
	//처리부서 정보
	public List<ParamMap<String, Object>> getDeptList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_MST, "getDeptList"), params);		
	}
	
	//ECR 정보
	public List<ParamMap<String, Object>> getEcrList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_MST, "getEcrList"), params);		
	}
		
	//처리 담당자 정보
	public List<ParamMap<String, Object>> getEmpList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_MST, "getEmpList"), params);		
	}
	
}
