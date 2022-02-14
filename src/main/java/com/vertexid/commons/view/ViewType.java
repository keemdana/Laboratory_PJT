/*
 * @(#)ViewType.java     2019-12-13 오후 5:01
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

/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public enum ViewType {
    JSON_VIEW("jsonView"),
    CSV_VIEW("csvView");

    private final String viewId;

    ViewType(String viewId){
        this.viewId = viewId;
    }

    public String getViewId(){
        return viewId;
    }
}
