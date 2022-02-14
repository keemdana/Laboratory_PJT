/*
 * @(#)SubHandlerFactory.java     2021-06-30(030) 오후 3:53
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
 *     sub handler factory
 *
 *     From 강세원
 *     <small>Since 최운수, 이성종, 홍성식</small>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class SubHandlerFactory {

    @Resource
    private List<SubHandler> subHandlerList;

    /**
     * sub handler type 으로 sub handler 반환
     * @param subHandlerType sub handler type
     * @return sub handler
     */
    public SubHandler getSubHandler(String subHandlerType){
        for(SubHandler subHandler: subHandlerList){
            if(subHandlerType.equalsIgnoreCase(subHandler.getSubHandlerType())){
                return subHandler;
            }
        }// end of for

        return null;
    }
}
