/*
 * @(#)navbar.js     20. 6. 26. 오전 10:25
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

(function(){
    "use strict";

    console.info('[Loading: navbar]................................');

    var MODULE_NAME = "navbar";

    // TOP
    // login info display
    var setLoginInfo = function(){
        $("#loginNm").text("Test User");
    };

    // left toggle event



    var init = function(){
        setLoginInfo();
        //toggleLeftMenu();
    };

    init();
})();
