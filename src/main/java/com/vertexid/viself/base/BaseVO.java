/*
 * @(#)BaseVO.java     2018-02-17 오전 7:44
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

package com.vertexid.viself.base;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vertexid.spring.utils.BaseProperties;

/**
 * 기본 VO
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseVO implements Serializable {

    private static final long serialVersionUID = -1398234279327888316L;

    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    private String toStringStyleStr;

    public BaseVO() {
        this.toStringStyleStr = BaseProperties.get("cmm.vo.toString.style",
                ToStringStyleConstant.DEFAULT_STYLE);
    }

    /**
     * to String Style 상수
     */
    public static class ToStringStyleConstant {
        public static final String DEFAULT_STYLE = "DEFAULT_STYLE";
        public static final String MULTI_LINE_STYLE = "MULTI_LINE_STYLE";
        public static final String NO_FIELD_NAMES_STYLE =
                "NO_FIELD_NAMES_STYLE";
        public static final String SHORT_PREFIX_STYLE = "SHORT_PREFIX_STYLE";
        public static final String SIMPLE_STYLE = "SIMPLE_STYLE";
        public static final String NO_CLASS_NAME_STYLE = "NO_CLASS_NAME_STYLE";
        public static final String JSON_STYLE = "JSON_STYLE";
    }

    public String getToStringStyleStr() {
        return toStringStyleStr;
    }

    public void setToStringStyleStr(String toStringStyleStr) {
        this.toStringStyleStr = toStringStyleStr;
    }

    /**
     * To String
     *
     * @return 기본 스타일로 내용 보여짐
     */
    public String toString() {

        ToStringStyle toStringStyle;
        if (ToStringStyleConstant.MULTI_LINE_STYLE.equals(toStringStyleStr)) {
            toStringStyle = ToStringStyle.MULTI_LINE_STYLE;
        } else if (ToStringStyleConstant.SHORT_PREFIX_STYLE
                .equals(toStringStyleStr)) {
            toStringStyle = ToStringStyle.SHORT_PREFIX_STYLE;
        } else if (ToStringStyleConstant.JSON_STYLE.equals(toStringStyleStr)) {
            toStringStyle = ToStringStyle.JSON_STYLE;
        } else if (ToStringStyleConstant.NO_CLASS_NAME_STYLE
                .equals(toStringStyleStr)) {
            toStringStyle = ToStringStyle.NO_CLASS_NAME_STYLE;
        } else if (ToStringStyleConstant.NO_FIELD_NAMES_STYLE
                .equals(toStringStyleStr)) {
            toStringStyle = ToStringStyle.NO_FIELD_NAMES_STYLE;
        } else if (ToStringStyleConstant.SIMPLE_STYLE
                .equals(toStringStyleStr)) {
            toStringStyle = ToStringStyle.SIMPLE_STYLE;
        } else {
            toStringStyle = ToStringStyle.DEFAULT_STYLE;
        }

//        log.debug("toStringStyleStr...." + toStringStyleStr);

        return ToStringBuilder.reflectionToString(this, toStringStyle);
    }
}
