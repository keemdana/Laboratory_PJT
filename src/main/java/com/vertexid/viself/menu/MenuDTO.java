/*
 * @(#)MenuDTO.java     2020-09-16(016) 오후 1:10
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
package com.vertexid.viself.menu;

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     메뉴 DTO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class MenuDTO extends CmmDTO {

    private static final long serialVersionUID = -3912003829536782801L;

    private String menuId;
    private String parentMenuId;
    private String ordNo;
    private String langCd;
    private String useYn;
    private String viewAuth;
    private String jsonData;
    private String urlPath;
    private String moduleId;
    private String regDte;
    private String regLoginId;
    private String uptDte;
    private String uptLoginId;
    private List<MenuDTO> list;

    public MenuDTO() {
    }


    public String getMenuId() {
		return menuId;
	}


	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}


	public String getParentMenuId() {
		return parentMenuId;
	}


	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}


	public String getOrdNo() {
		return ordNo;
	}


	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}


	public String getLangCd() {
		return langCd;
	}


	public void setLangCd(String langCd) {
		this.langCd = langCd;
	}


	public String getUseYn() {
		return useYn;
	}


	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}


	public String getViewAuth() {
		return viewAuth;
	}


	public void setViewAuth(String viewAuth) {
		this.viewAuth = viewAuth;
	}


	public String getJsonData() {
		return jsonData;
	}


	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}


	public String getUrlPath() {
		return urlPath;
	}


	public void setUrlPath(String urlPath) {
		this.urlPath = urlPath;
	}

	public String getModuleId() {
		return moduleId;
	}


	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	public String getRegDte() {
		return regDte;
	}


	public void setRegDte(String regDte) {
		this.regDte = regDte;
	}


	public String getRegLoginId() {
		return regLoginId;
	}


	public void setRegLoginId(String regLoginId) {
		this.regLoginId = regLoginId;
	}


	public String getUptDte() {
		return uptDte;
	}


	public void setUptDte(String uptDte) {
		this.uptDte = uptDte;
	}


	public String getUptLoginId() {
		return uptLoginId;
	}


	public void setUptLoginId(String uptLoginId) {
		this.uptLoginId = uptLoginId;
	}


	public List<MenuDTO> getList() {
        return list;
    }

    public void setList(List<MenuDTO> list) {
        this.list = list;
    }

}
