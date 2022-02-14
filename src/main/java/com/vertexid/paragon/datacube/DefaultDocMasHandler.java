/*
 * @(#)DefaultDocMasHandler.java     2021-12-01(001) 오전 7:52
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
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class DefaultDocMasHandler extends BaseDocMasHandler implements DocMasHandler{
    @Override
    public String getDocMasHandlerType() {
        return null;
    }

    @Override
    public DataCubeDTO init(DataCubeDTO params) {
        return null;
    }

    @Override
    public void doWork(DataCubeDTO params) {

    }

    @Override
    public List<Object> sendMessage(ParamMap<String, Object> params) {
        return null;
    }
}
