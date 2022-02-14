package com.vertexid.paragon.cmm;

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

public class StuLogDTO extends CmmDTO {

	/**
	 *
	 */
	private static final long serialVersionUID = -8421399142720025468L;

	private String changeUid   ;
	private String solMasUid   ;
	private String ordNo       ;
	private String docUid      ;
	private String beStuCd     ;
	private String beStuDtl    ;
	private String stuCd       ;
	private String stuDtl      ;
	private String docJsonData ;
	private String masJsonData ;

	private List<StuLogDTO> list;

	public String getChangeUid() {
		return changeUid;
	}

	public void setChangeUid(String changeUid) {
		this.changeUid = changeUid;
	}

	public String getSolMasUid() {
		return solMasUid;
	}

	public void setSolMasUid(String solMasUid) {
		this.solMasUid = solMasUid;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public String getDocUid() {
		return docUid;
	}

	public void setDocUid(String docUid) {
		this.docUid = docUid;
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

	public String getDocJsonData() {
		return docJsonData;
	}

	public void setDocJsonData(String docJsonData) {
		this.docJsonData = docJsonData;
	}

	public String getMasJsonData() {
		return masJsonData;
	}

	public void setMasJsonData(String masJsonData) {
		this.masJsonData = masJsonData;
	}

	public List<StuLogDTO> getList() {
		return list;
	}

	public void setList(List<StuLogDTO> list) {
		this.list = list;
	}



}
