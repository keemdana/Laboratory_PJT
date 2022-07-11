package com.vertexid.pcf;


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
public class workLabSvc extends BaseSvc {
	
	private static final String NAMESPACE = "com.vertexid.pcf.pcf.Pcf";	
	//private static final String NAMESPACE = "com.vertexid.paragon.hr.HrMng";
	
	@Resource(name = "cmmDAO")
	private CmmDAO cmmDAO;
	
	public List<ParamMap<String,Object>> getList(Map<String, Object> params){
		return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "deptList"), params);
	}
}
