/*
 * @(#)ParticleDTO.java     2020-12-19(016) 오후 4:30
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
package com.vertexid.paragon.def.particlemng;

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
public class ParticleMngDTO extends CmmDTO {



	private static final long serialVersionUID = 5601942164849350252L;
	private String patiUid;
    private String patiMngNo;
    private String patiTpCd;
    private String patiTpCd2;
    private String patiTpAbbCd;
    private String patiTpAbbCd2;
    private String patiNm;
    private String patiDesc;
    private String patiClassPath;
    private String patiJspWrtPath;
    private String patiJspViewPath;
    private String patiSourceWrtYn;
    private String patiOnlyViewYn;
    private String regDte;
    private String regLoginId;
    private String uptDte;
    private String uptLoginId;
    private List<ParticleMngDTO> list;

    public ParticleMngDTO() {
    }

	public String getPatiUid() {
		return patiUid;
	}

	public void setPatiUid(String patiUid) {
		this.patiUid = patiUid;
	}

	public String getPatiMngNo() {
		return patiMngNo;
	}

	public void setPatiMngNo(String patiMngNo) {
		this.patiMngNo = patiMngNo;
	}

	public String getPatiTpCd() {
		return patiTpCd;
	}

	public void setPatiTpCd(String patiTpCd) {
		this.patiTpCd = patiTpCd;
	}

	public String getPatiTpCd2() {
		return patiTpCd2;
	}

	public void setPatiTpCd2(String patiTpCd2) {
		this.patiTpCd2 = patiTpCd2;
	}

	public String getPatiTpAbbCd() {
		return patiTpAbbCd;
	}

	public void setPatiTpAbbCd(String patiTpAbbCd) {
		this.patiTpAbbCd = patiTpAbbCd;
	}

	public String getPatiTpAbbCd2() {
		return patiTpAbbCd2;
	}

	public void setPatiTpAbbCd2(String patiTpAbbCd2) {
		this.patiTpAbbCd2 = patiTpAbbCd2;
	}

	public String getPatiNm() {
		return patiNm;
	}

	public void setPatiNm(String patiNm) {
		this.patiNm = patiNm;
	}

	public String getPatiDesc() {
		return patiDesc;
	}

	public void setPatiDesc(String patiDesc) {
		this.patiDesc = patiDesc;
	}

	public String getPatiClassPath() {
		return patiClassPath;
	}

	public void setPatiClassPath(String patiClassPath) {
		this.patiClassPath = patiClassPath;
	}

	public String getPatiJspWrtPath() {
		return patiJspWrtPath;
	}

	public void setPatiJspWrtPath(String patiJspWrtPath) {
		this.patiJspWrtPath = patiJspWrtPath;
	}

	public String getPatiJspViewPath() {
		return patiJspViewPath;
	}

	public void setPatiJspViewPath(String patiJspViewPath) {
		this.patiJspViewPath = patiJspViewPath;
	}

	public String getPatiSourceWrtYn() {
		return patiSourceWrtYn;
	}

	public void setPatiSourceWrtYn(String patiSourceWrtYn) {
		this.patiSourceWrtYn = patiSourceWrtYn;
	}

	public String getPatiOnlyViewYn() {
		return patiOnlyViewYn;
	}

	public void setPatiOnlyViewYn(String patiOnlyViewYn) {
		this.patiOnlyViewYn = patiOnlyViewYn;
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

	public List<ParticleMngDTO> getList() {
		return list;
	}

	public void setList(List<ParticleMngDTO> list) {
		this.list = list;
	}



}
