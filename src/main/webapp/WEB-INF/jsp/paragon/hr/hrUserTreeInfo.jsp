<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%
	SysLoginVO loginUser 	=     (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();
	String siteCapital		= StringUtil.capitalize(siteLocale.toLowerCase());
	//-- 로그인 사용자 정보 셋팅
	String schFieldCodestr 		= "|--전체--^0|이름^1|부서";

%>

<style>
	.content{
		font-size : 0.85em;
	}
</style>
	<table style="width:100%;">
	<colgroup>
		<col width="48%" />
		<col width="4%" />
		<col width="48%" />
	</colgroup>
	<tr>
		<td valign="top">
			<form name="form1" method="post" onsubmit="return false;">
			<input type="hidden" name="parentCd" data-type="search"/>
			<table class="box">
				<colgroup>
					<col width="15%" />
					<col width="65%" />
					<col width="20%" />
				</colgroup>
				<tr>
					<th width="15%" id="schFieldArea"></th>
					<td width="65%">
						<input type="text" name="schValue" id="schValue" value="" data-type="search"  class="text width_max"/>
					</td>
					<td class="hbuttons">
						<span class="ui_btn medium icon" id="searchAprvBtn"><i class="fa fa-search"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
					</td>
				</tr>
			</table>
			</form>
			<div id="treeUserArea" style="width:98%;height:350px;vertical-align: top;border:1px solid #CDCDCD;overflow: auto;"></div>
		</td>
		<td></td>
		<td valign="top">
			<div style="width:98%;vertical-align: top;border:0px;overflow: auto;">
				<div class="buttonlist">
					<div class="left">
						<span class="ui_btn small icon" id="chkUserDel"><i class="fa fa-minus"><a href="javascript:void(0)" data-term="B.DELETE"></a></i></span>
					</div>
					<div class="right">
						<span class="ui_btn small icon"><i class="fa fa-download" onclick="UserGroupLoadOpen();"><a href="javascript:void(0)" data-term="B.불러오기"></a></i></span>
						<span class="ui_btn small icon"><i class="fa fa-pencil" onclick="UserGroupRegisterOpen();"><a href="javascript:void(0)" data-term="B.저장하기"></a></i></span>
					</div>
				</div>
				<table class="list">
					<colgroup>
						<col width="4%" />
						<col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th><input type="checkbox" id="userChkAll"/></th>
						<th data-term="L.사용자_정보"></th>
					</tr>
					</thead>
					<tbody id="hrUserList">
					</tbody>
				</table>
			</div>
		</td>
	</tr>
	</table>
	<div class="buttonlist">
		<span class="ui_btn medium icon" id="userConfirm"><i class="fa fa-check"><a href="javascript:void(0)" data-term="L.확인" ></a></i></span>
	</div>
<script id="addUserTmpl" type="text/x-jquery-tmpl">
<tr data-meaning="apvr_tr" id="sel_\${uuid}">
	<td align="center">
		<input type="checkbox"  value="sel_\${uuid}" name="chkSignList" >
	</td>
	<td align="center" data-meaning="data_td">
		\${dspNm<%=siteCapital%>}
		<input type="hidden" name="nmKo" value="\${nmKo}"/>
		<input type="hidden" name="nmEn" value="\${nmEn}"/>
		<input type="hidden" name="dspNmKo" value="\${dspNmKo}"/>
		<input type="hidden" name="dspNmEn" value="\${dspNmEn}"/>
		<input type="hidden" name="dspNmJa" value="\${dspNmJa}"/>
		<input type="hidden" name="dspNmZh" value="\${dspNmZh}"/>
		<input type="hidden" name="userNo" value="\${userNo}"/>
		<input type="hidden" name="loginId" value="\${loginId}"/>
		<input type="hidden" name="parentDeptCd" value="\${parentDeptCd}"/>
		<input type="hidden" name="parentCd" value="\${parentDeptCd}"/>
		<input type="hidden" name="parentDeptNmKo" value="\${parentDeptNmKo}"/>
		<input type="hidden" name="parentDeptNmEn" value="\${parentDeptNmEn}"/>
		<input type="hidden" name="dutyCd" value="\${dutyCd}"/>
		<input type="hidden" name="dutyLangCd" value="\${dutyLangCd}"/>
		<input type="hidden" name="positionCd" value="\${positionCd}"/>
		<input type="hidden" name="positionLangCd" value="\${positionLangCd}"/>
		<input type="hidden" name="deptNmPathKo" value="\${deptNmPathKo}"/>
		<input type="hidden" name="deptNmPathEn" value="\${deptNmPathEn}"/>
		<input type="hidden" name="deptNmKo" value="\${deptNmKo}"/>
		<input type="hidden" name="deptNmEn" value="\${deptNmEn}"/>
		<input type="hidden" name="deptCd" value="\${deptCd}"/>
		<input type="hidden" name="addrKo" value="\${addrKo}"/>
		<input type="hidden" name="addrEn" value="\${addrEn}"/>
		<input type="hidden" name="telephoneNo" value="\${telephoneNo}"/>
		<input type="hidden" name="mobileNo" value="\${mobileNo}"/>
		<input type="hidden" name="email" value="\${email}"/>
		<input type="hidden" name="registrationNo" value="\${registrationNo}"/>
		<input type="hidden" name="deptType" value="\${deptType}"/>
		<input type="hidden" name="useYn" value="\${useYn}"/>
		<input type="hidden" name="corpCd" value="\${corpCd}"/>
		<input type="hidden" name="corpNm" value="\${corpNm}"/>
	</td>
</tr>
</script>
<script type="text/javascript">
function HrAprv() {
	var callBackFnc;
	var chkUserId = function(json){
		 var data = json;
		 var arrObj = $("input:hidden[name='userNo']","#hrUserList");
		 var rtnBool = true;
		 arrObj.each(function(i, d){
			 if(data.userNo == $(d).val()){
				 rtnBool = false;
			 }
		 });

		 return rtnBool;
	}
    var selectNode = function(code_id){
    	var codGrp = $("#"+code_id);
    	var obj = codGrp.children("input:hidden");
    	var jsonData = {};
    	$(obj).each(function(i, d){
    		jsonData[$(d).attr("name")] = $(d).val();
    	});
    	//-- 이미 선택된 사용자인지 여부 체크!
    	if(chkUserId(jsonData)){
    		var data = jsonData;
    		$("#addUserTmpl").tmpl(data).appendTo("#hrUserList");
    	}
    	paragonCmm.tableTrDragSet("hrUserList");
	};
	var drawTree = function(){
		var arrDEPTH = [];
		//tree 불러오기
		treeInitSet("/paragon/hr/hrMng/treeList/json","USER",JSON.stringify(arrDEPTH),'');

		//그려넣을 id, 루트id, 최종
	    treeDrawChild("treeUserArea",null);
	}
	var doConfirm = function(){

		var chkB = true;
		var data = [];
		//-- 결재자 정보 수집
		var rowsApr = $("td[data-meaning='data_td']", "#hrUserList");
		$(rowsApr).each(function(i, tr){
			 var rowData = {};
			 //-- input TAG 처리
			 var $input = $("input:hidden", $(tr));
			 $input.each(function(j, e){
				 rowData[$(e).attr("name")] = $(e).val();
			 });
			 data.push(rowData);
		});

		if(typeof callBackFnc === "function"){
			callBackFnc(data);
		}
	}
	var doSearch = function(isCheckEnter) {
		if (isCheckEnter && event.keyCode != 13) {
			return;
		}
		if($("#schValue").val() != "" ){
			$("#treeUserArea").html("");
			treeDrawChild("treeUserArea","", paragonCmm.getSearchQueryParams());
		}else{
			$("#treeUserArea").html("");
			treeDrawChild("treeUserArea","",paragonCmm.getSearchQueryParams());
		}
	}
	var noneCheckApr = function(){
		if($("#none_apr_yn").is(":checked")){
			var msg = paragonCmm.getLang("M.전결알림");
			confirm(msg, function(r){
				if(r){
				$("tr", "#hrUserList").each(function(i, o){
					if(i == 0) return true;
					$(o).remove();
				});
				}else{
					$("#none_apr_yn").prop("checked",false);
				}
			});
		}
	}
	var attchmentEvent = function(){
		$("#schValue").off();	//-- 이벤트 초기화
		$("#schValue").on('keyup', function(){
			doSearch(true);
		});
		$("#searchAprvBtn").off();
		$("#searchAprvBtn").on('click', function(){
			doSearch();
		});
		$("#chkUserDel").off();
		$("#chkUserDel").on('click', function(){
			if($("input:checkbox[name='chkSignList']:checked").length == 0){
				alert(paragonCmm.getLang("M.삭제할대상체크해주세요"));
				return false;
			}else{
				$("input:checkbox[name='chkSignList']:checked").each(function(i, o){
					$("#"+$(o).val()).remove();
				});
			}

		});
		$("#userConfirm").off();
		$("#userConfirm").on('click', function(){
			doConfirm();
		});


	}
	//-- 기본결재선 셋팅
	var loadData = function(initData){
		if(typeof initData === "object"){
			paragonCmm.callAjax("/paragon/hr/hrMng/getDefaultLine",initData, function(json){
				$(json.data).each(function(i, jsonData){
					if(i == 0){
						jsonData["aprType"] = "S"; //-- 요청자
					}else{
						jsonData["aprType"] = "G"; //-- 기본 결재로
					}
					$("#addUserTmpl").tmpl(jsonData).appendTo("#hrUserList");
				});
				paragonCmm.tableTrDragSet("hrUserList");
			});
		}
	}
	var init = function (init, callback) {
		attchmentEvent();
		$("#schFieldArea").html(
			htmlUtils.getSelect("schField","schField", "<%=schFieldCodestr%>", "","data-type='search' class='select'")
		);
		drawTree();
		if(typeof init === "function"){
			loadData(init());
		}
		if(typeof callback === "function"){
			callBackFnc = callback;
		}

    };
	return{
    	init : init,
    	selectNode:selectNode
    }
}
var USER = new HrAprv();

</script>