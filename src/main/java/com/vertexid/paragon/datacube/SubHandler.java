/*
 * @(#)SubHandler.java     2021-06-30(030) 오후 3:49
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

/**
 * <b>Description</b>
 * <pre>
 *     각각의 세부 도메인 업무를 처리하는 핸들러
 *     
 *     From 강세원 SubHandler
 *     <small>Since 최운수, 이성종, 홍성식 SubHandler</small>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface SubHandler {

    /**
     * Sub Handler 유형 얻기
     * @return sub handler 유형
     */
    String getSubHandlerType();
    
    /**
     * 업무 핸들러를 통해서 UUID 생성, 초기 Data 입력등을 수행
     * 
     * @param param parameter
     * @return data cube info
     */
    DataCubeDTO init(DataCubeDTO param);

    /**
     * 업무 핸들러를 통해서 특화된 업무 처리
     * @param param parameter
     */
    void doWork(DataCubeDTO param);
}
