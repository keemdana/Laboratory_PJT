/*
 * @(#)SystemOperationType.java     2020-04-23 오후 4:41
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

/**
 * <b>Description</b>
 *
 * @author Yang, Ki Hwa
 */
public enum SystemOperationType {
    LOCAL("LOCAL", "(개발자 개인)개발 운영", "Indivisual Development Mode"),
    DEV("DEV", "(공용)개발 운영", "Development Mode"),
    QAS("QAS", "품질 운영", "Quality Assurance Service Mode"),
    TEST("TEST", "테스트 운영", "Test Mode"),
    EDU("EDU", "교육 운영", "Education Service Mode"),
    PROD("PROD", "서비스 운영", "Biz Operation Mode");

    private final String typeCode;
    private final String typeKoName;
    private final String typeEngName;

    SystemOperationType(String typeCode, String typeKoName,
            String typeEngName) {
        this.typeCode = typeCode;
        this.typeKoName = typeKoName;
        this.typeEngName = typeEngName;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public String getTypeKoName() {
        return typeKoName;
    }

    public String getTypeEngName() {
        return typeEngName;
    }
}
