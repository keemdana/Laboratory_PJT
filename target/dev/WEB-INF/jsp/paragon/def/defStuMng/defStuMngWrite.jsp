<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content-panel">
<form name="form1" id="form1" method="post">
	<input type="hidden" id="procGbn" name="procGbn">
	<table class="basic">
		<caption>상태 및 서식정의</caption>
		<tr>
			<th class = "th4"><span class="ui_icon required"></span>법무구분</th>
			<td class = "td4">
				<select name="stuTp" id="stuTp" class="select">
				</select>
				<select name="stuTp2" id="stuTp2" class="select">
				</select>
			</td>
			<th class = "th4">순번</th>
			<td class = "td4">
				<input type="number" name="ordNo" min="0" id="ordNo" max ="99" class="number" style="width: 97%;" value="" /></td>
		</tr>
		<tr>
			<th class = "th2"><span class="ui_icon required"></span>상태코드</th>
			<td class = "td2" colspan="3">
				<input type="text" name="stuCd" class="text width_max" id="stuCd" value="<c:out value="${param.stuCd}"/>" />
			</td>
		</tr>
		<tr>
			<th class = "th2"><span class="ui_icon required"></span>기본상태명</th>
			<td class = "td2" colspan="3">
				<input type="text" name="stuBaseNm" class="text width_max" id="stuBaseNm" value="" />
			</td>
		</tr>

		<tr>
			<th class = "th4"><span class="ui_icon required"></span>상태의 처리구분</th>
			<td colspan='7'>
				<span id="procTypeArea"></span>
			</td>
		</tr>
		<tr>
			<th class="th4"><span class="ui_icon required"></span>사용 유무</th>
			<td class="td4" >
				<select name="useYn" id="useYn" class="select width_max" >
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
			</td>
			<th class="th4">제목 표시 유무</th>
			<td class="td4">
				<select name="titDspYn" id="titDspYn" class="select width_max" >
					<option value="N">미표시</option>
					<option value="Y">표시</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="th4">메모 표시 유무</th>
			<td class="td4">
				<select name="memoDspYn" id="memoDspYn" class="select width_max" >
					<option value="N">미표시</option>
					<option value="Y">표시</option>
				</select>
				<input type="text" name="memoTitLangCd" class="text" id="memoTitLangCd" value="" placeholder='다국어 형식으로 입력' />
			<th class="th4">첨부파일 표시 유무</th>
			<td class="td4">
				<select name="fileDspYn" id="fileDspYn" class="select width_max" >
					<option value="N">미표시</option>
					<option value="Y">표시</option>
				</select>
			</td>
		</tr>
		<%--
		<tr>
			<th class="th2">안내문구</th>
			<td class="td2" colspan="3"><%=HtmlUtil.getHtmlEditor(request, true, "stu_desc", "stu_desc", defMainMap.getStringEditor("STU_DESC"), "", "100%", "350", "Default")%>
			</td>
		</tr>
		 --%>
		<tr>
			<th class="th4">작성시 데이터 참조상태<br />(상태 코드 콤마(,)로 입력)
			</th>
			<td class="td4" colspan="3">
				<input type="text" name="relDataStuCd" class="text" id="relDataStuCd" value="" placeholder='CT_REQ,CT_RST...' />
				<br />
				※상태코드 입력시 <span style="font-weight: bold;">본 상태 서식 최초작성 할떄 입력한 상태코로 작성된 서식의 데이터를 참조</span>하여 체워준다.(파티클 데이터를 json String 형태로 저장시 사용)</td>
		</tr>
		<tr>
			<th class="th4">문서생성권한</th>
			<td class="td4" colspan="3">
				<span id="stuRegAuthArea"></span>
			</td>
		</tr>
		<tr>
			<th class="th4">문서조회권한</th>
			<td class="td4" colspan="3">
				<span id="stuViewAuthArea"></span>
			</td>
		</tr>
		<tr>
			<th class="th2">처리 영역 메모</th>
			<td class="td2" colspan="3">
				*처리 영역 왼쪽정렬 표시문구 다국어코드<br/>
				<input type="text" name="procAreaMemo" class="text width_max" id="procAreaMemo" value="" placeholder="다국어코드 입력!!"/>
			</td>
		</tr>
		<tr>
			<th class="th2">상태 설명</th>
			<td class="td2" colspan="3">
				<textarea rows="5" class="text width_max" name="stuDesc"></textarea>
			</td>
		</tr>
		<tr>
			<th class="th2"><span class="ui_icon required"></span>서식명(버튼명) 언어코드</th>
			<td class="td2" colspan="3">
				<input type="text" name="docNmLangCd" id="docNmLangCdId" style='width:400px' value=""/>
			</td>
		</tr>
	</table>
	<p>
</form>
	<table class="basic">
		<caption>상태그룹정보</caption>
		<tr>
			<th class="th2" style="vertical-align: top;">
				상태 그룹<br/>
				<span class="ui_btn small icon" id="addAuthGroup"><i class="fa fa-plus" ><a href="javascript:void(0)" >추가</a></i></span>
			</th>
			<td class="td2" style="vertical-align: top;" colspan="3">
				<span style="color: red;">※ 상태그룹은 검색조건,상태별 카운트에 쓰입니다.</span>
				<table class="list">
					<tr>
						<th style="width:25%">세부상태</th>
						<th>그룹코드</th>
						<th style="width:15%"></th>
					</tr>
					<tbody id="authGroupTable">
					</tbody>
				</table>
			</td>
			<!--
			<th class="th4" style="vertical-align: top;">
				사용자별 뷰 명<br/>
				<span class="ui_btn small icon" id="addAuthView" onclick="addAuthView()"><i class="fa fa-plus" ><a href="javascript:void(0)" >추가</a></i></span>
			</th>
			<td class="td4"  style="vertical-align: top;">
				<span style="color: red;">※ 빈값일경우 기본상태명으로 표시 됩니다.</span>
				<table class="list">
					<tr>
						<th style="width:25%">세부상태</th>
						<th style="width:30%">권한 코드</th>
						<th>언어코드</th>
						<th style="width:15%"></th>
					</tr>
					<tbody id="authLangTable">
					</tbody>
				</table>
			</td> -->
		</tr>
	</table>
	<br> <br> <br>
	<table class="basic">
		<caption>구성정보</caption>
	</table>



	<table class="basic">
		<tr>
			<th class="th2">파티클 조회</th>
			<td class="td2"><input type="text" class="text"
				name="sangPatiSch" id="sangPatiSch" style='width:400px'/>
			</td>
		</tr>
	</table>
	<table class="basic">
		<tbody id="particleSangdanTableBody">
		</tbody>
	</table>
	<div class="buttonlist">
		<div class="right">
			<input type="button" name="btnPreview" data-term="B.미리보기" value="" class="btn70" />
			<input type="button" name="btnSave" data-term="B.SAVE" id="btnSave" value="" class="btn70"  />
			<input type="button" name="btnList" data-term="B.CLOSE" value="" class="btn70" onclick="window.close();" />
		</div>
	</div>
</div>
<script id="sang_patiTemp" type="text/html">
<tr data-meaning="sangdan_tr" id="pati_\${patiUid}">
	<td>
		<table class="basic">
			<tbody>
			<tr>
				<th class="th4">
					파티클 관리번호
					<input type="hidden" name="patiUid" value="\${patiUid}" >
				</th>
				<td class="td4"><input type="text" name="patiMngNo" value="\${patiMngNo}" style="width:80%;border:0px" readonly=""></td>
				<th class="th4">파티클 구분</th>
				<td class="td4"><input type="text" name="patiGbnNamSangdan" value="\${paragonCmm.getLang(patiTpCdLangCd)}/\${paragonCmm.getLang(patiTpCd2LangCd)}" class="text width_max" style="border:0px" readonly=""> </td>
				<td rowspan="4">
					<input type="button" name="btnDelete" value="삭제" class="btn70" onclick="stuDefWrite.deletePartiRow('\${patiUid}');">
				</td>
			</tr>
			<tr>
				<th class="th4">파티클 명</th>
				<td class="td4" colspan="3">
					<input type="text" name="patiNamSangdan" value="\${patiNm}" class="text width_max" style="border:0px" readonly="">
					<input type="hidden" name="patiMngNoSangdan" value="\${patiMngNoSangdan}">
				</td>
			</tr>
			<tr>
				<th class="th4">권한선택</th>
				<td class="td4" colspan="3" data-meaning="sangdan_auth_codes">
					{{html htmlUtils.getInputCheckbox("patiAuthCdsTmp", stuDefWrite.tmplAuth(), viewAuth) }}
					<input type="hidden" name="viewAuth" value=""/>
				</td>
			</tr>
			</tbody>
		</table>
	</td>
</tr>
</script>
<script id="stu_group_tmpl" type="text/html">
<tr id='\${stuGroupUid}'>
	<td>
		{{html htmlUtils.getSelect("stuDtl","stuDtl"+rn, stuDefWrite.tmplStuType(), stuDtl) }}
	</td>
	<td>
		{{html htmlUtils.getSelect("stuGroup","stuGroup"+rn, stuDefWrite.tmplStuGroup(), stuGroup) }}
	</td>
	<td><span class="ui_btn small icon" onclick="$('#\${stuGroupUid}').remove();"><i class="fa fa-minus"><a href="javascript:void(0)" >삭제</a></i></span></td>
</tr>
</script>
<script id="auth_view_tmpl" type="text/html">
<tr id='\${stu_lang_uid}'>
	<td>
		{{html htmlUtils.getSelect("lang_stu_dtl", $("#tmplStuType").val(), "") }}
	</td>
	<td>
		{{html htmlUtils.getSelect("lang_auth_cd", $("#tmplAuth").val(), "") }}
	</td>
	<td><input type="text" class="text width_max" data-type="ROLE_VIEW_NM" name="auth_lang_cd" value="" ></td>
	<td><span class="ui_btn small icon" onclick="$('#\${stu_lang_uid}').remove();"><i class="fa fa-minus"><a href="javascript:void(0)" >삭제</a></i></span></td>
</tr>
</script>
<script type="text/javascript">

"use strict";

function StuDefWrite(){
	var stuTypeSub = {};
	var tmplStuType ="";
	var tmplAuth ="";
	var tmplRole ="";
	var tmplStuGroup ="";
	//-- 이벤트 등록
	var attchmentEvent = function(){
		//--상태그룹 추가
		$("#addAuthGroup").on("click",function(){
			addAuthGroup();
		});
		//--미리보기 이벤트
		$("input:button[name='btnPreview']").on("click",function(){
			goDocumentPreview();
		});
		//--미리보기 이벤트
		$("input:button[name='btnSave']").on("click",function(){
			doSubmit();
		});

		$("#stuTp").on("change",function(){
			var cd = $(this).val();
			htmlUtils.getCodeSelectOpt({
				targetId:"stuTp2",
				parentCd:cd,
				initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
				valNm:"cd",
				txtNm:"langCd"
			});
		});
		$("#stuTp2").on("change",function(){
			var cd = $(this).val();
			htmlUtils.loadCodeStr(cd,"cd,langCd","",function(str){
				tmplStuGroup = str;
			});
		});

		$('#docNmLangCdId').combobox({
    		mode: 'remote',
    		valueField: 'value',
    		textField: 'label',
    		loader: function(param, succ){
    			console.log(param);
    			if (!param.q){return;}
    			$.ajax({
    				url: "/viself/mlang/mLangMng/list/json",
    				data: {langCd:param.q},
    				dataType: 'json',
    				success: function(data){
    					var rows = $.map(data.data, function(item){
    						return {
    							label: item.langCd,
    							value: item.langCd,
    							code:item.langCd
    						};
    					});
    					succ(rows)
    				}
    			})
    		}
    	});

		var selRecord = {};
		//-- 파티클 자동완성
		$("#sangPatiSch").combobox({
    		mode: 'remote',
    		valueField: 'value',
    		textField: 'label',
    		selectOnNavigation:true,
    		onSelect:function(record){
    			if(!jQuery.isEmptyObject(selRecord)){
    				selRecord = {}
    			}
    			selRecord = record;
    		},
    		onHidePanel:function(){
    			$("#sang_patiTemp").tmpl(selRecord.data).appendTo($("#particleSangdanTableBody"));
				paragonCmm.tableTrDragSet("particleSangdanTableBody");
    		},
    		loader: function(param, succ){
    			if (!param.q){return;}
    			$.ajax({
    				url: "/paragon/def/particlemng/ParticleMng/list/json",
    				data: {schword:param.q},
    				dataType: 'json',
    				success: function(data){
    					var rows = $.map(data.data, function(item){
    						return {
    							value: item.patiUid,
				                label: "["+item.patiMngNo+"]"+item.patiNm,
				                data: item
    						};
    					});
    					succ(rows);
    				}
    			})
    		}
    	});

	}
	//-- 저장 데이터 LOAD
	var loadMaster = function(){
		//-- 마스터 데이터 LOAD
		var data = {};
		data["stuCd"] = $("#stuCd").val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuMng/list/json",data, function(json){
			$.each(json.data[0],function(k, v){
				var val = v;
				var e = $("[name='"+k+"']");
				if($(e).prop('tagName') == "INPUT" && $(e).attr("type") == "checkbox"){
					$(e).each(function(i, o){
						if(val.indexOf($(o).val()) > -1 )$(o).attr("checked",true);
					});
				}else{
					if("stuTp2" == k){
						var cd = $("#stuTp").val();
						htmlUtils.getCodeSelectOpt({
							targetId:"stuTp2",
							parentCd:cd,
							initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
							valNm:"cd",
							txtNm:"langCd"
						});
						htmlUtils.loadCodeStr(val,"cd,langCd","",function(str){
							tmplStuGroup = str;
						});
					}
					$(e).val(val);
				}
			});
		});	//-- Async 동기
		//-- STU GROUP 코드 불러오기
		if($("#stuTp2").val() != ""){

			var cd = $("#stuTp2").val();
			htmlUtils.loadCodeStr(cd,"cd,langCd","",function(str){
				tmplStuGroup = str;
			});//--역할 checkbox Tmpl 로드
		}

		//-- 관련 파티클 LOAD
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuParti/list/json",data, function(json){
			$("#sang_patiTemp").tmpl(json.data).appendTo($("#particleSangdanTableBody"));
			paragonCmm.tableTrDragSet("particleSangdanTableBody");
		});	//-- Async 동기 호출

		//-- 상태그룹 LOAD
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuGroup/list/json",data, function(json){
			console.log(json.data);
			$("#stu_group_tmpl").tmpl(json.data).appendTo($("#authGroupTable"));
		});	//-- Async 동기 호출

	}
	//-- 상태 그룹 추가
	var addAuthGroup = function(){
		var data = {};
		var uuid = paragonCmm.getRandomUUID();;
		data['stuGroupUid'] = uuid;
		data['rn'] = $("#authGroupTable").find("tr").length;
		data['stuGroup'] = "";
		data['stuDtl'] 	= "";
		$("#stu_group_tmpl").tmpl(data).appendTo($("#authGroupTable"));

	}
	//-- 파티클 Row 삭제
	var deletePartiRow = function(id){
		$("#pati_"+id).remove();

	}
	var doSubmit = function(){
		if($("#stuTp").val()==''){
			alert("구분 상태1를 선택해주세요.");
			$("#stuTp").focus();
			return false;
		}
		if($("#stuTp2").val()==''){
			alert("구분 상태2를 선택해주세요.");
			$("#stuTp2").focus();
			return false;
		}
// 		if($("#stuType3").val()==''){
// 			alert("구분 상태3를 선택해주세요.");
// 			$("#stuType3").focus();
// 			return false;
// 		}
		// 상태 정보 체크
		if ("" == $("#stuCd").val() ) {
			alert (paragonCmm.getLang("M.필수_입력사항_입니다", "상태코드"));
			$("#stuCd").focus();
		    return false;
		}
		if ("" == $("#stuBaseNm").val() ) {
			alert (paragonCmm.getLang("M.필수_입력사항_입니다", "기본상태명"));
			$("#stuBaseNm").focus();
		    return false;

		}

		if($("input:checkbox[name='procTp']:checked").length == 0){
			alert (paragonCmm.getLang("M.필수_입력사항_입니다", "상태의처리구분"));
			return;
		}
		if ("" == $("#docNmLangCd").val() ) {
			alert(paragonCmm.getLang("M.필수_입력사항_입니다", "L.문서서식명"));
			frm.doc_nm_lang_cd.focus();
			return;
		}


		if($("input:checkbox[name='stuRegAuth']:checked").length == 0){
			alert("서식 생성권한을 체크해주세요.");
			return false;
		}

		if($("input:checkbox[name='stuViewAuth']:checked").length == 0){
			alert("서식 조회권한을 체크해주세요.");
			return false;
		}


		var $tr = $("tr[data-meaning='sangdan_tr']");
		var bool = true;
		$tr.each(function(i, o){
			var arrAuth = [];
			if($("input:checkbox[name='patiAuthCdsTmp']:checked" , o).length > 0){
				$("input:checkbox[name='patiAuthCdsTmp']:checked" , o).each(function(j, d){
					arrAuth.push($(d).val());
				});
				$("input:hidden[name='viewAuth']", $(o)).val(arrAuth.join(","));
			}else {
				alert("파티클에 대한 보기 권한을 설정 하세요.");
				bool = false;
			}
		});

		if(!bool)return false; //-- stop;

		// 저장 프로세스
		var msg = paragonCmm.getLang("M.하시겠습니까", "B.SAVE");
		confirm(msg, function(r){
			if(r){
				var params = $("#form1").serializeJSON();

				params["procTp"] = Array.isArray(params.procTp)?params.procTp.join(","):params.procTp;
				params["stuRegAuth"] = Array.isArray(params.stuRegAuth)?params.stuRegAuth.join(","):params.stuRegAuth;
				params["stuViewAuth"] =Array.isArray(params.stuViewAuth)?params.stuViewAuth.join(","):params.stuViewAuth;

				params["partiList"] = $("#particleSangdanTableBody").tableDataToJson();
				params["groupList"] = $("#authGroupTable").tableDataToJson();

				paragonCmm.callAjax("/paragon/def/defstumng/DefStuMng/save/json",params, function(json){
					if(json.errYn === "E"){
						//-- 오류처리
						alert(json.msg);
						return false;
					}
					opener.STUMNG.doSearch();
					window.close();
				});
			}
		})
	}
	var init = function(){
		htmlUtils.getCodeSelectOpt({
			targetId:"stuTp",
			parentCd:"SYS_SOL_TYPE",
			initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
			valNm:"cd",
			txtNm:"langCd"
		}); //-- 솔루션구분 select 로드
		htmlUtils.loadCodeStr("SOL_STU_TYPE","cdAbb,langCd","",function(str){
			tmplStuType = str;
		}); //--처리구분 코드 checkbox Tmpl 로드
		paragonCmm.callAjax("/viself/auth/authMng/list/json",{}, function(json){
			tmplAuth = htmlUtils.getCodeStrFromData(json.data,"authCd,authNm","");
		});//--권한 checkbox Tmpl 로드
		htmlUtils.loadCodeStr("USER_ROLE","cdAbb,langCd","",function(str){
			tmplRole = str;
		}); //--역할 checkbox Tmpl 로드

		$("#procTypeArea").html(htmlUtils.getInputCheckbox("procTp", tmplStuType)); 		//--처리구분 로드
		$("#stuRegAuthArea").html(htmlUtils.getInputCheckbox("stuRegAuth", tmplRole)); 		//--문서생성 권한 로드
		$("#stuViewAuthArea").html(htmlUtils.getInputCheckbox("stuViewAuth", tmplRole)); 	//--문서조회 권한 로드


		if($("#stuCd").val() != null && $("#stuCd").val() != "" ){
			//-- 수정모드일때 마스터 데이터 로드
			loadMaster();
		}else{
			//-- 수정모드가 아닐때는 미리보거 버튼 숨기기
			$("input:button[name='btnPreview']").hide();
		}
		attchmentEvent();
	}
	return{
		init:init,
		deletePartiRow:deletePartiRow,
		tmplStuGroup:function(){return tmplStuGroup;},
		tmplStuType:function(){return tmplStuType;},
		tmplAuth:function(){return tmplAuth;}
	}
}
var stuDefWrite = new StuDefWrite();
stuDefWrite.init();

</script>