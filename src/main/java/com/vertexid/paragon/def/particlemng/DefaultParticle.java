/*
 * @(#)DefaultParticle.java     2021-12-01(001) 오후 4:05
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
package com.vertexid.paragon.def.particlemng;

import com.vertexid.commons.utils.ParamMap;
import org.springframework.stereotype.Component;

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class DefaultParticle implements BeanInterfaceParticle{
    @Override
    public String getParticleType() {
        return null;
    }

    @Override
    public void particleExecuteQuery(ParamMap<String, Object> params,
            String mode) {

    }
}
