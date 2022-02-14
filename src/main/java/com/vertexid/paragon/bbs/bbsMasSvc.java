package com.vertexid.paragon.bbs;

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
public class bbsMasSvc extends BaseSvc {

	private static final String NAMESPACE =
            "com.vertexid.paragon.bbs.BbsMas";

	@Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

	public String getNewReqNo(bbsMasDTO bbsMasDTO) {
		return cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "maxRegNo"), bbsMasDTO);
	}

	public int insert(bbsMasDTO bbsMasDTO) {
		return cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), bbsMasDTO);
	}

	public int update(bbsMasDTO bbsMasDTO) {
		return cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), bbsMasDTO);

	}
	public int delete(bbsMasDTO bbsMasDTO) {
		return cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "delete"), bbsMasDTO);

	}

	//게시글 저장
	public String saveBbs(Map<String, Object> params) {
		cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), params);
		return null;
	}
	//게시글 수정
	public String updateBbs(Map<String, Object> params) {
		cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), params);
		return null;
	}
	//게시글 삭제
	public String deleteBbs(Map<String, Object> params) {
		cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "delete"), params);
		return null;
	}
	//게시글 상세보기
	public ParamMap<String,Object> getbbsMasView(Map<String, Object> params) {
		return cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "selectOne"), params);
	}
	//게시글 리스트 조회
	public List<ParamMap<String,Object>> getList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "list"), params);

	}


}
