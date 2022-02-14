/*
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

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.vertexid.viself.base.BaseSvc;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwsHeader;
import io.jsonwebtoken.SignatureAlgorithm;

/**
 *
 * JWT: JSON Web Token
 *
 * [IETF RFC 7519]
 * - https://tools.ietf.org/html/rfc7519#section-4.1.3
 *
 * @author Yang, Ki Hwa
 *
 */
public class JWTSvc extends BaseSvc {

    public static final String SEPERATOR = ".";

    // make JWT

    // 1. make header
    // 2. make payload
    // 3. make signature

    // create token - encode
    public String ecode(){

        String jwt = null;

        String key = "";

        // header: 토큰헤더
        Map<String, Object> headers = new HashMap<String, Object>();
        // type: 토큰타입 - JWT고정
        headers.put(JwsHeader.TYPE, JwsHeader.JWT_TYPE);
        // algorithm: 해싱 알고리즘
        headers.put(JwsHeader.ALGORITHM, SignatureAlgorithm.HS256.getValue());

        // payloads: 내용
        Map<String, Object> payloads = new HashMap<String, Object>();
        Long expireTime = 1000 * 60l;
        Date now = new Date();
        now.setTime(now.getTime() + expireTime);

        // registered claims: 등록된 클레임(청구항목)
        // issuer: 토큰발급자
        payloads.put(Claims.ISSUER, "");
        // subject: 토큰제목
        payloads.put(Claims.SUBJECT, "");
        // audience: 토큰 대상자
        payloads.put(Claims.AUDIENCE, "");
        // expiration: 토큰 만료시간
        payloads.put(Claims.EXPIRATION, now);
        // not before: 토큰 활성시간
        payloads.put(Claims.NOT_BEFORE, now);
        // issued at: 토큰 발급시간
        payloads.put(Claims.ISSUED_AT, new Date());
        // jwt id: 토큰 아이디
        payloads.put(Claims.ID, "");

        // public claims: 공개 항목

        // private claims: 비공개 항목


        return jwt;
    }

    // verify token - decode



}
