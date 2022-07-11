package com.vertexid.voc.prc;

public class vocPrcVo {
	
	private String vocNo;			//VOC번호
	private int seq;				//선택순서(행)	
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser;
	
	private String deptCd;
	private String deptNm;
	private String deptReqContents;
	private String prcUserId;
	private String prcUserNm;
	private String prcPlanType;
	private String prcPlanDate;
	private String prcStatus;
	private String ecrNo;
	private String ecrStatus;
	
	private String gwKey;
	private String prcCompYn;	
	private String prcContents;
	private String atchFileId;	
	private String loginUserId;
	
	
	public String getVocNo() {
		return vocNo;
	}
	public void setVocNo(String vocNo) {
		this.vocNo = vocNo;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getDeptCd() {
		return deptCd;
	}
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}
	public String getDeptReqContents() {
		return deptReqContents;
	}
	public void setDeptReqContents(String deptReqContents) {
		this.deptReqContents = deptReqContents;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}		
	
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	
	public String getPrcUserId() {
		return prcUserId;
	}
	public void setPrcUserId(String prcUserId) {
		this.prcUserId = prcUserId;
	}
	public String getPrcUserNm() {
		return prcUserNm;
	}
	public void setPrcUserNm(String prcUserNm) {
		this.prcUserNm = prcUserNm;
	}
	public String getPrcPlanType() {
		return prcPlanType;
	}
	public void setPrcPlanType(String prcPlanType) {
		this.prcPlanType = prcPlanType;
	}
	public String getPrcPlanDate() {
		return prcPlanDate;
	}
	public void setPrcPlanDate(String prcPlanDate) {
		this.prcPlanDate = prcPlanDate;
	}
	public String getPrcStatus() {
		return prcStatus;
	}
	public void setPrcStatus(String prcStatus) {
		this.prcStatus = prcStatus;
	}
	public String getEcrNo() {
		return ecrNo;
	}
	public void setEcrNo(String ecrNo) {
		this.ecrNo = ecrNo;
	}
	
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public String getEcrStatus() {
		return ecrStatus;
	}
	public void setEcrStatus(String ecrStatus) {
		this.ecrStatus = ecrStatus;
	}
	public String getGwKey() {
		return gwKey;
	}
	public void setGwKey(String gwKey) {
		this.gwKey = gwKey;
	}
	public String getPrcCompYn() {
		return prcCompYn;
	}
	public void setPrcCompYn(String prcCompYn) {
		this.prcCompYn = prcCompYn;
	}
	public String getPrcContents() {
		return prcContents;
	}
	public void setPrcContents(String prcContents) {
		this.prcContents = prcContents;
	}
	
}
