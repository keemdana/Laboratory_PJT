/*
 * @(#)CooperationMasDTO.java     2021-07-27(027) 오전 10:09
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
package com.vertexid.paragon.aprv;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     협조처 마스터 DTO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class CooperationMasDTO extends CmmDTO {
    private static final long serialVersionUID = -3908972749249198732L;

    private String aprNo;
    private String solMasUid;
    private String docUid;
    private String regDte;
    private String regLoginId;
    private String uptDte;
    private String uptLoginId;

    public CooperationMasDTO() {
    }

    public String getAprNo() {
        return aprNo;
    }

    public void setAprNo(String aprNo) {
        this.aprNo = aprNo;
    }

    public String getSolMasUid() {
        return solMasUid;
    }

    public void setSolMasUid(String solMasUid) {
        this.solMasUid = solMasUid;
    }

    public String getDocUid() {
        return docUid;
    }

    public void setDocUid(String docUid) {
        this.docUid = docUid;
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
}
