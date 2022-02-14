/*
 * @(#)StuPartiRelDTO.java     2020-12-29(024) 오전 8:23
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */
package com.vertexid.paragon.def.defstumng;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     상태관련 파티클 DTO
 * </pre>
 *
 * @author 강세원
 */
public class DefStuGroupDTO extends CmmDTO {


	private static final long serialVersionUID = -9087716893485330014L;

	private String stuGroupUid;
	private String stuGroup;
	private String stuCd;
	private String stuDtl;

    public DefStuGroupDTO() {
    }

	public String getStuGroupUid() {
		return stuGroupUid;
	}

	public void setStuGroupUid(String stuGroupUid) {
		this.stuGroupUid = stuGroupUid;
	}

	public String getStuGroup() {
		return stuGroup;
	}

	public void setStuGroup(String stuGroup) {
		this.stuGroup = stuGroup;
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


}
