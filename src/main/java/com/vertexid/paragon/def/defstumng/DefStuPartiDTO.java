/*
 * @(#)StuPartiRelDTO.java     2020-12-29(024) 오전 8:23
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
package com.vertexid.paragon.def.defstumng;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     상태관련 파티클 DTO
 * </pre>
 *
 * @author 강세원
 */
public class DefStuPartiDTO extends CmmDTO {


	private static final long serialVersionUID = -8457100661101055904L;

	private String stuPatiUid;
	private String stuCd;
	private String patiMngNo;
	private String ordNo;
	private String viewAuth;
	private String patiOnlyViewYn;

    public DefStuPartiDTO() {
    }

	public String getStuPatiUid() {
		return stuPatiUid;
	}

	public void setStuPatiUid(String stuPatiUid) {
		this.stuPatiUid = stuPatiUid;
	}

	public String getStuCd() {
		return stuCd;
	}

	public void setStuCd(String stuCd) {
		this.stuCd = stuCd;
	}

	public String getPatiMngNo() {
		return patiMngNo;
	}

	public void setPatiMngNo(String patiMngNo) {
		this.patiMngNo = patiMngNo;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public String getViewAuth() {
		return viewAuth;
	}

	public void setViewAuth(String viewAuth) {
		this.viewAuth = viewAuth;
	}

	public String getPatiOnlyViewYn() {
		return patiOnlyViewYn;
	}

	public void setPatiOnlyViewYn(String patiOnlyViewYn) {
		this.patiOnlyViewYn = patiOnlyViewYn;
	}

}
