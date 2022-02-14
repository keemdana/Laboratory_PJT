/*
 * @(#)StuPartiRelDTO.java     2020-12-29(024) 오전 8:23
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
package com.vertexid.paragon.def.defstumail;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     상태관련 메일설정 DTO
 * </pre>
 *
 * @author 강세원
 */
public class DefStuMailDTO extends CmmDTO {


	private static final long serialVersionUID = -7775813826733361999L;

	private String stuEmailUid;
	private String stuCd;
	private String stuDtl;
	private String ordNo;
	private String recRoleCd;
	private String recRoleNm;
	private String recUserCd;
	private String recUserNm;
	private String refRoleCd;
	private String refRoleNm;
	private String refUserCd;
	private String refUserNm;
	private String titKo;
	private String titEn;
	private String titJa;
	private String titZh;
	private String contentKo;
	private String contentEn;
	private String contentJa;
	private String contentZh;

    public DefStuMailDTO() {
    }

	public String getStuEmailUid() {
		return stuEmailUid;
	}

	public void setStuEmailUid(String stuEmailUid) {
		this.stuEmailUid = stuEmailUid;
	}

	public String getStuCd() {
		return stuCd;
	}

	public void setStuCd(String stuCd) {
		this.stuCd = stuCd;
	}

	public String getStuDtl() {
		return stuDtl;
	}

	public void setStuDtl(String stuDtl) {
		this.stuDtl = stuDtl;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public String getRecRoleCd() {
		return recRoleCd;
	}

	public void setRecRoleCd(String recRoleCd) {
		this.recRoleCd = recRoleCd;
	}

	public String getRecRoleNm() {
		return recRoleNm;
	}

	public void setRecRoleNm(String recRoleNm) {
		this.recRoleNm = recRoleNm;
	}

	public String getRecUserCd() {
		return recUserCd;
	}

	public void setRecUserCd(String recUserCd) {
		this.recUserCd = recUserCd;
	}

	public String getRecUserNm() {
		return recUserNm;
	}

	public void setRecUserNm(String recUserNm) {
		this.recUserNm = recUserNm;
	}

	public String getRefRoleCd() {
		return refRoleCd;
	}

	public void setRefRoleCd(String refRoleCd) {
		this.refRoleCd = refRoleCd;
	}

	public String getRefRoleNm() {
		return refRoleNm;
	}

	public void setRefRoleNm(String refRoleNm) {
		this.refRoleNm = refRoleNm;
	}

	public String getRefUserCd() {
		return refUserCd;
	}

	public void setRefUserCd(String refUserCd) {
		this.refUserCd = refUserCd;
	}

	public String getRefUserNm() {
		return refUserNm;
	}

	public void setRefUserNm(String refUserNm) {
		this.refUserNm = refUserNm;
	}

	public String getTitKo() {
		return titKo;
	}

	public void setTitKo(String titKo) {
		this.titKo = titKo;
	}

	public String getTitEn() {
		return titEn;
	}

	public void setTitEn(String titEn) {
		this.titEn = titEn;
	}

	public String getTitJa() {
		return titJa;
	}

	public void setTitJa(String titJa) {
		this.titJa = titJa;
	}

	public String getTitZh() {
		return titZh;
	}

	public void setTitZh(String titZh) {
		this.titZh = titZh;
	}

	public String getContentKo() {
		return contentKo;
	}

	public void setContentKo(String contentKo) {
		this.contentKo = contentKo;
	}

	public String getContentEn() {
		return contentEn;
	}

	public void setContentEn(String contentEn) {
		this.contentEn = contentEn;
	}

	public String getContentJa() {
		return contentJa;
	}

	public void setContentJa(String contentJa) {
		this.contentJa = contentJa;
	}

	public String getContentZh() {
		return contentZh;
	}

	public void setContentZh(String contentZh) {
		this.contentZh = contentZh;
	}


}
