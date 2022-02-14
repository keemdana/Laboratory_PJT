/*
 * @(#)ModuleUrlDTO.java     2021-03-17(017) 오후 2:35
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
 *     Module Url DTO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class ModuleUrlDTO extends CmmDTO {

    private static final long serialVersionUID = -3115886597147932665L;

    private String moduleId;
    private String accesUrl;
    private String repreUrlEnable;

    private List<ModuleUrlDTO> list;

    public ModuleUrlDTO() {
    }

    public String getModuleId() {
        return moduleId;
    }

    public void setModuleId(String moduleId) {
        this.moduleId = moduleId;
    }

    public String getAccesUrl() {
        return accesUrl;
    }

    public void setAccesUrl(String accesUrl) {
        this.accesUrl = accesUrl;
    }

    public String getRepreUrlEnable() {
        return repreUrlEnable;
    }

    public void setRepreUrlEnable(String repreUrlEnable) {
        this.repreUrlEnable = repreUrlEnable;
    }

    public List<ModuleUrlDTO> getList() {
        return list;
    }

    public void setList(List<ModuleUrlDTO> list) {
        this.list = list;
    }
}
