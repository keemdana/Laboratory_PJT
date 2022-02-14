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
 *    코드 관리 화면
 * </pre>
 * @author 강세원
 */
"use strict";

function CODE_WRITE(){
	var codeStr = "";
	var $parentCdSelectModal;
    /**
     * 목록 페이지로 이동
     */
    var goList = function(frm) {

		var msg = paragonCmm.getLang("M.ALERT_LIST");
		confirm(msg, function(r){
    		if (r) {
    			var params = $(frm).serializeJSON();
    			params.langCd = "L.코드관리";
    			main.movePage("/viself/code/codeMng.include",params );
    		}
		});

    }

    /**
     * 저장
     */
    var doSubmit = function(frm) {
    	var cd 	= $("#CODE_INPUT_LIST input:text[name='cd']");

    	for(var i=0;i < cd.length ; i++){

    		//CODE_ID Validation
    		if(cd[i].value == ""){
    			alert(paragonCmm.getLang("M.ALERT_INPUT","L.코드"));
    			cd[i].focus();
    			return;
    		}

    		//아이디 중복 확인
    		for(var j=0;j < cd.length ; j++){
    			if(i == j ){
					continue;
    			}else{
    				if(cd[i].value==cd[j].value){
    					alert("중복된 코드 아이디가 존재합니다.");
    					$("#CODE_INPUT_LIST tr:eq("+j+")").find("td").attr("style", "background-color:red");
    					cd[j].focus();
    					return;
    				}
    			}
    		}
    	}
    	if($("#div_CODE_SUB_DATA").css("display") == "block"){
    		alert("추가정보 입력을 완료 하였다면 입력완료 버튼을 클릭해 주세요.");
			return;
    	}
    	confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장"), function(r){
    		if (r) {
				var params = {list: $("#CODE_INPUT_LIST").tableDataToJson()};
				params["parentCd"] = $("#codeMngWriteForm1 input:text[name='parentCd']").val();
				$.ajax({
                    type: "POST",
                    url: "/viself/code/codeMng/saveCode/json",
                    data: JSON.stringify(params),
                    success: function(json){
                    	if(json.errYn === "E"){
							//-- 오류처리
							alert(json.msg);
							return false;
						}
                    	goList(document.codeMngWriteForm1);
                    },
                    dataType: "json",
                    contentType: "application/json"
                });
        	}
    	});
    }
    /**
     * 상위 코드 아이디 정보 클리어
     */
	var InitParentCdSelect = function(){
		var opt = {};
		opt["multiSelect"] = "N";
		opt["selectType"] = "ALL";	//기본 최하위만 선택이지만 중간도 선택가능 하도록
		return opt;
	}
    /**
     * 상위 코드 아이디 검색
     */
    var ParentCodeId_Search = function() {
    	if( typeof $parentCdSelectModal != "object"){
    		$parentCdSelectModal = $("<div>");
		}
		//-- 코드 선택 모달
    	$parentCdSelectModal.window({
			iconCls:'icon-search',
		    width:850,
		    height:500,
		    title:paragonCmm.getLang("L.코드"),
		    href:"/viself/code/codeSelect.modal",
		    modal:true,
		    onClose:function(){
		    	$parentCdSelectModal.window("destroy");
		    },
		    onLoad:function(){
		    	CODE.init(InitParentCdSelect, ParentCodeId_Change);			//-- init,콜백 Function 지정
		    	paragonCmm.convertLang($parentCdSelectModal); 			//-- 다국어 처리
		    }
		});

    }

    /**
     * 상위 코드 아이디 정보 변경
     */
    var ParentCodeId_Change = function(json) {
    	$("#codeMngWriteForm1 input:text[name='parentCd']").val(json[0]["cd"]);
    	$parentCdSelectModal.window('close');
    }
    var autoComplete = function(ord){
		//언어사전에 존재하는 단어가 나오도록 자동완성하는 코드.
    	$('.autoLangCd_'+ord).combobox({
    		mode: 'remote',
    		valueField: 'value',
    		textField: 'label',
    		loader: function(param, succ){
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
    					succ(rows);
    				}
    			})
    		}
    	});

	}

    //코드 라인추가
    var addCodList = function(){
    	var codIdx = paragonCmm.getRandomUUID();
    	var data = [{init:"N",
    			childCnt:"0",
    			index:codIdx,
    			cd:codIdx,
    			cdAbb:"",
    			langCd:"",
    			useYn:"Y",
    			cud:"C",
    			rn:codIdx
    			}];
    	$("#TMPL_CODE_WIRTE").tmpl(data).appendTo($("#CODE_INPUT_LIST"));
    	return codIdx;
    }

    /*
    * 코드 라인 삭제
    */
    var removeCodLine = function(removeKey,child_cnt){
    	confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.선택하신코드및하위코드정보를완전히삭제"),function(r){
    		if(r){
    			var data = {};
    			data.cd = $("#div_CODE_WRITE_LIST tr[data-meaning="+removeKey+"]").find("input:text[name='cd']").val();
    			paragonCmm.callAjax("/viself/code/codeMng/deleteCode/json", data, function(json){
    				$("#div_CODE_WRITE_LIST tr[data-meaning="+removeKey+"]").remove();
    			});
    		}
    	});
//    	if(child_cnt != "0"){
//    		if(confirm("하위 코드가 존재 합니다. 삭제하시면 하위코드까지 모두 삭제 됩니다.\n삭제 하시겠습니까?")){
//    			$("#div_CODE_WRITE_LIST tr[data-meaning="+removeKey+"]").remove();
//    		}
//    	}else{
//	    	$("#div_CODE_WRITE_LIST tr[data-meaning="+removeKey+"]").remove();
//    	}

    }

    //코드 추가 정보 입력 활성
    var subDataOpen = function(trIdx){

    	var tm_index =	$("#tmpIndex").val();
    	//접있을땐 열어 준다.
    	if($("#div_CODE_SUB_DATA").css("display") == "none"){
    		setTmpData(trIdx);
	    	$("#div_CODE_SUB_DATA").show();
    	}else{
    		//열려있을때 클릭된 Idx 와 Tmp의 Idx가 같으면 숨김
    		if(tm_index == trIdx){
	    		$("#div_CODE_SUB_DATA").hide();

	    	//열려있을때 클릭된 Idx 와 Tmp의 Idx가 틀리면 초기화진행후 열어준다.
    		}else{
    			subDataReset();
    	    	setTmpData(trIdx);
    		}
    	}
    }

    var setTmpData = function(trIdx){
    	$("#tmpIndex").val(trIdx);
    	$("#tmpCdAttr1").val($("#cdAttr1_"+trIdx).val());
    	$("#tmpCdAttr2").val($("#cdAttr2_"+trIdx).val());
    	$("#tmpCdAttr3").val($("#cdAttr3_"+trIdx).val());
    	$("#tmpCdAttr4").val($("#cdAttr4_"+trIdx).val());
    	$("#tmpCdAttrDesc1").val($("#attrDesc1_"+trIdx).val());
    	$("#tmpCdAttrDesc2").val($("#attrDesc2_"+trIdx).val());
    	$("#tmpCdAttrDesc3").val($("#attrDesc3_"+trIdx).val());
    	$("#tmpCdAttrDesc4").val($("#attrDesc4_"+trIdx).val());
    	$("#tmpCdData").val($("#cdData_"+trIdx).val());
    }
    //코드 추가 정보 데이터 비활성
    var subDataClose = function(trInx){
    	subDataReset();
    	$("#tmpIndex").val(trInx);
    	$("#div_CODE_SUB_DATA").hide();
    }
    //코드 추가 정보 데이터 초기화
    var subDataReset = function(){
    	$("#div_CODE_SUB_DATA INPUT[data-meaning=TMP]").val("");
    	$("#div_CODE_SUB_DATA TEXTAREA[data-meaning=TMP]").val("");
    }

    //코드 추가 정보 입력 완료
    var doCompleSubData = function(){

    	var trIdx = $("#tmpIndex").val();
    	$("#cdAttr1_"+trIdx).val($("#tmpCdAttr1").val());
    	$("#cdAttr2_"+trIdx).val($("#tmpCdAttr2").val());
    	$("#cdAttr3_"+trIdx).val($("#tmpCdAttr3").val());
    	$("#cdAttr4_"+trIdx).val($("#tmpCdAttr4").val());
    	$("#attrDesc1_"+trIdx).val($("#tmpCdAttrDesc1").val());
    	$("#attrDesc2_"+trIdx).val($("#tmpCdAttrDesc2").val());
    	$("#attrDesc3_"+trIdx).val($("#tmpCdAttrDesc3").val());
    	$("#attrDesc4_"+trIdx).val($("#tmpCdAttrDesc4").val());
    	$("#cdData_"+trIdx).val(	$("#tmpCdData").val());

    	subDataClose();
    }

  	//저장항목 로드
    var loadPatentTable = function(){
		var data = {};
		if( "CHILD" == $("#updateMode").val()){
			data["parentCd"] = $("#reqCd").val();
		}else{
			data["parentCd"] = $("#reqParentCd").val();
			data["cd"] = $("#reqCd").val();
		}
  		paragonCmm.callAjax("/viself/code/codeMng/listCode/json", data, function(data){
  			console.log(data);
  			$("#TMPL_CODE_WIRTE").tmpl(data.data).appendTo($("#CODE_INPUT_LIST"));
  			paragonCmm.tableTrDragSet("CODE_INPUT_LIST");
		});
    }

  	var getUseYnHtml = function(val){
  		var div = $("<div>");
  		var sel = $("<select name='useYn'>");
  		sel.append($("<option value='Y'>").attr("selected",("Y" == val)).text("Y"));
  		sel.append($("<option value='N'>").attr("selected",("N" == val)).text("N"));
  		div.append(sel);
  		return div.html();
  	}
  	//이벤트 추가
    var attachEvents = function(){
    	//코드 추가 버튼
    	$("#div_CODE_WRITE_LIST span[data-meaning=code_list_add]").off();
    	$("#div_CODE_WRITE_LIST span[data-meaning=code_list_add]").click(function(){
            var ord = addCodList();
            paragonCmm.tableTrDragSet("CODE_INPUT_LIST");
            autoComplete(ord);
        });
    	$("#codeMngWriteBtnSave").off();
    	$("#codeMngWriteBtnSave").on("click",function(){
    		doSubmit(document.codeMngWriteForm1);
    	});
    	$("#codeMngWriteBtnClose").off();
    	$("#codeMngWriteBtnClose").on("click",function(){
    		goList(document.codeMngWriteForm1);
    	});
    	$("#parentCd,#parentCodeSearchBtn").off();
    	$("#parentCd,#parentCodeSearchBtn").on("click",function(){
    		ParentCodeId_Search();
    	});
    	$("#subInputEnd").off();
    	$("#subInputEnd").on("click",function(){
    		doCompleSubData();
    	});
    }

  	var init = function(){
		if( "CHILD" == $("#updateMode").val()){
			$("input:text[name='parentCd']", "#codeMngWriteForm1").val($("#reqCd").val());
		}else{
			$("input:text[name='parentCd']", "#codeMngWriteForm1").val($("#reqParentCd").val());
		}
		attachEvents();
		loadPatentTable();
		var tr 	= $("#CODE_INPUT_LIST tr");
		console.log(tr.length);
		$(tr).each(function(i, o){
			var ord = $(o).data("meaning");
			autoComplete(ord);

		});

    }

  	return{
  		init:init,
  		getUseYnHtml:getUseYnHtml,
  		subDataOpen:subDataOpen,
  		removeCodLine:removeCodLine
  	}

}
	var CODDWRITE = new CODE_WRITE();
	$(document).ready(function () {

	    console.info("[Loading Module: 코드관리작성].....................");

	    CODDWRITE.init();
	}());
