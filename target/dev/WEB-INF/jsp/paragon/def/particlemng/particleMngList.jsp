<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%=SysStaticDataController.sysNoLang.toString() %> --%>


<div class="row mt">
	<h5 class="sub1_title" data-term="L.파티클정의"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<!-- Search AREA -->
			<form id="form1" method="post">
                <div class="row sub1_search">
                	<div class="col-md-10">
                		<div class="row">
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="L.관리번호"></span>
                                <input type="text" name="patiMngNo" id="patiMngNo" class="form-control input-sm" data-type="search" >
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="파티클명칭"></span>
                                <input type="text" name="patiNm" id="patiNm" class="form-control input-sm" data-type="search" >
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="파티클구분"></span>
                				<select id="urlMngSelect2" name="useYn" class="form-control input-sm" data-type="search"></select>
                			</div>
                		</div>
                	</div>
                	<div class="col-md-2">
                    	<button type="button" class="btn btn-primary " onclick="PARTICLE.doSearch();" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                        <button type="button" class="btn btn-default " onclick="$('#form1').reset();" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                    </div>
                </div>
              </form>
			</div>
		</div>
	</div>
</div>
<div class="row mt">
	<div class="col-md-12 col-sm-12 donut-chart" style="text-align: right;">
		<button type="button" class="btn btn-default" onclick="PARTICLE.goWrite();" data-term="L.추가"><i class="fa fa-plus"></i> </button>
	</div>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-table donut-chart">
			<table class="list" id="SysMngPtiTable">
				<thead >
				<tr data-opt='{"onClick":"PARTICLE.goView(\"@{patiUid}\")"}'>
					<th style="width:5%" data-opt='{"align":"center","col":"ROWSEQ"}'>No.</th>
					<th style="width:15%" data-opt='{"align":"center","col":"patiMngNo"}' data-term="L.관리번호"></th>
					<th style="width:15%" data-opt='{"align":"center","col":"patiTpCdLangCd"}' data-term="L.파티클구분_1"></th>
					<th style="width:15%" data-opt='{"align":"center","col":"patiTpCd2LangCd"}' data-term="L.파티클구분_2"></th>
					<th style="width:*" data-opt='{"align":"center","col":"patiNm"}' data-term="L.파티클명"></th>
					<th style="width:10%" data-opt='{"align":"center","col":"useDocCnt"}' data-term="L.사용문서수"></th>
				</tr>
				</thead>
				<tbody id="SysMngPtiTableBody">
				</tbody>
			</table>
			<%-- 페이지 목록 --%>
			<div class="pagelist" id="SysMngPtiTablePage"></div>
		</div>
	</div>
</div>


<%--
<div class="content-panel p-3 site-min-height">
	<h3><i class="fa fa-angle-right" id="content_header" data-term="L.파티클정의"> </i></h3>
	<div >
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
						<td><input type="text" name="patiMngNo" value="" style="width:90%" data-type="search" class="text" onkeydown="PARTICLE.doSearch(true)" /></td>
						<th data-term="파티클명칭"></th>
						<td><input type="text" name="patiNm" value="" style="width:90%" data-type="search" class="text" onkeydown="PARTICLE.doSearch(true)" /></td>
						<th data-term="파티클_구분"></th>
						<td>
							<%=HtmlUtil.getSelect(true, "PATI_TYPE_1", "PATI_TYPE_1", sysPatiGbnStr, schSysPatiGbn01, "class=\"select\" data-type='search' onChange=\"getSysPatiGbnCode('PATI_TYPE_2', this.value);\"") %>
							<%=HtmlUtil.getSelect(true, "PATI_TYPE_2", "PATI_TYPE_2", "|--선택--", schSysPatiGbn02, "class=\"select\"  data-type='search'") %>
						</td>
						<td style="text-align:center;">
							<span class="ui_btn medium icon"><i class="fa fa-search" onclick="PARTICLE.doSearch();"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
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
					<span class="ui_btn medium icon"><i class="fa fa-plus" onclick="PARTICLE.goWrite();"><a href="javascript:void(0)" >파티클 추가</a></i></span>
				</div>
			</div>
			<table class="list" id="SysMngPtiTable">
				<thead >
				<tr data-opt='{"onClick":"PARTICLE.goView(\"@{patiUid}\")"}'>
					<th style="width:5%" data-opt='{"align":"center","col":"ROWSEQ"}'>No.</th>
					<th style="width:15%" data-opt='{"align":"center","col":"patiMngNo"}' data-term="L.관리번호"></th>
					<th style="width:15%" data-opt='{"align":"center","col":"patiTpCdLangCd"}' data-term="L.파티클구분_1"></th>
					<th style="width:15%" data-opt='{"align":"center","col":"patiTpCd2LangCd"}' data-term="L.파티클구분_2"></th>
					<th style="width:*" data-opt='{"align":"center","col":"patiNm"}' data-term="L.파티클명"></th>
					<th style="width:10%" data-opt='{"align":"center","col":"useDocCnt"}' data-term="L.사용문서수"></th>
				</tr>
				</thead>
				<tbody id="SysMngPtiTableBody">
				</tbody>
			</table>
			페이지 목록
			<div class="pagelist" id="SysMngPtiTablePage"></div>
	</div>
</div>
 --%>
<script>
	function Particle(){


		var doInit = function(frm){
			frm.reset();
		}
		var goWrite = function() {
			var url = "/paragon/def/particlemng/particleWrite.popup";

			var imsiForm = $("<form method='POST'>").attr("action",url);
			imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
			paragonCmm.openWindow("", "1024", "450", "POP_WRITE_PARTICLE", "yes", "yes", "");
			imsiForm.attr("target","POP_WRITE_PARTICLE");
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();

		}
		var goView = function(patiUid) {
			var url = "/paragon/def/particlemng/particleView.popup?patiUid="+patiUid;
			paragonCmm.openWindow(url, "1024", "650", "POPUP_WRITE_FORM", "yes", "yes", "");
		}

		var reject = function(){
		    $('#listTable').datagrid('rejectChanges');
		}

		var loadGrid = function(pageNo){
			if(pageNo == undefined) pageNo =1;
			var data = paragonCmm.getSearchQueryParams();
			data["page"] = pageNo;
			data["rows"] = "10";

			paragonCmm.callAjax("/paragon/def/particlemng/ParticleMng/list/json",data, function(json){
			  var data = paragonCmm.easyuiLoadFilter(json);
			  var page = pageNo;
			  var rowCnt = 10;

			  htmlUtils.createTableRow("SysMngPtiTable", data, page, rowCnt, "PARTICLE.loadGrid");

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
	    	goWrite:goWrite,
	    	goView:goView
	    }
	}
	var PARTICLE = new Particle();
	PARTICLE.init();
</script>