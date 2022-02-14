package com.vertexid.paragon.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import com.vertexid.viself.hr.SysLoginVO;

@Service
@Transactional
public class HrMngSvc extends BaseSvc{

	private static final String NAMESPACE =
            "com.vertexid.paragon.hr.HrMng";

	@Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;


	public Object getList(HrMngDTO params) {
		 log.debug("PARAMS......................................"+params);


		 return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "list"), params);
	}


	public String update(HrMngDTO params) {
        String result = "";

        cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), params);

        if (log.isInfoEnabled()) {
            log.info("Input parameters............." + params);
        }

        if (ERROR_RESULT.equals(params.getErrCd())) {
            result = params.getErrMsg();
            log.error("Error.Input parameters............." + params);
            throw new RuntimeException(result);
        }else {
        	cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteVUser"),params);
            cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "selectVInsert"),params);

        }

        return result;
    }


	/**
	 * 기본 결재선 구하기
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> getDefaultLine(Map<String, Object> params) {
		List<Object> aprvList = new ArrayList<Object>();
		SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();
    	params.put("loginInfo", loginUser);
    	String loginId 	= StringUtil.convertNull( loginUser.getLoginId());
    	if(StringUtil.isNotBlank(StringUtil.convertNull(params.get("reqLoginId")))) {
    		//-- 넘겨 받은 사용자가 있을경우
    		loginId 	= StringUtil.convertNull( params.get("reqLoginId"));
    	}else {
    		//-- 넘겨 받은 사용자가 없을경우 로그인 사용자.
    		loginId 	= StringUtil.convertNull( loginUser.getLoginId());
    	}
    	HrMngDTO reqDTO = new HrMngDTO();
    	reqDTO.setLoginId(loginId);
    	ParamMap<String, Object> row =  cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "list"),reqDTO);


		if(row != null && !row.isEmpty()) {
			Map<String, Object> param = new HashMap<>();
			param.put("deptCdPath", row.get("deptCdPath"));
			List<Object> list =  cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "allChieflist"),param);
			if(list != null && list.size() > 0) {
				HrMngDTO hrMngDTO = new HrMngDTO();
				hrMngDTO.setLoginId(loginId);
				String loginIds = "";
				for (int i = 0; i < list.size(); i++) {
					ParamMap<String, Object> rowMap =  (ParamMap<String, Object>)list.get(i);
					if(i > 0)loginIds +=",";
					loginIds += rowMap.getString("loginId");
				}
				hrMngDTO.setLoginIds(loginIds);

				aprvList =  cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "aprvLinelist"),hrMngDTO);
//				ObjectMapper objectMapper = new ObjectMapper();
//				try {
//					rtnStr = objectMapper.writeValueAsString(aprvList);
//				} catch (JsonProcessingException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}

			}

		}
		return aprvList;
	}

}
