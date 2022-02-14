/*
 * @(#)ApprovalInterfaceFactory.java     2021-07-16(016) 오후 4:12
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

import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 *     결재 인터페이스 팩토리
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class ApprovalInterfaceFactory {

    @Resource
    private List<ApprovalInterface> approvalInterfaceList;

    public ApprovalInterface getApprovalInterface(String approvalInterfaceType){
        for(ApprovalInterface approvalInterface: approvalInterfaceList){
            if(approvalInterfaceType.equals(approvalInterface.getApprovalInterfaceType())){
                return approvalInterface;
            }
        }
        return null;
    }
}
