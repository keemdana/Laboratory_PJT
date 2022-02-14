<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content-panel p-3">
	<h3><i class="fa fa-angle-right" id="content_header" data-term="L.파티클정의"> </i></h3>
	<div >
		<form name="form1" id="saveForm" method="post">
			<input type="hidden" name="patiUid" id="patiUid" 	value="<c:out value="${result.patiUid}"/>" />
			<input type="hidden" name="tempUid" id="tempUid" 	value="<c:out value="${StringUtil.getRandomUUID()}"/>" />
			<input type="hidden" name="cud" 	id="cud" 		value="<c:out value="${result.cud}"/>" />
			<input type="hidden" name="patiTpAbbCd" 	id="patiTpAbbCd" 		value="" />
			<input type="hidden" name="patiTpAbbCd2" 	id="patiTpAbbCd2" 		value="" />
			<input type="hidden" name="maxCnt" 			id="maxCnt" 		value="" />

			<table class="basic">
			<tr>
				<th class="th2">파티클_관리번호</td>
				<td class="td2"><c:out value="${result.patiNo}"/>
					<input type="text" name="patiMngNo" id="patiMngNo" value="<c:out value="${result.patiMngNo}"/>" readonly style="background-color:#EEEEEE;width:80%">
				</td>
			</tr>
			<tr>
				<th class="th2">파티클_명</th>
				<td class="td2"><input type="text" name="patiNm" id="patiNm" class="text width_max" value="<c:out value="${result.patiNm}"/>"></td>
			</tr>
			<tr>
				<th class="th2">파티클_구분</th>
				<td class="td2">
					<select name="patiTpCd" id="patiTpCd"></select>
					<select name="patiTpCd2" id="patiTpCd2"></select>
				</td>
			</tr>
			<tr>
				<th class="th2">파티클_Class</th>
				<td class="td2"><input type="text" name="patiClassPath" id="patiClassPath" value="<c:out value="${result.patiClassPath}"/>" readonly style="background-color:#EEEEEE;width:80%"><!-- <input type="checkbox" name="checkPatiClass" onClick="doCheckPatiClass()">직접입력 --></td>
			</tr>
			<tr>
				<th class="th2">파티클_입력_JSP</th>
				<td class="td2"><input type="text" name="patiJspWrtPath" id="patiJspWrtPath" value="<c:out value="${result.patiJspWrtPath}"/>" readonly style="background-color:#EEEEEE;width:80%"><!-- <input type="checkbox" name="checkPatiWrtJsp" onClick="doCheckPatiWrtJsp()">직접입력 --></td>
			</tr>
			<tr>
				<th class="th2">파티클_조회_JSP</th>
				<td class="td2"><input type="text" name="patiJspViewPath" id="patiJspViewPath" value="<c:out value="${result.patiJspViewPath}"/>" readonly  style="background-color:#EEEEEE;width:80%"><!-- <input type="checkbox" name="checkPatiWrtJsp" onClick="doCheckPatiViewJsp()">직접입력 --></td>
			</tr>
			<tr>
				<th class="th2">파티클_설명</th>
				<td class="td2">
					<textarea class="memo width_max" name="patiDesc" id="patiDesc" onkeyup="paragonCmm.validateMaxLength(this, 1500)"><c:out value="${result.patiDesc}"/></textarea>
				</td>
			</tr>
			<tr>
				<th class="th2">VIEW_전용_파티클여부</th>
				<td class="td2">
					<select name="patiOnlyViewYn" id="patiOnlyViewYn">
						<option value="">--Select--</option>
						<option value="N" selected>일반</option>
						<option value="Y">VIEW전용</option>
					</select>
				</td>
			</tr>

			</table>

			<div class="buttonlist">
				<div class="right">
					<input type="button" name="btnSave" id="btnSave" data-term="B.SAVE" value="" class="btn70" />
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">

"use strict";

function PaticleWrite(){
	var doSubmit = function() {
		var frm = $("#saveForm");

		if($("#patiNm").val() == ""){
			alert("파티클 명을 입력하세요");
			$("#patiNm").focus();
			return;
		}
		if($("#patiTpCd").val()  == "" || $("#patiTpCd2").val()  == ""){
			alert("파티클 구분을 선택하세요");
			return;
		}
		if($("#patiDesc").val()  == ""){
			alert("파티클 설명을 입력하세요");
			$("#patiDesc").focus();
			return;
		}

		if($("#patiOnlyViewYn").val()  == ""){
			alert("뷰전용 파티클 여부를 선택 하세요.");
			return;
		}

		confirm(paragonCmm.getLang("M.ALERT_SUBMIT","L.저장"), function(r){
			if (r) {

				//--에디터 서브밋 처리
				paragonCmm.setEditorSubmit("");

				var data = $("#saveForm").serializeJSON();
				paragonCmm.callAjax("/paragon/def/particlemng/ParticleMng/saveData/json",data, function(json){
					if($("#patiUid").val() != null && $("#patiUid").val() != ""){
						try {
							opener.getList(1);
						} catch(exception) {
							console.log(exception.message);
						}
						var imsiForm = $("<form method='POST'>").attr("action","/paragon/def/particlemng/particleView.popup")
						imsiForm.append($("<input type='hidden' name='patiUid'>").val($("#patiUid").val()));
						imsiForm.attr("target","_self");
						imsiForm.appendTo("body");
						imsiForm.submit();

					}else{
						opener.PATICLE.loadGrid(1);
						window.close();
					}
				});

			}
		})
	}
	var getSysPatiGbnCode = function(targetId, val){
		var data = {};

		if(val == ""){
			htmlUtils.initializeSelectJson(targetId,"", "", "|"+paragonCmm.getLang("L.CBO_SELECT"), "cd", "langCd");
		}else{
		data["parentCd"] = val;
		data["useYn"] = "Y";
		paragonCmm.callAjax("/viself/code/codeMng/listCode/json",data, function(json){
			console.log(json);
			htmlUtils.initializeSelectJson(targetId,"", json.data, "|"+paragonCmm.getLang("L.CBO_SELECT"), "cd", "langCd");
		});

		}

	}
	var setClassJsp = function(){
		var type1 = $("#patiTpAbbCd").val();
		var type2 = $("#patiTpAbbCd2").val();
		var maxCnt = $("#maxCnt").val();
		var mngNo  = type1.toLowerCase()+type2.capitalize()+maxCnt;
		var patiClassPath = "com.vertexid."+type1.toLowerCase()+".particle."+type1.capitalize()+type2.capitalize()+$("#maxCnt").val()+"Particle";
		var patiJspWrtPath = "/"+type1.toLowerCase()+"/particle/"+mngNo+"/"+mngNo+"Write";
		var patiJspViewPath = "/"+type1.toLowerCase()+"/particle/"+mngNo+"/"+mngNo+"View";
		$("#patiClassPath").val(patiClassPath);
		$("#patiJspWrtPath").val(patiJspWrtPath);
		$("#patiJspViewPath").val(patiJspViewPath);
	}
	var attchmentEvent = function(){
		$("#patiTpCd").on("change",function(){
			$("#patiTpAbbCd").val($("#patiTpCd").find(":selected").data("row").cdAbb)
			getSysPatiGbnCode("patiTpCd2", $(this).val());
		});
		$("#patiTpCd2").on("change",function(){
			$("#patiTpAbbCd2").val($("#patiTpCd2").find(":selected").data("row").cdAbb);
			var data = {};
			data["patiTpAbbCd"] = $("#patiTpAbbCd").val();
			data["patiTpAbbCd2"] = $("#patiTpAbbCd2").val();
			paragonCmm.callAjax("/paragon/def/particlemng/ParticleMng/listOfNewMngNo/json",data, function(json){
				if(json.data){
					var row = json.data[0];
					$("#patiMngNo").val(row.patiMngNo);
					$("#maxCnt").val(row.maxCnt);
					setClassJsp();
				}
			});

		});

		$("#btnSave").on("click",function(){
			doSubmit();
		});
	}
	var loadData = function(){
		if($("#patiUid").val() != null && $("#patiUid").val() !=""){
			var data = {};
			data["patiUid"] = $("#patiUid").val();
			paragonCmm.callAjax("/paragon/def/particlemng/ParticleMng/listOne/json",data, function(json){
				if(json.data){
					$("#cud").val("U");
				}
			});
		}else{
			$("#cud").val("C");
			$("#patiUid").val(paragonCmm.getRandomUUID());
		}
	}
	var init = function(){
		loadData();
		attchmentEvent();
		getSysPatiGbnCode("patiTpCd", "SYS_PATI_GBN");
	}
	return{
		init:init,
		getSysPatiGbnCode:getSysPatiGbnCode
	}
}
var patiWrite = new PaticleWrite();
patiWrite.init();

</script>