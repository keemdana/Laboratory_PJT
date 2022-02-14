<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="listTabsLayer" class="easyui-tabs" data-options="border:false,plain:true" style="width:auto;height:auto">
	<div id="listTabs-LIST" title="사용자권한관리" style="padding-top:5px;" data-options="selected:true">
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
						<col style="width:8%" />
						<col style="width:8%" />
						<col style="width:30%" />
						<col style="width:8%" />
						<col style="width:10%" />
						<col style="width:8%" />
						<col style="width:10%" />
						<col style="width:auto" />
					</colgroup>
					<tr>
						<th data-term="L.이름"></th>
						<td >
							<input type="text" class="text width_max" name="nmKo" data-type="search" onkeyup="hrMng.doSearch(true)"/>
						</td>
						<th data-term="L.부서"></th>
						<td>
							<input type="text" class="text width_max" name="deptNmKo" data-type="search" onkeyup="hrMng.doSearch(true)"/>
						</td>
						<td rowspan="2" class="verticalContainer">
							<span class="ui_btn medium icon"><i class="fa fa-search" onclick="hrMng.doSearch();"><a href="javascript:void(0)"  data-term="B.SEARCH"></a></i></span>
						</td>
					</tr>
					<tr>
						<th data-term="L.상태"></th>
						<td >
							<select name="useYn" data-type="search" class="select">
								<option value="" data-term="L.CBO_ALL"></option>
								<option value="Y" data-term="L.재직"></option>
								<option value="N" data-term="L.퇴직"></option>
							</select>
						</td>
						<th data-term="L.사용자권한"></th>
						<td >
							<select name="authCd" class="select" data-type="search"></select>
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
				    <span class="ui_btn medium icon" id="editBtn" ><i class="fa fa-edit" ><a href="javascript:void(0)" data-term="B.AUTH_MODIFY"></a></i></span>
				</div>
			</div>
			<table class="list" id="hrMngTable">
				<thead >
				<tr>
					<th style="width:5%"   data-opt='{"align":"center"
														,"html":{"type":"checkbox"
																,"name":"chkHr"
																,"valueField":"loginId"
																,"checkAll":true
														}
													}'></th>
					<th style="width:5%" data-opt='{"align":"center","col":"nmKo"}' data-term="L.이름"></th>
					<th style="width:10%" data-opt='{"align":"center","col":"positionLangCd"}' data-term="L.직위"></th>
					<th style="width:10%" data-opt='{"align":"center","col":"deptNmKo"}' data-term="L.부서"></th>
					<th style="width:15%" data-opt='{"align":"center","col":"telNo"}' data-term="L.연락처"></th>
					<th style="width:10%" data-opt='{"align":"center","col":"authLangCd"}'  data-term="L.사용자권한"></th>
					<th style="width:10%" data-opt='{"align":"center","col":"useYnLangCd"}'  data-term="L.상태"></th>
				</tr>
				</thead>
				<tbody id="hrMngTableBody">
				</tbody>
			</table>
			<%-- 페이지 목록 --%>
			<div class="pagelist" id="hrMngTablePage"></div>
	</div>
</div>
<script>
	function HrMng(){

		var doInit = function(frm){
			frm.reset();
		}
		var goEditor = function() {
			var loginIds = [];
			$("input:checkbox[name='chkHr']:checked").each(function(i, o){
				loginIds.push($(o).val());
			})
			if($(loginIds).length == 0){
				alert("변경할 사용자를 체크 하세요.");
				return false;
			}
			var imsiForm = $("<form method='POST'>").attr("action","/paragon/hr/hrMngWrite.popup");
			imsiForm.append($("<input type='hidden' name='loginIds'>").val(loginIds.join(",")));
			paragonCmm.openWindow("", "1024", "450", "POP_USER_EDIT", "yes", "yes", "");
			imsiForm.attr("target","POP_USER_EDIT");
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();
		}
		var loadGrid = function(pageNo){
			if(pageNo == undefined) pageNo =1;
			var data = paragonCmm.getSearchQueryParams();
			data["page"] = pageNo;
			data["rows"] = "10";

			paragonCmm.callAjax("/paragon/hr/hrMng/userList/json",data, function(json){
			  var data = paragonCmm.easyuiLoadFilter(json);
			  var page = pageNo;
			  var rowCnt = 10;

			  htmlUtils.createTableRow("hrMngTable", data, page, rowCnt, "hrMng.loadGrid");

			});

		}
		var doSearch = function(isCheckEnter){
			if (isCheckEnter && event.keyCode != 13) {
				return;
			}

			loadGrid();
		}
		var attchmentEvent = function(){
			$("#editBtn").on("click",function(){
				goEditor();
			});
		}
		var init = function(){
			htmlUtils.getCodeSelectOpt({
				targetNm:"authCd",
				parentCd:"USER_AUTH",
				initdata:"|"+paragonCmm.getLang("L.CBO_ALL"),
				valNm:"cdAbb",
				txtNm:"langCd"
			});

			attchmentEvent();	//-- 이벤트 등록
			loadGrid();			//-- 리스트 로드

		}
		return{
	    	init : init,
	    	loadGrid:loadGrid,
	    	doSearch:doSearch
	    }
	}
	var hrMng = new HrMng();
	hrMng.init();
</script>