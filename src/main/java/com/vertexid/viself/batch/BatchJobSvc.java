/*
 * @(#)BatchJobSvc.java     2021-07-13(013) 오후 4:58
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
package com.vertexid.viself.batch;

/**
 * <b>Description</b>
 * <pre>
 *     Batch 작업을 수행하는 Service I/F
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface BatchJobSvc {

    /**
     * Batch 작업 유형 얻기
     *
     * @return Batch job type
     */
    String getBatchJobType();

    /**
     * Batch 작업 수행
     */
    void execBatchJob();
}
