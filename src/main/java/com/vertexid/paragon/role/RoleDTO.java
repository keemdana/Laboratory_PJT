package com.vertexid.paragon.role;

import com.vertexid.viself.base.CmmDTO;

public class RoleDTO extends CmmDTO{

/**
	 *
	 */
	private static final long serialVersionUID = -5694592101114440796L;

//	[SOL_MAS_UID] [char](32) COLLATE Korean_Wansung_CI_AS NOT NULL,  /* 솔루션 마스터 UUID */
//	[DOC_UID] [char](32) COLLATE Korean_Wansung_CI_AS,  /* 문서 UUID */
//	[ORD_NO] [int] NOT NULL,  /* 순서 번호 */
//	[ROLE_CD] [varchar](50) COLLATE Korean_Wansung_CI_AS NOT NULL,  /* 역할 코드 */
//	[ROLE_NM] [nvarchar](80) COLLATE Korean_Wansung_CI_AS,  /* 역할 명칭 */
//	[REL_NO] [varchar](50) COLLATE Korean_Wansung_CI_AS NOT NULL,  /* 사번 */
//	[REL_NM] [nvarchar](80) COLLATE Korean_Wansung_CI_AS,  /* 관련 명칭 */
//	[REG_DTE] [datetime],  /* 등록 일자 */
//	[REG_LOGIN_ID] [varchar](50) COLLATE Korean_Wansung_CI_AS,  /* 등록 로그인 ID */
//	[UPT_DTE] [datetime],  /* 수정 일자 */
//	[UPT_LOGIN_ID] [varchar](50) COLLATE Korean_Wansung_CI_AS,  /* 수정 로그인 ID */
//	[USE_YN] [varchar](1) COLLATE Korean_Wansung_CI_AS NOT NULL /* 사용 YN */

	private String solMasUid;
	private String docUid;
	private String ordNo;
	private String roleCd;
	private String roleNm;
	private String relNo;
	private String relNm;

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
	public String getRoleCd() {
		return roleCd;
	}
	public void setRoleCd(String roleCd) {
		this.roleCd = roleCd;
	}
	public String getRoleNm() {
		return roleNm;
	}
	public void setRoleNm(String roleNm) {
		this.roleNm = roleNm;
	}
	public String getRelNo() {
		return relNo;
	}
	public void setRelNo(String relNo) {
		this.relNo = relNo;
	}
	public String getRelNm() {
		return relNm;
	}
	public void setRelNm(String relNm) {
		this.relNm = relNm;
	}

}
