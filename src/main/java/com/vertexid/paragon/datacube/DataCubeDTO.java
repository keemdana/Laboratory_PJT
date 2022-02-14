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
package com.vertexid.paragon.datacube;

import java.util.List;

import com.vertexid.paragon.aprv.AprvLineDTO;
import com.vertexid.viself.base.CmmDTO;
import com.vertexid.viself.hr.SysLoginVO;

/**
 * <b>Description</b>
 * <pre>
 *     DATA CUBE DTO
 * </pre>
 *
 * @author 강세원
 */
public class DataCubeDTO extends CmmDTO {


	private static final long serialVersionUID = 8413524256165254358L;

	private String docUid;
	private String notDocUid;
	private String lastDocUid;
	private String solMasUid;
	private String groupUid;
	private String ordNo;
	private String lastYn;
	private String stuTp;
	private String stuTp2;
	private String stuCd;
	private String stuDtl;
	private String beStuCd;
	private String beStuDtl;
	private String nextStuCd;
	private String jsonData;
	private String regLoginId;
	private String uptLoginId;
	private String noneAprYn;
	private String aprMemo;
	private String siteLocale;
	private String mode;
	private SysLoginVO loginUser;
	private List<AprvLineDTO> aprvLineDTO;
	public String getDocUid() {
		return docUid;
	}
	public void setDocUid(String docUid) {
		this.docUid = docUid;
	}
	public String getNotDocUid() {
		return notDocUid;
	}
	public void setNotDocUid(String notDocUid) {
		this.notDocUid = notDocUid;
	}
	public String getLastDocUid() {
		return lastDocUid;
	}
	public void setLastDocUid(String lastDocUid) {
		this.lastDocUid = lastDocUid;
	}
	public String getSolMasUid() {
		return solMasUid;
	}
	public void setSolMasUid(String solMasUid) {
		this.solMasUid = solMasUid;
	}
	public String getGroupUid() {
		return groupUid;
	}
	public void setGroupUid(String groupUid) {
		this.groupUid = groupUid;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getLastYn() {
		return lastYn;
	}
	public void setLastYn(String lastYn) {
		this.lastYn = lastYn;
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
	public String getBeStuCd() {
		return beStuCd;
	}
	public void setBeStuCd(String beStuCd) {
		this.beStuCd = beStuCd;
	}
	public String getBeStuDtl() {
		return beStuDtl;
	}
	public void setBeStuDtl(String beStuDtl) {
		this.beStuDtl = beStuDtl;
	}
	public String getNextStuCd() {
		return nextStuCd;
	}
	public void setNextStuCd(String nextStuCd) {
		this.nextStuCd = nextStuCd;
	}
	public String getJsonData() {
		return jsonData;
	}
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}
	public String getRegLoginId() {
		return regLoginId;
	}
	public void setRegLoginId(String regLoginId) {
		this.regLoginId = regLoginId;
	}
	public String getUptLoginId() {
		return uptLoginId;
	}
	public void setUptLoginId(String uptLoginId) {
		this.uptLoginId = uptLoginId;
	}
	public String getNoneAprYn() {
		return noneAprYn;
	}
	public void setNoneAprYn(String noneAprYn) {
		this.noneAprYn = noneAprYn;
	}
	public String getAprMemo() {
		return aprMemo;
	}
	public void setAprMemo(String aprMemo) {
		this.aprMemo = aprMemo;
	}
	public List<AprvLineDTO> getAprvLineDTO() {
		return aprvLineDTO;
	}
	public void setAprvLineDTO(List<AprvLineDTO> aprvLineDTO) {
		this.aprvLineDTO = aprvLineDTO;
	}
	public String getSiteLocale() {
		return siteLocale;
	}
	public void setSiteLocale(String siteLocale) {
		this.siteLocale = siteLocale;
	}
	public SysLoginVO getLoginUser() {
		return loginUser;
	}
	public void setLoginUser(SysLoginVO loginUser) {
		this.loginUser = loginUser;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}


}
