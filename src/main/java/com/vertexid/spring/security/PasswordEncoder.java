/*
 * @(#)PasswordEncoder.java     2019-12-13 오후 4:58
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
package com.vertexid.spring.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.security.SecureRandom;

/**
 * <b>Description</b>
 * <pre>
 *     패스워드 암호화 처리
 *     신현삼(Shin, Hyeon Sam)[mong32@gmail.com]의 EISF3에 EisfBCryptPasswordEncoder를 참고하여 작성
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class PasswordEncoder extends BCryptPasswordEncoder {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    public PasswordEncoder() {
        super();
    }

    public PasswordEncoder(int strength) {
        super(strength);
    }

    public PasswordEncoder(int strength, SecureRandom random) {
        super(strength, random);
    }

    @Override
    public String encode(CharSequence rawPassword) {

        // DEBUG
        if (log.isDebugEnabled()){
            log.debug("INPUT PASSWORD : " + rawPassword);
        }

        String encPassword = super.encode(rawPassword);

        // DEBUG
        if (log.isDebugEnabled()){
            log.debug("ENCODED HASH : " + encPassword);
        }

        return encPassword;
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        boolean rtn = super.matches(rawPassword, encodedPassword);

        // DEBUG
        if (log.isDebugEnabled()){
            log.debug("rawPassword ...................["+rawPassword+']');
            log.debug("encodedPassword ...............["+encodedPassword+']');
            log.debug("matches .......................["+rtn+']');
        }

        return rtn;
    }
}
