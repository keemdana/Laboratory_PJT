/*
 * @(#)BatchJobCollisionAvoidSvc.java     2021-07-13(013) 오후 5:15
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
import com.vertexid.viself.base.CmmDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * <b>Description</b>
 * <pre>
 *     Batch 작업 충돌 회피 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class BatchJobCollisionAvoidSvc extends BaseSvc {

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    private static final String NAMESPACE =
            "com.vertexid.viself.batch.CommonBatch";

    public int startJob(String batchJobType) {

        BatchJobDTO batchJobDTO = new BatchJobDTO();
        batchJobDTO.setJobName(batchJobType);

        cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertBatch"),
                batchJobDTO);

        log.info("BATCH_START........................"+batchJobDTO.toString());
        if(!"S".equals(batchJobDTO.getErrYn())){
            log.info(batchJobDTO.getErrMsg());
            return -1;
        }
        return 0;
    }

    public void endJob(String batchJobType) {
        BatchJobDTO batchJobDTO = new BatchJobDTO();
        batchJobDTO.setJobName(batchJobType);

        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteBatch"),
                batchJobDTO);
        log.info("BATCH_END.........................."+batchJobDTO.toString());
        if(!"S".equals(batchJobDTO.getErrYn())){
            log.warn(batchJobDTO.getErrMsg());
        }
    }
}
