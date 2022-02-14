package com.vertexid.paragon.bbs;

import com.vertexid.viself.base.CmmDTO;

public class bbsMasDTO extends CmmDTO{

	/**
	 *
	 */
	private static final long serialVersionUID = -6844329018997663984L;

	private String bbsUid         ; /*법무DB 메인 키*/
	private String bbsTpCd        ; /*게시판 유형*/
	private String bbsTit         ; /*제목*/
	private String bbsContent     ; /*내용*/
	private String bbsHitCnt      ; /*조회수*/
	private String bbsRegLoginId  ; /*등록 로그인 ID*/
	private String bbsRegDte      ; /*등록 일자*/
	private String bbsUptLoginId  ; /*수정 로그인 ID*/
	private String bbsUptDte      ; /*수정 일자*/
	private String bbsUseYn       ; /*사용 YN*/
	private String bbsTopYn       ; /*상단고정 여부*/
	private String bbsPopupStDte  ; /*팝업시작기간*/
	private String bbsPopupEdDte  ; /*팝업종료기간*/

	private String bbsTpCdNm	  ;
	private String bbsRegLoginNm  ;
	private String bbsUptLoginNm  ;

	public String getBbsUid() {
		return bbsUid;
	}
	public void setBbsUid(String bbsUid) {
		this.bbsUid = bbsUid;
	}
	public String getBbsTpCd() {
		return bbsTpCd;
	}
	public void setBbsTpCd(String bbsTpCd) {
		this.bbsTpCd = bbsTpCd;
	}
	public String getBbsTit() {
		return bbsTit;
	}
	public void setBbsTit(String bbsTit) {
		this.bbsTit = bbsTit;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public String getBbsHitCnt() {
		return bbsHitCnt;
	}
	public void setBbsHitCnt(String bbsHitCnt) {
		this.bbsHitCnt = bbsHitCnt;
	}
	public String getBbsRegLoginId() {
		return bbsRegLoginId;
	}
	public void setBbsRegLoginId(String bbsRegLoginId) {
		this.bbsRegLoginId = bbsRegLoginId;
	}
	public String getBbsRegDte() {
		return bbsRegDte;
	}
	public void setBbsRegDte(String bbsRegDte) {
		this.bbsRegDte = bbsRegDte;
	}
	public String getBbsUptLoginId() {
		return bbsUptLoginId;
	}
	public void setBbsUptLoginId(String bbsUptLoginId) {
		this.bbsUptLoginId = bbsUptLoginId;
	}
	public String getBbsUptDte() {
		return bbsUptDte;
	}
	public void setBbsUptDte(String bbsUptDte) {
		this.bbsUptDte = bbsUptDte;
	}
	public String getBbsUseYn() {
		return bbsUseYn;
	}
	public void setBbsUseYn(String bbsUseYn) {
		this.bbsUseYn = bbsUseYn;
	}
	public String getBbsTopYn() {
		return bbsTopYn;
	}
	public void setBbsTopYn(String bbsTopYn) {
		this.bbsTopYn = bbsTopYn;
	}
	public String getBbsPopupStDte() {
		return bbsPopupStDte;
	}
	public void setBbsPopupStDte(String bbsPopupStDte) {
		this.bbsPopupStDte = bbsPopupStDte;
	}
	public String getBbsPopupEdDte() {
		return bbsPopupEdDte;
	}
	public void setBbsPopupEdDte(String bbsPopupEdDte) {
		this.bbsPopupEdDte = bbsPopupEdDte;
	}
	public String getBbsTpCdNm() {
		return bbsTpCdNm;
	}
	public void setBbsTpCdNm(String bbsTpCdNm) {
		this.bbsTpCdNm = bbsTpCdNm;
	}
	public String getBbsRegLoginNm() {
		return bbsRegLoginNm;
	}
	public void setBbsRegLoginNm(String bbsRegLoginNm) {
		this.bbsRegLoginNm = bbsRegLoginNm;
	}
	public String getBbsUptLoginNm() {
		return bbsUptLoginNm;
	}
	public void setBbsUptLoginNm(String bbsUptLoginNm) {
		this.bbsUptLoginNm = bbsUptLoginNm;
	}




}
