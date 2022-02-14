<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form name="form1" id="form1" method="post">
<input type="hidden" name="loginIds" id="loginIds"value="<c:out value="${param.loginIds}"/>" />
<table class="basic">
	<caption>사용자 권한 변경</caption>
	<tr>
		<th class="th2" data-term="L.대상자"></th>
		<td class="td2" id="userNms">
		</td>
	</tr>
	<tr>
		<th class="th2" data-term="L.사용자권한"></th>
		<td class="td2" id="userAuths">
		</td>
	</tr>
	<tr>
		<th class="th2" data-term="L.상태"></th>
		<td class="td2">
			<select name="useYn" id="useYn" data-type="search" class="select">
				<option value="" data-term="L.CBO_ALL"></option>
				<option value="Y" data-term="L.재직" selected></option>
				<option value="N" data-term="L.퇴직"></option>
			</select>
		</td>
	</tr>
</table>
</form>
<br><br>
<div class="buttonlist">
	<div class="right">
		<span class="ui_btn medium icon" id="btnSave"><i class="fa fa-save" ><a href="javascript:void(0)"  data-term="B.CONFIRM"></a></i></span>
		<span class="ui_btn medium icon"><i class="fa fa-check" onclick="window.close();"><a href="javascript:void(0)"  data-term="B.CLOSE"></a></i></span>
	</div>
</div>
<script type="text/javascript">

"use strict";

function HrMngWrite(){

	var tmplAuth ="";

	//-- 이벤트 등록
	var attchmentEvent = function(){
		//--저장 이벤트
		$("#btnSave").on("click",function(){
			doSubmit();
		});

	}
	//-- 저장 데이터 LOAD
	var loadData = function(){
		//-- 마스터 데이터 LOAD
		var data = {};
		data["loginIds"] = $("#loginIds").val();
		paragonCmm.callAjax("/paragon/hr/hrMng/userList/json",data, function(json){
			$("#userNms").html("");
			$(json.data).each(function(i, d){
				if($("#userNms").text().trim() != ""){
					$("#userNms").append(",");
				}
				$("#userNms").append($("<span>").text(d.nmKo));
			});
			if($("#loginIds").val().indexOf(",") < 0){
				var authCd = json.data[0].authCd;
				var arrAuth = authCd.split(",");
				$(arrAuth).each(function(i, e){
					$("input:checkbox[name='authCd'][value='"+e+"']").prop("checked",true);
				});
				$("#useYn").val(json.data[0].useYn);
			}
		});	//-- Async 동기



	}

	var doSubmit = function(){
		// 저장 프로세스
		if($("input:checkbox[name='authCd']:checked").length == 0){
			alert("권한을 1개 이상 선택하세요.");
			return false;
		}
		if($("#useYn").val() == ""){
			alert("사용여부를 선택해 주세요.");
			return false;
		}
		var msg = paragonCmm.getLang("M.하시겠습니까", "B.SAVE");
		confirm(msg, function(r){
			if(r){
				var data = {};
				data["loginIds"] = $("#loginIds").val();
				var authCdStr = (function(){
					var rtn = "";
					$("input:checkbox[name='authCd']:checked").each(function(i,o){
						if(i > 0) rtn += ",";
						rtn += $(o).val();
					});
					return rtn;
				})();
				console.log(authCdStr);
				data["authCd"] = authCdStr;
				data["useYn"] = $("#useYn").val();

				paragonCmm.callAjax("/paragon/hr/hrMng/update/json",data, function(json){
						if(opener){
							opener.hrMng.doSearch();
							window.close();
						}else{
							init();
						}
				});
			}
		})
	}
	var init = function(){
		htmlUtils.loadCodeStr("USER_AUTH","cdAbb,langCd","",function(str){
			tmplAuth = str;
		});

		//--사용자권한 권한 로드
		$("#userAuths").html(htmlUtils.getInputCheckbox("authCd", tmplAuth));

		//-- 이벤트 등록
		attchmentEvent();
		//--데이터 로드
		loadData();
	}
	return{
		init:init,
		doSubmit:doSubmit
	}
}
var hrMngWrite = new HrMngWrite();
hrMngWrite.init();

</script>