package com.vertexid.paragon.aprv;

import com.vertexid.viself.base.CmmDTO;

public class AprvMasDTO extends CmmDTO{


	/**
	 *
	 */
	private static final long serialVersionUID = 7779181708066572104L;

	private String aprNo;
	private String solMasUid;
	private String docUid;
	private String aprMasStu;
	private String aprEdLoginId;
	private String aprEdDte;
	private String regLoginId;
	private String uptLoginId;

	public String getAprNo() {
		return aprNo;
	}
	public void setAprNo(String aprNo) {
		this.aprNo = aprNo;
	}
	public String getSolMasUid() {
		return solMasUid;
	}
	public void setSolMasUid(String solMasUid) {
		this.solMasUid = solMasUid;
	}
	public String getDocUid() {
		return docUid;
	}
	public void setDocUid(String docUid) {
		this.docUid = docUid;
	}
	public String getAprMasStu() {
		return aprMasStu;
	}
	public void setAprMasStu(String aprMasStu) {
		this.aprMasStu = aprMasStu;
	}
	public String getAprEdLoginId() {
		return aprEdLoginId;
	}
	public void setAprEdLoginId(String aprEdLoginId) {
		this.aprEdLoginId = aprEdLoginId;
	}
	public String getAprEdDte() {
		return aprEdDte;
	}
	public void setAprEdDte(String aprEdDte) {
		this.aprEdDte = aprEdDte;
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


}
