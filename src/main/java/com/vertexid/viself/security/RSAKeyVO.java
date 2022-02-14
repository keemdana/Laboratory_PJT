/*
 * @(#)RSAKeyVO.java     2019-10-31 오후 6:09
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

import java.security.PrivateKey;
import java.security.PublicKey;

import com.vertexid.viself.base.BaseVO;

/**
 * RSA key VO
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class RSAKeyVO extends BaseVO {

    private static final long serialVersionUID = -5961833516457076962L;

    /** 개인키 */
    private final PrivateKey privateKey;

    /** 공개키 */
    private final PublicKey publicKey;

    /** 공개키 정수부 */
    private final String publicKeyModulus;

    /** 공개키 지수부 */
    private final String publicKeyExponent;

    public RSAKeyVO(final PrivateKey privateKey, final PublicKey publicKey,
            final String publicKeyModulus, final String publicKeyExponent) {
        this.privateKey = privateKey;
        this.publicKey = publicKey;
        this.publicKeyModulus = publicKeyModulus;
        this.publicKeyExponent = publicKeyExponent;
    }

    public PrivateKey getPrivateKey() {
        return privateKey;
    }

    public PublicKey getPublicKey() {
        return publicKey;
    }

    public String getPublicKeyModulus() {
        return publicKeyModulus;
    }

    public String getPublicKeyExponent() {
        return publicKeyExponent;
    }

}
