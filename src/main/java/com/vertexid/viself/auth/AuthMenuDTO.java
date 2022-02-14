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
public class AuthMenuDTO extends CmmDTO {


	private static final long serialVersionUID = 7003987569465246610L;

	private String authCd;
    private String menuId;
    private String alwCd;

    private List<AuthMenuDTO> list;

    public AuthMenuDTO() {
    }

	public String getAuthCd() {
		return authCd;
	}

	public void setAuthCd(String authCd) {
		this.authCd = authCd;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getAlwCd() {
		return alwCd;
	}
	public void setAlwCd(String alwCd) {
		this.alwCd = alwCd;
	}

	public List<AuthMenuDTO> getList() {
		return list;
	}
	public void setList(List<AuthMenuDTO> list) {
		this.list = list;
	}

}
