/*
 * @(#)PwdChangeDTO.java     2021-12-01(001) 오후 3:51
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
package com.vertexid.viself.hr;

import com.vertexid.viself.base.CmmDTO;

/**
 * <b>Description</b>
 * <pre>
 *     비밀번호 변경 DTO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class PwdChangeDTO extends CmmDTO {
    private static final long serialVersionUID = -1544281389520877124L;

    /** 비밀번호를 변경할 사용자 아이디 */
    private String userId;
    /** 기존 비밀번호 */
    private String oldPwd;
    /** 신규 비밀번호 */
    private String newPwd;
    /** 확인 비밀번호 */
    private String cfmPwd;
    /** DB에 저장될 단방향 암호화된 비밀번호 */
    private String encPwd;

    public PwdChangeDTO() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOldPwd() {
        return oldPwd;
    }

    public void setOldPwd(String oldPwd) {
        this.oldPwd = oldPwd;
    }

    public String getNewPwd() {
        return newPwd;
    }

    public void setNewPwd(String newPwd) {
        this.newPwd = newPwd;
    }

    public String getCfmPwd() {
        return cfmPwd;
    }

    public void setCfmPwd(String cfmPwd) {
        this.cfmPwd = cfmPwd;
    }

    public String getEncPwd() {
        return encPwd;
    }

    public void setEncPwd(String encPwd) {
        this.encPwd = encPwd;
    }
}
