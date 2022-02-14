/*
 * @(#)ImsSubHandlerType.java     2021-06-30(030) 오후 3:58
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
package com.vertexid.paragon.def;

/**
 * 상태 상세코드 타입 유형
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public enum StuDtlType {

    /**
     * 임시저장
     */
    T("T"),
    /**
     * 검토후 결재요청
     */
    G("G"),
    /**
     * 결재 상신
     */
    F("F"),
    /**
     * 결재 중
     */
    I("I"),
    /**
     * 결재 반려
     */
    R("R"),
    /**
     * 최종결재 완료
     */
    A("A"),
    /**
     * 저장 및 상태변경
     */
    S("S"),
    /**
     * 상태만 변경
     */
    P("P");

    private final String stuDtlTypeCd;

    StuDtlType(String stuDtlTypeCd) {
        this.stuDtlTypeCd = stuDtlTypeCd;
    }

    public String getStuDtlTypeCd() {
        return stuDtlTypeCd;
    }
}
