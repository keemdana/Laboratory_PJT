/*
 * @(#)jquery.js     2020-02-21 오후 2:04
 *
 * Copyright 2020 JAYU.space
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

// import JQuery
//import JaYu from "../Config";

/**
 * form 초기화 (hidden 포함)
 * https://gracefullight.dev/2016/12/26/form-reset-%EC%9D%98-input-hidden-%EC%B4%88%EA%B8%B0%ED%99%94-%EB%AC%B8%EC%A0%9C/
 * @returns {*}
 */
$.fn.clearForm = function () {
    return this.each(function () {
        var type = this.type,
            tag = this.tagName.toLowerCase();
        if (tag === 'form') {
            return $(':input', this).clearForm();
        }
        if (
            type === 'text' ||
            type === 'password' ||
            type === 'hidden' ||
            tag === 'textarea'
        ) {
            this.value = '';
        } else if (type === 'checkbox' || type === 'radio') {
            this.checked = false;
        } else if (tag === 'select') {
            this.selectedIndex = -1;
        }
    });
};

/**
 * JQuery CSRF Token 처리
 */
$(function () {

    // ajax CSRF Token 처리
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    var customHeader = "JaYu";
    var customAjaxValue = "YeoYu";

    $(document).ajaxSend(function (e, xhr, options) {
        if(header && header != ""){
            xhr.setRequestHeader(header, token);
        }
        xhr.setRequestHeader(customHeader, customAjaxValue);
    });

    // ajax session/CSRF missing 처리
    $(document).ajaxSuccess(function(e, xhr, options, data){
        var principal = $("meta[name='_principal_header']").attr("content");

        // console.info(xhr.responseText);
        var resTxt = xhr.responseText;
        if(resTxt.indexOf("ACCESS_DENY") !== -1 || resTxt.indexOf("MISSING_YN") != -1){
            var chk = JSON.parse(xhr.responseText);
            if(chk.ACCESS_DENY || chk.MISSING_YN){

                console.info("chk.ACCESS_DENY..."+chk.ACCESS_DENY);
                console.info("chk.MISSING_YN..."+chk.MISSING_YN);
                console.info("principal...["+principal+"]");
                console.info(typeof principal);

                if(principal !== ""){
                    console.log("principal is not empty!!");
                    alert("Your session has expired.\n Please log in again");
                }

                console.info("access deny or missing token");
                // 접근금지, 세션종료, CSRF Token Missing
                //location.reload();
                return false;
            }
        }
    });

}());

/**
 * jquery serialize 를 json 형태로 반환
 * 출처: https://cofs.tistory.com/184 [CofS]
 * @returns {*}
 */
jQuery.fn.serializeObject = function () {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function () {
                    obj[this.name] = this.value;
                });
            }//if ( arr ) {
        }
    } catch (e) {
        alert(e.message);
    } finally {
    }

    return obj;
};
