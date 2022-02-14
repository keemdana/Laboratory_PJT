/*
 * @(#)TimestampTypeHandler.java     2021-10-08(008) 오후 1:28
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
package com.vertexid.mybatis;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.StringTypeHandler;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * <b>Description</b>
 * <pre>
 *     Mybatis 에서 조회된 jdbcType=TIMESTAMP 를 , javaType=java.lang.Object 으로 변환하기 위한 TypeHandler
 *     - 신현삼(Shin, Hyeon Sam)<mong32@gmail.com> 의 EISF3에 EisfDateToStringAccordingToPropsTypeHandler을 참고하여 작성
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class TimestampTypeHandler extends StringTypeHandler {
    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

    private String dateFormat = DEFAULT_DATE_FORMAT;

    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i,
            String parameter, JdbcType jdbcType) throws SQLException {
        ps.setString(i, parameter);
    }

    @Override
    public String getNullableResult(ResultSet rs, String columnName)
            throws SQLException {
        DateTime dt = new DateTime(rs.getDate(columnName));
        return dt.toString(dateFormat);
    }

    @Override
    public String getNullableResult(ResultSet rs, int columnIndex)
            throws SQLException {
        DateTime dt = new DateTime(rs.getDate(columnIndex));
        return dt.toString(dateFormat);
    }

    @Override
    public String getNullableResult(CallableStatement cs, int columnIndex)
            throws SQLException {
        DateTime dt = new DateTime(cs.getDate(columnIndex));
        return dt.toString(dateFormat);
    }
}
