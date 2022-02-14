package com.vertexid.paragon.aprv;

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

public class AprvLineDTO extends CmmDTO{

	/**
	 *
	 */
	private static final long serialVersionUID = -6725579716662020968L;
	private String aprLineUid;
	private String aprNo;
	private String solMasUid;
	private String docUid;
	private String ordNo;
	private String aprTp;
	private String nAprStu;
	private String aprStu;
	private String aprDeptCd;
	private String aprDeptNm;
	private String aprPosCd;
	private String aprPosLangCd;	
	private String aprDutyCd;
	private String aprDutyLangCd;	
	private String nAprLoginId;
	private String aprLoginId;
	private String aprUserNm;
	private String realAprLoginId;
	private String realAprLoginNm;
	private String aprDte;
	private String aprMemo;
	private List<AprvLineDTO> list;

	public String getAprLineUid() {
		return aprLineUid;
	}
	public void setAprLineUid(String aprLineUid) {
		this.aprLineUid = aprLineUid;
	}
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
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getAprTp() {
		return aprTp;
	}
	public void setAprTp(String aprTp) {
		this.aprTp = aprTp;
	}
	public String getnAprStu() {
		return nAprStu;
	}
	public void setnAprStu(String nAprStu) {
		this.nAprStu = nAprStu;
	}
	public String getAprStu() {
		return aprStu;
	}
	public void setAprStu(String aprStu) {
		this.aprStu = aprStu;
	}
	public String getAprDeptCd() {
		return aprDeptCd;
	}
	public void setAprDeptCd(String aprDeptCd) {
		this.aprDeptCd = aprDeptCd;
	}
	public String getAprDeptNm() {
		return aprDeptNm;
	}
	public void setAprDeptNm(String aprDeptNm) {
		this.aprDeptNm = aprDeptNm;
	}
	public String getAprPosCd() {
		return aprPosCd;
	}
	public void setAprPosCd(String aprPosCd) {
		this.aprPosCd = aprPosCd;
	}
	public String getAprPosLangCd() {
		return aprPosLangCd;
	}
	public void setAprPosLangCd(String aprPosLangCd) {
		this.aprPosLangCd = aprPosLangCd;
	}	
	public String getAprDutyCd() {
		return aprDutyCd;
	}
	public void setAprDutyCd(String aprDutyCd) {
		this.aprDutyCd = aprDutyCd;
	}
	public String getAprDutyLangCd() {
		return aprDutyLangCd;
	}
	public void setAprDutyLangCd(String aprDutyLangCd) {
		this.aprDutyLangCd = aprDutyLangCd;
	}	
	public String getnAprLoginId() {
		return nAprLoginId;
	}
	public void setnAprLoginId(String nAprLoginId) {
		this.nAprLoginId = nAprLoginId;
	}
	public String getAprLoginId() {
		return aprLoginId;
	}
	public void setAprLoginId(String aprLoginId) {
		this.aprLoginId = aprLoginId;
	}
	public String getAprUserNm() {
		return aprUserNm;
	}
	public void setAprUserNm(String aprUserNm) {
		this.aprUserNm = aprUserNm;
	}
	public String getRealAprLoginId() {
		return realAprLoginId;
	}
	public void setRealAprLoginId(String realAprLoginId) {
		this.realAprLoginId = realAprLoginId;
	}
	public String getRealAprLoginNm() {
		return realAprLoginNm;
	}
	public void setRealAprLoginNm(String realAprLoginNm) {
		this.realAprLoginNm = realAprLoginNm;
	}
	public String getAprDte() {
		return aprDte;
	}
	public void setAprDte(String aprDte) {
		this.aprDte = aprDte;
	}
	public String getAprMemo() {
		return aprMemo;
	}
	public void setAprMemo(String aprMemo) {
		this.aprMemo = aprMemo;
	}
	public List<AprvLineDTO> getList() {
		return list;
	}
	public void setList(List<AprvLineDTO> list) {
		this.list = list;
	}

}
