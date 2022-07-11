package com.vertexid.voc.sulbi;

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
import com.vertexid.voc.mst.vocMstDTO;

@Service
@Transactional
public class vocSulbiSvc extends BaseSvc {
	
	private static final String VOC_SULBI = "com.vertexid.voc.vocProcess.VocSulbi";
	
	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;
	
	//설비 정보
	public List<ParamMap<String, Object>> getSulbiList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_SULBI, "getSulbiList"), params);		
	}
		
	//설비 정보 삭제
	public void deleteSulbi(vocMstDTO dto) {
		cmmDAO.delete(cmmDAO.getStmtByNS(VOC_SULBI, "deleteSulbi"), dto);		
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
	
	//상세조회 시 설비 리스트 조회
	public List<ParamMap<String,Object>> getSchVocSelectSulbiList(Map<String, Object> params) {
		return cmmDAO.getList(cmmDAO.getStmtByNS(VOC_SULBI, "getSchVocSelectSulbiList"), params);
	}
}
