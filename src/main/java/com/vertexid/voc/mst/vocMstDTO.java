package com.vertexid.voc.mst;

import java.util.HashMap;
import java.util.List;

import com.vertexid.viself.base.CmmDTO;
import com.vertexid.voc.prc.vocPrcVo;
import com.vertexid.voc.sulbi.vocSulbiVo;

public class vocMstDTO extends CmmDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String vocNo;			
	private String createDept;
	private String createUser;
	private String createDate;
	private String bssArea;
	private String vocRegType;
	private String custReqDate;
	private String custUserNm;
	private String custUserEmail;
	private String custFbYn;
	private String vocTitle;
	private String custCd;
	private String custNm;
	private String custReqContents;
	private String atchFileMstId;
	private String vocStatus;
	private String delFlag;
	

	//처리부서 선택
	private String regAcceptYn;
	private String regRejectReason;
	private String regDecideDate;
	private String regDecideUser;
	private String regDecideOpinion;
	private String vocGradeType;
	private String prcOrderYn;
	
	
	private String loginUserId;	
	private String rejectFlag;	//VOC 반려 건에 대한 처리
	private String hisStatus;	//History 테이블에 쌓기 위한 진행상태
	
	private List<vocSulbiVo> sulbiList;
	private List<vocPrcVo> processList;
	
	public List<vocSulbiVo> getSulbiList() {
		return sulbiList;
	}
	public void setSulbiList(List<vocSulbiVo> sulbiList) {
		this.sulbiList = sulbiList;
	}
	
	
	public List<vocPrcVo> getProcessList() {
		return processList;
	}
	public void setProcessList(List<vocPrcVo> processList) {
		this.processList = processList;
	}
	public String getVocNo() {
		return vocNo;
	}
	public void setVocNo(String vocNo) {
		this.vocNo = vocNo;
	}
	public String getCreateDept() {
		return createDept;
	}
	public void setCreateDept(String createDept) {
		this.createDept = createDept;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getBssArea() {
		return bssArea;
	}
	public void setBssArea(String bssArea) {
		this.bssArea = bssArea;
	}
	public String getVocRegType() {
		return vocRegType;
	}
	public void setVocRegType(String vocRegType) {
		this.vocRegType = vocRegType;
	}
	public String getCustReqDate() {
		return custReqDate;
	}
	public void setCustReqDate(String custReqDate) {
		this.custReqDate = custReqDate;
	}
	public String getCustUserNm() {
		return custUserNm;
	}
	public void setCustUserNm(String custUserNm) {
		this.custUserNm = custUserNm;
	}
	public String getCustUserEmail() {
		return custUserEmail;
	}
	public void setCustUserEmail(String custUserEmail) {
		this.custUserEmail = custUserEmail;
	}
	public String getCustFbYn() {
		return custFbYn;
	}
	public void setCustFbYn(String custFbYn) {
		this.custFbYn = custFbYn;
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
	
	public String getCustReqContents() {
		return custReqContents;
	}
	public void setCustReqContents(String custReqContents) {
		this.custReqContents = custReqContents;
	}
	public String getAtchFileMstId() {
		return atchFileMstId;
	}
	public void setAtchFileMstId(String atchFileMstId) {
		this.atchFileMstId = atchFileMstId;
	}
	public String getVocStatus() {
		return vocStatus;
	}
	public void setVocStatus(String vocStatus) {
		this.vocStatus = vocStatus;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public String getRegAcceptYn() {
		return regAcceptYn;
	}
	public void setRegAcceptYn(String regAcceptYn) {
		this.regAcceptYn = regAcceptYn;
	}
	public String getRegRejectReason() {
		return regRejectReason;
	}
	public void setRegRejectReason(String regRejectReason) {
		this.regRejectReason = regRejectReason;
	}
	public String getRegDecideDate() {
		return regDecideDate;
	}
	public void setRegDecideDate(String regDecideDate) {
		this.regDecideDate = regDecideDate;
	}
	public String getRegDecideUser() {
		return regDecideUser;
	}
	public void setRegDecideUser(String regDecideUser) {
		this.regDecideUser = regDecideUser;
	}
	public String getRegDecideOpinion() {
		return regDecideOpinion;
	}
	public void setRegDecideOpinion(String regDecideOpinion) {
		this.regDecideOpinion = regDecideOpinion;
	}
	public String getVocGradeType() {
		return vocGradeType;
	}
	public void setVocGradeType(String vocGradeType) {
		this.vocGradeType = vocGradeType;
	}
	public String getPrcOrderYn() {
		return prcOrderYn;
	}
	public void setPrcOrderYn(String prcOrderYn) {
		this.prcOrderYn = prcOrderYn;
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
	public String getHisStatus() {
		return hisStatus;
	}
	public void setHisStatus(String hisStatus) {
		this.hisStatus = hisStatus;
	}
	
	
	
}
