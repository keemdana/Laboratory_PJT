/*
 * @(#)BaseViewVO.java     2019-11-19 오후 5:52
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */

package com.vertexid.viself.base;

import com.vertexid.commons.utils.CaseConverter;
import org.apache.commons.lang3.StringUtils;

/**
 * <b>Description</b>
 * <pre>
 * SELF 에서 사용하는 기본 View 정보
 *
 * 페이지에 대한 정보를 가지고 있다.
 *
 * View 에 대한 처리를 위해 CmmTilesViewCtrl 에서 사용된다.
 *
 * 뷰정보에대한 패턴은
 *
 *      /시스템/앱/모듈/서브모듈/페이지
 *
 * 형태이다.
 *
 * 페이지에 대한 naming case 는 url 규칙을 따르며
 *
 * 페이지는 camel case, 그외에는 lower cobol case 로 변환된다.
 *
 * tiles 뷰를 호출하는 용도로 사용
 *     ex) /시스템/앱/페이지 형태
 *
 *         RequestMapping(/viself/auth-app/test-mng)
 *
 *         =>
 *             - system: viself
 *             - app: auth-app
 *             - page: TestMng
 *
 *             tiles 주소: /viself/auth-app/TestMng.tiles
 *             jsp 주소: /WEB-INF/jsp/viself/auth-app/TestMng.jsp
 *             js 주소: /js/module/viself/auth-app/TestMng.js
 *
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseViewVO extends BaseVO {

    private static final long serialVersionUID = -4531779895559572735L;

	public static final char SEPERATOR_CHAR = '.';

	/** 시스템 */
	private final String system;

	/** 앱 */
	private final String app;

	/** 모듈(메뉴) */
	private final String module;

	/** 서브모듈 */
	private final String sub;

	/**
	 * 페이지
	 */
	private String page;

	private String typePostfix;

	private void setTypePostfix(String page) {

		String[] arrPage = StringUtils.split(page, SEPERATOR_CHAR);

		if (arrPage.length > 1) {
			this.page = CaseConverter.camelCase(arrPage[0]);
			this.typePostfix = arrPage[1];
		} else {
			this.page = CaseConverter.camelCase(arrPage[0]);
		}
	}

	/**
	 * 뷰 VO
	 * @param system 시스템
	 * @param app 앱
	 * @param module 모듈
	 * @param sub 서브모듈
	 * @param page 페이지(리소스)
	 */
	public BaseViewVO(String system, String app, String module, String sub,
					  String page) {
		this.system = CaseConverter.camelCase(system);
		this.app = CaseConverter.camelCase(app);
		this.module = CaseConverter.camelCase(module);
		this.sub = CaseConverter.camelCase(sub);
		this.page = CaseConverter.camelCase(page);
		setTypePostfix(page);

		log.debug(this.toString());
	}

	public String getSystem() {
		return system;
	}

	public String getApp() {
		return app;
	}

	public String getModule() {
		return module;
	}

	public String getSub() {
		return sub;
	}

	public void setPage(String page) {
		this.page = page;
	}

	/**
	 * 페이지 정보
	 *
	 * @return 페이지정보
	 */
	public String getPage() {
		return page;
	}

	public String getTypePostfix() {
		return typePostfix;
	}

}
