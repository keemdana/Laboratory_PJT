package com.vertexid.voc.prc;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.commons.utils.ParamMap;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import com.vertexid.voc.mst.vocApvDTO;
import com.vertexid.voc.mst.vocMstDTO;
import com.vertexid.voc.mst.vocMstSvc;

@Service
@Transactional
public class vocPrcSvc extends BaseSvc {
	
	private static final String VOC_PROCESS = "com.vertexid.voc.vocProcess.VocProcess";
	
	private static final String VOC_MST = "com.vertexid.voc.vocProcess.VocMst";
	
	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;
	
	@Resource
	vocMstSvc vocMstSvc;	//VOC 마스터 정보
	
	//처리현황 삭제
	public void deleteProcess(vocMstDTO dto) {
		cmmDAO.delete(cmmDAO.getStmtByNS(VOC_PROCESS, "deleteProcess"), dto);		
	}
	
	//상세 정보 조회 시 처리현황 조회
	public List<ParamMap<String,Object>> getSchVocSelectProcessList(Map<String, Object> params) {
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_PROCESS, "getSchVocSelectProcessList"), params);
	}
	
	//상세 정보 조회 시 처리현황 SUM 조회
	public ParamMap<String,Object> getSchVocSelectProcessTot(Map<String, Object> params) {
		return cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_PROCESS, "getSchVocSelectProcessTot"), params);
	}
	
	//상세 정보 조회 시 처리현황 SUM 조회
	public ParamMap<String,Object> getDeptJang(Map<String, Object> params) {
		return cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_PROCESS, "getDeptJang"), params);
	}
	
	//처리현황 정보 저장
	public void saveProcess(vocMstDTO dto) {
		
		int cnt = dto.getProcessList().size();
		for(int i = 0; i < cnt; i++) {
			vocPrcVo pDto = new vocPrcVo();
			
			pDto.setCreateUser(dto.getLoginUserId());
			pDto.setVocNo(dto.getVocNo());
			pDto.setSeq(i);
			pDto.setDeptCd(dto.getProcessList().get(i).getDeptCd().toString());
			pDto.setDeptNm(dto.getProcessList().get(i).getDeptNm().toString());
			pDto.setDeptReqContents(dto.getProcessList().get(i).getDeptReqContents());
			
			if("VOC03".equals(dto.getVocStatus())) {
				pDto.setPrcUserId(dto.getProcessList().get(i).getPrcUserId().toString());
				pDto.setPrcUserNm(dto.getProcessList().get(i).getPrcUserNm().toString());
				pDto.setPrcPlanType(dto.getProcessList().get(i).getPrcPlanType().toString());
				pDto.setPrcPlanDate(dto.getProcessList().get(i).getPrcPlanDate().toString());
				pDto.setPrcStatus(dto.getProcessList().get(i).getPrcStatus().toString());
				pDto.setEcrNo(dto.getProcessList().get(i).getEcrNo().toString());
				pDto.setAtchFileId(dto.getProcessList().get(i).getAtchFileId().toString());	
				
				//대책수립완료일 경우 처리 테이블 내 PROCESS_COMP_YN 업데이트 처리
				/*
				if(pDto.getPrcStatus().equals("103")) {
					pDto.setPrcCompYn("Y");
					cmmDAO.update(cmmDAO.getStmtByNS(VOC_PROCESS, "updateProcessCompYn"), pDto);
				}
				*/
			}
			
			cmmDAO.insert(cmmDAO.getStmtByNS(VOC_PROCESS, "saveVocProcess"), pDto);			
		}
	}
	
	//처리담당자 정보 저장
	public void saveEmpProcess(vocMstDTO dto) {
		int cnt = dto.getProcessList().size();
		for(int i = 0; i < cnt; i++) {
			vocPrcVo pDto = new vocPrcVo();
			
			pDto.setCreateUser(dto.getLoginUserId());
			pDto.setVocNo(dto.getVocNo());
			pDto.setSeq(i);
			pDto.setDeptCd(dto.getProcessList().get(i).getDeptCd().toString());
			
			String userId = dto.getProcessList().get(i).getPrcUserId().toString();
			if(userId != null && !userId.equals("")) {
				pDto.setPrcUserId(dto.getProcessList().get(i).getPrcUserId().toString());
				pDto.setPrcUserNm(dto.getProcessList().get(i).getPrcUserNm().toString());
			}
			
			cmmDAO.update(cmmDAO.getStmtByNS(VOC_PROCESS, "saveEmpProcess"), pDto);			
		}
		
		//처리 담당자가 모두 확정되었는지 체크
		String prcessCmpYn = cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_PROCESS, "getPrcessCmpYn"), dto);
		if("Y".equals(prcessCmpYn)) {
			dto.setVocStatus("VOC04");		
			cmmDAO.update(cmmDAO.getStmtByNS(VOC_MST, "updateProcessStatus"), dto);
			
			dto.setHisStatus("VOC04");
	    	vocMstSvc.updateHisStatus(dto);
			
		}	
	}
		
	//처리현황 정보 저장
	public void saveProProcess(vocMstDTO dto) {
		
		vocPrcVo pDto = new vocPrcVo();
		
		int seq = dto.getProcessList().get(0).getSeq();
		
		pDto.setCreateUser(dto.getLoginUserId());
		pDto.setVocNo(dto.getVocNo());
		pDto.setSeq(seq);
		pDto.setDeptCd(dto.getProcessList().get(seq).getDeptCd().toString());
		pDto.setPrcPlanType(dto.getProcessList().get(seq).getPrcPlanType().toString());
		pDto.setPrcPlanDate(dto.getProcessList().get(seq).getPrcPlanDate().toString());
		pDto.setPrcStatus(dto.getProcessList().get(seq).getPrcStatus().toString());
		
		String ecrNo = dto.getProcessList().get(seq).getEcrNo().toString();
		if(ecrNo != null && !ecrNo.equals("")) {
			pDto.setEcrNo(ecrNo);
			
			//선택한 ECR 건 진행상태 조회(상태 업데이트는 batch로 하루에 한번 진행 예정)
			String ecrStatus = cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_PROCESS, "getEcrStatus"), pDto);
			pDto.setEcrStatus(ecrStatus);
		}
		
		String processContents = dto.getProcessList().get(seq).getPrcContents().toString();
		if(processContents != null && !processContents.equals("")) {
			pDto.setPrcContents(processContents);
		}
		
		String atchFileId = dto.getProcessList().get(seq).getAtchFileId().toString();
		if(atchFileId != null && !atchFileId.equals("")) {
			pDto.setAtchFileId(atchFileId);	
		}
		
		cmmDAO.update(cmmDAO.getStmtByNS(VOC_PROCESS, "saveProProcess"), pDto);
		
		//각 단계별 완료 시 HISTORY 테이블에 별도로 저장한다.
		//업데이트 되는 최신값을 가져간다.
		String prcStatus = dto.getProcessList().get(seq).getPrcStatus();
		if(prcStatus.equals("100")) {
			dto.setHisStatus("VOC05");
			vocMstSvc.updateHisStatus(dto);
		}else if(prcStatus.equals("101")) {
			dto.setHisStatus("VOC06");
			vocMstSvc.updateHisStatus(dto);
		}
		
		//디스플레이 경우 대책완료를 선택할 수 있음.
		if("DP".equals(dto.getBssArea())) {
			if(prcStatus.equals("103")) {
				dto.setHisStatus("VOC08");
				vocMstSvc.updateHisStatus(dto);
			}
		}
		
		
		/*int cnt = dto.getProcessList().size();
		for(int i = 0; i < cnt; i++) {
			vocPrcVo pDto = new vocPrcVo();
			
			String proEditYn = dto.getProcessList().get(i).getPrcPlanType().toString();
			if(proEditYn != null && !proEditYn.equals("")) {
				pDto.setCreateUser(dto.getLoginUserId());
				pDto.setVocNo(dto.getVocNo());
				pDto.setSeq(i);
				pDto.setDeptCd(dto.getProcessList().get(i).getDeptCd().toString());
				pDto.setPrcPlanType(dto.getProcessList().get(i).getPrcPlanType().toString());
				pDto.setPrcPlanDate(dto.getProcessList().get(i).getPrcPlanDate().toString());
				pDto.setPrcStatus(dto.getProcessList().get(i).getPrcStatus().toString());
				
				String ecrNo = dto.getProcessList().get(i).getEcrNo().toString();
				if(ecrNo != null && !ecrNo.equals("")) {
					pDto.setEcrNo(ecrNo);
					
					//선택한 ECR 건 진행상태 조회(상태 업데이트는 batch로 하루에 한번 진행 예정)
					String ecrStatus = cmmDAO.getOne(cmmDAO.getStmtByNS(VOC_PROCESS, "getEcrStatus"), pDto);
					pDto.setEcrStatus(ecrStatus);
				}
				
				String processContents = dto.getProcessList().get(i).getPrcContents().toString();
				if(processContents != null && !processContents.equals("")) {
					pDto.setPrcContents(processContents);
				}
				
				String atchFileId = dto.getProcessList().get(i).getAtchFileId().toString();
				if(atchFileId != null && !atchFileId.equals("")) {
					pDto.setAtchFileId(atchFileId);	
				}
				
				cmmDAO.update(cmmDAO.getStmtByNS(VOC_PROCESS, "saveProProcess"), pDto);
				
				String prcStatus = dto.getProcessList().get(i).getPrcStatus();
				if(prcStatus.equals("100")) {
					dto.setHisStatus("VOC05");
					vocMstSvc.updateHisStatus(dto);
				}else if(prcStatus.equals("101")) {
					dto.setHisStatus("VOC06");
					vocMstSvc.updateHisStatus(dto);
				}
				
				
			}
		}*/
		
	}
	
	//처리현황 결재상신
	public void savePrcApproval(vocApvDTO dto) {
		
		//그룹웨어 결재 저장
		cmmDAO.insert(cmmDAO.getStmtByNS(VOC_PROCESS, "savePrcApproval"), dto);
		
		//처리현황 GW_KEY 업데이트
		vocPrcVo pDto = new vocPrcVo();
		pDto.setVocNo(dto.getVocNo());
		pDto.setSeq(dto.getPrcSeq());
		pDto.setDeptCd(dto.getDeptCd());
		pDto.setGwKey(dto.getSysKey());
		cmmDAO.update(cmmDAO.getStmtByNS(VOC_PROCESS, "updateGwKeyProcess"), dto);
		
	}
}
