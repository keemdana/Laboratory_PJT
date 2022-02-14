<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form name="form1" id="form1">
	<input type="hidden" id="patiUid"  value="<c:out value="${param.patiUid}"/>" />
</form>
	<table class="basic">
	<tr>
		<th class="th2">파티클_관리번호</th>
		<td class="td2" data-col="patiMngNo"></td>
	</tr>
	<tr>
		<th class="th2">파티클_명</th>
		<td class="td2" data-col="patiNm"></td>
	</tr>
	<tr>
		<th class="th2">파티클_구분</th>
		<td class="td2">
			<span data-col="patiType1LangCd"></span>-
			<span data-col="patiType2LangCd"></span>
		</td>
	</tr>
	<tr>
		<th class="th2">파티클_Class</th>
		<td class="td2" data-col="patiClassPath"></td>
	</tr>
	<tr>
		<th class="th2">파티클_입력_JSP</th>
		<td class="td2" data-col="patiJspWrtPath"></td>
	</tr>
	<tr>
		<th class="th2">파티클_조회_JSP</th>
		<td class="td2" data-col="patiJspViewPath"></td>
	</tr>
	<tr>
		<th class="th2">파티클_설명</th>
		<td class="td2" data-col="patiDesc">
		</td>
	</tr>
	<tr>
		<th class="th2">VIEW_전용_파티클여부</th>
		<td class="td2" data-col="patiOnlyViewYn">
		</td>
	</tr>

	</table>

	<div class="buttonlist">
		<div class="right">
			<input type="button" id="btnWritePage" value="작성화면" class="btn70"/>
			<input type="button" id="btnViewPage" value="뷰화면" class="btn70"/>
			<input type="button" id="btnSource" value="파티클소스코드 생성" class="btn140"/>
			<input type="button" id="btnModify" data-term="B.수정" value="" class="btn70" onclick="goModify(this.form)" />
			<input type="button" id="btnList" data-term="B.CLOSE"  value="" class="btn70" onclick="window.close()" /><br /><br />
			<font color="red" id="sourceAlert" style="display: none;">※파티클 소스코드 및 테이블이 이미 생성되어 있어 파티클 소스코드를 생성할 수 없습니다. <br>다시 소스코드 및 테이블을 생성하시려면, 파티클관리 테이블의 소스코드 생성여부유무를 N으로 변경 및 테이블을 삭제하신 후
			진행하시기 바랍니다.</font>
		</div>
	</div>
<script type="text/javascript">

"use strict";

function PaticleView(){
	var loadData = function(){
		var data = {};
		data["patiUid"] = $("#patiUid").val();
		paragonCmm.callAjax("/paragon/def/particlemng/ParticleMng/list/json",data, function(json){
			console.log(json.data[0]);
			$.each(json.data[0],function(k, v){
				var val;
				if(k.toUpperCase().indexOf("LANGCD") > -1){
					val = paragonCmm.getLang(v);
				}else{
					val = v;
				}
				$("[data-col='"+k+"']").append(val);
				if(k == "patiJspWrtPath"){	//--작성화면 이벤트
					$("#btnWritePage").on("click",function(){
						var url = val+".popup";
						paragonCmm.openWindow(url, "1024", "650", "POPUP_PATI_WRITE_FORM", "yes", "yes", "");
					});
				}
				if(k == "patiJspViewPath"){	//--뷰화면 이벤트
					$("#btnViewPage").on("click",function(){
						var url = val+".popup";
						paragonCmm.openWindow(url, "1024", "650", "POPUP_PATI_VIEW_FORM", "yes", "yes", "");
					});
				}
			});
			if(json.data[0].patiSourceWrtYn === "Y"){
				$("#btnSource").hide();
				$("#sourceAlert").show();
			}
		});
	}
	//-- 파티클 소스 생성
	var goPatiCreateSource = function(){
		var frm = $("#form1");
		confirm(paragonCmm.getLang("M.ALERT_SUBMIT","생성"), function(r){
			if (r) {
				var data = $(frm).serializeJSON();
				paragonCmm.callAjax("/paragon/def/particlemng/PaticleMng/createSource/json",data, function(json){
					alert("처리되었습니다.");
					window.close();
				});

			}
		})
	}

	var attchmentEvent = function(){

		$("#btnSource").on("click",function(){
			goPatiCreateSource();
		});


	}
	var init = function(){
		attchmentEvent();
		loadData();
	}
	return{
		init:init
	}
}
var patiView = new PaticleView();
patiView.init();

</script>