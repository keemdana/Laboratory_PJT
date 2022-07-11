package com.vertexid.voc.mst;

import com.vertexid.viself.base.CmmDTO;

public class vocApvDTO extends CmmDTO{

	private static final long serialVersionUID = 1L;

	private String cmpId;
	private String interId;
	private String sysId;
	private String sysKey;
	private String seq;
	private String userId;
	private String formPrefix;
	private String title;
	private String body;
	private String status;
	private String insertDt;
	private String formName;
	private String appPathLine;
	
	private String vocNo;	
	private String deptCd;
	private int prcSeq;
	
	
	
	public String getCmpId() {
		return cmpId;
	}
	public void setCmpId(String cmpId) {
		this.cmpId = cmpId;
	}
	public String getSysId() {
		return sysId;
	}
	public void setSysId(String sysId) {
		this.sysId = sysId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getVocNo() {
		return vocNo;
	}
	public void setVocNo(String vocNo) {
		this.vocNo = vocNo;
	}
	public String getDeptCd() {
		return deptCd;
	}
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}
	public String getInterId() {
		return interId;
	}
	public void setInterId(String interId) {
		this.interId = interId;
	}
	public String getSysKey() {
		return sysKey;
	}
	public void setSysKey(String sysKey) {
		this.sysKey = sysKey;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFormPrefix() {
		return formPrefix;
	}
	public void setFormPrefix(String formPrefix) {
		this.formPrefix = formPrefix;
	}
	public String getInsertDt() {
		return insertDt;
	}
	public void setInsertDt(String insertDt) {
		this.insertDt = insertDt;
	}
	public String getFormName() {
		return formName;
	}
	public void setFormName(String formName) {
		this.formName = formName;
	}
	public String getAppPathLine() {
		return appPathLine;
	}
	public void setAppPathLine(String appPathLine) {
		this.appPathLine = appPathLine;
	}
	public int getPrcSeq() {
		return prcSeq;
	}
	public void setPrcSeq(int prcSeq) {
		this.prcSeq = prcSeq;
	}
	
}
