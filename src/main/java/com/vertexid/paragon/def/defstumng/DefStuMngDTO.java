/*
 * @(#)StuMngDTO.java     2020-12-29(024) 오전 8:24
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
package com.vertexid.paragon.def.defstumng;

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     상태마스터 DTO
 * </pre>
 *
 * @author 강세원
 */
public class DefStuMngDTO extends CmmDTO {


	private static final long serialVersionUID = -6203270709530575159L;

	private String stuCd;
    private String stuTp;
    private String stuTp2;
    private String headEnd;
    private String ordNo;
    private String stuBaseNm;
    private String langCd;
    private String procTp;
    private String stuDesc;
    private String docNmLangCd;
    private String titDspYn;
    private String memoDspYn;
    private String fileDspYn;
    private String memoTitLangCd;
    private String stuRegAuth;
    private String stuViewAuth;
    private String relDataStuCd;
    private String useYn;

    private List<DefStuPartiDTO> partiList;
    private List<DefStuGroupDTO> groupList;

    public DefStuMngDTO() {
    }

	public String getStuCd() {
		return stuCd;
	}

	public void setStuCd(String stuCd) {
		this.stuCd = stuCd;
	}

	public String getStuTp() {
		return stuTp;
	}

	public void setStuTp(String stuTp) {
		this.stuTp = stuTp;
	}

	public String getStuTp2() {
		return stuTp2;
	}

	public void setStuTp2(String stuTp2) {
		this.stuTp2 = stuTp2;
	}

	public String getHeadEnd() {
		return headEnd;
	}

	public void setHeadEnd(String headEnd) {
		this.headEnd = headEnd;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public String getStuBaseNm() {
		return stuBaseNm;
	}

	public void setStuBaseNm(String stuBaseNm) {
		this.stuBaseNm = stuBaseNm;
	}

	public String getLangCd() {
		return langCd;
	}

	public void setLangCd(String langCd) {
		this.langCd = langCd;
	}

	public String getProcTp() {
		return procTp;
	}

	public void setProcTp(String procTp) {
		this.procTp = procTp;
	}

	public String getStuDesc() {
		return stuDesc;
	}

	public void setStuDesc(String stuDesc) {
		this.stuDesc = stuDesc;
	}

	public String getDocNmLangCd() {
		return docNmLangCd;
	}

	public void setDocNmLangCd(String docNmLangCd) {
		this.docNmLangCd = docNmLangCd;
	}

	public String getTitDspYn() {
		return titDspYn;
	}

	public void setTitDspYn(String titDspYn) {
		this.titDspYn = titDspYn;
	}

	public String getMemoDspYn() {
		return memoDspYn;
	}

	public void setMemoDspYn(String memoDspYn) {
		this.memoDspYn = memoDspYn;
	}

	public String getFileDspYn() {
		return fileDspYn;
	}

	public void setFileDspYn(String fileDspYn) {
		this.fileDspYn = fileDspYn;
	}

	public String getMemoTitLangCd() {
		return memoTitLangCd;
	}

	public void setMemoTitLangCd(String memoTitLangCd) {
		this.memoTitLangCd = memoTitLangCd;
	}

	public String getStuRegAuth() {
		return stuRegAuth;
	}

	public void setStuRegAuth(String stuRegAuth) {
		this.stuRegAuth = stuRegAuth;
	}

	public String getStuViewAuth() {
		return stuViewAuth;
	}

	public void setStuViewAuth(String stuViewAuth) {
		this.stuViewAuth = stuViewAuth;
	}

	public String getRelDataStuCd() {
		return relDataStuCd;
	}

	public void setRelDataStuCd(String relDataStuCd) {
		this.relDataStuCd = relDataStuCd;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public List<DefStuPartiDTO> getPartiList() {
		return partiList;
	}

	public void setPartiList(List<DefStuPartiDTO> partiList) {
		this.partiList = partiList;
	}

	public List<DefStuGroupDTO> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<DefStuGroupDTO> groupList) {
		this.groupList = groupList;
	}




}
