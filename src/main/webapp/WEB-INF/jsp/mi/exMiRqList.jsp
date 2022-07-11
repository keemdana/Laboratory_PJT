<%--
  - Author(s): Dana kim
  - Date: 2022-06-08
  -
  - Copyright (c) 2021 Vertex ID., KOREA
  - All rights reserved.
  -
  - This software is the confidential
  - and proprietary information of emFrontier.com ("Confidential Information").
  - You shall not disclose such Confidential Information
  - and shall use it only in accordance with
  - the terms of the license agreement you entered into
  - with Vertex ID. Networks
  -
  - @(#)
  - Description:
  -      계측기예약 > 의뢰현황
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<script type="text/javascript">
    function ExRqList(){

        var $form     = $("#exReqStListForm");
        var $grid        = $("#listTable");
        var $resetBtn     = $("#miExRqResetBtn");
        var $searchBtn     = $("#miExRqSearchBtn");

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
                url:'/mi/exRequestStatusList/json',
                singleSelect:true,
                striped:true,
                fitColumns:false,
                rownumbers:true,
                multiSort:true,
                pagination:true,
                pagePosition:'bottom',
                nowrap:false,
                method:"post",
                queryParams:$form.serializeObject(),
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
                    var miRqKey = row.miRqKey;

                     $("#miRqKey").val(row.miRqKey);
                    //$("#csrf").val(row.d$("meta[name='_csrf']").attr("content"));
                    //alert("row"+row.miRqKey);
                    goViewData(miRqKey);
                }
            });
        }

        var doSearch = function(isCheckEnter){
            if (isCheckEnter && event.keyCode != 13) {
                return;
            }
            $('#listTable').datagrid('reload', $form.serializeObject());

        }
        
        var goViewData = function(miRqKey){
        	var openerData = {
                isNew : "FALSE",
                miRqKey : miRqKey
            };
        	
        	console.log("openerData........")
        	console.log(openerData);

	        // openDialog(mainStu, openerData);
    	    goView(openerData);
		};		

        var goView =  function(openerData){
            var imsiForm = $("<form method='POST'>").attr("action","/mi/exMiRqView.popup");
            imsiForm.append($("<input type='hidden' name='miRqKey'>").val(openerData.miRqKey));
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "900", "1200", "POPUP_VIEW", "yes", "yes", "");
            imsiForm.attr("target","POPUP_VIEW");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();
        }

        var attchmentEvent = function(){

            $form.off();
            $form.on("submit", function(){
                doSearch();
                return false;
            });

            $searchBtn.off();
            $searchBtn.on("click",function(){
            	var stdt = $('#stdt').val();
            	var eddt = $('#eddt').val();

            	if(stdt!=null && stdt!='') {
            		if(eddt==null || eddt=='') {
            			alert('날짜 조건이 정상적으로 선택되지 않았습니다.');
            			return;
            		}
            	}

            	if(eddt!=null && eddt!='') {
            		if(stdt==null || stdt=='') {
            			alert('날짜 조건이 정상적으로 선택되지 않았습니다.');
            			return;
            		}
            	}
            	
                doSearch();
                return false;
            });

            $("input:text[data-type='search']", $form).off();
            $("input:text[data-type='search']", $form).on("keyup", function(e){
                if(e.keyCode != 13) return false;
                doSearch(true);
                return false;
            });

            $resetBtn.on("click", function(){
            	$("#miKey").val("");
            	$("#status").val("");
            	$("#opt").val("");
            	$("#stdt").val("");
            	$("#eddt").val("");
            	$('#schWord').val("");
            });
            
            $("#exMiRqWriteBtn").on("click",function(){
                goWriteData();
                return false;
            });
        }
        var init = function(){

            loadGrid();            //-- 리스트 로드
            attchmentEvent();    //-- 이벤트 등록

        }
        
        
        var goWrite = function(openerData){
            var imsiForm = $("<form method='POST'>").attr("action","/mi/exMiRq.popup");
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "900", "1200", "POPUP_WRITE", "yes", "yes", "");
            imsiForm.attr("target","POPUP_WRITE");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();

        }
        
        var goWriteData = function(){

            var openerData = {
                isNew : "TRUE"
            };

	        console.log("openerData........")
	        console.log(openerData);
	
	        // openDialog(mainStu, openerData);
	        goWrite(openerData);
	    };        
        
        
        return{
            init : init,
            doSearch : doSearch
        }
    }

    var ExRqList;
    $(document).ready(function(){
        ExRqList = new ExRqList();
        ExRqList.init();
        
        //계측기 리스트
        $.ajax({
        	url: "/mi/miKeyList/json"
          , type: "POST"
          , dataType: "json"
          , contentType: "application/json"
	      , success : function(data) {
	    	  var obj = data.data;
	    	  var len = obj.length;
	      	
	    	  //console.log(obj);

    		  $('#miKey').append($('<option>', {
	    		    value: '',
	    		    text: '선택'
	    		}));
	    	  
	    	  if(len!=0) {
	    		  for(var i=0; i<len; i++) {
	    			  $('#miKey').append($('<option>', {
			    		    value: obj[i].miCd,
			    		    text: obj[i].miNm
			    		}));
	    		  }
	    	  }
	    	  
	      }
		, error : function(status) {
			alert(status + " error");
		      }
        });
        
    });
</script>

<form id="exReqStListForm" method="post">
    <div class="row mt">
        <h5 class="sub1_title" data-term="L.EX_MI_RQ_LIST"><i class="fa fa-file-text"></i> </h5>
        <div class="col-md-12 col-sm-12">
            <div class="white-panel pn-sub1-top donut-chart">
                <div class="white-header">
                    <!-- Search AREA -->
                    <div class="row sub1_search">
                        <div class="col-md-9">
                            <div>
                				<span data-tp="th">계측기</span>
                				<select id="miKey" name="miKey" class="form-control input-sm" style="width:120px">
                				</select>
                			</div>
                			<div>
                				<span data-tp="th">작성일자</span>
                				<input type="date" name="stdt" id=stdt class="form-control" style="width: 15%;">
                                <span class="p-1">~</span>
                                <input type="date" name="eddt" id="eddt" class="form-control" style="width: 15%;">
                			</div>
                			<div>
                				<span data-tp="th" >조건</span>
                				<select id="opt" name="opt" class="form-control input-sm" style="width:120px">
                					<option value="" selected="selected">선택</option>
                					<option value="1">의뢰자명</option>
                					<option value="2">FOUP ID</option>
                					<option value="3">RECIPE</option>
                					<option value="4">LOT NAME</option>
                				</select>
                                <input type="text" name="schWord" id="schWord" class="form-control input-sm" data-type="search" style="width:300px" >
                			</div>
                        </div>
                        <div class="col-md-3" style="text-align:center;">
                            <button type="button" class="btn btn-default sear_st" id="miExRqResetBtn" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                            <button type="button" class="btn btn-primary sear_st" id="miExRqSearchBtn" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<!-- LIST 시작 -->
<div class="col-md-12 col-sm-12 donut-chart" style="padding-top: 5px;" align="right">
	<button type="button" class="btn btn-primary" id="exMiRqWriteBtn"><i class="fa fa-pencil"></i> 예외측정</button>
</div>
<div class="row mt">

    <div class="col-md-12 col-sm-12">
        <div class="white-panel pn-sub1-table donut-chart">
                <table id="listTable" style="width:auto;height:auto;">
                    <thead>
						<tr>
							<th data-options="field:'miRqKey',hidden:true"></th>
							<th data-options="field:'commentYn',width:'5%',halign:'CENTER',align:'CENTER',sortable:true">의뢰내용</th>
							<th data-options="field:'miKey',width:'7%',halign:'CENTER',align:'CENTER',sortable:true">계측기</th>
							<th data-options="field:'miRqDeptNm',width:'8%',halign:'CENTER',align:'CENTER',sortable:true">사용 부서</th>
							<th data-options="field:'miRqUserNm',width:'5%',halign:'CENTER',align:'CENTER',sortable:true">등록자</th>
							<th data-options="field:'miRqFoupId',width:'10%',halign:'CENTER',align:'CENTER',sortable:true">FOUP ID</th>
							<th data-options="field:'miRqG',width:'7%',halign:'CENTER',align:'CENTER',sortable:true">의뢰 항목</th>
							<th data-options="field:'miRqRecipe',width:'23%',halign:'CENTER',align:'CENTER',sortable:true">RECIPE</th>
							<th data-options="field:'miRqLot',width:'9%',halign:'CENTER',align:'CENTER',sortable:true">LOT NAME</th>
							<th data-options="field:'miRqPoint',width:'9%',halign:'CENTER',align:'CENTER',sortable:true">POINT</th>
							<th data-options="field:'slotCnt',width:'7%',halign:'CENTER',align:'CENTER',sortable:true">SLOT매수</th>
							<th data-options="field:'insertDt',width:'10%',halign:'CENTER',align:'CENTER',sortable:true">작성일자</th>
						</tr>
                    </thead>
                </table>
        </div>
    </div>
</div>
    <input type="hidden" name="_csrf" id="csrf" value=""/>
