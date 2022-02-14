/*
 * @(#)BaseSvc.java     2018-02-17 오전 7:44
 *
 * Copyright 2018 Yang, Ki Hwa
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.vertexid.viself.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <b>Description</b>
 * 기본서비스
 * [참고]신현삼(Shin, Hyeon Sam)[mong32@gmail.com]의 EISF BaseSvc를 참고
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseSvc {

    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    public static final String ERROR_RESULT = MessageCode.ERROR.getResultCode();

}
