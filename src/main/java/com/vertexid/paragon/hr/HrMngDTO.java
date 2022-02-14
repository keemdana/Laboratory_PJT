package com.vertexid.paragon.hr;

import org.apache.commons.lang3.StringUtils;

import com.vertexid.viself.base.CmmDTO;

public class HrMngDTO extends CmmDTO{

	/**
	 *
	 */
	private static final long serialVersionUID = 9034018451128260553L;

	private String page;
	private String rows;
	private String order;
	private String dspNmKo;
	private String nmKo;
	private String deptNmKo;
	private String useYn;
	private String authCd;
	private String deptCd;
	private String chiefYn;
	private String loginId;
	private String loginIds;
	private String deptCds;


	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getRows() {
		return rows;
	}
	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getDspNmKo() {
		return dspNmKo;
	}
	public void setDspNmKo(String dspNmKo) {
		this.dspNmKo = dspNmKo;
	}
	public String getNmKo() {
		return nmKo;
	}
	public void setNmKo(String nmKo) {
		this.nmKo = nmKo;
	}
	public String getDeptNmKo() {
		return deptNmKo;
	}
	public void setDeptNmKo(String deptNmKo) {
		this.deptNmKo = deptNmKo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getAuthCd() {
		return authCd;
	}
	public void setAuthCd(String authCd) {
		this.authCd = authCd;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String[] getLoginIds() {
		return StringUtils.split(loginIds,",");
	}
	public void setLoginIds(String loginIds) {
		this.loginIds = loginIds;
	}
	public String getDeptCd() {
		return deptCd;
	}
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}
	public String getChiefYn() {
		return chiefYn;
	}
	public void setChiefYn(String chiefYn) {
		this.chiefYn = chiefYn;
	}
	public String[] getDeptCds() {
		return StringUtils.split(deptCds,",");
	}
	public void setDeptCds(String deptCds) {
		this.deptCds = deptCds;
	}



}
