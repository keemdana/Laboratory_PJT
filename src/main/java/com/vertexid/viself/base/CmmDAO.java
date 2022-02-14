/*
 * @(#)CmmDAO.java     2018-10-02 오후 7:01
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

import java.util.List;

import com.vertexid.mybatis.MyBatisBaseDAO;
import com.vertexid.mybatis.MyBatisDAOFunction;

/**
 * <b>Description</b>
 * <pre>
 *     공용 DAO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class CmmDAO extends MyBatisBaseDAO {

    private MyBatisDAOFunction myBatis;

    public void setMyBatis(MyBatisDAOFunction myBatis) {
        this.myBatis = myBatis;
    }

    public <T> T getOne(BaseModelVO modelVO, Object params) {
        return myBatis.select(getStatement(modelVO), params);
    }

    public <T> T getOne(String statement, Object params) {
        return myBatis.select(statement, params);
    }

    public <E> List<E> getList(BaseModelVO modelVO,
                               Object params) {
        return myBatis.selectList(getStatement(modelVO), params);
    }

    public <E> List<E> getList(String statement,
                               Object params) {
        return myBatis.selectList(statement, params);
    }

    public int insert(BaseModelVO modelVO, Object params) {
        return myBatis.insert(getStatement(modelVO), params);
    }

    public int insert(String statement, Object params) {
        return myBatis.insert(statement, params);
    }

    public int update(BaseModelVO modelVO, Object params) {
        return myBatis.update(getStatement(modelVO), params);
    }

    public int update(String statement, Object params) {
        return myBatis.update(statement, params);
    }

    public int delete(BaseModelVO modelVO, Object params) {
        return myBatis.delete(getStatement(modelVO), params);
    }
    public int delete(String statement, Object params) {
        return myBatis.delete(statement, params);
    }


}
