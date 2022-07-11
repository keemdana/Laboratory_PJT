<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2021-03-16(016)
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
  -     URL 검색/선택용 다이얼로그
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>

<div class="content-panel" style="width:30%; float:left; margin:-15px 10px 10px 10px;">
	<form id="lineListform" name="lineListform" method="post" onsubmit="return false;">
	<p>
	    <table class="box">
		    <tr>
		        <td class="corner_lt"></td><td class="border_mt"></td><td class="corner_rt"></td>
		    </tr>
		    <tr>
		        <td class="border_lm"></td>
		        <td class="body">
		            <table>
		                <colgroup>
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col />
		                </colgroup>
		                <tr>
		                	<th>Line</th>
							<td>
								<input type="text" name="line" id="line" data-type="search" maxlength="30" class="text width_max" />
							</td>
			                <th>
	      					   	<span class="ui_btn medium icon" id="searchLineBtn"><i class="fa fa-search" ><a data-term="B.SEARCH"></a></i></span>
							</th>
							<th>
	      					   	<!-- <span class="ui_btn small icon" id="custListProc"><i class="fa fa-check"><a class="btn_search" data-term="B.처리"></a></i></span> -->
							</th>
		                </tr>
		            </table>
		        </td>
		        <td class="border_rm"></td>
		    </tr>
		    <tr>
		        <td class="corner_lb"></td><td class="border_mb"></td><td class="corner_rb"></td>
		    </tr>
	    </table>
	</form>	
    <!-- <table class="list" id="LineListTable">
		<thead >
		<tr>
			<th style="width:5%"   data-opt='{"align":"center"
														,"html":{"type":"radio"
																,"name":"chkModule"
																,"valueField":"dname"
														}
													}'></th>
			<th style="width:15%" data-opt='{"align":"center","col":"dcode"}' >고객코드</th>
			<th style="width:15%" data-opt='{"align":"center","col":"dname"}'>고객사명</th>
		</tr>
		</thead>
		<tbody id="LineListTableBody">
		</tbody>
	</table> -->
	<table id="LineListTable"></table>
</div>



<div class="content-panel" style="width:33%; float:left; margin:-15px 10px 10px 0px;">
	<form id="prodListform" name="prodListform" method="post" onsubmit="return false;">
	<p>
	    <table class="box">
		    <tr>
		        <td class="corner_lt"></td><td class="border_mt"></td><td class="corner_rt"></td>
		    </tr>
		    <tr>
		        <td class="border_lm"></td>
		        <td class="body">
		            <table>
		                <colgroup>
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col />
		                </colgroup>
		                <tr>
		                	<th>제품유형</th>
							<td>
								<input type="text" name="product" id="product" data-type="search" maxlength="30" class="text width_max" />
							</td>
			                <th>
	      					   	<span class="ui_btn medium icon" id="searchProdBtn"><i class="fa fa-search" ><a data-term="B.SEARCH"></a></i></span>
							</th>
							<th>
	      					   	<!-- <span class="ui_btn small icon" id="custListProc"><i class="fa fa-check"><a class="btn_search" data-term="B.처리"></a></i></span> -->
							</th>
		                </tr>
		            </table>
		        </td>
		        <td class="border_rm"></td>
		    </tr>
		    <tr>
		        <td class="corner_lb"></td><td class="border_mb"></td><td class="corner_rb"></td>
		    </tr>
	    </table>
	</form>
	<!-- <div class="clearfix">
        <div class="datatable-btns p-1">
        </div>
        <div id="urlMngPager1" class="float-left w-50"></div>
    </div> -->
	<table id="ProdListTable"></table>
</div>

<div class="content-panel" style="width:33%; float:left; margin:-15px 10px 10px 0px;">
	<form id="processListform" name="processListform" method="post" onsubmit="return false;">
	<p>
	    <table class="box">
		    <tr>
		        <td class="corner_lt"></td><td class="border_mt"></td><td class="corner_rt"></td>
		    </tr>
		    <tr>
		        <td class="border_lm"></td>
		        <td class="body">
		            <table>
		                <colgroup>
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col width="25%" />
		                    <col />
		                </colgroup>
		                <tr>
		                	<th>Process</th>
							<td>
								<input type="text" name="process" id="process" data-type="search" maxlength="30" class="text width_max" />
							</td>
			                <th>
	      					   	<span class="ui_btn medium icon" id="searchProcessBtn"><i class="fa fa-search" ><a data-term="B.SEARCH"></a></i></span>
							</th>
							<th>
	      					   	<!-- <span class="ui_btn small icon" id="custListProc"><i class="fa fa-check"><a class="btn_search" data-term="B.처리"></a></i></span> -->
							</th>
		                </tr>
		            </table>
		        </td>
		        <td class="border_rm"></td>
		    </tr>
		    <tr>
		        <td class="corner_lb"></td><td class="border_mb"></td><td class="corner_rb"></td>
		    </tr>
	    </table>
	</form>
	<table id="ProcessListTable"></table>
    <!-- <table class="list" id="ProcessListTable">
		<thead >
		<tr>
			<th style="width:5%"   data-opt='{"align":"center"
														,"html":{"type":"radio"
																,"name":"chkModule"
																,"valueField":"dname"
														}
													}'></th>
			<th style="width:15%" data-opt='{"align":"center","col":"dcode"}' >고객코드</th>
			<th style="width:15%" data-opt='{"align":"center","col":"dname"}'>고객사명</th>
		</tr>
		</thead>
		<tbody id="ProcessListTableBody">
		</tbody>
	</table> -->
</div>
<div class="buttonlist">
    <div class="right" style="margin-right:25px;">
        <button type="button" class="btn btn-primary" id="btnSulbiSave" data-term="L.저장"><i class="fa fa-check"></i> </button>
    </div>
</div>


<script>
function Module_List(){
	
	var loadSulbiList = function(gubun, schData, newSch){
		
		var $grid = ""
		var data = "";
		var hcode = "";
		var schNm = "";
		
		if(gubun == "line"){
			$grid = $("#LineListTable");
			data = paragonCmm.getSearchQueryParams($("#lineListform"));
			data["hcode"] = "IEHM02";			
			schNm = "Line";
		}else if(gubun == "product"){
			$grid = $("#ProdListTable");
			data = paragonCmm.getSearchQueryParams($("#prodListform"));
			data["hcode"] = "ISCM25";			
			schNm = "제품유형";
		}else if(gubun == "process"){
			$grid = $("#ProcessListTable");
			data = paragonCmm.getSearchQueryParams($("#processListform"));
			data["hcode"] = "IEHM03";			
			schNm = "Process";
		}
		
		data["dname"] = schData;
		data["newSch"] = newSch;
		
	    var rowStyler = function(index, row){
	        if (row.cud === "C" || row.isNewRecord){
	            return "background-color:#6293BB;color:#fff;font-weight:bold;";
	        }
	    };

		$grid.datagrid({
	        url: "/voc/getSulbiList/json",
	        method: "post",
	        queryParams: data,//+"&hcode="+hcode,//paragonCmm.getSearchQueryParams($("#prodListform")),
	        loadFilter: paragonCmm.easyuiLoadFilter,
	        height: 420,
	        striped: true,
	        fitColumns: true,
	        nowrap: true,
	        multiSort: true,
	        remoteSort: true,
	        rownumbers: true,
	        singleSelect: true, //(check) multi / single
	        checkOnSelect: true, // row 를 클릭 시 체크박스 선택(false : 체크박스 클릭 필요)
	        selectOnCheck: true,
	        pagination: true,
	        pagePosition: "bottom",
	        pageSize: 10,	//최초 조회 시 갯수
	        rowStyler: rowStyler,
	        columns: [[	//field 값은 컬럼명 중 _ 있을 경우 대문자로 구분하여 표기
	            {
	                field: "no", checkbox: true, width: "10%", toExcel: false	// unique key
	            }, 
	            {
	                field: "dcode", title: "코드", formatter: filterXSS, width: "48%"
	            }, 
	            {
	                field: "dname", title: schNm, formatter: filterXSS, width: "48%"
	            }            
	        ]]
	    });		
		
		data["newSch"] = "N";
	}
	<%--
	var loadTable = function(pageNo){
		if(pageNo == undefined) pageNo =1;
		var data = paragonCmm.getSearchQueryParams($("#lineListform"));
		data["page"] = pageNo;
		data["rows"] = "10";

		paragonCmm.callAjax("/voc/getCustList/json",data, function(json){
		  var data = paragonCmm.easyuiLoadFilter(json);
		  var page = pageNo;
		  var rowCnt = 10;
		  console.log(data);
		  htmlUtils.createTableRow("LineListTable", data, page, rowCnt, "moduleList.loadTable");

		});
		
		if(pageNo == undefined) pageNo =1;
		var data = paragonCmm.getSearchQueryParams($("#processListform"));
		data["page"] = pageNo;
		data["rows"] = "10";

		paragonCmm.callAjax("/voc/getCustList/json",data, function(json){
		  var data = paragonCmm.easyuiLoadFilter(json);
		  var page = pageNo;
		  var rowCnt = 10;
		  console.log(data);
		  htmlUtils.createTableRow("ProcessListTable", data, page, rowCnt, "moduleList.loadTable");

		});
	}
	--%>
	
	var setCallback;
	var attachEvents = function(){
		$("#searchLineBtn").off();
		$("#searchLineBtn").on("click",function(){
			var schData = $("#line").val();
			loadSulbiList("line", schData, "Y");
		});
		
		$("#searchProdBtn").off();
		$("#searchProdBtn").on("click",function(){
			var schData = $("#product").val();
			loadSulbiList("product", schData, "Y");
		});
		
		$("#searchProcessBtn").off();
		$("#searchProcessBtn").on("click",function(){
			var schData = $("#process").val();
			loadSulbiList("process", schData, "Y");
		});
		
		$("#btnSulbiSave").off();
		$("#btnSulbiSave").on("click", function(){
			var lineRows = $("#LineListTable").datagrid("getSelections");
			var prodRows = $("#ProdListTable").datagrid("getSelections");
			var processRows = $("#ProcessListTable").datagrid("getSelections");
			
			if(lineRows.length == 0 || prodRows.length == 0 || processRows.length == 0){
	            alert("선택이 안됨");
				return false;
	        }
			
			var lineCd = $("#LineListTable").datagrid("getSelections")[0].dcode;
			var lineNm = $("#LineListTable").datagrid("getSelections")[0].dname;
			var prodCd = $("#ProdListTable").datagrid("getSelections")[0].dcode;
			var prodNm = $("#ProdListTable").datagrid("getSelections")[0].dname;
			var processCd = $("#ProcessListTable").datagrid("getSelections")[0].dcode;
			var processNm = $("#ProcessListTable").datagrid("getSelections")[0].dname;
			
			var line = [];
			line["lineCd"] = lineCd;
			line["lineNm"] = lineNm;
			
			var product = [];
			product["prodCd"] = prodCd;
			product["prodNm"] = prodNm;
			
			var process = [];
			process["processCd"] = processCd;
			process["processNm"] = processNm;
			
			setSulbiList(line, product, process);
	    });
	}
	
	var init = function(initFunc, callbackFunc){
		if(typeof callbackFunc === "function"){
			setCallback = callbackFunc;
		}
		
		//loadTable();
		loadSulbiList("line", "", "N");
		loadSulbiList("product", "", "N");
		loadSulbiList("process", "", "N");
		
		attachEvents();
		
		/* $("#searchBtn").off();
		$("#searchBtn").on("click",function(){
			var custNm = $("input:text[id='custNm']").val();

			alert(custNm);
		}); */
	}
	return {
		init:init,
		//loadTable:loadTable
	}
	
	/* saveRow: function(jq){
		return jq.each(function(){
			var dg = $("#LineListTable");
			var opts = $.data(this, 'edatagrid').options;
			if (opts.editIndex >= 0){
				if (opts.onBeforeSave.call(this, opts.editIndex) == false) {
					setTimeout(function(){
						dg.datagrid('selectRow', opts.editIndex);
					},0);
					return;
				}
				$(this).datagrid('endEdit', opts.editIndex);
			}
		});
	}, */
	
	
}
var moduleList = new Module_List();
console.info("[Loading Module: URL관리].....................");

</script>

