package com.vertexid.paragon.def.defstumng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;

@Service
@Transactional
public class DefStuMngSvc extends BaseSvc{

	private static final String MAS_NAMESPACE =
            "com.vertexid.paragon.def.defstumng.DefStuMng";
	private static final String PARTI_NAMESPACE =
			"com.vertexid.paragon.def.defstumng.DefStuParti";
	private static final String GROUP_NAMESPACE =
			"com.vertexid.paragon.def.defstumng.DefStuGroup";
	private static final String MAIL_NAMESPACE =
			"com.vertexid.paragon.def.defstumail.DefStuMail";

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

	public String save(DefStuMngDTO params) {
		String result = "";

		String stuCd = (String)params.getStuCd();
		if(StringUtil.isNotBlank(stuCd)) {
			Map<String, Object> masMap = new HashMap<String, Object>();
			masMap.put("stuCd", params.getStuCd());
			//마스터 조회-------------------------------------------------------
			ParamMap< String, Object> resultMap =  cmmDAO.getOne(cmmDAO.getStmtByNS(MAS_NAMESPACE, "listOne"), masMap);

			//선 삭제 처리 조회-------------------------------------------------------
			if(resultMap != null && !resultMap.isEmpty()) {
				//--연결 상태그룹 선삭제
				cmmDAO.delete(cmmDAO.getStmtByNS(GROUP_NAMESPACE, "delete"), masMap);
				//--연결 파티클 선삭제
				cmmDAO.delete(cmmDAO.getStmtByNS(PARTI_NAMESPACE, "delete"), masMap);
				//-- 마스터 선 삭제후 재등록
				cmmDAO.delete(cmmDAO.getStmtByNS(MAS_NAMESPACE, "delete"), masMap);
			}

			//마스터입력 처리-------------------------------------------------------
			cmmDAO.insert(cmmDAO.getStmtByNS(MAS_NAMESPACE, "insert"), params);

			//관련파티클 처리-------------------------------------------------------
			List<DefStuPartiDTO> partiList = params.getPartiList();
			if(partiList != null && partiList.size() > 0) {

				for (int i = 0; i < partiList.size(); i++) {
					DefStuPartiDTO tmpDTO = partiList.get(i);
					String uuid = StringUtil.getRandomUUID();
					tmpDTO.setStuPatiUid(uuid);
					tmpDTO.setStuCd(params.getStuCd());
					tmpDTO.setOrdNo(""+(i+1));
					cmmDAO.insert(cmmDAO.getStmtByNS(PARTI_NAMESPACE, "insert"), tmpDTO);

					if (ERROR_RESULT.equals(tmpDTO.getErrCd())) {
	                    result = tmpDTO.getErrMsg();
	                    log.error("Error.Input parameters............." + tmpDTO);
	                    throw new RuntimeException(result);
	                }
				}
			}

			//관련상태그룹 처리-------------------------------------------------------
			List<DefStuGroupDTO> groupList = params.getGroupList();
			if(groupList != null && groupList.size() > 0) {

				for (int i = 0; i < groupList.size(); i++) {
					DefStuGroupDTO tmpDTO = groupList.get(i);
					String uuid = StringUtil.getRandomUUID();
					tmpDTO.setStuGroupUid(uuid);
					tmpDTO.setStuCd(params.getStuCd());

					cmmDAO.insert(cmmDAO.getStmtByNS(GROUP_NAMESPACE, "insert"), tmpDTO);

					if (ERROR_RESULT.equals(tmpDTO.getErrCd())) {
						result = tmpDTO.getErrMsg();
						log.error("Error.Input parameters............." + tmpDTO);
						throw new RuntimeException(result);
					}
				}
			}

			if (ERROR_RESULT.equals(params.getErrCd())) {
                result = params.getErrMsg();
                log.error("Error.Input parameters............." + params);
                throw new RuntimeException(result);
            }

		}

		return result;
	}

	/**
	 * 리스트에서 상태 일괄 삭제.
	 * @param params
	 * @return
	 */
	public String delete(Map<String, Object> params) {
		String result = "";
		String stuCds = (String)params.get("stuCds");

		if(StringUtils.isNotBlank(stuCds)) {
			String[] arrStuCd = StringUtils.split(stuCds,",");
			for (int i = 0; i < arrStuCd.length; i++) {
				Map<String, Object> whereMap = new HashMap<String, Object>();
				whereMap.put("stuCd", arrStuCd[i]);
				int cnt = 0;
				//--연결 상태그룹 선삭제
				cnt += cmmDAO.delete(cmmDAO.getStmtByNS(MAIL_NAMESPACE, "delete"), whereMap);
				//--연결 상태그룹 선삭제
				cnt += cmmDAO.delete(cmmDAO.getStmtByNS(GROUP_NAMESPACE, "delete"), whereMap);
				//--연결 파티클 선삭제
				cnt += cmmDAO.delete(cmmDAO.getStmtByNS(PARTI_NAMESPACE, "delete"), whereMap);
				//-- 마스터 선 삭제후 재등록
				cnt += cmmDAO.delete(cmmDAO.getStmtByNS(MAS_NAMESPACE, "delete"), whereMap);

				if (cnt == 0) {
					result = "삭제가 실패 되었습니다. 상태코드:"+ arrStuCd[i];
					log.error("Error.Input parameters............." + params);
					throw new RuntimeException(result);
				}
			}
		}

		return result;
	}

}
