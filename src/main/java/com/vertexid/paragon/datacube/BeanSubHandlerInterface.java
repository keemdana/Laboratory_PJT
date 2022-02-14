package com.vertexid.paragon.datacube;

import java.sql.SQLException;

import com.vertexid.viself.base.CmmDAO;

/**
 * @deprecated SubHandler 로 대체
 */
public interface BeanSubHandlerInterface {


	CmmDAO getCmmDAO();

	void setCmmDAO(CmmDAO cmmDAO);

	/**
	 * 업무 핸들러를 통해서 UUID 생성, 초기 Data 입력등을 수행
	 * @return
	 * @throws SQLException
	 */
	DataCubeDTO init(DataCubeDTO param);


	/**
	 * 업무 핸들러를 통해서 특화된 업무 처리
	 */
	void doWork(DataCubeDTO param);
}
