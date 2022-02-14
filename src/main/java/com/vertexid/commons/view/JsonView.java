/*
 * @(#)JsonView.java     2019-12-13 오후 5:00
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
package com.vertexid.commons.view;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

/**
 * <b>Description</b>
 * <pre>
 *     JSON View 처리
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class JsonView extends MappingJackson2JsonView {

    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

//    MappingJackson2HttpMessageConverter v;
}
