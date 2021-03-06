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
<div id="<c:out value='${param.docUid}'/>_stuFormWrite" class="content-panel">
<input type="hidden" name="isProd" id="isProd" value="<c:out value="${isProd}"/>" />
<form name="form1" id="<c:out value="${param.docUid}"/>_saveForm" method="post">
	<input type="hidden" name="stuCd" id="<c:out value='${param.docUid}'/>_stuCd" value="<c:out value="${param.stuCd}"/>" />
	<input type="hidden" name="docUid" id="<c:out value='${param.docUid}'/>_docUid" value="<c:out value="${param.docUid}"/>" />
	<input type="hidden" name="stuDtl" id="<c:out value='${param.docUid}'/>_stuDtl" value=""/>
	<input type="hidden" name="procType" id="<c:out value='${param.docUid}'/>_procType" value=""/>
	<input type="hidden" name="nextStuCd" id="<c:out value='${param.docUid}'/>_nextStuCd" value=""/>
	<input type="hidden" name="stuType1" id="<c:out value='${param.docUid}'/>_stuType1" value=""/>
	<input type="hidden" name="stuType2" id="<c:out value='${param.docUid}'/>_stuType2" value=""/>
	<input type="hidden" name="ordNo" id="<c:out value='${param.docUid}'/>_ordNo" value=""/>
	<input type="hidden" name="lastYn" id="<c:out value='${param.docUid}'/>_lastYn" value="Y"/>
	<input type="hidden" name="groupUid" id="<c:out value='${param.docUid}'/>_groupUid" value=""/>
	<input type="hidden" name="solMasUid" id="<c:out value='${param.docUid}'/>_solMasUid" value="<c:out value="${param.solMasUid}"/>"/>
	<input type="hidden" name="cud" id="<c:out value='${param.docUid}'/>_cud" value="C"/>
</form>
	<table><tbody id="<c:out value='${param.docUid}'/>_aprDiv"></tbody></table>
	<table><tbody id="<c:out value='${param.docUid}'/>_refDiv"></tbody></table>
	<h3><i class="fa fa-angle-right" id="writeCaption" > </i></h3>
	<div id="<c:out value='${param.docUid}'/>_particleArea">
	</div>
	<div class="buttonlist">
		<div class="right" id="<c:out value='${param.docUid}'/>_btnProcArea">
		</div>
	</div>
	<div id="<c:out value='${param.docUid}'/>_aprv" style="width:600px;height:400px;display: none;" ></div>
</div>
<script type="text/javascript">

"use strict";

var jsonData<c:out value="${param.docUid}"/>    = {}		//-- Json Data
function StuFrom_<c:out value='${param.docUid}'/>(){


	var PRE_FIX = "<c:out value='${param.docUid}'/>";
	var obj = {
		prnt 			: "#"+PRE_FIX+"_stuFormWrite"
		,btnProcArea	: "#"+PRE_FIX+"_btnProcArea"
		,saveForm		: "#"+PRE_FIX+"_saveForm"
		,aprv			: "#"+PRE_FIX+"_aprv"
		,aprDiv			: "#"+PRE_FIX+"_aprDiv"
		,refDiv			: "#"+PRE_FIX+"_refDiv"
		,particleArea	: "#"+PRE_FIX+"_particleArea"
		,docUid			: "#"+PRE_FIX+"_docUid"
	}

	var isDoSubmit 	= true; 	//-- ???????????? ??????
	var tmpValiFunc = [];		//-- ???????????? ??????????????? ??????
	var valiFunc 	= [];		//-- ??????????????? ??????
	var isValidate	= false;	//-- ??????????????? ??????
	var dataCube    = {}		//-- Data cube Master

	var tmpValiFuncs = function(func){ //-- ???????????? ??????????????? ????????? ?????? ??????.
		tmpValiFunc.push(func);
	}

	var valiFuncs = function(func){ //-- ???????????? ??????????????? ????????? ?????? ??????.
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

		var frm = $(obj.saveForm);
		//-- Validation ??????
		if(!chkVal(mode)) return false;
		isDoSubmit = true;
		if(!isDoSubmit) return false; //-- ???????????? ?????? ??????
		else{
			if("M" != mode){ 		 //-- ??????????????? ????????????????????? ???????????? ????????? ???????????? ?????????.20190409 ?????????
				isDoSubmit = false;
			}
		}
		var stu_dtl = mode;

		var msg1 = paragonCmm.getLang("M.??????????????????","B.TEMP_SAVE");
		var msg2 = paragonCmm.getLang("M.??????????????????","B.??????");
		var msg3 = paragonCmm.getLang("M.??????????????????","L.????????????");
		var msg4 = paragonCmm.getLang("M.??????????????????","B.??????");
		var msg = "";

		if("T" == mode){
			msg = msg1;
		}else if("F" == mode){
			msg = msg3;
			if($("input:hidden[name='_aprLoginId']", obj.aprDiv).length == 1){
				msg = paragonCmm.getLang("M.??????????????????","L.??????");
			}

		}else if("D" == mode){
			msg = msg4;
		}else if("M" == mode){
			stu_dtl = "T";
			msg = "??????????????? ?????? ???????????? ??? ?????? ?????????.<br/>?????????????????????????";
		}else{
			msg = msg2;
		}

		$("#<c:out value='${param.docUid}'/>_stuDtl").val(stu_dtl);
		setTimeout(function(){
			confirm(msg, function(r){
				if (r) {
					//--????????? ????????? ??????
					paragonCmm.setEditorSubmit("");
					//-- ?????? ?????? ?????? ??????
					if($(".cost", $(obj.saveForm)).length > 0){
						$(".cost", $(obj.saveForm)).each(function(i, o){
							$(this).val($(this).val().replaceAll(",",""));
						});
					}
					var data = $(obj.saveForm).serializeJSON();
					var jsonPatiData = $(obj.particleArea).serializeJSON()
					jsonPatiData.docUid = $(obj.docUid).val();
					data["jsonData"] = JSON.stringify(jsonPatiData);
					data["aprvLineDTO"] = $(obj.aprDiv).tableDataToJson();
					paragonCmm.submitAjax("/paragon/datacube/DataCube/doProc/json",data, function(json){

						if(json.errYn === "E"){
							//-- ????????????

							alert(json.msg);
							return false;

						}


						if("M" == mode){
							$("input:hidden[name='cud']").val("U");
							$("input:hidden[name='sol_mas_uid']").val(json.SOL_MAS_UID);//-- ?????????????????? ????????? sol_mas_uid??? ????????????.
							var url = "/ServletController?AIR_ACTION=SYS_FORM&AIR_MODE=POPUP_VIEW_FORM_ONE";
<%-- 							url +="&group_uid=<%=group_uid%>" --%>
							url +="&sol_mas_uid="+json.SOL_MAS_UID
<%-- 							url +="&doc_uid=<%=doc_uid%>" --%>
<%-- 							url +="&stu_cd=<%=stu_cd%>" --%>
							url +="&view_mode=PREVIEW"

							paragonCmm.openWindow(url, "1024", "650", "POPUP_VIEW_ONE", "yes", "yes", "");
						}else{
							if(opener){
								//-- ????????????????????? ???????????? ???????????? ???????????? ??????????????? ?????? try catch??? ??????
								try{
									//--????????? ????????? refresh
									opener.doSearch(opener.document.form1);
								}catch(e){
									console.log(e.message);
									try{
										//-- ?????? ?????? refresh
										opener.initMain();
									}catch(e){
										console.log(e.message);
									}
								}
								if(json.stuDtl == "T" || (json.stuDtl == "D" && !json.nextStuCd.endsWith("_REQ") && !json.nextStuCd.endsWith("_PUM2")) ){
									var url = json.stuType2.split("_").join("/")
									var action_code = "LMS_"+json.stuType2+"_MAS";
									var mode_code = "POPUP_INDEX";
									if("SU" ==  json.stuType){
										action_code = "LMS_SU_MAS";
										mode_code = "POPUP_INDEX";
									}else if(json.STU_TYPE.indexOf("OLD") > -1){
										action_code = "LMS_CT_OLD";
									}

									//-- ????????????????????? ?????????????????? ?????? ?????? TEP??? ?????? ??????.
									var imsiForm = $("<form method='POST'>").attr("action","/ServletController")
									imsiForm.append($("<input type='hidden' name='sol_mas_uid'>").val(json.solMasUid));
									imsiForm.attr("target","_self");
									imsiForm.appendTo("body");
									imsiForm.submit();
								}else if(json.STU_DTL == "X" ){	//-- ????????? ????????? ?????? ?????? ????????????
// 									opener.refreshPopup();
// 									window.close();
								}else{
// 									window.close();
								}
							}else{
								selectTabRefresh();
							}
						}
					},null, function(){ //-- error callback function
						isDoSubmit = true;
					});

				}
			});
		}, 300);
	}
	//-- ?????? ????????? ??????
	var initAprvLine = function(){
		var initData = {};
		initData["loginId"] = "<%=loginUser.getLoginId()%>";
		initData["deptCd"] = "<%=loginUser.getDeptCd()%>";
		return initData;
	}
	//-- ????????? ?????? ??????
	var selAprvLine = function(){
		if(!chkVal("S")) return false;
		//-- ????????? ?????? ??????
		$(obj.aprv).window({
			iconCls:'icon-search',
		    width:850,
		    height:600,
		    title:paragonCmm.getLang("L.???????????????"),
		    href:"/paragon/hr/hrAprvTreeInfo.modal",
		    modal:true,
		    onClose:function(){
		    	$(obj.aprv).window("destroy");
		    },
		    onLoad:function(){
		    	paragonCmm.convertLang($(obj.aprv)); 			//-- ????????? ??????
		    	USER.init(initAprvLine, setAprvCallBack);			//-- ??????????????? ????????? ??? ?????? ??????
		    }
		});
	}
	//-- ????????? ?????? ??? Submit
	var setAprvCallBack = function(data){
		var apr = data["APR"];
		var ref = data["REF"];
		var apr_memo = data["apr_memo"];
		var none_apr_yn = data["none_apr_yn"];
		$(obj.aprDiv).html("");
		//-- ????????? ????????? ??????
		$(apr).each(function(i, d){
			var $tr = $("<tr>");
			var $td = $("<td>");
			$td.append($("<input type='hidden' name='aprLineUid'>").val(paragonCmm.getRandomUUID()));	//-- Line UID ??????
			$td.append($("<input type='hidden' name='docUid'>").val($("#<c:out value='${param.docUid}'/>_docUid").val()));
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
		//-- ??????????????????
// 		$(obj.aprDiv).append($("<input type='hidden' name='_none_apr_yn'>").val(none_apr_yn));
		//-- ?????? ??????


		$(obj.refDiv).html("");
		//-- ????????? ????????? ??????
		$(ref).each(function(i, d){

			var $tr = $("<tr>");
			var $td = $("<td>");
			$td.append($("<input type='hidden' name='aprLineUid'>").val(paragonCmm.getRandomUUID()));	//-- Line UID ??????
			$td.append($("<input type='hidden' name='docUid'>").val($("#<c:out value='${param.docUid}'/>_docUid").val()));
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
			$(obj.refDiv).append($tr);
		});
		$(obj.aprv).window('close');
	}
	var attchmentEvent = function(){
// 		$("#patiType1").on("change",function(){
// 			getSysPatiGbnCode("patiType2", $(this).val());
// 		});
	}
	//-- ?????? ?????? ??????
	var loadBtn = function(procType){
		procType = ((procType == undefined || procType == "") ? "" : procType);
		var stuCd = $("#<c:out value='${param.docUid}'/>_stuCd").val();
		if(procType.indexOf("T") > -1){	//-- ????????????
			var uiBtn = $('<span class="ui_btn medium icon">');
			var iTag  = $("<i id='imsiSaveBtn<c:out value='${param.docUid}'/>'>").attr("class","fa fa-edit");
			$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.????????????"))));
			$(obj.btnProcArea).append(uiBtn);
			$("#imsiSaveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('T');});

		}
		if(procType.indexOf("F") > -1){	//-- ????????????, ????????????
			var uiBtn = $('<span class="ui_btn medium icon" id="preViewBtn<c:out value='${param.docUid}'/>">');
			var iTag  = $("<i>").attr("class","fa fa-search");
			uiBtn.append(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.????????????"))));
			$(obj.btnProcArea).append(uiBtn);
			$("#preViewBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('M');});

			var uiBtn2 = $('<span class="ui_btn medium icon" id="aprvLineSel<c:out value='${param.docUid}'/>">');
			var iTag2  = $("<i>").attr("class","fa fa-pencil");
			uiBtn2.append(iTag2.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.???????????????"))));
			$(obj.btnProcArea).append(uiBtn2);
			$("#aprvLineSel<c:out value='${param.docUid}'/>").on("click",function(){selAprvLine()});

			var uiBtn3 = $('<span class="ui_btn medium icon" id="doAprvBtn<c:out value='${param.docUid}'/>">');
			var iTag3  = $("<i>").attr("class","fa fa-pencil");
			uiBtn3.append(iTag3.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.??????"))));
			$(obj.btnProcArea).append(uiBtn3);
			$("#doAprvBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('F');});

		}
		if(procType.indexOf("S") > -1){	//-- ????????????
			var uiBtn = $('<span class="ui_btn medium icon" id="saveBtn'+stuCd+'">');
			var iTag  = $("<i>").attr("class","fa fa-pencil");
			$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.??????"))));
			$(obj.btnProcArea).append(uiBtn);
			$("#saveBtn"+stuCd).on("click",function(){doSubmit("S");});
		}
		if(procType.indexOf("G") > -1){	//-- ???????????? ?????????
			var uiBtn2 = $('<span class="ui_btn medium icon" id="aprvLineSel<c:out value='${param.docUid}'/>">');
			var iTag2  = $("<i>").attr("class","fa fa-pencil");
			uiBtn2.append(iTag2.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.???????????????"))));
			$(obj.btnProcArea).append(uiBtn2);
			$("#aprvLineSel<c:out value='${param.docUid}'/>").on("click",function(){selAprvLine()});

			var uiBtn = $('<span class="ui_btn medium icon" id="saveBtn'+stuCd+'">');
			var iTag  = $("<i>").attr("class","fa fa-pencil");
			$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.????????????"))));
			$(obj.btnProcArea).append(uiBtn);
			$("#saveBtn"+stuCd).on("click",function(){doSubmit('G');});
		}
		if(procType.indexOf("X") > -1){	//-- ????????????
			var uiBtn = $('<span class="ui_btn medium icon" id="fixSaveBtn<c:out value='${param.docUid}'/>">');
			var iTag  = $("<i>").attr("class","fa fa-pencil");
			$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.??????"))));
			$(obj.btnProcArea).append(uiBtn);
			$("#fixSaveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('S');});
		}
	}
	//-- ?????? ????????? ??????
	var relLoadData = function(relDataStuCd){
		if($("#<c:out value='${param.docUid}'/>_solMasUid").val() != ""
			&& 	$("#<c:out value='${param.docUid}'/>_cud").val() == "C"
		){	//-- solMasUid??? ???????????? ?????? ????????????.
			var data = {};
			data["solMasUid"] = $("#<c:out value='${param.docUid}'/>_solMasUid").val();
			data["stuCd"] = relDataStuCd;
			data["lastYn"] = "Y";
			paragonCmm.callAjax("/paragon/datacube/DataCube/listOne/json",data, function(json){
				if(json.data){
					$("#<c:out value='${param.docUid}'/>_cud",obj.prnt).val("C");
					$("#<c:out value='${param.docUid}'/>_groupUid",obj.prnt).val(json.data[0].groupUid);
					$("#<c:out value='${param.docUid}'/>_ordNo",obj.prnt).val(json.data[0].ordNo);
					$("#<c:out value='${param.docUid}'/>_solMasUid",obj.prnt).val(json.data[0].solMasUid);
					dataCube = json.data[0];
					jsonData<c:out value="${param.docUid}"/> = JSON.parse(json.data[0].jsonData);
					jsonData<c:out value="${param.docUid}"/>.docUid = json.data[0].docUid;
				}
			});
		}
	}
	//-- ????????? ????????? ??????
	var loadData = function(docUid){
		if(typeof docUid === "string" && docUid !=""){
			var data = {};
			data["docUid"] = docUid;
			paragonCmm.callAjax("/paragon/datacube/DataCube/listOne/json",data, function(json){
				if($(json.data).length > 0){
					$("#<c:out value='${param.docUid}'/>_cud",obj.prnt).val("U");
					$("#<c:out value='${param.docUid}'/>_groupUid",obj.prnt).val(json.data[0].groupUid);
					$("#<c:out value='${param.docUid}'/>_ordNo",obj.prnt).val(json.data[0].ordNo);
					$("#<c:out value='${param.docUid}'/>_solMasUid",obj.prnt).val(json.data[0].solMasUid);
					dataCube = json.data[0];
					jsonData<c:out value="${param.docUid}"/> = JSON.parse(json.data[0].jsonData);
				}
			});
		}else{
			$("#<c:out value='${param.docUid}'/>_cud",obj.prnt).val("C");
			$("#<c:out value='${param.docUid}'/>_docUid",obj.prnt).val(paragonCmm.getRandomUUID());

		}
	}
	//-- ??? ????????? ??????
	var loadForm = function(){
		var data = {};
		data["stuCd"] = $("#<c:out value='${param.docUid}'/>_stuCd").val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuMng/listOne/json",data, function(json){
			if(json.data){
				$.each(json.data[0], function(key, val){
					if("cud" != key){	//-- ?????? ????????????????????? U??? ???????????? ?????? ????????? ??????.
						$("#<c:out value='${param.docUid}'/>_"+key,obj.prnt).val(val);
					}
				});
				//-- ??????????????? ????????? ????????????
				if(typeof json.data[0].relDataStuCd === "string" && json.data[0].relDataStuCd !="" ){
					relLoadData(json.data[0].relDataStuCd);
				}

				$("#writeCaption",obj.prnt).append(paragonCmm.getLang(json.data[0].docNmLangCd));
				loadBtn(json.data[0].procTp);
				loadParticle();
			}
		});

	}
	var bool = false;
	var loadParticle = function(){
		var data = {};
		data["stuCd"] = $("#<c:out value='${param.docUid}'/>_stuCd",obj.prnt).val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuParti/list/json",data, function(json){
			var maxLen = $(json.data).length;

			var param = {};
			param.stuCd = "<c:out value='${param.stuCd}'/>";
			param.docUid = $(obj.docUid).val();
			$(json.data).each(function(i, e){
				if("false" == $("#isProd").val()){
					$(obj.particleArea).append($("<font color=\"#DDDDDD\">++?????? : "+e.patiMngNo+" : "+e.patiNm+"++</font>"));
				}
				$(obj.particleArea).append("<br>");
				var $div = $("<div>").attr("id", e.patiMngNo);

				$(obj.particleArea).append(
					$div.load(e.patiJspWrtPath+".include",param,function(){
						if(i == (maxLen - 1)){	//-- ?????? ????????? ?????? ?????? ??? ????????? Convert ??????
							setTimeout(function(){
								paragonCmm.convertLang($(obj.particleArea));
							},200);
						}
					})
				);

			});
		});
	}
	var setCallback = function(func){
		obj.callBackFnc = func;
	}
	var init = function(){
		attchmentEvent();
		var docUid = $("input:hidden[name='docUid']",obj.prnt).val();
		loadData(docUid);
		loadForm();

	}
	return{
		init:init,
		dataCube:function(){return dataCube;},
		jsonData:function(){return jsonData;},
		setCallback:setCallback,
		valiFuncs:valiFuncs,
		tmpValiFuncs:tmpValiFuncs
	}
}
var stuFrom_<c:out value='${param.docUid}'/> = new StuFrom_<c:out value='${param.docUid}'/>();
stuFrom_<c:out value='${param.docUid}'/>.init();
var stuWriteForm_setFunc = function(func){
	stuFrom_<c:out value='${param.docUid}'/>.setCallback(func);
}
</script>