/*
 * @(#)UserDTO.java     2019-11-19 오후 5:52
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

import java.util.List;

import com.vertexid.viself.base.CmmDTO;

/**
 * 사용자 DTO
 * @author 양기화(梁起華: Yang, Ki Hwa)
 */
public class UserDTO extends CmmDTO {
    private static final long serialVersionUID = 4635589865784563353L;

    /**
     * 사용자 아이디
     */
    private String userId;

    /**
     * 사용자 이름
     */
    private String userNm;

    /**
     * 사용자유형
     */
    private String userTpCd;

    /**
     * 사용자 사용여부
     */
    private String useEnable;

    private String userPwd;

    private String tempPwd;

    private List<UserDTO> list;

    public UserDTO() {
    }

    public UserDTO(String userId, String userNm) {
        this.userId = userId;
        this.userNm = userNm;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getUserTpCd() {
        return userTpCd;
    }

    public void setUserTpCd(String userTpCd) {
        this.userTpCd = userTpCd;
    }

    public String getUseEnable() {
        return useEnable;
    }

    public void setUseEnable(String useEnable) {
        this.useEnable = useEnable;
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }

    public String getTempPwd() {
        return tempPwd;
    }

    public void setTempPwd(String tempPwd) {
        this.tempPwd = tempPwd;
    }

    public List<UserDTO> getList() {
        return list;
    }

    public void setList(List<UserDTO> list) {
        this.list = list;
    }


}
