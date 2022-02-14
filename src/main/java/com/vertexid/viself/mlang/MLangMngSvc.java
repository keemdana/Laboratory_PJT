package com.vertexid.viself.mlang;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.viself.base.BaseSvc;


/**
 * 다국어사전 관리 서비스
 * @author sitas
 * @sinse 2020.09.251
 */
@Transactional
@Service
public class MLangMngSvc extends BaseSvc{

	private static final String NAMESPACE =
			"com.vertexid.viself.mlang.MLangMng";


}
