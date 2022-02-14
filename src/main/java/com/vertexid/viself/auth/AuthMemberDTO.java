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
 *     권한 사용자 DTO
 * </pre>
 *
 * @author 강세원
 */
public class AuthMemberDTO extends CmmDTO {


	private static final long serialVersionUID = -1133325854937034333L;

	private String authCd;
    private String mbrTpCd;
    private String mbrId;
    private String userNm;

    private List<AuthMemberDTO> list;

    public AuthMemberDTO() {
    }

	public String getAuthCd() {
		return authCd;
	}

	public void setAuthCd(String authCd) {
		this.authCd = authCd;
	}

	public String getMbrTpCd() {
		return mbrTpCd;
	}

	public void setMbrTpCd(String mbrTpCd) {
		this.mbrTpCd = mbrTpCd;
	}

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public List<AuthMemberDTO> getList() {
		return list;
	}

	public void setList(List<AuthMemberDTO> list) {
		this.list = list;
	}



}
