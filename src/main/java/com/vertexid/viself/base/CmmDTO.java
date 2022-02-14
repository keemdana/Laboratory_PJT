/*
 * @(#)CmmDTO.java     2019-11-19 오후 5:52
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

package com.vertexid.viself.base;

import com.vertexid.spring.utils.SessionUtils;

/**
 * 공용 DTO
 * @author Yang, Ki Hwa
 */
public class CmmDTO extends BaseVO{
    private static final long serialVersionUID = 9070205907361546283L;

    /**
     * Create, Update, Delete flag
     */
    private String cud;

    /**
     * Error Y/N flag
     */
    private String errYn;

    /**
     * Error code
     */
    private String errCd;

    /**
     * Error message
     */
    private String errMsg;

    private Object loginInfo;

    /**
     * CUD(Transaction) 유형
     * @author Yang, Ki Hwa
     */
    public static class CudType {
        /**
         * create type
         */
        public static final String CREATE = "C";

        /**
         * update type
         */
        public static final String UPDATE = "U";

        /**
         * delete type
         */
        public static final String DELETE = "D";
    }

    public CmmDTO() {
    }

    public String getCud() {
        return cud;
    }

    public void setCud(String cud) {
        this.cud = cud;
    }

    public String getErrYn() {
        return errYn;
    }

    public void setErrYn(String errYn) {
        this.errYn = errYn;
    }

    public String getErrCd() {
        return errCd;
    }

    public void setErrCd(String errCd) {
        this.errCd = errCd;
    }

    public String getErrMsg() {
        return errMsg;
    }

    public void setErrMsg(String errMsg) {
        this.errMsg = errMsg;
    }

    public Object getLoginInfo() {

        if(null == loginInfo){
            loginInfo = SessionUtils.getLoginVO();
        }
        return loginInfo;
    }
}
