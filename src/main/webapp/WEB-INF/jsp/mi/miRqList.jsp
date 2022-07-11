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
<%@ page import="java.util.Date" %>  
<%@ page import="java.text.SimpleDateFormat" %>  
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<% String miKey= (String)request.getParameter("miKey"); %>
<% String status= (String)request.getParameter("status"); %>
<%
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
	String nowDate = sf.format(now);
%>
<script type="text/javascript">

	var RqList;
	$(document).ready(function(){
	  	
		var miKey = <%= miKey %>;
		var status = <%= status %>;
	    
	    //계측기 리스트
	    $.ajax({
	    	url: "/mi/miKeyList/json"
	      , type: "POST"
	      , dataType: "json"
	      , async: false
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
	    	  
	    	  if(miKey != null)
	    		  $("#miKey").val(miKey).prop("selected", true);
	    	  
	      }
		, error : function(status) {
			alert(status + " error");
		      }
	    });
	    
	    //상태 리스트
	    $.ajax({
	    	url: "/mi/statusList/json"
	      , type: "POST"
	      , dataType: "json"
	      , async: false
	      , contentType: "application/json"
	      , success : function(data) {
	    	  var obj = data.data;
	    	  var len = obj.length;
	      	
	    	  console.log(obj);
	
			  $('#status').append($('<option>', {
	    		    value: '',
	    		    text: '선택'
	    		}));
	    	  
	    	  if(len!=0) {
	    		  for(var i=0; i<len; i++) {
	    			  $('#status').append($('<option>', {
			    		    value: obj[i].miRqStatus,
			    		    text: obj[i].miRqStatusNm
			    		}));
	    		  }
	    	  }
	
	    	  if(status != null)
	    		  $("#status").val(status).prop("selected", true);
	    	  
	      }
		, error : function(status) {
			alert(status + " error");
		      }
	    });
	    
	    RqList = new RqList();
	    RqList.init();
	    
	});

    function RqList(){
    	
        var $form     = $("#reqStListForm");
        var $grid        = $("#listTable");
        var $resetBtn     = $("#miRqResetBtn");
        var $searchBtn     = $("#miRqSearchBtn");
        var $excelBtn     = $("#urlMngExcelBtn1");

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
                url:'/mi/requestStatusList/json',
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
                },
                columns: [[	//field 값은 컬럼명 중 _ 있을 경우 대문자로 구분하여 표기
    	            /* {
    	                field: "no", checkbox: true, width: "1%", toExcel: false	// unique key
    	            }, */ 
    	            {
    	                field: "miRqKey", hidden: true, title: "MI_RQ_KEY", formatter: filterXSS, width: "10%"
    	            },
    	            {
    	                field: "miRqSubun", title: "순번", formatter: filterXSS, width: "10%"
    	            },
    	            {
    	                field: "insertDt", title: "의뢰일시", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "miRqDt", title: "실물접수", formatter: filterXSS, width: "10%"
    	            },
    	            {
    	                field: "miKey", title: "계측기", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "statusNm", title: "상태", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "miStart", title: "계측시작", formatter: filterXSS, width: "10%"
    	            },
    	            {
    	                field: "miEnd", title: "계측완료", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "miRqDeptNm", title: "의뢰부서", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "miRqUserNm", title: "의뢰자", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "miRqFoupId", title: "FOUP ID", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "miRqG", title: "의뢰항목", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "miRqRecipe", title: "RECIPE", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "slotCnt", title: "SLOT 매수", formatter: filterXSS, width: "10%"
    	            }, 
    	            {
    	                field: "commentYn", title: "의뢰내용", formatter: filterXSS, width: "10%"
    	            }
                ]]   
            });
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
            var imsiForm = $("<form method='POST'>").attr("action","/mi/miRqView.popup");
            imsiForm.append($("<input type='hidden' name='miRqKey'>").val(openerData.miRqKey));
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "900", "1200", "POPUP_VIEW", "yes", "yes", "");
            imsiForm.attr("target","POPUP_VIEW");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();
        }

        var doSearch = function(isCheckEnter){
            if (isCheckEnter && event.keyCode != 13) {
                return;
            }
            $('#listTable').datagrid('reload', $form.serializeObject());

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
            

            $("#miRqWriteBtn").on("click",function(){
                goWriteData();
                return false;
            });
            
            $excelBtn.on("click", function(){
                toExcel();
                return false;
            });

        }
        var init = function(){

            loadGrid();            //-- 리스트 로드
            attchmentEvent();    //-- 이벤트 등록

        }
        
        var goWrite = function(openerData){
            var imsiForm = $("<form method='POST'>").attr("action","/mi/miRq.popup");
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "900", "1200", "POPUP_WRITE", "yes", "yes", "");
            imsiForm.attr("target","POPUP_WRITE");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();

        }
        
        var toExcel = function(){
            $grid.edatagrid("toExcel", {
                filename: "의뢰현황_"+<%=nowDate%>+".xls", /* xlsx 타입으로하면 양식 깨짐.. */
                worksheet: <%=nowDate%>,
                caption: "의뢰현황_"+<%=nowDate%>
            });
        };
        
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
    
    function fn_rqView() {
    	alert('상세보기');
    }
    
    function fn_miRqMain() {
    	location.href="/mi/miMain"
    }

</script>

<form id="reqStListForm" method="post">
    <div class="row mt">
        <h5 class="sub1_title" data-term="L.MI_RQ_LIST"><i class="fa fa-file-text"></i> </h5>
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
                				<span data-tp="th">상태</span>
                				<select id="status" name="status" class="form-control input-sm" style="width:120px">
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
                            <button type="button" class="btn btn-default sear_st" id="miRqResetBtn" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                            <button type="button" class="btn btn-primary sear_st" id="miRqSearchBtn" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<!-- LIST 시작 -->

<div class="col-md-12 col-sm-12 donut-chart" style="padding-top: 5px;" align="right">
	<button type="button" class="btn btn-primary" id="miRqWriteBtn"><i class="fa fa-pencil"></i> 계측의뢰</button>
	<button type="button" class="btn btn-light" id="urlMngExcelBtn1" style="color: #f5f5f5; background-color: #449d44; border-color: #449d44;"><i class="fa fa-file"></i> Excel</button>
</div>
<br>
<div class="row mt">

    <div class="col-md-12 col-sm-12">
        <div class="white-panel pn-sub1-table donut-chart">
                <table id="listTable" style="width:auto;height:auto;">
                    <thead>
						<tr>
							<th data-options="field:'miRqKey',hidden:true"></th>
							<th data-options="field:'miRqSubun',width:'3%',halign:'CENTER',align:'CENTER',sortable:true">순번</th>
							<th data-options="field:'commentYn',width:'5%',halign:'CENTER',align:'CENTER',sortable:true">의뢰내용</th>
							<th data-options="field:'insertDt',width:'8%',halign:'CENTER',align:'CENTER',sortable:true">의뢰 일시</th>
							<th data-options="field:'miRqDt',width:'8%',halign:'CENTER',align:'CENTER',sortable:true">실물 접수</th>
							<th data-options="field:'miKey',width:'8%',halign:'CENTER',align:'CENTER',sortable:true">계측기</th>
							<th data-options="field:'statusNm',width:'7%',halign:'CENTER',align:'CENTER',sortable:true">상태</th>
							<th data-options="field:'miStart',width:'8%',halign:'CENTER',align:'CENTER',sortable:true">계측 시작</th>
							<th data-options="field:'miEnd',width:'8%',halign:'CENTER',align:'CENTER',sortable:true">계측 완료</th>
							<th data-options="field:'miRqDeptNm',width:'8%',halign:'CENTER',align:'CENTER',sortable:true">의뢰 부서</th>
							<th data-options="field:'miRqUserNm',width:'6%',halign:'CENTER',align:'CENTER',sortable:true">의뢰자</th>
							<th data-options="field:'miRqFoupId',width:'10%',halign:'CENTER',align:'CENTER',sortable:true">FOUP ID</th>
							<th data-options="field:'miRqG',width:'7%',halign:'CENTER',align:'CENTER',sortable:true">의뢰 항목</th>
							<th data-options="field:'miRqRecipe',width:'12%',halign:'CENTER',align:'CENTER',sortable:true">RECIPE</th>
							<th data-options="field:'slotCnt',width:'3%',halign:'CENTER',align:'CENTER',sortable:true">SLOT<br>매수</th>
						</tr>
                    </thead>
                </table>
    <br>
    <!-- <button type="button" class="btn btn-primary" id="miRqMain" style="float:right;" onclick="fn_miRqMain()">홈 바로가기</button> -->
        </div>
    </div>
</div>

    <input type="hidden" name="_csrf" id="csrf" value=""/>
