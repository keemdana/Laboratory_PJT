<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	SysLoginVO loginUser 	=     (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();
	String capitalizeSiteLocale = StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko
%>
<div id="stuFormProc<c:out value="${param.docUid}"/>">
<input type="hidden" name="isProd" id="isProd" value="<c:out value="${isProd}"/>" />
<form name="form1" id="procForm" method="post">
	<input type="hidden" name="stuCd" id="stuCd" value="<c:out value="${param.stuCd}"/>" />
	<input type="hidden" name="docUid" id="docUid" value="<c:out value="${param.docUid}"/>" />
	<input type="hidden" name="stuDtl" id="stuDtl" value="T"/>
	<input type="hidden" name="procType" id="procType" value=""/>
	<input type="hidden" name="nextStuCd" id="nextStuCd" value=""/>
	<input type="hidden" name="stuType1" id="stuType1" value=""/>
	<input type="hidden" name="stuType2" id="stuType2" value=""/>
	<input type="hidden" name="ordNo" id="ordNo" value=""/>
	<input type="hidden" name="lastYn" id="lastYn" value=""/>
	<input type="hidden" name="groupUid" id="groupUid" value=""/>
	<input type="hidden" name="solMasUid" id="solMasUid" value=""/>
	<input type="hidden" name="isTodo" id="isTodo" value="false"/>
	<input type="hidden" name="todoType" id="todoType" value=""/>
	<input type="hidden" name="inUid" id="inUid" value=""/>
	<input type="hidden" name="wrtloginId" id="wrtloginId" value=""/>
</form>
	<table><tbody id="aprDiv<c:out value="${param.docUid}"/>"></tbody></table>
	<div id="refDiv"></div>
	<table class="basic">
		<caption id="writeCaption"></caption>
	</table>
	<div id="particleArea<c:out value="${param.docUid}"/>">
	</div>
	<div id="stuAprvLineArea<c:out value='${param.docUid}'/>" style="display: none;">
		<br/>
		<table class="basic">
			<caption data-term="L.결재정보"></caption>
			<thead>
			<tr>
				<th style="width:7%;text-align:center;" data-term="L.진행상태"></th>
				<th style="width:7%;text-align:center;" data-term="L.구분"></th>
				<th style="width:14%;text-align:center;" data-term="L.처리일자"></th>
				<th style="width:26%;text-align:center;" data-term="L.결재자정보"></th>
				<th style="width:*;text-align:center;" data-term="L.메모"></th>
			</tr>
			</thead>
			<tbody id="stuAprvLineTbody<c:out value='${param.docUid}'/>">
			</tbody>
		</table>
	</div>
	<div id="stuAprvProcArea<c:out value='${param.docUid}'/>">
	</div>
	<div id="stuNextProcArea<c:out value='${param.docUid}'/>" style="display:none;">
		<br/>
		<table class="basic">
		<tr>
			<th class="th2" data-term="L.처리업무"></th>
			<td style="text-align:right;" id="stuNextProcTbody<c:out value='${param.docUid}'/>">
			</td>
		</tr>
		</table>
	</div>
	<div class="buttonlist">
		<div class="right" id="btnProcArea<c:out value='${param.docUid}'/>">
		</div>
	</div>
	<div id="aprvModal<c:out value='${param.docUid}'/>" style="width:600px;height:400px;display: none;" ></div>
	<div id="nextProcModal<c:out value='${param.docUid}'/>" style="width:600px;height:400px;display: none;" ></div>
</div>
<script id="stuAprvLineTmpl<c:out value='${param.docUid}'/>" type="text/x-jquery-tmpl">
<tr>
	<td style="text-align:center;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">\${paragonCmm.getLang(aprStuLangCd)}</td>
	<td style="text-align:center;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">\${paragonCmm.getLang(aprTypeLangCd)}</td>
	<td style="text-align:center;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">\${aprDteTime}</td>
	<td style="text-align:left;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">
		\${aprNm }
	</td>
	<td style="{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">
		\${aprMemo }
	</td>
</tr>
</script>

<script id="stuNextProcTmpl<c:out value='${param.docUid}'/>" type="text/x-jquery-tmpl">
	<span class="ui_btn medium icon" id="proc_\${nextStuCd}_<c:out value='${param.docUid}'/>"><i class="fa fa-check"><a href="javascript:void(0)" >\${paragonCmm.getLang(nextStuNm) }</a></i></span>
</script>
<script id="stuAprvProcTmpl<c:out value='${param.docUid}'/>" type="text/x-jquery-tmpl">
<br/>
<table class="basic">
	<caption>\${paragonCmm.getLang('L.결재의견') }</caption>
	<tr>
		<th class="th4">\${paragonCmm.getLang('L.결재구분') }</th>
		<td class="td4">
			{{html htmlUtils.getInputRadio("aprStu", "Y|"+paragonCmm.getLang('L.승인')+"^R|"+paragonCmm.getLang('L.반려')+"","Y")}}
		</td>
		<th class="th4">\${paragonCmm.getLang('L.결재자') }</th>
		<td class="td4">
			<c:out value="${sessionUser.dspNmKo}"/>
		</td>
	</tr>
	<tr>
		<th class="th2">\${paragonCmm.getLang('L.결재의견') }</th>
		<td class="td2" colspan="3">111
			<textarea class="memo width_max" name="aprMemo" id="aprMemo" maxlength="600" maxlength="600"></textarea>
		</td>
	</tr>
</table>
<div class="buttonlist">
	<div class="right" id="btnAprProcArea<c:out value='${param.docUid}'/>"></div>
</div>
</script>
<script type="text/javascript">

"use strict";

var jsonData<c:out value="${param.docUid}"/>    = {}		//-- Json Data
var jsonView<c:out value="${param.docUid}"/>    = {}		//-- Json Data

function StuFrom_<c:out value="${param.docUid}"/>(){

	var POST_FIX = "<c:out value='${param.docUid}'/>";
	var obj = {
		prnt 				: "#stuFormProc" +POST_FIX
		,aprDiv				: "#aprDiv"+POST_FIX
		,aprvModal			: "#aprvModal"+POST_FIX
		,particleArea		: "#particleArea"+POST_FIX
		,stuAprvLineArea	: "#stuAprvLineArea"+POST_FIX
		,stuAprvLineTbody	: "#stuAprvLineTbody"+POST_FIX
		,stuAprvProcArea	: "#stuAprvProcArea"+POST_FIX
		,stuNextProcTmpl	: "#stuNextProcTmpl"+POST_FIX
		,stuNextProcArea	: "#stuNextProcArea"+POST_FIX
		,stuNextProcTbody	: "#stuNextProcTbody"+POST_FIX
		,btnProcArea		: "#btnProcArea"+POST_FIX
		,stuAprvLineTmpl	: "#stuAprvLineTmpl"+POST_FIX
		,stuAprvProcTmpl	: "#stuAprvProcTmpl"+POST_FIX
		,nextProcModal		: "#nextProcModal"+POST_FIX
	}

	var isDoSubmit 	= true; 	//-- 처리클릭 여부
	var tmpValiFunc = [];		//-- 임시저장 벨리데이션 함수
	var valiFunc 	= [];		//-- 벨리데이션 함수
	var isValidate	= false;	//-- 벨리데이션 여부
	var dataCube    = {}		//-- Data cube Master

	var setTmpValiFunc = function(func){ //-- 파티클의 벨리데이션 함수를 추가 한다.
		tmpValiFunc.push(func);
	}

	var setValiFunc = function(func){ //-- 파티클의 벨리데이션 함수를 추가 한다.
		valiFunc.push(func);
	}
	var chkVal = function(mode){
		if(!isValidate){
			if("T" == mode || "M" == mode){
				var bool = false;
				$(tmpValiFunc).each(function(i, f){
					bool = f();
					return bool;
				});
				if(!bool) return false;
			}else if("D" == mode){
				return true;
			}else{
				var bool = false;
				$(valiFunc).each(function(i, f){
					bool = f();
					return bool;
				});
				if(!bool) return false;
			}
			isValidate = true;
			return true;
		}else{
			return true;
		}

	}
	var doSubmit = function(mode) {
		var frm = $("#procForm", obj.prnt);
		//-- Validation 체크
		if(!chkVal(mode)) return false;
		isDoSubmit = true;
		if(!isDoSubmit) return false; //-- 중복클릭 방어 코드
		else{
			if("M" != mode){ 		 //-- 미리보기용 임시저장일때는 중복코드 방어를 적용하지 않는다.20190409 강세원
				isDoSubmit = false;
			}
		}
		var stu_dtl = mode;

		var msg1 = paragonCmm.getLang("M.하시겠습니까","B.TEMP_SAVE");
		var msg2 = paragonCmm.getLang("M.하시겠습니까","B.처리");
		var msg3 = paragonCmm.getLang("M.하시겠습니까","L.결재요청");
		var msg4 = paragonCmm.getLang("M.하시겠습니까","B.삭제");
		var msg = "";

		if("T" == mode){
			msg = msg1;
		}else if("F" == mode){
			msg = msg3;
			if($("input:hidden[name='_aprLoginId']", obj.aprDiv).length == 1){
				msg = paragonCmm.getLang("M.하시겠습니까","L.전결");
			}

		}else if("D" == mode){
			msg = msg4;
		}else if("M" == mode){
			stu_dtl = "T";
			msg = "미리보기를 위해 임시저장 후 진행 됩니다.<br/>계속하시겠습니까?";
		}else{
			msg = msg2;
		}

		$("#stuDtl",obj.prnt).val(stu_dtl);

		setTimeout(function(){
			confirm(msg, function(r){
				if (r) {
					//--에디터 서브밋 처리
					paragonCmm.setEditorSubmit("");
					//-- 금액 콤마 제거 처리
					if($(".cost", $("#procForm", obj.prnt)).length > 0){
						$(".cost", $("#procForm", obj.prnt)).each(function(i, o){
							$(this).val($(this).val().replaceAll(",",""));
						});
					}
					var data = $("#procForm", obj.prnt).serializeJSON();
					data["jsonData"] = JSON.stringify($(obj.particleArea).serializeJSON());
					data["aprvLineDTO"] = $(obj.aprDiv).tableDataToJson();
					paragonCmm.submitAjax("/paragon/datacube/DataCube/doProc/json",data, function(json){
						if(json.errYn === "E"){
							//-- 오류처리
							alert(json.msg);
							return false;
						}

						var addedTab = false;
						var tabs = $('#ipMasTab').tabs('tabs');
						$(tabs).each(function(i, tab){
							if($(tab).attr("id") == "tab_<c:out value='${param.docUid}'/>"){
								var url = "/paragon/def/defStuForm/stuFormView.include";
								if(mode == "T"){	// 임시저장 일경우 처리 페이지로
									url = "/paragon/def/defStuForm/stuFormProc.include";
								}
									console.log(url);
								tab.panel('refresh', url);				// tab refresh
								$('#ipMasTab').tabs('select', i); // tab select
								addedTab = true;
								ipTepLeft.init();			//LEFT 영역 초기화
							}
						});
						if(!addedTab && opener){

							window.close();
						}


					},null, function(){ //-- error callback function
						isDoSubmit = true;
					});

				}
			});
		}, 300);
	}
	//-- 초기 결재선 정보
	var initAprvLine = function(){
		var initData = {};
		initData["loginId"] = "<%=loginUser.getLoginId()%>";
		initData["deptCd"] = "<%=loginUser.getDeptCd()%>";
		return initData;
	}
	//-- 결재자 선택 팝업
	var selAprvLine = function(){
		if(!chkVal("S")) return false;
		//-- 결재자 선택 모달
		$(obj.aprvModal).window({
			iconCls:'icon-search',
		    width:850,
		    height:600,
		    title:paragonCmm.getLang("L.결재자정보"),
		    href:"/paragon/hr/hrAprvTreeInfo.modal",
		    modal:true,
		    onLoad:function(){
		    	paragonCmm.convertLang($(obj.aprvModal)); 			//-- 다국어 처리
		    	USER.init(initAprvLine, setAprvCallBack);			//-- 결재자선택 초기화 및 콜백 셋팅
		    }
		});
	}
	//-- 결재자 셋팅 후 Submit
	var setAprvCallBack = function(data){
		var apr = data["APR"];
		var ref = data["REF"];
		var apr_memo = data["apr_memo"];
		var none_apr_yn = data["none_apr_yn"];
		$(obj.aprDiv).html("");
		//-- 결재자 데이터 추가
		$(apr).each(function(i, d){
			var $tr = $("<tr>");
			var $td = $("<td>");
			$td.append($("<input type='hidden' name='aprLineUid'>").val(paragonCmm.getRandomUUID()));	//-- Line UID 채번
			$td.append($("<input type='hidden' name='docUid'>").val($("#docUid", obj.prnt).val()));
			$td.append($("<input type='hidden' name='ordNo'>").val((i+1)));
			$td.append($("<input type='hidden' name='aprType'>").val(d.aprType));
			$td.append($("<input type='hidden' name='aprDeptCd'>").val(d.deptCd));
			$td.append($("<input type='hidden' name='aprDeptNm'>").val(d.deptNm<%=capitalizeSiteLocale%>));
			$td.append($("<input type='hidden' name='aprLoginId'>").val(d.loginId));
			$td.append($("<input type='hidden' name='aprUserNm'>").val(d.nm<%=capitalizeSiteLocale%>));
			if(i == 0){
				$td.append($("<input type='hidden' name='aprMemo'>").val(apr_memo));
			}else{
				$td.append($("<input type='hidden' name='aprMemo'>").val(""));
			}
			$tr.append($td);
			$(obj.aprDiv).append($tr);
		});
		//-- 전결처리여부
// 		$("#aprDiv").append($("<input type='hidden' name='_none_apr_yn'>").val(none_apr_yn));
		//-- 상신 메모


		$("#refDiv", obj.prnt).html("");
		//-- 참조자 데이터 추가
		$(ref).each(function(i, d){

			$("#refDiv").append($("<input type='hidden' name='aprLineUid'>").val(paragonCmm.getRandomUUID()));	//-- Line UID 채번
			$("#refDiv").append($("<input type='hidden' name='docUid'>").val($("#docUid").val()));
			$("#refDiv").append($("<input type='hidden' name='ordNo'>").val((i+1)));
			$("#refDiv").append($("<input type='hidden' name='aprType'>").val(d.aprType));
			$("#refDiv").append($("<input type='hidden' name='aprStu'>").val(""));
			$("#refDiv").append($("<input type='hidden' name='aprDeptCd'>").val(d.deptCd));
			$("#refDiv").append($("<input type='hidden' name='aprDeptNm'>").val(d.deptNm<%=capitalizeSiteLocale%>));
			$("#refDiv").append($("<input type='hidden' name='aprLoginId'>").val(d.loginId));
			$("#refDiv").append($("<input type='hidden' name='aprUserNm'>").val(d.nm<%=capitalizeSiteLocale%>));
		});
		$(obj.aprvModal).window('close');
		//-- 저장 및 상태처리
		doSubmit("F");
	}
	//-- 처리 버튼 로드
	var loadBtn = function(procType){
		if($("#isTodo", obj.prnt).val() == "false"){	//-- 투두가 아니면 false
			return false;
		}
		var stuDtl = $("#stuDtl", obj.prnt).val();
		if("T" == stuDtl && $("#wrtloginId", obj.prnt).val() == "<c:out value='${sessionUser.loginId}'/>"){		//-- 임시저장상태가 아니면 false
			procType = ((procType == undefined || procType == "") ? "" : procType);
			if(procType.indexOf("T") > -1){	//-- 임시저장
				var uiBtn = $('<span class="ui_btn medium icon">');
				var iTag  = $("<i id='imsiSaveBtn<c:out value='${param.docUid}'/>'>").attr("class","fa fa-edit");
				$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.임시저장"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#imsiSaveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('T');});

			}
			if(procType.indexOf("F") > -1){	//-- 미리보기, 결재상신
				var uiBtn = $('<span class="ui_btn medium icon" id="preViewBtn<c:out value='${param.docUid}'/>">');
				var iTag  = $("<i>").attr("class","fa fa-search");
				uiBtn.append(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.미리보기"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#preViewBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('M');});

				var uiBtn2 = $('<span class="ui_btn medium icon" id="doAprvBtn<c:out value='${param.docUid}'/>">');
				var iTag2  = $("<i>").attr("class","fa fa-pencil");
				uiBtn2.append(iTag2.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.결재요청"))));
				$(obj.btnProcArea).append(uiBtn2);
				$("#doAprvBtn<c:out value='${param.docUid}'/>").on("click",function(){selAprvLine()});

			}
			if(procType.indexOf("S") > -1){	//-- 처리완료,상태변경
				var uiBtn = $('<span class="ui_btn medium icon" id="saveBtn<c:out value='${param.docUid}'/>">');
				var iTag  = $("<i>").attr("class","fa fa-pencil");
				$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.처리"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#saveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit("S");});
			}
			if(procType.indexOf("X") > -1){	//-- 직접입력
				var uiBtn = $('<span class="ui_btn medium icon" id="fixSaveBtn<c:out value='${param.docUid}'/>">');
				var iTag  = $("<i>").attr("class","fa fa-pencil");
				$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.처리"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#fixSaveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('S');});
			}
		}
	}
	//-- 마스터 데이터 로드
	var loadData = function(){
		if($("#docUid",obj.prnt).val() != null && $("#docUid",obj.prnt).val() !=""){
			var data = {};
			data["docUid"] = $("#docUid",obj.prnt).val();
			paragonCmm.callAjax("/paragon/datacube/DataCube/listOne/json",data, function(json){
				if(json.errYn === "E"){
					alert(json.msg);//-- 오류처리
					return false;
				}
				var login = json.loginId;
				if(json.data){
					$("#stuDtl",obj.prnt).val(json.data[0].stuDtl);
					$("#nextStuCd",obj.prnt).val(json.data[0].nextStuCd);
					$("#groupUid",obj.prnt).val(json.data[0].groupUid);
					$("#ordNo",obj.prnt).val(json.data[0].ordNo);
					$("#solMasUid",obj.prnt).val(json.data[0].solMasUid);
					$("#isTodo",obj.prnt).val(json.data[0].isTodo);
					$("#todoType",obj.prnt).val(json.data[0].todoType);
					$("#wrtloginId",obj.prnt).val(json.data[0].regLoginId);
					$("#inUid",obj.prnt).val(json.data[0].inUid);

					dataCube = json.data[0];
					if(json.data[0].stuDtl == "T"){
						jsonData<c:out value="${param.docUid}"/> = JSON.parse(json.data[0].jsonData);
					}else{
						jsonView<c:out value="${param.docUid}"/> = JSON.parse(json.data[0].jsonData);
					}

					loadForm();		// 내용 로드

				}
			});

		}
	}
	//-- 폼 데이터 로드
	var loadForm = function(){
		var data = {};
		data["stuCd"] = $("#stuCd",obj.prnt).val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuMng/listOne/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- 오류처리
				return false;
			}
			if(json.data){
				$.each(json.data[0], function(key, val){
					if("cud" != key){	//-- 신규 작성모드인데도 U로 업데이트 되는 부분을 막음.
						$("#"+key,obj.prnt).val(val);
					}
				});
				$("#writeCaption").html(paragonCmm.getLang(json.data[0].docNmLangCd));

				loadParticle();								//-- 파티클 내용 로드
				var stuDtl = $("#stuDtl",obj.prnt).val();
				if("T" != stuDtl){
					loadAprvLine();								//-- 결재선 로드
				}
				if("IMSI" === $("#todoType",obj.prnt).val()){	//-- 임시저장 일때
					loadBtn(json.data[0].procType);
				}else if("PROC" === $("#todoType",obj.prnt).val()){		//-- 일반처리일때
					nextProcBtn();								//-- 다음 처리 버튼 로드
				}else if("APRV" === $("#todoType",obj.prnt).val()){
					loadAprvForm();							//-- 결재처리 폼 로드
				}
			}
		});

	}
	//-- 결재선 로드
	var loadAprvLine = function(){
		var data = {docUid:$("#docUid",obj.prnt).val()};
		paragonCmm.callAjax("/paragon/aprv/aprv/aprLinelist/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- 오류처리
				return false;
			}
			if(json.data.length > 0){
				//--Template 입력
				$(obj.stuAprvLineTmpl).tmpl(json.data).appendTo(obj.stuAprvLineTbody);
				//-- 다국어 처리
				paragonCmm.convertLang($(obj.stuAprvLineArea));
				//-- 결재선 표시
				$(obj.stuAprvLineArea).show();
				if($("#isTodo",obj.prnt).val() == "true"){ 	//-- 투두일경우
					$(json.data).each(function(i, o){
						if("W" == o.aprStu){				//-- 대상 결재 정보
							var $aprvTodo = $("<input type='hidden'>").attr("id","aprvTodo<c:out value='${param.docUid}'/>").data("aprRow", o);
							$(obj.stuAprvProcArea).append($aprvTodo);
						}
					});
				}
			}

		});
	}
	//-- 다음처리 버튼
	var nextProcBtn = function(){
		if("" === $("#inUid",obj.prnt).val()){	//-- 다음 처리 버튼어 없으면 false
			return false;
		}
		if($("#isTodo",obj.prnt).val() == "false"){	//-- 투두가 아니면 false
			return false;
		}
		var data = {inUid:$("#inUid",obj.prnt).val()};
		paragonCmm.convertLang($(obj.stuNextProcArea));
		$(obj.stuNextProcArea).show();
		paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outList/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- 오류처리
				return false;
			}
			$(obj.stuNextProcTmpl).tmpl(json.data).appendTo($(obj.stuNextProcTbody));
			$(json.data).each(function(i,d){
				var id = "proc_"+d.nextStuCd+"_<c:out value='${param.docUid}'/>"
				$("#"+id).data('rowData', d);
				$("#"+id).on('click',function(){	//-- 처리버튼 이벤트
					var row = $(this).data("rowData");
					//{authLangCd: "L.특허배당자",inUid: "...",nextStuCd: "TH_REQ_DIS",nextStuNm: "L.담당자_지정",ordNo: "0",outUid: "...",procType: "S",regDte: "...",regLoginId: "...",rn: "1",roleCd: "DIVID",stuCd: "TH_REQ",stuNm: "담당자 지정",stuType1: "SOL_IPS",stuType1LangCd: "",stuType2: "IPS_TH",stuType2LangCd: "",totCnt: "1",uptDte: "...",uptLoginId: "..."}
					var url = "/paragon/def/defStuForm/stuFormWrite.popup";
// 					var imsiForm = $("<form method='POST'>").attr("action",url);
// 					imsiForm.append($("<input type='hidden' name='stuCd'>").val(row.nextStuCd));
// 					imsiForm.append($("<input type='hidden' name='docUid'>").val(""));
// 					imsiForm.append($("<input type='hidden' name='solMasUid'>").val($("#solMasUid").val()));
// 					imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
// 					paragonCmm.openWindow("", "1000", "750", "POP_TEP_"+row.nextStuCd, "yes", "yes", "");
// 					imsiForm.attr("target","POP_TEP_"+row.nextStuCd);
// 					imsiForm.appendTo("body");
// 					imsiForm.submit();
// 					imsiForm.remove();
					//-- 사용자 선택 모달
					var newDocUid = paragonCmm.getRandomUUID();
					var queryParams = {};
						queryParams["stuCd"] = row.nextStuCd;
						queryParams["docUid"] = newDocUid
						queryParams["solMasUid"] = $("#solMasUid").val();

					$(obj.nextProcModal).window({
						iconCls:'icon-more',
					    width:850,
					    height:630,
					    title:paragonCmm.getLang(row.nextStuNm),
					    href:url,
					    method:'POST',
					    queryParams:queryParams,
					    modal:true,
					    onLoad:function(){
					    	stuWriteForm_setFunc(function(){							//-- 콜백 Function 지정
					    		$(obj.nextProcModal).window('close');
					    	});
					    	paragonCmm.convertLang($(obj.nextProcModal)); 			//-- 다국어 처리
					    },
					    onResize:function(){
// 					    	$('#partyInfoList').datagrid('resize');
					    }
					});

				})

			});
		});
	}
	//-- 다음처리 실행
	var nextProc = function(){
		if("" === $("#inUid",obj.prnt).val()){	//-- 다음 처리 버튼어 없으면 false
			return false;
		}
		if($("#isTodo",obj.prnt).val() == "false"){	//-- 투두가 아니면 false
			return false;
		}
		var data = {inUid:$("#inUid",obj.prnt).val()};
		$(obj.stuNextProcArea).show();
		paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outList/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- 오류처리
				return false;
			}
			$(obj.stuAprvProcTmpl).tmpl(json.data).appendTo($(obj.stuNextProcTbody));

// 			console.log(json);
		});
	}
	//-- 파티클 로드
	var loadParticle = function(){
		var data = {};
		data["stuCd"] = $("#stuCd",obj.prnt).val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuParti/list/json",data, function(json){
			var maxLen = $(json.data).length;
			$(json.data).each(function(i, e){
				if("false" == $("#isProd",obj.prnt).val()){
					$(obj.particleArea).append($("<font color=\"#DDDDDD\">++시작 : "+e.patiMngNo+" : "+e.patiNm+"++</font>"));
				}
				$(obj.particleArea).append("<br>");
				var $div = $("<div>").attr("id", e.patiMngNo);
				var url = e.patiJspViewPath+".include";
				if($("#stuDtl",obj.prnt).val() == "T"){
					url = e.patiJspWrtPath+".include";
				}
				//-- 파티클 로드
				$(obj.particleArea).append(
					$div.load(url,{docUid:"<c:out value="${param.docUid}"/>"},function(){
						if(i == (maxLen - 1)){	//-- 모든 파티클 로드 완료 후 다국어 Convert 실행
							setTimeout(function(){
								paragonCmm.convertLang($(obj.particleArea));
							},200);
						}
					})
				);
			});
		});
	}
	//-- 결재처리 Form 로드
	var loadAprvForm = function(){
		$(obj.stuAprvProcTmpl).tmpl({}).appendTo($(obj.stuAprvProcArea));

		var uiBtn = $('<span class="ui_btn medium icon">');						//-- 결재처리버튼 생성
		var iTag  = $("<i id='aprvProcBtn<c:out value='${param.docUid}'/>'>").attr("class","fa fa-pencil");
		$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.처리"))));
		$("#btnAprProcArea<c:out value='${param.docUid}'/>").append(uiBtn);
		$("#aprvProcBtn<c:out value='${param.docUid}'/>").on("click",function(){loadAprvProc();});
	}
	// 결재처리 로드
	var loadAprvProc = function(){
		var msg = paragonCmm.getLang('M.하시겠습니까', $("input:radio[name='aprStu']:checked",obj.prnt).attr("title"));
		confirm(msg,function(r){
			if(r){
				var data = $("#aprvTodo<c:out value='${param.docUid}'/>").data("aprRow");
				data.aprStu = $("input:radio[name='aprStu']:checked",obj.prnt).val();
				data.aprMemo = $("#aprMemo",obj.prnt).val();
				data.stuType2 = $("#stuType2",obj.prnt).val();	//-- 결재후 Handler 처리에 쓰임.
				data.stuCd = $("#stuCd",obj.prnt).val();	//-- 결재후 Handler 처리에 쓰임.

				paragonCmm.callAjax("/paragon/aprv/aprv/doAprvProc/json",data, function(json){
					console.log(json);
				});
			}
		});
	}
	var init = function(){
		loadData();
	}
	return{
		init:init,
		setValiFunc:setValiFunc,
		setTmpValiFunc:setTmpValiFunc
	}
}
var stuFrom_<c:out value="${param.docUid}"/> = new StuFrom_<c:out value="${param.docUid}"/>();
stuFrom_<c:out value="${param.docUid}"/>.init();

</script>