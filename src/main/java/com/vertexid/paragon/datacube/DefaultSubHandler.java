/*
 * @(#)DefaultSubHandler.java     2021-12-01(001) 오전 7:51
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

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class DefaultSubHandler extends BaseSubHandler implements SubHandler{
    @Override
    public String getSubHandlerType() {
        return null;
    }

    @Override
    public DataCubeDTO init(DataCubeDTO param) {
        return null;
    }

    @Override
    public void doWork(DataCubeDTO param) {

    }
}
