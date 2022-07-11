package com.vertexid.voc;

import java.util.HashMap;
import java.util.List;

import com.vertexid.viself.base.CmmDTO;

public class vocProcessDTO extends CmmDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String vocNo;			//관리번호
	private String creDept;			//접수부서
	private String creUser;			//접수자
	private String creDate;			//접수일
	private String bssArea;			//사업구분
	private String regType;			//접수유형
	private String cusMngDate;		//고객요청일
	private String cusMngUser;		//고객담당자
	private String cusMngEmail;		//고객담당메일
	private String cusMngFbYn;		//고객 Feedback 여부
	private String vocTitle;		//제목
	private String custCd;			//고객사 코드
	private String custNm;			//고객사 이름
	private String regContents;		//요청내용
	private String vocRegFile;		//등록 첨부파일
	private String processDate;		//작업에정일
	private String atchFileId;		//첨부파일ID
	private String updDate;
	private String updUser;
	private String delFlag;
	private String vocStatus;
	
	private String regIngYn;
	private String regIngRs;
	private String regIngRsEtc;
	private String regIngDate;
	private String regIngUser;
	
	private String gradeType;
	private String prOrderYn;
	
	private String loginUserId;
	
	private String rejectFlag;
	
	//private List<vocSulbiVo> sulbiList;
	
	//private HashMap<String, Object> sulbiList;
	
	private List<vocSulbiVo> sulbiList;
	private List<vocProcessVo> processList;
	
	public List<vocSulbiVo> getSulbiList() {
		return sulbiList;
	}
	public void setSulbiList(List<vocSulbiVo> sulbiList) {
		this.sulbiList = sulbiList;
	}
	
	
	public List<vocProcessVo> getProcessList() {
		return processList;
	}
	public void setProcessList(List<vocProcessVo> processList) {
		this.processList = processList;
	}
	
	public String getVocNo() {
		return vocNo;
	}
	public void setVocNo(String vocNo) {
		this.vocNo = vocNo;
	}
	public String getCreDept() {
		return creDept;
	}
	public void setCreDept(String creDept) {
		this.creDept = creDept;
	}
	public String getCreUser() {
		return creUser;
	}
	public void setCreUser(String creUser) {
		this.creUser = creUser;
	}
	public String getCreDate() {
		return creDate;
	}
	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}
	public String getBssArea() {
		return bssArea;
	}
	public void setBssArea(String bssArea) {
		this.bssArea = bssArea;
	}
	public String getRegType() {
		return regType;
	}
	public void setRegType(String regType) {
		this.regType = regType;
	}
	public String getCusMngDate() {
		return cusMngDate;
	}
	public void setCusMngDate(String cusMngDate) {
		this.cusMngDate = cusMngDate;
	}
	public String getCusMngUser() {
		return cusMngUser;
	}
	public void setCusMngUser(String cusMngUser) {
		this.cusMngUser = cusMngUser;
	}
	public String getCusMngEmail() {
		return cusMngEmail;
	}
	public void setCusMngEmail(String cusMngEmail) {
		this.cusMngEmail = cusMngEmail;
	}
	public String getCusMngFbYn() {
		return cusMngFbYn;
	}
	public void setCusMngFbYn(String cusMngFbYn) {
		this.cusMngFbYn = cusMngFbYn;
	}
	public String getVocTitle() {
		return vocTitle;
	}
	public void setVocTitle(String vocTitle) {
		this.vocTitle = vocTitle;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRegContents() {
		return regContents;
	}
	public void setRegContents(String regContents) {
		this.regContents = regContents;
	}
	public String getVocRegFile() {
		return vocRegFile;
	}
	public void setVocRegFile(String vocRegFile) {
		this.vocRegFile = vocRegFile;
	}
	public String getProcessDate() {
		return processDate;
	}
	public void setProcessDate(String processDate) {
		this.processDate = processDate;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getUpdDate() {
		return updDate;
	}
	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
	public String getUpdUser() {
		return updUser;
	}
	public void setUpdUser(String updUser) {
		this.updUser = updUser;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public String getVocStatus() {
		return vocStatus;
	}
	public void setVocStatus(String vocStatus) {
		this.vocStatus = vocStatus;
	}
	public String getRegIngYn() {
		return regIngYn;
	}
	public void setRegIngYn(String regIngYn) {
		this.regIngYn = regIngYn;
	}	
	public String getRegIngRs() {
		return regIngRs;
	}
	public void setRegIngRs(String regIngRs) {
		this.regIngRs = regIngRs;
	}	
	public String getRegIngRsEtc() {
		return regIngRsEtc;
	}
	public void setRegIngRsEtc(String regIngRsEtc) {
		this.regIngRsEtc = regIngRsEtc;
	}
	public String getRegIngDate() {
		return regIngDate;
	}
	public void setRegIngDate(String regIngDate) {
		this.regIngDate = regIngDate;
	}
	public String getRegIngUser() {
		return regIngUser;
	}
	public void setRegIngUser(String regIngUser) {
		this.regIngUser = regIngUser;
	}
	public String getGradeType() {
		return gradeType;
	}
	public void setGradeType(String gradeType) {
		this.gradeType = gradeType;
	}
	public String getPrOrderYn() {
		return prOrderYn;
	}
	public void setPrOrderYn(String prOrderYn) {
		this.prOrderYn = prOrderYn;
	}
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	public String getRejectFlag() {
		return rejectFlag;
	}
	public void setRejectFlag(String rejectFlag) {
		this.rejectFlag = rejectFlag;
	}
	
	
}
