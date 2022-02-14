<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%=SysStaticDataController.sysNoLang.toString() %> --%>
<section class="wrapper">
	<h3><i class="fa fa-angle-right" id="content_header" data-term="L.문서리스트"> </i></h3>
	<div class="content-panel">
		<form name="form1" method="post">
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
						<col style="width:8%" />
						<col style="width:15%" />
						<col style="width:10%" />
						<col style="width:20%" />
						<col style="width:10%" />
						<col style="width:28%" />
						<col style="width:auto" />
					</colgroup>
					<tr>
						<th data-term="L.관리번호"></th>
						<td><input type="text" name="patiMngNo" value="" style="width:90%" data-type="search" class="text" onkeydown="dataCube.doSearch(true)" /></td>
						<th data-term="파티클명칭"></th>
						<td><input type="text" name="patiNm" value="" style="width:90%" data-type="search" class="text" onkeydown="dataCube.doSearch(true)" /></td>
						<th data-term="파티클_구분"></th>
						<td>
	<%-- 						<%=HtmlUtil.getSelect(true, "PATI_TYPE_1", "PATI_TYPE_1", sysPatiGbnStr, schSysPatiGbn01, "class=\"select\" data-type='search' onChange=\"getSysPatiGbnCode('PATI_TYPE_2', this.value);\"") %> --%>
	<%-- 						<%=HtmlUtil.getSelect(true, "PATI_TYPE_2", "PATI_TYPE_2", "|--선택--", schSysPatiGbn02, "class=\"select\"  data-type='search'") %> --%>
						</td>
						<td style="text-align:center;">
							<span class="ui_btn medium icon"><i class="fa fa-search" onclick="dataCube.doSearch();"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
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
				<div class="left">
				</div>
				<div class="right">
<!-- 					<span class="ui_btn medium icon"><i class="fa fa-plus" onclick="dataCube.goWrite();"><a href="javascript:void(0)" >파티클 추가</a></i></span> -->
				</div>
			</div>
			<table class="list" id="DataCubeTable">
				<thead >
				<tr>
					<th style="width:5%" data-opt='{"align":"center","col":"ROWSEQ"}'>No.</th>
					<th style="width:8%" data-opt='{"align":"center","col":"mngNo"}' data-term="L.관리번호"></th>
					<th style="width:22%" data-opt='{"align":"center","col":"docUid"}' >문서Uid</th>
					<th style="width:22%" data-opt='{"align":"center","col":"solMasUid"}' >솔루션Uid</th>
					<th style="width:12%" data-opt='{"align":"center","col":"stuLangCd"}'>상태명</th>
					<th style="width:*" data-opt='{"align":"center","col":"docNmLangCd"}'>문서명</th>
					<th style="width:65px" data-opt='{"align":"center","html":{"type":"BTN","class":"fa fa-pencil","callback":"dataCube.goWrite(\"@{stuCd}\",\"@{docUid}\")","title":"B.WRITE"}}'></th>
				</tr>
				</thead>
				<tbody id="DataCubeTableBody">
				</tbody>
			</table>
			<%-- 페이지 목록 --%>
			<div class="pagelist" id="DataCubeTablePage"></div>
	</div>
</section>
<script>
	function DataCube(){


		var doInit = function(frm){
			frm.reset();
		}
		var goWrite = function(stuCd,docUid){
			var imsiForm = $("<form method='POST'>").attr("action","/paragon/def/defStuForm/stuFormWrite.popup");
			imsiForm.append($("<input type='hidden' name='stuCd'>").val(stuCd));
			imsiForm.append($("<input type='hidden' name='docUid'>").val(docUid));
			paragonCmm.openWindow("", "1024", "650", "POP_WRITE_"+stuCd, "yes", "yes", "");
			imsiForm.attr("target","POP_WRITE_"+stuCd);
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();
		}

		var reject = function(){
		    $('#listTable').datagrid('rejectChanges');
		}

		var loadGrid = function(pageNo){
			if(pageNo == undefined) pageNo =1;
			var data = paragonCmm.getSearchQueryParams();
			data["page"] = pageNo;
			data["rows"] = "10";

			paragonCmm.callAjax("/paragon/datacube/DataCube/list/json",data, function(json){
				var data = paragonCmm.easyuiLoadFilter(json);
				var page = pageNo;
				var rowCnt = 10;

				htmlUtils.createTableRow("DataCubeTable", data, page, rowCnt, "dataCube.loadGrid");

			});

		}
		var doSearch = function(isCheckEnter){
			if (isCheckEnter && event.keyCode != 13) {
				return;
			}

			loadGrid();
		}
		var init = function(){
			loadGrid();
		}
		return{
	    	init : init,
	    	loadGrid:loadGrid,
	    	doSearch:doSearch,
	    	goWrite:goWrite
	    }
	}
	var dataCube = new DataCube();
	dataCube.init();
</script>