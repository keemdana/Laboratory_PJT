/*
 * @(#)RSACryptographicUtil.java     2019-12-17 오후 1:28
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
package com.vertexid.commons.crypto;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * TODO 작업중
 * <b>Description</b>
 * <pre>
 *     RSA 암호화 유틸
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class RSACryptographicUtil {

    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * RSA 키 생성
     *
     * @return
     */
    /*public Map<K, V> genRsaKeys() {

        try {
            KeyPairGenerator generator = KeyPairGenerator.getInstance(RSA);

            // key size
            int keySize = 1024;
            generator.initialize(keySize);

            KeyPair keyPair = generator.generateKeyPair();

            // 개인키
            PrivateKey privateKey = keyPair.getPrivate();

            // 공개키
            PublicKey publicKey = keyPair.getPublic();

            // 공개키 String으로 변환
            KeyFactory keyFactory = KeyFactory.getInstance(RSA);
            RSAPublicKeySpec publicKeySpec = keyFactory
                    .getKeySpec(publicKey, RSAPublicKeySpec.class);
            // 공개키 정수부
            String pubKeyMod = publicKeySpec.getModulus().toString(16);
            // 공개키 지수부
            String pubKeyExp = publicKeySpec.getPublicExponent().toString(16);

//            return new RSAKeyVO(privateKey, publicKey, pubKeyMod, pubKeyExp);

        } catch (NoSuchAlgorithmException e) {
            log.error("NoSuchAlgorithmException.....................\n" + e);
        } catch (InvalidKeySpecException e) {
            log.error("InvalidKeySpecException.....................\n" + e);
        }

        return null;
    }*/
}
