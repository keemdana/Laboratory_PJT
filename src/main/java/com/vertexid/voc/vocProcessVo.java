package com.vertexid.voc;

public class vocProcessVo {
	
	private String vocNo;			//VOC번호
	private int seq;				//선택순서(행)	
	private String creDate;
	private String creUser;
		
	private String dept;
	private String deptNm;
	private String reqContents;
	private String processContents;
	
	private String loginUserId;
	
	private String processUserId;
	private String processUserNm;
	private String processPlan;
	private String processPlanDate;
	private String processStatus;
	private String processCompYn;
	
	private String ecrNo;
	private String atchFileId;
	
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
	public String getCreDate() {
		return creDate;
	}
	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}
	public String getCreUser() {
		return creUser;
	}
	public void setCreUser(String creUser) {
		this.creUser = creUser;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}	
	public String getReqContents() {
		return reqContents;
	}
	public void setReqContents(String reqContents) {
		this.reqContents = reqContents;
	}
	public String getProcessContents() {
		return processContents;
	}
	public void setProcessContents(String processContents) {
		this.processContents = processContents;
	}
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	public String getProcessUserId() {
		return processUserId;
	}
	public void setProcessUserId(String processUserId) {
		this.processUserId = processUserId;
	}
	
	public String getProcessUserNm() {
		return processUserNm;
	}
	public void setProcessUserNm(String processUserNm) {
		this.processUserNm = processUserNm;
	}
	public String getProcessPlan() {
		return processPlan;
	}
	public void setProcessPlan(String processPlan) {
		this.processPlan = processPlan;
	}
	public String getProcessPlanDate() {
		return processPlanDate;
	}
	public void setProcessPlanDate(String processPlanDate) {
		this.processPlanDate = processPlanDate;
	}
	public String getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(String processStatus) {
		this.processStatus = processStatus;
	}
	public String getEcrNo() {
		return ecrNo;
	}
	public void setEcrNo(String ecrNo) {
		this.ecrNo = ecrNo;
	}
	/*
	 * public List<vocProcessVo> getAtchFileList() { return atchFileList; } public
	 * void setAtchFileList(List<vocProcessVo> atchFileList) { this.atchFileList =
	 * atchFileList; }
	 */
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getProcessCompYn() {
		return processCompYn;
	}
	public void setProcessCompYn(String processCompYn) {
		this.processCompYn = processCompYn;
	}
	
	
	
	
	
}
