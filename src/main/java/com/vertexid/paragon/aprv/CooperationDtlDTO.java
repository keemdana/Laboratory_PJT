/*
 * @(#)CooperationDtlDTO.java     2021-07-27(027) 오전 10:15
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

import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 *     협조처 상세 DTO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class CooperationDtlDTO extends CmmDTO {
    private static final long serialVersionUID = 4617090176869060017L;

    private String aprNo;
    private String solMasUid;
    private String docUid;
    private String aprLineUid;
    private String ordNo;
    private String aprDeptCd;
    private String aprDeptNm;
    private String aprLoginId;
    private String aprUserNm;
    private String realAprLoginId;
    private String realAprUserNm;
    private String aprDte;
    private String aprMemo;
    private String regDte;
    private String regLoginId;
    private String uptDte;
    private String uptLoginId;
    private List<CooperationDtlDTO> list;

    public CooperationDtlDTO() {
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

    public String getAprLineUid() {
        return aprLineUid;
    }

    public void setAprLineUid(String aprLineUid) {
        this.aprLineUid = aprLineUid;
    }

    public String getOrdNo() {
        return ordNo;
    }

    public void setOrdNo(String ordNo) {
        this.ordNo = ordNo;
    }

    public String getAprDeptCd() {
        return aprDeptCd;
    }

    public void setAprDeptCd(String aprDeptCd) {
        this.aprDeptCd = aprDeptCd;
    }

    public String getAprDeptNm() {
        return aprDeptNm;
    }

    public void setAprDeptNm(String aprDeptNm) {
        this.aprDeptNm = aprDeptNm;
    }

    public String getAprLoginId() {
        return aprLoginId;
    }

    public void setAprLoginId(String aprLoginId) {
        this.aprLoginId = aprLoginId;
    }

    public String getAprUserNm() {
        return aprUserNm;
    }

    public void setAprUserNm(String aprUserNm) {
        this.aprUserNm = aprUserNm;
    }

    public String getRealAprLoginId() {
        return realAprLoginId;
    }

    public void setRealAprLoginId(String realAprLoginId) {
        this.realAprLoginId = realAprLoginId;
    }

    public String getRealAprUserNm() {
        return realAprUserNm;
    }

    public void setRealAprUserNm(String realAprUserNm) {
        this.realAprUserNm = realAprUserNm;
    }

    public String getAprDte() {
        return aprDte;
    }

    public void setAprDte(String aprDte) {
        this.aprDte = aprDte;
    }

    public String getAprMemo() {
        return aprMemo;
    }

    public void setAprMemo(String aprMemo) {
        this.aprMemo = aprMemo;
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

    public List<CooperationDtlDTO> getList() {
        return list;
    }

    public void setList(List<CooperationDtlDTO> list) {
        this.list = list;
    }
}
