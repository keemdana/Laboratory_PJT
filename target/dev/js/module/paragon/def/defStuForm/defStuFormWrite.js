/*
 * @(#)codeMng.js    2019-12-10 오전 9:42
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */
/**
 * <b>Description</b>
 * <pre>
 *    폼 작성 화면
 * </pre>
 * @author 강세원
 */
"use strict";
function DefStuFromWrite(){
	var callBackFnc 	= null;
	var PROC_URL	 	= "/paragon/datacube/DataCube/doProc/json";
	var DATACUBE_URL 	= "/paragon/datacube/DataCube/listOne/json";
	var DEF_STU_URL 	= "/paragon/def/defstumng/DefStuMng/listOne/json";
	var PARTICLE_URL 	= "/paragon/def/defstumng/DefStuParti/list/json";


	var APR_PROC_URL 	= "/paragon/aprv/aprv/doAprvProc/json";

	var preFix		= $("#preFix").val();
	var docUid		= $("#"+preFix+"_docUid").val();
	var $prnt		= $("#"+preFix+"_stuFormWrite");

	var $docUid		= $("#"+preFix+"_docUid");
	var $stuCd		= $("#"+preFix+"_stuCd");
	var $stuDtl		= $("#"+preFix+"_stuDtl");
	var $curStuDtl	= $("#"+preFix+"_curStuDtl");
	var $cud		= $("#"+preFix+"_cud");
	var $mode		= $("#"+preFix+"_mode");
	var $groupUid	= $("#"+preFix+"_groupUid");
	var $ordNo		= $("#"+preFix+"_ordNo");
	var $solMasUid	= $("#"+preFix+"_solMasUid");
	var $stuTp		= $("#"+preFix+"_stuTp");
	var $stuTp2		= $("#"+preFix+"_stuTp2");
	var $todoType	= $("#"+preFix+"_todoType");
	var $todoUid	= "";
	var $memo		= $("#"+preFix+"_memo");

	var $form				= $("#"+preFix+"_saveForm");
	var $partiArea			= $("#"+preFix+"_particleArea");

	var $memoArea			= $("#"+preFix+"_memoArea");
	var $memoAreaTit		= $("#"+preFix+"_memoAreaTit");
	var $fileArea			= $("#"+preFix+"_fileArea");
	var fileAreaId			= preFix+"_fileAreaId";
	var $btnArea			= $("#"+preFix+"_btnProcArea");

	var $writeCaption		= $("#"+preFix+"_writeCaption");
	var $stuAprvLineTbody	= $("#"+preFix+"_stuAprvLineTbody");

	var $stuAprvProcArea= $("#"+preFix+"_stuAprvProcArea");
	var $stuAprvProcTmpl= $("#"+preFix+"_stuAprvProcTmpl");
	var isDoSubmit 	= true; 	//-- 처리클릭 여부

	var doOpenerCallback = function(){
		if(typeof(opener) !== "undefined") {
			if(typeof opener.baseOpener !== "undefined"){
				if(typeof opener.baseOpener.popupCbFnc === "function"){
					opener.baseOpener.popupCbFnc();
				}
			}
		}
	};

	//-- 미리보기 버튼 처리
	var openPreview = function(){
		//-- Validation 체크
		if(!chkVal("M")) return false;
		var previewInfo = paragonCmm.formMap.get(docUid).previewInfo;

		//-- 미리보기 정보 여부
		if(jQuery.isEmptyObject(previewInfo)){	//-- 비어있을경우 일반

		}else{									//-- 있을경우
			var url 	= previewInfo.url;
			var param 	= previewInfo.param;

			var imsiForm = $("<form method='POST'>").attr("action", url);
			// imsiForm.append($("<input type='hidden' name='docUid'>").val(paragonCmm.getRandomUUID()));
			imsiForm.append($("<input type='hidden' name='docUid'>").val(docUid));
			$.each(param, function(key, val){
				imsiForm.append($("<input type='hidden' name='"+key+"'>").val(val));
			})
			imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));

			var screenWidth = 1000; //screen.width;
			//var screenHeight = screen.height / 2;
			var screenHeight = 700;

			paragonCmm.openWindow("", screenWidth, screenHeight, "POP_PREVIEW_" + docUid, "yes", "yes", "");
			imsiForm.attr("target", "POP_PREVIEW_" + docUid);
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();

		}

	}
	var doSubmit = function(mode) {
		//-- Validation 체크
		if(!chkVal(mode)) {
			return false;
		}
		isDoSubmit = true;			//-- TODO 나중에 삭제 해야 함. 개발을 위해 풀어 둠. 20210611 강세원
		if(!isDoSubmit){
			return false; //-- 중복클릭 방어 코드
		}
		else{
			if("M" != mode){ 		 //-- 미리보기용 임시저장일때는 중복코드 방어를 적용하지 않는다.20190409 강세원
				isDoSubmit = false;
			}
		}
		var stu_dtl = mode;

		// var msg1 = paragonCmm.getLang("M.하시겠습니까","B.TEMP_SAVE");
		// var msg2 = paragonCmm.getLang("M.하시겠습니까","B.처리");
		// var msg3 = paragonCmm.getLang("M.하시겠습니까","L.결재요청");
		// var msg4 = paragonCmm.getLang("M.하시겠습니까","B.삭제");
		// var msg5 = paragonCmm.getLang("M.하시겠습니까","L.검토요청");

		var msg1 = "B.TEMP_SAVE";
		var msg2 = "B.처리";
		var msg3 = "L.결재요청";
		var msg4 = "B.삭제";
		var msg5 = "L.검토요청";
		var msgType = "";

		var msg = "";

		if("T" == mode){
			msgType = msg1;
		}else if("F" == mode){
			msgType = msg3;
			if($("input:hidden[name='aprLineUid']", $stuAprvLineTbody).length == 1){
				msgType = "L.전결";
			}

		}else if("D" == mode){
			msgType = msg4;
		}else if("G" == mode){
			msgType = msg5;
		}else if("M" == mode){
			stu_dtl = "T";
			msg = "미리보기를 위해 임시저장 후 진행 됩니다.<br/>계속하시겠습니까?";
		}else{
			msgType = msg2;
		}

		if(msg === ""){
			msg = paragonCmm.getLang("M.하시겠습니까", msgType);
		}

		$stuDtl.val(stu_dtl);

		confirm(msg, function(r){
			if (r) {
				//--에디터 서브밋 처리
				paragonCmm.setEditorSubmit("");
				//-- 금액 콤마 제거 처리
				if($(".cost", $form).length > 0){
					$(".cost", $form).each(function(i, o){
						$(this).val($(this).val().replaceAll(",",""));
					});
				}
				var data = $form.serializeJSON();
				var jsonData = $partiArea.serializeJSON();
				jsonData.docMemo = $memo.val();
				data["jsonData"] = JSON.stringify(jsonData);

				if(typeof aprvLine  == "object"){
					data["aprvLineDTO"] = aprvLine.getAprvJson();
				}
				//data["aprvLineDTO"] = aprvLine.getAprvJson();
//				$stuAprvLineTbody.tableDataToJson();

				$.messager.progress({
					interval: 1000
				});

				paragonCmm.submitAjax(PROC_URL,data, function(json){
					$.messager.progress('close');
					if(json.errYn === "E"){
						//-- 오류처리
						alert(json.msg);
						isDoSubmit = true;
						return false;
					}else{
						if(msgType !== ""){
							$.messager.alert({
								msg: paragonCmm.getLang("M.ALERT_DONE", msgType),
								fn: function(){
									if(opener){
										doOpenerCallback();
										window.close();
									}
								}
							});
						}
					}


				},true, function(){ //-- error callback function
					$.messager.progress('close');
					isDoSubmit = true;
				});

			}else{
				isDoSubmit = true;
			}
		});

	}

	//--저장 데이터 로드
	var loadData = function(){
		if(typeof docUid === "string" && docUid !=""){
			var data = {};
			data["docUid"] = docUid;
			paragonCmm.callAjax(DATACUBE_URL,data, function(json){
				if($(json.data).length > 0){
					$cud.val("U");
					$groupUid.val(json.data[0].groupUid);
					$ordNo.val(json.data[0].ordNo);
					$solMasUid.val(json.data[0].solMasUid);
					$todoType.val(json.data[0].todoType);
					$stuTp.val(json.data[0].stuTp);
					$stuTp2.val(json.data[0].stuTp2);
					$stuDtl.val(json.data[0].stuDtl);
					$curStuDtl.val(json.data[0].stuDtl);

					$todoUid = json.data[0].todoUid;

					$memo.val(json.data[0].baseMemo); //-- 기본메모

					//-- 불러온 JSON DATA를 전역변수에 PUT 시킨다.
					paragonCmm.formMap.get(docUid).docInfo = json.data[0];
					paragonCmm.formMap.get(docUid).jsonData = JSON.parse(json.data[0].jsonData);
				}
			});
		}else{
			$cud.val("C");
			$docUid.val(paragonCmm.getRandomUUID());
			docId	= $docUid.val();
		}
	}
	//--폼 정보 로드
	var loadForm = function(){
		var data = {};
		data["stuCd"] = $stuCd.val();
		paragonCmm.callAjax(DEF_STU_URL,data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- 오류처리
				return false;
			}
			if(json.data){
				$.each(json.data[0], function(key, val){
					if("cud" != key){	//-- 신규 작성모드인데도 U로 업데이트 되는 부분을 막음.
						$("#"+preFix+"_"+key).val(val);
					}
				});
				//-- 연관데이터 로드가 있을경우 신규작성일 경우
				if($cud.val() == "C"
					&& typeof json.data[0].relDataStuCd === "string"
					&& json.data[0].relDataStuCd !=""
				){
					relLoadData(json.data[0].relDataStuCd);
				}
				//-- 문서재목 로드
				$writeCaption.append(paragonCmm.getLang(json.data[0].docNmLangCd));

				//-- 파티클영역 로드
				loadParticle();

				//-- 메모/첨부 로드
				if(json.data[0].memoDspYn == "Y" ){
					//-- 메모영역 활성
					$memoArea.show();
					//-- 메모컬럼명 변경
					if(json.data[0].memoTitLangCd != ""){
						$memoAreaTit.removeAttr("data-term");
						$memoAreaTit.html("");
						$memoAreaTit.html(paragonCmm.getLang(json.data[0].memoTitLangCd));
					}
				}
				if( json.data[0].fileDspYn == "Y"){
					//-- 첨부파일 로드
					var options = {}
					options.relUid = preFix;			//-- 관계 키 UID
					options.fileTpCd = "CMM/CMM";		//-- 파일 유형 코드
					options.defaultRelUid = "";				//-- 기본 로드 첨부파일(수정시)
					htmlUtils.loadFileHtml(fileAreaId, options);	//-- 첨부파일 로드

					$fileArea.show();
				}


				if($cud.val() == "C" || $mode.val() != "" ){
					loadBtn(json.data[0].procTp);		//-- 처리버튼영역 로드
				}else{
					if("IMSI" === $todoType.val()){				//-- 임시저장 일때
						loadBtn(json.data[0].procTp);
//					}else if("PROC" === $todoType.val()){		//-- 일반처리일때
//						nextProcBtn();							//-- 다음 처리 버튼 로드
					}else if("APRV" === $todoType.val()){
						loadAprvForm();							//-- 결재처리 폼 로드
					}
				}

			}
		});
	}

	//-- 결재처리 Form 로드
	var loadAprvForm = function(){
		$stuAprvProcTmpl.tmpl({}).appendTo($stuAprvProcArea);

		var uiBtn = $('<span class="ui_btn medium icon">');						//-- 결재처리버튼 생성
		var iTag  = $("<i>").attr("class","fa fa-check");
		$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.처리"))));
		var $btnAprProcArea 	= $("#"+preFix+"_btnAprProcArea");
		$btnAprProcArea.append(uiBtn);
		uiBtn.off();
		$(uiBtn).on("click",function(){
			loadAprvProc();
		});
	}
	// 결재처리 로드
	var loadAprvProc = function(){
		var msg = paragonCmm.getLang('M.하시겠습니까', $("input:radio[name='aprStu']:checked",$stuAprvProcArea).attr("title"));
		confirm(msg,function(r){
			if(r){
				var data = {};
				data.aprLineUid = $todoUid;
				data.solMasUid =  $solMasUid.val()
				data.docUid =  $docUid.val()
				data.aprStu = $("input:radio[name='aprStu']:checked",$stuAprvProcArea).val();
				data.aprMemo = $("#aprMemo",$stuAprvProcArea).val();
				data.stuTp2 = $stuTp2.val()	//-- 결재후 Handler 처리에 쓰임.
				data.stuCd = $stuCd.val();	//-- 결재후 Handler 처리에 쓰임.

				paragonCmm.callAjax(APR_PROC_URL,data, function(json){
					console.log(json);
					if(opener){
						// if(typeof opener.dashBoard.loadTodo === "function"){
						// 	opener.dashBoard.loadTodo(1);
						// }
						doOpenerCallback();


						window.close();

					}
				});
			}
		});
	}
	//-- 연관 데이터 로드
	var relLoadData = function(relDataStuCd){
		if($solMasUid.val() != "" && $cud.val() == "C" ){	//-- solMasUid가 있으면서 최초 작성일때.
			var data = {};
			data["solMasUid"] = $solMasUid.val();
			data["stuCd"] = relDataStuCd;
			data["lastYn"] = "Y";
			paragonCmm.callAjax(DATACUBE_URL,data, function(json){
				if(json.data && $(json.data).length > 0){
					$cud.val("C");
					$groupUid.val(json.data[0].groupUid);
					$ordNo.val(json.data[0].ordNo);
					$solMasUid.val(json.data[0].solMasUid);
					var jsonData = JSON.parse(json.data[0].jsonData);
					jsonData.docUid = json.data[0].docUid;
					//-- 불러온 JSON DATA를 전역변수에 PUT 시킨다.
//					paragonCmm.jsonDataMap.put(docUid, JSON.parse(jsonData));
					paragonCmm.formMap.get(docUid).jsonData = jsonData;
				}
			});
		}
	}

	//-- 처리 버튼 로드
	var loadBtn = function(procType){
		procType = ((procType == undefined || procType == "") ? "" : procType);
		if(procType.indexOf("T") > -1){	//-- 임시저장
			var uiBtn = $('<span class="ui_btn medium icon">');
			var iTag  = $("<i id='"+preFix+"imsiSaveBtn'>").attr("class","fa fa-edit");
			$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.임시저장"))));
			$btnArea.append(uiBtn);
			$(uiBtn).off();
			$(uiBtn).on("click",function(){doSubmit('T');});

		}
		if(procType.indexOf("F") > -1){	//-- 미리보기, 결재상신
			var uiBtn = $('<span class="ui_btn medium icon">');
			var iTag  = $("<i>").attr("class","fa fa-search");
			uiBtn.append(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.미리보기"))));
			$btnArea.append(uiBtn);
			$(uiBtn).off();
			$(uiBtn).on("click",function(){openPreview();});

			var uiBtn3 = $('<span class="ui_btn medium icon" >');
			var iTag3  = $("<i>").attr("class","fa fa-pencil");
			uiBtn3.append(iTag3.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.상신"))));
			$btnArea.append(uiBtn3);
			$(uiBtn3).off();
			$(uiBtn3).on("click",function(){
				doSubmit('F');
			});

		}
		if(procType.indexOf("S") > -1){	//-- 처리완료
			var uiBtn = $('<span class="ui_btn medium icon">');
			var iTag  = $("<i>").attr("class","fa fa-pencil");
			$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.처리"))));
			$btnArea.append(uiBtn);
			$(uiBtn).off();
			$(uiBtn).on("click",function(){
				doSubmit('S');
			});
		}
		if(procType.indexOf("G") > -1){	//-- 검토요청 후결재
//			var uiBtn2 = $('<span class="ui_btn medium icon">');
//			var iTag2  = $("<i>").attr("class","fa fa-pen");
//			uiBtn2.append(iTag2.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.결재선지정"))));
//			$btnArea.append(uiBtn2);
//			$(uiBtn2).off();
//			$(uiBtn2).on("click",function(){selAprvLine()});

			var uiBtn = $('<span class="ui_btn medium icon">');
			var iTag  = $("<i>").attr("class","fa fa-search");
			uiBtn.append(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.미리보기"))));
			$btnArea.append(uiBtn);
			$(uiBtn).off();
			$(uiBtn).on("click",function(){openPreview();});


			var uiBtn = $('<span class="ui_btn medium icon">');
			var iTag  = $("<i>").attr("class","fa fa-pencil");
			$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.검토요청"))));
			$btnArea.append(uiBtn);
			$(uiBtn).off();
			$(uiBtn).on("click",function(){
				doSubmit('G');
			});
		}
	}
	//-- 파티클 로드
	var loadParticle = function(){
		var data = {};
		data["stuCd"] = $stuCd.val();
		paragonCmm.callAjax(PARTICLE_URL,data, function(json){
			var maxLen = $(json.data).length;

			var param = {};
			param.stuCd = $stuCd.val();
			param.docUid = $docUid.val();
			$(json.data).each(function(i, e){
				if("false" == $("#isProd").val()){
					$partiArea.append($("<span style='color:#DDDDDD;'>++시작 : "+e.patiMngNo+" : "+e.patiNm+"++</span>"));
				}
				$partiArea.append("<br>");
				var $div = $("<div>").attr("id", e.patiMngNo);
				var url = e.patiJspViewPath+".include";
				if($stuDtl.val() == "T" || $mode.val() != ""){
					url = e.patiJspWrtPath+".include";
				}
				param.ordNo = e.ordNo;
				$partiArea.append($div.load(url,param,function(){
						//-- 파티클에서 하도록 수정 20210727 강세원
//						if(i == (maxLen - 1)){	//-- 모든 파티클 로드 완료 후 다국어 Convert 실행
//							setTimeout(function(){
//								paragonCmm.convertLang($partiArea);
//							},200);
//						}
				}));

			});
		});
	}

	var sortArray = function(list){
		// 임시 배열은 위치 및 정렬 값이있는 객체를 보유합니다.
		var mapped = list.map(function(el, i) {
			return { index: i, value: el.ordNo };
		})

		// 축소 치를 포함한 매핑 된 배열의 소트
		mapped.sort(function(a, b) {
			return +(a.value > b.value) || +(a.value === b.value) - 1;
		});

		// 결과 순서를 위한 컨테이너
		var result = mapped.map(function(el){
			return list[el.index];
		});

		return result;
	};

	//-- 파티클 벨리데이션
	var chkVal = function(mode){
		var tmpValiFunc = paragonCmm.formMap.get(docUid).tmpValiFuncs;
		var valiFunc	= paragonCmm.formMap.get(docUid).valiFuncs;

		// tmpValiFunc.sort();
		// valiFunc.sort();

		tmpValiFunc = sortArray(tmpValiFunc);
		valiFunc = sortArray(valiFunc);

		var returnFail = function(){
			return false;
		};

		var chkFlag = false;
		if("T" == mode || "M" == mode){
			if($(tmpValiFunc).length > 0){
				var bool = false;
				tmpValiFunc.every(function(f, i){
					bool = f.fnc();
					return bool;
				});
				if(!bool) {
					return false;
				}
			}
		}else if("D" == mode){
			return true;
		}else{
			if($(valiFunc).length > 0){
				var bool = false;
				valiFunc.every(function(f, i){
					bool = f.fnc();
					return bool;
				});
				if(!bool){
					return false;
				}
			}
		}
		return true;

	}


	var setEvnet = function(){
		$("#KKKKKK"+docUid).on('click',function(){
			var imsiForm = $("<form method='POST'>").attr("action", "/paragon/def/defStuForm/defStuFormWrite.popup");
			imsiForm.append($("<input type='hidden' name='docUid'>").val('<c:out value="${param.docUid}"/>'));
			imsiForm.append($("<input type='hidden' name='solMasUid'>").val($solMasUid.val()));
			imsiForm.append($("<input type='hidden' name='stuCd'>").val($stuCd.val()));
			imsiForm.append($("<input type='hidden' name='mode'>").val('UPDATE'));
			imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));

			var screenWidth = 1152; //screen.width;
			var screenHeight = screen.height / 2;

			paragonCmm.openWindow("", screenWidth, screenHeight, "POP_PREVIEW_" , "yes", "yes", "");
			imsiForm.attr("target", "POP_PREVIEW_" );
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();
		} );
	}

	var init = function(){
		var obj ={
				jsonData:{}
				,docInfo:{}
				,previewInfo:{}
				,tmpValiFuncs:[]
				,valiFuncs:[]
		}
		//-- formMap에 초기 데이터 추가
		paragonCmm.formMap.set(docUid,obj);
		loadData();
		loadForm();
		setEvnet();
	}
	return{
		init:init,
		doSubmit:doSubmit
	}
}

	var defStuFromWrite = new DefStuFromWrite();
	$(document).ready(function () {

	    console.info("[Loading Module: 문서작성].....................");
	    defStuFromWrite.init();
	});
