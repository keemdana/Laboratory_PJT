/*
 * @(#)dashboard.js     2019-12-23 오전 10:24
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
/**
 * <b>Description</b>
 * <pre>
 *    메인 데시보드 화면
 * </pre>
 * @author 강세원
 * @auther 백서윤
 */
"use strict";

// 팝업 콜백용 전역변수
var baseOpener = baseOpener || {};

var dashBoard = (function(){

    var FORM_URL = "/paragon/def/defStuForm/defStuFormTotal.popup";

    // 단위: 억(나누기)
    var DIV = "100000000";

    // 표시: 일만단위
     var ROUND = 2;

    //당해년도 연간계획/실적
    var CURR_YEAR_URL = "/ims/main/Dashboard/currYearList/json";
    var currYearTblId = "currYearTbl";

    //당월 계획/실적
    var CURR_MONTH_URL = "/ims/main/Dashboard/currMonthList/json";
    var currMonthTblId = "currMonthTbl";

    //당월누적계획/실적
    var ACC_CURR_URL = "/ims/main/Dashboard/accCurrList/json";
    var accCurrTblId = "accCurrTbl";

    //TODO
    var TODO_URL = "/ims/main/Dashboard/todoList/json";
    var todoTblId = "todoTbl";

    //공지사항
    var BOARD_URL = "/ims/main/Dashboard/boardList/json";
    var boardTblId = "boardTbl";

    //당월 계획/실적 차트
    var CURR_YEAR_CHART_URL = "/ims/main/Dashboard/currYearChartList/json"

    var currentYear = (new Date()).getFullYear()
    var currentMonth = (new Date()).getMonth()+1;

    var $dashboardStat = $("#dashboardStat");
    var $dashboardChart = $("#dashboardChart");
    var $dashboardTodo = $("#dashboardTodo");

    //paragonCmm.convertLang($dashboardStat);
    //paragonCmm.convertLang($dashboardChart);
    //paragonCmm.convertLang($dashboardTodo);

    //천단위
    var getNumberOnly = function(val){
        if(typeof val === "undefined" || val === null ){
            return "0";
        }
        // if(isNaN(parseInt(rtnVal, 10))){
        //     rtnVal = "0";
        // }
        return val.replace(/[^0-9.]/g, "");
    };


    // 연도 콤보박스 초기화
    var getMonthOptionsStr = function(){
        var rtn = "";
        var startMonth = 1;
        var lastMonth = 12;
        for(var i = startMonth; i <= lastMonth; i+=1){
            if(i > startMonth){
                rtn += "^";
            }
            rtn += i+"|"+i+"월";
        }
        return rtn;
    }

    var initForm = function(){
        $("#dashboardMonth").html(htmlUtils.getSelect('month','month', getMonthOptionsStr(),''+currentMonth,'data-type="search"'));
    };

    //차트데이터 load
    var loadChart = function(){
        var aData = paragonCmm.getSearchQueryParams();
        aData["currentYear"] = currentYear;
        paragonCmm.callAjax(CURR_YEAR_CHART_URL,aData, function(json){
            var cData = json.data;
            var chartData = [
                { Day:'1월', 계획:(Big(cData[0].month1).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm01).div(DIV)).round(ROUND).toString()},
                { Day:'2월', 계획:(Big(cData[0].month2).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm02).div(DIV)).round(ROUND).toString()},
                { Day:'3월', 계획:(Big(cData[0].month3).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm03).div(DIV)).round(ROUND).toString()},
                { Day:'4월', 계획:(Big(cData[0].month4).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm04).div(DIV)).round(ROUND).toString()},
                { Day:'5월', 계획:(Big(cData[0].month5).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm05).div(DIV)).round(ROUND).toString()},
                { Day:'6월', 계획:(Big(cData[0].month6).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm06).div(DIV)).round(ROUND).toString()},
                { Day:'7월', 계획:(Big(cData[0].month7).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm07).div(DIV)).round(ROUND).toString()},
                { Day:'8월', 계획:(Big(cData[0].month8).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm08).div(DIV)).round(ROUND).toString()},
                { Day:'9월', 계획:(Big(cData[0].month9).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm09).div(DIV)).round(ROUND).toString()},
                { Day:'10월', 계획:(Big(cData[0].month10).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm10).div(DIV)).round(ROUND).toString()},
                { Day:'11월', 계획:(Big(cData[0].month11).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm11).div(DIV)).round(ROUND).toString()},
                { Day:'12월', 계획:(Big(cData[0].month12).div(DIV)).round(ROUND).toString(), 실적:(Big(cData[0].sapAm12).div(DIV)).round(ROUND).toString()}
            ];
            // prepare jqxChart settings
            var settings = {
                 title: "   ",
                description: "   ",
                source: chartData,
                categoryAxis:{
                    dataField: 'Day',
                    showGridLines: false
                },
                seriesGroups:[{
                    type: 'column',
                    valueAxis:{
						maxValue : cData[0].maxValue,
                        visible: true,
                        position : 'left',
                        showGridLines : false,
                        labels:{
                            tickOptions:{
                                showLabel :true,
                                formatString:"%s",
                            }
                        },
						formatFunction : function (val) {
							var formatNumber = paragonCmm.getFormatCurrency(val, 2);
							return formatNumber;
						}
                    },
                    series: [{
                        dataField: '계획', displayText: '계획',
                        labels: {
                            visible: true,
                            verticalAlignment: 'top',
                            offset: { x: 0, y: -20 }
                        },
						formatFunction : function (val) {
							var formatNumber = paragonCmm.getFormatCurrency(val, 2);
							return formatNumber+"억";
						}
                    },{
                        dataField: '실적', displayText: '실적',
                        labels: {
                            visible: true,
                            verticalAlignment: 'top',
                            offset: { x: 0, y: -20 }
                        },
						formatFunction : function (val) {
							var formatNumber = paragonCmm.getFormatCurrency(val, 2);
							return formatNumber+"억";
						}
                    }]
                }]
            };
            // setup the chart
            $("#chartContainer").jqxChart(settings);

        });
    }
    //공지사항 load
    var loadBoard = function(pageNo){
        if(pageNo == undefined) pageNo =1;
        var data = paragonCmm.getSearchQueryParams();
        data["page"] = pageNo;
        data["rows"] = "5";


        paragonCmm.callAjax(BOARD_URL,data, function(json){
          var data = paragonCmm.easyuiLoadFilter(json);
          var page = "";
          var rowCnt = "";
          htmlUtils.createTableRow(boardTblId, data, page, rowCnt, "dashBoard.loadBoard");
        });

    }

    //공지사항popup load
    var loadBoardPopup = function(){
        var data = paragonCmm.getSearchQueryParams();

        var popupList = [];
        paragonCmm.callAjax(BOARD_URL,data, function(json){
          data = paragonCmm.easyuiLoadFilter(json);
          var bbsList = data.rows;
        //console.log(bbsList)
          var iLen = bbsList.length;
            for(var i = 0; i <= iLen -1; i++){
                var bbsPopupYn = bbsList[i].bbsPopupYn;
                if(bbsPopupYn == "Y"){
                    popupList.push(bbsList[i].bbsUid)
                }
            }
        });
        //console.log("loadBoardPopup")
        //console.log(popupList)
        var popupLen = popupList.length;
        if(paragonCmm.getCookie("toDate") != "ok"){
        for(var i = 0; i <= popupLen -1; i++){
            var openerData = {
                isNew : "FALSE",
                bbsUid : popupList[i],
                openType : "MAIN"
            };

        var imsiForm = $("<form method='POST'>").attr("action","/paragon/bbs/bbsMasView.popup");
        //imsiForm.append($("<input type='hidden' name='bbsUid'>").val(bbsUid));
        imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
        imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
        paragonCmm.openWindow("", "1024", "580", "POPUP_VIEW", "yes", "yes", "");
        imsiForm.attr("target","POPUP_VIEW");
        imsiForm.appendTo("body");
        imsiForm.submit();
        imsiForm.remove();
        }
    }
    }


    //todo load
    var loadTodo = function(pageNo){
        if(pageNo == undefined) pageNo =1;
        var data = paragonCmm.getSearchQueryParams();
        data["page"] = pageNo;
        data["rows"] = "10";

        paragonCmm.callAjax(TODO_URL,data, function(json){
          var data = paragonCmm.easyuiLoadFilter(json);
          var page = pageNo;
          var rowCnt = 10;
          htmlUtils.createTableRow(todoTblId, data, page, rowCnt, "dashBoard.loadTodo");

        });
    }

    //당월 계획/실적 해당 월 select
    $("#dashboardMonth").on("change", function(){
            dashBoard.loadCurrMonth()
    });

    //당월 계획/실적, 당월 누적계획/실적
    var loadCurrMonth = function(pageNo){
        if(pageNo == undefined) pageNo =1;
        var loginDeptCd = $("#regDeptCd").val();
        var data = paragonCmm.getSearchQueryParams();
        data["page"] = pageNo;
        data["rows"] = "10";
        data["currentYear"] = currentYear;
        data["loginDeptCd"] = loginDeptCd;
        paragonCmm.callAjax(CURR_MONTH_URL, data, function(json){
            var data = json.data;
            var len = data.length;
            var selectedMonth = $("#dashboardMonth option:selected").val()

            var j = Number(selectedMonth);
            var strNo = "0"+j;
            if(j > 9){
                strNo = "" + j;
            }

            var sapStr = "sapAm" + strNo;
            var monthAmtStr = "month" + selectedMonth;

            //당월 계획/실적
            var currMonthPerform = 0;
            var currMonthInv = 0;

            for(var i = 0; i < len; i++){
                var sapAmt = data[i][sapStr]
                var monthAmt = data[i][monthAmtStr]
                if(sapAmt == null){sapAmt = 0}
                if(monthAmt == null){monthAmt = 0}
                currMonthPerform = Big(currMonthPerform).add(sapAmt).toString();
                currMonthInv = Big(currMonthInv).add(monthAmt).toString();

            }
            var monthExecutePer = 0;
			currMonthInv = (Big(currMonthInv).div(DIV)).round(ROUND).toString();
			currMonthPerform = (Big(currMonthPerform).div(DIV)).round(ROUND).toString();

            if(currMonthInv == 0 || isNaN(monthExecutePer) || currMonthPerform == 0){
                monthExecutePer = 0;
            } else {
	            monthExecutePer = Big(currMonthPerform).div(currMonthInv).times(100).round(ROUND).toString();
			}

            var currMonthData = $("#currMonthTblBody");
            var $currMonthInv = currMonthData.find("span.currMonthInv");
            $currMonthInv.html(paragonCmm.getFormatCurrency(currMonthInv, 2));

            var $currMonthPerform = currMonthData.find("span.currMonthPerform");
            $currMonthPerform.html(paragonCmm.getFormatCurrency(currMonthPerform, 2));

            var $monthExecutePer = currMonthData.find("span.monthExecutePer");
            $monthExecutePer.html(monthExecutePer + "%");

            //당월 누적계획/실적
            var accCurrInv = 0;
            var accCurrPerform = 0;
            var currentMonth = (new Date()).getMonth();

            for(var i = 0; i < len; i++){
                for(var j = 1; j < currentMonth+1; j++){
                    var monthAmt = data[i]["month"+j]
                    if(monthAmt == null){monthAmt = 0}
                    accCurrInv = Big(accCurrInv).add(monthAmt).toString();

                    var strNo = "0"+j;
                    if(j > 9){
                        strNo = "" + j;
                    }
                    var sapAmt = data[i]["sapAm"+strNo]
                    if(sapAmt == null){sapAmt = 0}
                    accCurrPerform = Big(accCurrPerform).add(sapAmt).toString();
                }
            }
            var executePer = 0;
			accCurrInv = (Big(accCurrInv).div(DIV)).round(ROUND).toString();
			accCurrPerform = (Big(accCurrPerform).div(DIV)).round(ROUND).toString();

            if(accCurrInv == 0 || isNaN(executePer) || accCurrPerform == 0){
                executePer = 0;
            }else {
            	executePer = Big(accCurrPerform).div(accCurrInv).times(100).round(ROUND).toString();
			}

            var accCurrData = $("#accCurrTblBody");

            var $accCurrInv = accCurrData.find("span.accCurrInv");
            $accCurrInv.html(paragonCmm.getFormatCurrency(accCurrInv, 2));

            var $accCurrPerform = accCurrData.find("span.accCurrPerform");
            $accCurrPerform.html(paragonCmm.getFormatCurrency(accCurrPerform, 2));

            var $executePer = accCurrData.find("span.executePer");
            $executePer.html(executePer + "%");

        });

    }

    //당해년도 연간계획/실적
    var loadCurrYear = function(pageNo){
        if(pageNo == undefined) pageNo =1;

        var data = paragonCmm.getSearchQueryParams();
        var loginDeptCd = $("#regDeptCd").val();

        data["page"] = pageNo;
        data["rows"] = "10";
        data["currentYear"] = currentYear;
        data["loginDeptCd"] = loginDeptCd;
        paragonCmm.callAjax(CURR_YEAR_URL,data, function(json){
            var data = json.data[0];
            var yearInv = (Big(data.yearInv).div(DIV)).round(ROUND).toString();
            var apprAmt = (Big(data.apprAmt).div(DIV)).round(ROUND).toString();
            var accPerform =  (Big(data.accPerform).div(DIV)).round(ROUND).toString();
            var progressPer = 0;

            if(yearInv == 0 || isNaN(progressPer) || accPerform == 0) {
                progressPer = 0;
            } else {
				progressPer = Big(accPerform).div(yearInv).times(100).round(ROUND).toString();
			}

            var currYearData = $("#currYearTblBody");

            var $yearInv = currYearData.find("span.yearInv");
            $yearInv.html(paragonCmm.getFormatCurrency(yearInv, 2));

            var $apprAmt = currYearData.find("span.apprAmt");
            $apprAmt.html(paragonCmm.getFormatCurrency(apprAmt, 2));

            var $accPerform = currYearData.find("span.accPerform");
            $accPerform.html(paragonCmm.getFormatCurrency(accPerform, 2));

            var $progressPer = currYearData.find("span.progressPer");
            $progressPer.html(progressPer + "%");


            // 당월 누계/실적 처리 : 2021-11-03 안재민
            // var accCurrData = $("#accCurrTblBody");
            //
            // var $accCurrInv = accCurrData.find("span.accCurrInv");
            // $accCurrInv.html(paragonCmm.getFormatCurrency(yearInv, 2));
            //
            // var $accCurrPerform = accCurrData.find("span.accCurrPerform");
            // $accCurrPerform.html(paragonCmm.getFormatCurrency(accPerform, 2));
            //
            // var $executePer = accCurrData.find("span.executePer");
            // $executePer.html(progressPer + "%");
        });

    }

    //공지사항 글 바로가기
    var goBoardView = function(bbsUid){

        var openerData = {
                isNew : "FALSE",
                bbsUid : bbsUid
            };

        var imsiForm = $("<form method='POST'>").attr("action","/paragon/bbs/bbsMasView.popup");
        imsiForm.append($("<input type='hidden' name='bbsUid'>").val(bbsUid));
        imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
        imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
        paragonCmm.openWindow("", "1024", "540", "POPUP_VIEW", "yes", "yes", "");
        imsiForm.attr("target","POPUP_VIEW");
        imsiForm.appendTo("body");
        imsiForm.submit();
        imsiForm.remove();
    }

    //todo 글 바로가기
    var goView = function(solMasUid,stuLangCd, stuDtl){
        var imsiForm = $("<form method='POST'>").attr("action",FORM_URL);
        imsiForm.append($("<input type='hidden' name='solMasUid'>").val(solMasUid));
        imsiForm.append($("<input type='hidden' name='stuCd'>").val(stuLangCd));
        imsiForm.append($("<input type='hidden' name='stuDtl'>").val(stuDtl));
        imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
        paragonCmm.openWindow("", "1250", "800", "POP_VIEW_"+solMasUid, "yes", "yes", "");
        imsiForm.attr("target","POP_VIEW_"+solMasUid);
        imsiForm.appendTo("body");
        imsiForm.submit();
        imsiForm.remove();
    }

    var getNoticeIco = function(txt){
        return '<i class="fa fa-caret-right"></i> '+txt;
    }

    var init = function(){
        initForm()
        loadTodo(1);
        loadBoard();
        loadBoardPopup()

        loadCurrYear();
        loadCurrMonth();
        loadChart()

        var search = function(){
            loadTodo(1);
        };

        // popup
        baseOpener.popupCbFnc = search;
    }
    return{
        init:init,
        initForm:initForm,
        loadBoard:loadBoard,
        goBoardView:goBoardView,
        getNoticeIco:getNoticeIco,
        loadBoardPopup:loadBoardPopup,
        loadTodo:loadTodo,
        goView:goView,


        loadCurrYear:loadCurrYear,
        loadCurrMonth:loadCurrMonth,
        loadChart:loadChart
    }
})();

dashBoard.init();
