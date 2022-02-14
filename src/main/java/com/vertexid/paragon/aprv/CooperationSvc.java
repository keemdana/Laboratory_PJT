/*
 * @(#)CooperationSvc.java     2021-07-27(027) 오전 10:04
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
package com.vertexid.paragon.aprv;

import com.vertexid.commons.utils.StringUtil;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import org.joda.time.DateTime;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <b>Description</b>
 * <pre>
 *     협조처 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class CooperationSvc extends BaseSvc {

    private static final String NAMESPACE =
            "com.vertexid.paragon.aprv.Cooperation";

    @Resource
    private CmmDAO cmmDAO;

    /**
     * 협조처 마스터 저장
     *
     * @param param 파라메터
     * @return 협조처 마스터 번호
     */
    public String save(CooperationMasDTO param) {
        Map<String, Object> chkParam = new HashMap<>();
        chkParam.put("docUid", param.getDocUid());
        if (count(chkParam) > 0) {
            update(param);
        } else {
            param.setAprNo(makeAprNo());
            insert(param);
        }

        return param.getAprNo();
    }

    /**
     * 마스터 번호 생성
     *
     * @return 마스터 번호
     */
    public String makeAprNo() {
        DateTime dateTime = new DateTime();
        String today = dateTime.toString("yyyyMMddHHmmssSSSS").substring(0, 18);
        return today + StringUtil.getRandomUUID();
    }

    /**
     * 마스터 입력
     *
     * @param param 파라메터
     */
    private void insert(CooperationMasDTO param) {
        cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertMas"), param);
    }

    /**
     * 마스터 수정
     *
     * @param param 파라메터
     */
    private void update(CooperationMasDTO param) {
        cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateMas"), param);
    }

    /**
     * 마스터 데이터 카운트
     *
     * @param params 파라메터
     * @return 마스터 데이터 수
     */
    @Transactional(readOnly = true)
    public Integer count(Map<String, Object> params) {
        Map<String, Object> rtnData =
                cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "countMas"),
                        params);
        return Integer.valueOf(String.valueOf(rtnData.get("totCnt")));
    }

    /**
     * 상세 저장
     *
     * @param paramList 상세 데이터 리스트
     */
    public void saveDtl(List<CooperationDtlDTO> paramList) {

        // delete
        CooperationDtlDTO cooperationDtlDTO = paramList.get(0);
        deleteDtl(cooperationDtlDTO);

        // insert
        for (CooperationDtlDTO param : paramList) {
            cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertDtl"), param);
        }// end of for
    }

    /**
     * 상세데이터 삭제
     *
     * @param param 파라메터
     */
    private void deleteDtl(CooperationDtlDTO param) {
        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteDtl"), param);
    }
}
