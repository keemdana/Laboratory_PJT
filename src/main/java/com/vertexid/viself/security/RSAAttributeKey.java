/*
 * @(#)RSAAttributeKey.java     2019-10-31 오후 6:09
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

package com.vertexid.viself.security;

/**
 * RSA 사용과 관련한 상수 Key
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class RSAAttributeKey {

    /**
     * RSA 개인키 : session용 attribute
     */
    public static final String PRIVATE_KEY = "__rsaPrivateKey__";

    /**
     * RSA 공개키 : session용 attribute
     */
    public static final String PUBLIC_KEY = "__rsaPublicKey__";

    /**
     * RSA 공개키 정수부 : request attribute
     */
    public static final String PUBLIC_KEY_MODULUS = "publicKeyModulus";

    /**
     * RSA 공개키 지수부 : request attribute
     */
    public static final String PUBLIC_KEY_EXPONENT = "publicKeyExponent";

    /**
     * RSA 암호화 parameter 리스트 : client form parameter
     */
    public static final String RSA_TARGET_PARAMETERS = "encParams";
}
