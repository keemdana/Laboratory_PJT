/*
 * @(#)ModuleDTO.java     2021-03-16(016) 오후 2:28
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
package com.vertexid.viself.module;

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     Module DTO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class ModuleDTO extends CmmDTO {
    private static final long serialVersionUID = 4933546668213614121L;

    private String moduleId;
    private String moduleDesc;
    private String useYn;

    private List<ModuleDTO> list;

    public ModuleDTO() {
    }

    public String getModuleId() {
        return moduleId;
    }

    public void setModuleId(String moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleDesc() {
        return moduleDesc;
    }

    public void setModuleDesc(String moduleDesc) {
        this.moduleDesc = moduleDesc;
    }

    public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public List<ModuleDTO> getList() {
        return list;
    }

    public void setList(List<ModuleDTO> list) {
        this.list = list;
    }
}
