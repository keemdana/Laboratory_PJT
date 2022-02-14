/*
 * @(#)UrlDTO.java     2021-03-31(031) 오후 1:53
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

import com.vertexid.viself.base.CmmDTO;

import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class UrlDTO extends CmmDTO {
    private static final long serialVersionUID = -4104234561085749500L;

    private String accesUrl;
    private String urlDesc;
    private String alwDiv;
    private String useYn;

    private List<UrlDTO> list;

    public UrlDTO() {
    }

    public String getAccesUrl() {
        return accesUrl;
    }

    public void setAccesUrl(String accesUrl) {
        this.accesUrl = accesUrl;
    }

    public String getUrlDesc() {
        return urlDesc;
    }

    public void setUrlDesc(String urlDesc) {
        this.urlDesc = urlDesc;
    }

    public String getAlwDiv() {
        return alwDiv;
    }

    public void setAlwDiv(String alwDiv) {
        this.alwDiv = alwDiv;
    }


    public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public List<UrlDTO> getList() {
        return list;
    }

    public void setList(List<UrlDTO> list) {
        this.list = list;
    }
}
