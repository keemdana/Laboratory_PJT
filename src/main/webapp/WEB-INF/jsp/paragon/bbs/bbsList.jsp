<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form id="bbsListForm" method="post">
    <div class="row mt">
        <h5 class="sub1_title" data-term="L.공지사항"><i class="fa fa-file-text"></i> </h5>
        <div class="col-md-12 col-sm-12">
            <div class="white-panel pn-sub1-top donut-chart">
                <div class="white-header">
                    <!-- Search AREA -->
                    <div class="row sub1_search">
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-md-10 col-sd-10" style="text-align:left;">
                                    <span data-tp="th" data-term="L.제목"></span>
                                    <input type="text" name="bbsTit" id="bbsTit" value="" class="form-control sub_80" data-type="search" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3" style="text-align:center;">
                            <button type="button" class="btn btn-default sear_st" id="bbsResetBtn" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                            <button type="button" class="btn btn-primary sear_st" id="bbsSearchBtn" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<!-- LIST 시작 -->
<div class="row mt">

    <div class="col-md-12 col-sm-12">
        <div class="white-panel pn-sub1-table donut-chart">
                <table id="listTable" style="width:auto;height:auto;">
                    <thead>
                    <tr>
                        <th data-options="field:'bbsUid',hidden:true"></th>
                        <th data-options="field:'bbsTpCd',hidden:true"></th>
                        <th data-options="field:'bbsTit',width:'65%',halign:'center',align:'LEFT',editor:'text', sortable:true,formatter:BBSLIST.isTopYn"><span style="font-weight:bolder;" data-term="L.제목"></span></th>
                        <th data-options="field:'bbsRegLoginId',hidden:true"><span data-term="l.등록자"></span></th>
                        <th data-options="field:'bbsRegLoginNm',width:'20%',halign:'CENTER',align:'CENTER',editor:'text',sortable:true"><span style="font-weight:bolder;" data-term="L.작성자"></span></th>
                         <th data-options="field:'bbsRegDte',width:'15%',halign:'CENTER',align:'CENTER',editor:'text',sortable:true" ><span style="font-weight:bolder;" data-term="L.등록일"></span></th>
                         <th data-options="field:'bbsTopYn',hidden:true"></th>
                        </tr>
                    </thead>
                </table>
        </div>
    </div>
    <div class="col-md-12 col-sm-12 donut-chart" style="text-align: left; padding-top: 5px;">
        <button type="button" class="btn btn-primary" id="writeBtn" data-term="B.WRITE"><i class="fa fa-pencil"></i> </button>
    </div>
</div>
    <input type="hidden" name="_csrf" id="csrf" value=""/>
    <input type="hidden" name="bbsUid" id="bbsUid" value=""/>
    <div id="bbsViewModal" style="width:600px;height:400px;display: none;" ></div>
    <div id="bbsWriteModal" style="width:600px;height:400px;display: none;" ></div>
<!--  <section class="wrapper site-min-height">-->
<!-- <div class="content-panel site-min-height">
    <h3><i class="fa fa-angle-right" id="content_header" data-term="L.공지사항"> </i></h3>
        <form id="bbsListForm" method="post">
            <table class="box">
                <tr>
                    <td class="corner_lt"></td>
                    <td class="border_mt"></td>
                    <td class="corner_rt"></td>
                </tr>
                <tr>
                    <td class="border_lm"></td>
                    <td class="body">
                        <table>
                            <colgroup>
                                <col style="width:5%" />
                                <col style="width:auto" />
                                <col style="width:20%" />
                            </colgroup>
                            <tr>
                                <th data-term="L.제목"></th>
                                <td><input type="text" name="bbsTit" id="bbsTit" data-type="search" class="form-control"/></td>
                                <td>
                                    <span class="ui_btn medium icon" style="width:100px;" id="bbsResetBtn"><i class="fa fa-refresh" ><a href="javascript:void(0)"  data-term="B.INIT"></a></i></span>
                                    <span class="separ"></span>
                                    <span class="ui_btn medium icon" id="bbsSearchBtn" style="width:100px;"><i class="fa fa-search"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
                                </td>
                            </tr>
                        </table>
                        </td>
                    <td class="border_rm"></td>
                </tr>
                <tr>
                    <td class="corner_lb"></td>
                    <td class="border_mb"></td>
                    <td class="corner_rb"></td>
                </tr>
                </table>
            </form>
            <div class="buttonlist">
                <div class="right">
                <span class="ui_btn medium icon" id="writeBtn" name="writeBtn" ><i class="fa fa-pencil" ><a href="javascript:void(0)" data-term="B.WRITE"></a></i></span>
                 </div>
            </div>
            <table id="listTable" style="height:auto;clear:both;">
                <thead>
                    <tr>
                        <th data-options="field:'bbsUid',hidden:true"></th>
                        <th data-options="field:'bbsTpCd',hidden:true"></th>
                        <th data-options="field:'bbsTit',width:'65%',halign:'center',align:'LEFT',editor:'text',sortable:true,formatter:BBSLIST.isTopYn"><span data-term="L.제목"></span></th>
                        <th data-options="field:'bbsRegLoginId',hidden:true"><span data-term="l.등록자"></span></th>
                        <th data-options="field:'bbsRegLoginNm',width:'20%',halign:'CENTER',align:'CENTER',editor:'text',sortable:true"><span data-term="L.작성자"></span></th>
                         <th data-options="field:'bbsRegDte',width:'15%',halign:'CENTER',align:'CENTER',editor:'text',sortable:true" ><span data-term="L.등록일"></span></th>
                         <th data-options="field:'bbsTopYn',hidden:true"></th>
                        </tr>
                </thead>
            </table>
    </section>
    </div>
    <input type="hidden" name="_csrf" id="csrf" value=""/>
    <input type="hidden" name="bbsUid" id="bbsUid" value=""/>
    <div id="bbsViewModal" style="width:600px;height:400px;display: none;" ></div>
    <div id="bbsWriteModal" style="width:600px;height:400px;display: none;" ></div> -->
<script>
    function BbsList(){

        var $bbsForm     = $("#bbsListForm");
        var $grid        = $("#listTable");
        var $resetBtn     = $("#bbsResetBtn");
        var $searchBtn     = $("#bbsSearchBtn");

        var doInit = function(frm){
            frm.reset();
        }

        var getGridHeight = function () {
            var ENURI = 320;
            var SCH_HEIGHT = 0; //$searchFrm.innerHeight();
            var windowHeight = window.innerHeight;
            return windowHeight - SCH_HEIGHT - ENURI;
        };

        var getPageSize = function(){
            var gHeight = getGridHeight();

            // console.log(gHeight);
            if(gHeight > 500){
                return 20;
            }
            return 10;
        };

        var loadGrid = function(pageNo){
            $('#listTable').datagrid({
                url:'/paragon/bbs/bbsMas/list/json',
                singleSelect:true,
                striped:true,
                fitColumns:false,
                rownumbers:true,
                multiSort:true,
                pagination:true,
                pagePosition:'bottom',
                nowrap:false,
                method:"post",
                queryParams:$bbsForm.serializeObject(),
                loadFilter:paragonCmm.easyuiLoadFilter,
                height: getGridHeight(),
                pageSize: getPageSize(),
                onBeforeLoad:function() { paragonCmm.showBackDrop(); },
                onLoadSuccess:function(json) {
                    paragonCmm.hideBackDrop();
                    $(this).datagrid('resize');
                },
                onLoadError:function() { paragonCmm.hideBackDrop(); },
                onDblClickRow:function(index, row){
                    var rows = $('#listTable').datagrid('getRows');
                    var row = rows[index];
                    var bbsUid = row.bbsUid;

                     $("#bbsUid").val(row.bbsUid);
                    //$("#csrf").val(row.d$("meta[name='_csrf']").attr("content"));
                    //alert("row"+row.bbsUid);
                    goViewData(bbsUid);
                }
            });
        }

        var doSearch = function(isCheckEnter){
            if (isCheckEnter && event.keyCode != 13) {
                return;
            }
            $('#listTable').datagrid('reload', $bbsForm.serializeObject());

        }


        var goWrite = function(openerData){
            var imsiForm = $("<form method='POST'>").attr("action","/paragon/bbs/bbsWrite.popup");
            imsiForm.append($("<input type='hidden' name='bbsUid'>").val(bbsUid));
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "1000", "600", "POPUP_WRITE", "yes", "yes", "");
            imsiForm.attr("target","POPUP_WRITE");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();

        }

        var goWriteData = function(bbsUid){

            var openerData = {
                isNew : "TRUE",
                bbsUid : paragonCmm.getRandomUUID()
            };

        console.log("openerData........")
        console.log(openerData);

        // openDialog(mainStu, openerData);
        goWrite(openerData);
    };

        var goView =  function(openerData){
            var imsiForm = $("<form method='POST'>").attr("action","/paragon/bbs/bbsMasView.popup");
            imsiForm.append($("<input type='hidden' name='bbsUid'>").val(bbsUid));
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "1000", "550", "POPUP_VIEW", "yes", "yes", "");
            imsiForm.attr("target","POPUP_VIEW");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();
        }

        var goViewData = function(bbsUid){

            var openerData = {
                isNew : "FALSE",
                bbsUid : bbsUid
            };

        console.log("openerData........")
        console.log(openerData);

        // openDialog(mainStu, openerData);
        goView(openerData);
    };

        var attchmentEvent = function(){

            $bbsForm.off();
            $bbsForm.on("submit", function(){
                doSearch();
                return false;
            });

            $("#writeBtn").on("click",function(){
                goWriteData();
                return false;
            });

            $searchBtn.off();
            $searchBtn.on("click",function(){
                doSearch();
                return false;
            });

            $("input:text[data-type='search']", $bbsForm).off();
            $("input:text[data-type='search']", $bbsForm).on("keyup", function(e){
                if(e.keyCode != 13) return false;
                doSearch(true);
                return false;
            });

            $resetBtn.on("click", function(){
                $("#bbsTit").html("");
            });

        }
        var init = function(){

            loadGrid();            //-- 리스트 로드
            attchmentEvent();    //-- 이벤트 등록

        }
        //-- 상단게시 여부 Y ->  제목 앞 느낌표 추가
        var isTopYn = function(txt,row,idx){
            txt = (txt == null?"":txt);
            if(row.bbsTopYn == "Y"){
                return '<i class="fa fa-exclamation" style="color:red;"></i>&nbsp&nbsp' + txt;
            }else{
                return txt;
            }

        }
        return{
            init : init,
            isTopYn : isTopYn,
            doSearch : doSearch
        }
    }

    var BBSLIST;
    $(document).ready(function(){
        BBSLIST = new BbsList();
        BBSLIST.init();
    });
</script>