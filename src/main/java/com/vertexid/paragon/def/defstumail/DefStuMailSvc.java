package com.vertexid.paragon.def.defstumail;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.commons.utils.StringUtil;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;

@Service
@Transactional
public class DefStuMailSvc extends BaseSvc{
	private static final String NAMESPACE =
            "com.vertexid.commons.def.defstumail.DefStuMail";

	@Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

	public String save(DefStuMailDTO params) {
		String result = "";

		String mailUid = params.getStuEmailUid();
		// UPDATE
		if(StringUtil.isNotBlank(mailUid)) {
			cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), params);
		}else {
			cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), params);
		}
		if (ERROR_RESULT.equals(params.getErrCd())) {
			result = params.getErrMsg();
			log.error("Error.Input parameters............." + params);
			throw new RuntimeException(result);
		}
		return result;
	}


}
