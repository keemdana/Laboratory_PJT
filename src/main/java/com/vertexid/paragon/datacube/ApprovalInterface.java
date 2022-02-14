/*
 * @(#)ApprovalInterface.java     2021-07-16(016) 오후 4:10
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
 *     결재 인터페이스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public interface ApprovalInterface {

    String getApprovalInterfaceType();

    void doWork(Object param);
}
