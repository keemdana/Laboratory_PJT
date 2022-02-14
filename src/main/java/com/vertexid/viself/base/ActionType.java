/*
 * @(#)ActionType.java     2018-10-02 오후 7:01
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

import org.apache.commons.lang3.StringUtils;

/**
 * 조회액션 유형
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public enum ActionType {

    DATA("data"),
    LIST("list"),
    SELECT("select"),
    MODIFY("modify") ,
    UPDATE("update") ,
    INSERT("insert"),
    SAVE("save"),
	DELETE("delete");

    private final String actionId;

    ActionType(String actionId) {
        this.actionId = actionId;
    }

    public static ActionType findBy(String actionId) {

        for (ActionType action : values()) {
            if (StringUtils.equals(action.getActionId(), actionId) ||
                    StringUtils.containsIgnoreCase(actionId,
                            action.getActionId())) {
                return action;
            }
        }// end of for

        return null;
    }

    public String getActionId() {
        return actionId;
    }
}
