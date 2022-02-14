/*
 * @(#)BaseBtchJobSvc.java     2021-07-13(013) 오후 5:03
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

import com.vertexid.viself.base.BaseSvc;
import org.apache.commons.lang3.BooleanUtils;
import org.springframework.beans.factory.annotation.Value;

/**
 * <b>Description</b>
 * <pre>
 *     Batch 작업을 수행하는 기본 Batch 작업 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public abstract class BaseBtchJobSvc extends BaseSvc implements BatchJobSvc {

    @Value(value = "#{cmmProperties['batch.yn']}")
    private String batchJobYn;

    /**
     * Batch 작업 수행여부 얻기
     * @return string 으로된 Batch 작업 수행여부
     */
    public String getBatchJobYn() {
        return batchJobYn;
    }

    /**
     * Batch 작업 수행여부
     * @return true: 수행, other: 수행하지 않음
     */
    public boolean isBatchJobFlag() {
        try{
            return BooleanUtils.toBooleanObject(this.batchJobYn);
        }catch (Exception e){
            return false;
        }
    }

    /**
     * Batch 작업 비수행여부
     * @return true: 수행하지 않음, other: 수행
     */
    public boolean isNotBatchJobFlag(){
        return !isBatchJobFlag();
    }
}
