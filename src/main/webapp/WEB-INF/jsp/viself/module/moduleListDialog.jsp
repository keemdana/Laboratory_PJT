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
<div class="content-panel">
	<form id="moudleListform1" name="moudleListform1" method="post" onsubmit="return false;">
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
		                    <col width="10%" />
		                    <col width="25%" />
		                    <col width="20%" />
		                    <col width="30%" />
		                    <col />
		                </colgroup>
		                <tr>
		                	<th data-term="L.모듈"></th>
							<td>
								<input type="text" name="moduleId" id="moduleId" data-type="search"  maxlength="30" class="text width_max" />
							</td>
			                <th>
	      					   	<span class="ui_btn medium icon" id="moduleSearchBtn"><i class="fa fa-search" ><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
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
	<div class="buttonlist">
		<div class="left">
        </div>
        <div class = "right">
          	<span class="ui_btn small icon" id="moduleListProc"><i class="fa fa-check"><a class="btn_search" data-term="B.처리"></a></i></span>
        </div>
     </div>
    <table class="list" id="ModuleListTable">
		<thead >
		<tr>
			<th style="width:5%"   data-opt='{"align":"center"
														,"html":{"type":"radio"
																,"name":"chkModule"
																,"valueField":"moduleId"
														}
													}'></th>
			<th style="width:15%" data-opt='{"align":"center","col":"moduleId"}' >Module</th>
			<th style="width:15%" data-opt='{"align":"center","col":"moduleDesc"}'>Description</th>
		</tr>
		</thead>
		<tbody id="ModuleListTableBody">
		</tbody>
	</table>
	<%-- 페이지 목록 --%>
	<div class="pagelist" id="ModuleListTablePage"></div>
</div>
<script>
function Module_List(){

	var loadTable = function(pageNo){
		if(pageNo == undefined) pageNo =1;
		var data = paragonCmm.getSearchQueryParams($("#moudleListform1"));
		data["page"] = pageNo;
		data["rows"] = "10";

		paragonCmm.callAjax("/viself/module/moduleMng/moduleList/json",data, function(json){
		  var data = paragonCmm.easyuiLoadFilter(json);
		  var page = pageNo;
		  var rowCnt = 10;
		  console.log(data);
		  htmlUtils.createTableRow("ModuleListTable", data, page, rowCnt, "moduleList.loadTable");

		});
	}
	var setCallback;
	var attachEvents = function(){
		$("#moduleListProc").off();
		$("#moduleListProc").on("click",function(){
			var $chkId = $("input:radio[name='chkModule']:checked");
			if($chkId.length == 0){
				alert("모듈을 선택해 주세요.");
				return false;
			}
			if(typeof setCallback === "function"){
				setCallback($chkId.val());
			}
		});
		$("#moduleSearchBtn").off();
		$("#moduleSearchBtn").on("click",function(){
			loadTable(1);
		});
		$("#moduleId").off();
		$("#moduleId").on("keyup",function(){
			if (isCheckEnter && event.keyCode != 13) {
				return;
			}
			loadTable(1);
		});
	}
	var init = function(initFunc, callbackFunc){
		if(typeof callbackFunc === "function"){
			setCallback = callbackFunc;
		}
		loadTable();
		attachEvents();
	}
	return {
		init:init,
		loadTable:loadTable
	}
}
var moduleList = new Module_List();
</script>