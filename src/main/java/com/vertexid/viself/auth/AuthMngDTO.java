/*
 * @(#)CodeDTO.java     2020-09-24(024) 오후 2:21
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
package com.vertexid.viself.auth;

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     권한관리 DTO
 * </pre>
 *
 * @author 강세원
 */
public class AuthMngDTO extends CmmDTO {

	private static final long serialVersionUID = -7772027497755878219L;

	private String authCd;
    private String authNm;
    private String authTpCd;
    private String useYn;
	private String ordNo;

    private List<AuthMngDTO> list;

    public AuthMngDTO() {
    }

	public String getAuthCd() {
		return authCd;
	}

	public void setAuthCd(String authCd) {
		this.authCd = authCd;
	}


	public String getAuthNm() {
		return authNm;
	}

	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}

	public String getAuthTpCd() {
		return authTpCd;
	}

	public void setAuthTpCd(String authTpCd) {
		this.authTpCd = authTpCd;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public List<AuthMngDTO> getList() {
		return list;
	}

	public void setList(List<AuthMngDTO> list) {
		this.list = list;
	}



}
