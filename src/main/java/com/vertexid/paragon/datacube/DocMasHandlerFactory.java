/*
 * @(#)DocMasHandlerFactory.java     2021-06-30(030) 오후 3:28
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
 *     Doc mas handler Factory
 *
 *     From 강세원 DocMasHandlerFactory
 *     <small>Since 최운수, 이성종, 홍성식 DocMasHandlerFactory</small>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class DocMasHandlerFactory {

    @Resource
    private List<DocMasHandler> docMasHandlerList;

    /**
     * doc mas handler type 으로 doc mas handler 반환
     *
     * @param docMasHandlerType doc mas handler type
     * @return doc mas handler
     */
    public DocMasHandler getDocMasHandler(String docMasHandlerType) {
        for (DocMasHandler docMasHandler : docMasHandlerList) {
            if (docMasHandlerType
                    .equalsIgnoreCase(docMasHandler.getDocMasHandlerType())) {
                return docMasHandler;
            }
        }// end of for
        return null;
    }
}
