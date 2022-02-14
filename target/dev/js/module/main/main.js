/*
 * @(#)main.js     2021-04-07(031) 오후 12:30
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


var Main = function(){
    "use strict";
    var CONTEXT_PATH = "";

    var movePage = function(url, params){
        if(!url.endsWith(".include")){
            url = url+".include";
        }
        $("#contentBody").load(url,params,function(){
            paragonCmm.convertLang($("#contentBody"));
        })
    }

    /**
     * 비밀번호 변경
     */
    var openChangPwd = function(){

        // $("a.logout").get(0).click();

        var PW_CHANGE_MODAL_URL = "/ims/cmm/pwdChange.modal";

        // 1. callback function
        var cbFnc = function () {
            $dialog.dialog("close");
            // 변경이 성공했을 경우 로그아웃 한다.
            $("a.logout").get(0).click();
        };

        var $dialog = document.getElementById("chPwModal");


        // 3. 모달초기화
        var initModal = (function(){
            if (!$dialog) {
                var DIALOG_HTML = "<div id='chPwModal'/>"
                $("body").append(DIALOG_HTML);
            }
            $dialog = $("#chPwModal");
            $dialog.html("");
        })();

        // 4. 모달 오픈
        $dialog.dialog({
            iconCls: "fa fa-info-circle",
            title: "비밀번호 변경",
            top: 100,
            width: 576,
            //height: 500,
            cache: false,
            modal: true,
            href: CONTEXT_PATH + PW_CHANGE_MODAL_URL,
            // maximizable: true,
            // maximized: true,
            method: "post",
            // queryParams: param,
            onClose: function () {
                // HACK 이벤트를 지우지 않으면 계속 쌓인다.
                // resetEvent();
                $dialog.dialog("destroy");
            },
            onLoad: function () {
                // include 페이지 최상위 DOM id
                var $DIALOG_ROOT_NODE = $("#pwdChange");
                // close callback function
                var close = function () {
                    $dialog.dialog("close");
                };

                // 1. 가운데에서 뜨기
                //$dialog.dialog("center");

                // 2. 다국어 설정
                paragonCmm.convertLang($dialog);

                // 3. callback function 설정
                $DIALOG_ROOT_NODE.data("callback", cbFnc);

                // 4. callback function(close) 설정
                $DIALOG_ROOT_NODE.data("callback-close", close);
            }
        });
    };

    /**
     * EasyUI 가 panel 을 남발하기 때문에 초기화 시켜 버림
     */
    var gcEasyUI = function(){
        var divs = $("body").children("div");
        var iLen = (divs) ? divs.length : 0;
        for(var i = 0; i < iLen; i += 1){
            var tmpObj = divs[i];
            if($(tmpObj).hasClass("panel")){
                $(tmpObj).remove();
            }

            if($(tmpObj).hasClass("window-shadow")){
                $(tmpObj).remove();
            }

            if($(tmpObj).hasClass("window-mask")){
                $(tmpObj).remove();
            }
        }// end of for
    };

    var doMenuClick = function(json){
        if(json){

            // easy ui panel 초기화
            gcEasyUI();

            var $form = $("form[name='menuForm']");
            var $divMenuForm = $("#menuForm");
            var urlPath = "";
            if(json.hasOwnProperty("accesUrl")){    //-- 권한 Url
                urlPath = json.accesUrl;
            }
            if((urlPath == null || urlPath == "" ) && json.hasOwnProperty("urlPath")){ //-- 메뉴 지정 Url (추후 제거 예정: 권한Url 만 사용해야 함.)
                urlPath = json.urlPath;
            }
            if(urlPath == null || urlPath == "" ){
                return false;
            }
            console.log(urlPath);
            if(json.JSON_DATA != null){
                var jsonText = json.JSON_DATA;
                jsonText = jsonText.replaceAll("&#39;","\"");
                var jsonData = JSON.parse(jsonText);

                $.extend(json,jsonData);

            }
            var isPopup = false;
            if(json.hasOwnProperty("open_type")){
                if(json.open_type === "POPUP"){
                    isPopup = true;
                }
            }

            if(isPopup){
                var imsiForm = $("<form method='POST'>").attr("action",urlPath);
                $(json).each(function(i, e){
                    $.each(e, function(key, val){
                        imsiForm.append($("<input type='hidden' name='"+key+"'>").val(val));
                    })
                });
                imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
                paragonCmm.openWindow("", "1024", "650", "POP_"+json.menuId, "yes", "yes", "");
                imsiForm.attr("target","POP_"+json.menuId);
                imsiForm.appendTo("body");
                imsiForm.submit();
                imsiForm.remove();

            }else{

                $("#contentBody *").off();

                $("#contentBody").html("");
                $("#contentBody").load(urlPath+".include",json,function(){
                    paragonCmm.convertLang($("#contentBody"));
                });

            }
        }
    }
    var loadMenu = function(){
        var data = {};
        paragonCmm.callAjax("/viself/auth/authMenu/list/json",data, function(json){
            console.log(json);
            $(json.data).each(function(i, e){
                if("1" == e.levelNo){
                    var li = $("<li class='sub-menu' id='t_"+e.menuId+"'>").data("meaning",e)
                    li.append("<a href='javascript:;''><i class='fa fa-chevron-right'/> <span style='font-weight:bold; font-family:맑은 고딕;font-size:16px;'> "+paragonCmm.getLang(e.langCd)+"</span></a>")
                    .appendTo("#nav-accordion");
                    $(li).on("click",function(){
                        var json = $(this).data("meaning");
                        doMenuClick(json);
                    });
                }else{
                    if($("#t_"+e.parentMenuId).find("ul").length == 0){
                        $("<ul class='sub' id='p_"+e.parentMenuId+"' >").appendTo($("#t_"+e.parentMenuId));
                    }
                    var li = $("<li data-id='p_"+e.menuId+"'>").data("meaning",e)
                        .append("<a href='javascript:;'>"+paragonCmm.getLang(e.langCd)+"</a>");
                    li.appendTo("#p_"+e.parentMenuId);
                    $(li).on("click",function(){
                        var json = $(this).data("meaning");
                        doMenuClick(json);
                        var id = $(this).data("id");
                        $(".sub > li[class='active']" ).each(function(i, e){
                            if($(e).data("id") != id){
                                $(e).removeAttr("class");
                            }
                        })
                    });
                }
            });
        });
    }
    var pageResize = function(){
        $(".easyui-tabs").tabs('resize');        //-- tab resize
        $('.datagrid-f').datagrid('resize');    //-- data-grid resize
        $(".panel-body").panel("resize");
    }
    var attchmentEvent = function(){
        jQuery('#sidebar .sub-menu > a').click(function() {
            var o = ($(this).offset());
            var diff = 250 - o.top;
            if (diff > 0)
              $("#sidebar").scrollTo("-=" + Math.abs(diff), 500);
            else
              $("#sidebar").scrollTo("+=" + Math.abs(diff), 500);
         });


        function setSideSize(bool){
            if (!bool) {
                  $('#main-content').css({
                    'margin-left': '0px'
                  });
                  $('#sidebar').css({
                    'width': '0px'
                  });
                  $("#container").addClass("sidebar-closed");
                } else {
                  $('#main-content').css({
                    'margin-left': '210px'
                  });
                  $('#sidebar').css({
                    'width': '210px'
                  });
                  $("#container").removeClass("sidebar-closed");
                }
        }
        function responsiveView() {
              var wSize = $(window).width();
              if (wSize <= 768) {
                  setSideSize(false);
              }
              if (wSize > 768) {
                  setSideSize(true);
              }
//              pageResize();    //jsLink.jsp 에서 수행
        }
        //-- 리사이즈 이벤트
        $(window).bind('resize', function(){
            responsiveView();
//            pageResize(); //jsLink.jsp 에서 수행
        });

        $('.sidebar-toggle-box').on("click",function() {
            if ($('#sidebar').width() > 0) {
                setSideSize(false);
            }else{
                setSideSize(true);

            }
            pageResize(); //jsLink.jsp 에서 수행
          });

        // custom scrollbar
        $("#sidebar").niceScroll({
          styler: "fb",
          cursorcolor: "#4ECDC4",
          cursorwidth: '3',
          cursorborderradius: '10px',
          background: '#404040',
          spacebarenabled: false,
          cursorborder: ''
        });
        function scEnCode(sParam) {                            // 이름 파라미터 깨짐 방지
            sParam = sParam.replace(/(^\s*)|(\s*$)/gi, ""); //trim

            var encode = '';

            for(var iIndex=0; iIndex<sParam.length; iIndex++) {
                var sLength  = ''+sParam.charCodeAt(iIndex);
                var sToken = '' + sLength.length;
                encode  += sToken + sParam.charCodeAt(iIndex);
            }

            return encode;
        }
        $("#vertexIdServiceDesk").on("click",function(){
            var vParams = "";

            vParams += "compky=";        // 지정한 고객사 고정코드 (helpdesk에서 고객사 등록 후 확인)
            vParams += "&id="+"";    // 지정한 고객사 고정계정 (helpdesk에서 고객사 등록 후 확인)
            vParams += "&name="+scEnCode($("#loginNm").text());    // 이름
            vParams += "&email="+$("#loginEmail").val(); // 이메일

            paragonCmm.openWindow("http://sd.vertexid.com/main/ssoLogin2.do?"+vParams, "1250", "800", "Service Desk", "yes", "yes", "");

        });

        // 비밀번호 변경
        $("#mainChPwdBtn").on("click", function(){
            openChangPwd();
            return false;
        });

    }
    var loadForm = function(){
        $('#nav-accordion').dcAccordion({
            eventType: 'click',
            autoClose: true,
            saveState: true,
            disableLink: true,
            speed: 'slow',
            showCount: false,
            autoExpand: true,
            //        cookie: 'dcjq-accordion-1',
            classExpand: 'dcjq-current-parent'
          });

        // movePage("/main/dashboard",{});

    }
    var loadMLang = function(){
        cmmLocalStorage.set("SITE_LOCALE", "KO");
        //-- 다국어 최종 버전 가져오기
        paragonCmm.callAjax("/viself/mlang/mLangUpdate/listMaxVersion/json",{}, function(json){
            var listMaxVersion = json.data[0].maxVersion
            var oldVersion =cmmLocalStorage.get("LANG_VERSION");
            if(oldVersion == undefined || oldVersion != listMaxVersion)    paragonCmm.initLangStorage(listMaxVersion);    //-- 최종 버전으로 로드
        });
    }
    var init = function(){
        loadMLang();
        loadMenu();
        loadForm();
        attchmentEvent();
    }
    return{
        init:init,
        movePage:movePage
    }
};
var main;
$(document).ready(function () {
    main = new Main();
    console.info("[Loading Module: main].....................");
    main.init();
});