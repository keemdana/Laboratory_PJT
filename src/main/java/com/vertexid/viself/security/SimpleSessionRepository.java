/*
 * @(#)SimpleSessionRepository.java     2021-01-22(022) 오전 9:03
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.Hashtable;

/**
 * <b>Description</b>
 * <pre>
 *     사용자 세션저장소
 *     동접관리 등으로 사용
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Repository
public class SimpleSessionRepository {
    private static final String SIMPLE_PRINCIPAL = "SIMPLE_PRINCIPAL";
    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    private static SimpleSessionRepository instance =
            new SimpleSessionRepository();
    private static Hashtable<String, Object> repositoryTable =
            new Hashtable<String, Object>();

    private SimpleSessionRepository() {
    }

    public static SimpleSessionRepository getInstance() {
        if (null == instance) {
            instance = new SimpleSessionRepository();
            repositoryTable = new Hashtable<String, Object>();
        }
        return instance;
    }

    /**
     * 해당 세션정보가 존재하지 않는가
     *
     * @param sessionId 세션아이디 혹은 저장된 키
     * @return true: 존재하지 않음, other: 존재함
     */
    public boolean isNotExist(String sessionId) {
        return !isExist(sessionId);
    }

    /**
     * 해당 세션정보가 존재하는가
     *
     * @param sessionId 세션아이디 혹은 저장된 키
     * @return true: 존재함, other: 존재하지 않음
     */
    private boolean isExist(String sessionId) {
        return repositoryTable.containsKey(sessionId);
    }

    public boolean isLogin(String loginId){
        Enumeration<String> enuKeys = repositoryTable.keys();
        while(enuKeys.hasMoreElements()){
            String key = enuKeys.nextElement();
            HttpSession session = getSession(key);
            if(session != null){
                BaseLoginDTO loginData = (BaseLoginDTO)session.getAttribute(SIMPLE_PRINCIPAL);
                if(loginData.getUsername().equals(loginId)){
                    return true;
                }
            }
        }
        return false;
    }

    private HttpSession getSession(String key) {
        return (HttpSession)repositoryTable.get(key);
    }


    /**
     * 세션정보 추가
     *
     * @param session 세션정보
     */
    public void add(HttpSession session) {
        repositoryTable.put(session.getId(), session);

        log.debug("\n    add new session.............." + session.getId());
        log.debug("\n    now system sessions.........." + repositoryTable.toString());
        log.info("\n    now system sessions count...." + repositoryTable.size());
    }

    /**
     * 세션에서 로그인 정보를 가져옴
     * @param session 세션
     * @return 로그인 정보
     */
    public BaseLoginDTO getLoginVO(HttpSession session) {
        if(null == session){
            return null;
        }
        String sessionId = session.getId();
        HttpSession savedSession = (HttpSession) repositoryTable.get(sessionId);
        if (null == savedSession) {
            return null;
        }

        return (BaseLoginDTO) savedSession.getAttribute(SIMPLE_PRINCIPAL);
    }

    /**
     * 세션에 로그인 정보를 저장함
     * @param session 세션
     * @param loginDTO 로그인 정보
     */
    public void setLoginVO(HttpSession session, BaseLoginDTO loginDTO ){
        session.setAttribute(SIMPLE_PRINCIPAL, loginDTO);
        add(session);
    }

    /**
     * 해당 세션 삭제
     * @param id session id
     */
    public void removeSession(String id) {
        repositoryTable.remove(id);

        log.debug("\n    remove session.............." + id);
        log.info("\n    now system sessions count...." + repositoryTable.size());
    }
}
