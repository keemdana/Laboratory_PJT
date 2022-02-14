/*
 * @(#)DocMasHandler.java     2021-06-30(030) 오후 3:15
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
package com.vertexid.paragon.datacube;

import com.vertexid.commons.utils.ParamMap;

import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 *     솔루션의 도메인(Document)을 처리하는 메인 핸들러
 *     
 *     From 강세원 DocMasHandler
 *     <small>Since 최운수, 이성종, 홍성식 DocMasHandler</small>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface DocMasHandler {

    /**
     * Doc Mas Handler 유형 얻기
     * @return dos mas handler 유형
     */
    String getDocMasHandlerType();

    /**
     * 어플리케이션 DMC를 통해서 관련 데이터의 초기정보를 등록한다.
     * @param params parameters
     * @return data cube info
     */
    DataCubeDTO init(DataCubeDTO params);

    /**
     * 어플리케이션 DMC 를 통한 업무 처리
     * @param params parameters
     */
    void doWork(DataCubeDTO params);

    /**
     * 어플리케이션 DMC 를 통한 메시지 전송 처리
     * @param params parameters
     * @return 전송 메시지 리스트
     */
    List<Object> sendMessage(ParamMap<String, Object> params);
}
