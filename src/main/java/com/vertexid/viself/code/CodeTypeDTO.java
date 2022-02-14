/*
 * @(#)CodeTypeDTO.java     2020-04-23 오후 3:50
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
package com.vertexid.viself.code;

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 *
 * @author Yang, Ki Hwa
 */
public class CodeTypeDTO extends CmmDTO {

    private static final long serialVersionUID = -2421219985696541699L;

    private String tpId;
    private String tpNm;
    private String uptAuthCd;
    private String sortOrd;
    private String remark;
    private String useEnable;
    private List<CodeTypeDTO> list;

    public CodeTypeDTO() {
    }

    public String getTpId() {
        return tpId;
    }

    public void setTpId(String tpId) {
        this.tpId = tpId;
    }

    public String getTpNm() {
        return tpNm;
    }

    public void setTpNm(String tpNm) {
        this.tpNm = tpNm;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUseEnable() {
        return useEnable;
    }

    public void setUseEnable(String useEnable) {
        this.useEnable = useEnable;
    }

    public List<CodeTypeDTO> getList() {
        return list;
    }

    public void setList(List<CodeTypeDTO> list) {
        this.list = list;
    }

    public String getSortOrd() {
        return sortOrd;
    }

    public void setSortOrd(String sortOrd) {
        this.sortOrd = sortOrd;
    }

    public String getUptAuthCd() {
        return uptAuthCd;
    }

    public void setUptAuthCd(String uptAuthCd) {
        this.uptAuthCd = uptAuthCd;
    }
}
