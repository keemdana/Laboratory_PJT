/**
 * AIR 시스템 공용 자바스크립트 도우미 객체
 * @returns {jsHelper_paragonCmm}
 */
function jsHelper_paragonCmm () {

	// CONTEXT Path 가 정의되면 아래 CONTEXT_PATH 값을 변경해준다.
	this.CONTEXT_PATH = "";
}
// IE console.log polyfill
if ( !window.console ) window.console = { log:function() {} };

/**
 * AIR 시스템 공용 자바스크립트 도우미 인스턴스
 */
var paragonCmm = new jsHelper_paragonCmm();
/**
 * 윕스 링크 전역상수
 */
jsHelper_paragonCmm.prototype.wipsLink = "http://sd.wips.co.kr/wipslink/api/dkrdshtm.wips?skey=";
jsHelper_paragonCmm.prototype.wipsLinkSs = "http://sd.wips.co.kr/wipslink/api/d";
jsHelper_paragonCmm.prototype.wipsLinkEs = "dshtm.wips?skey=";

/**
 * 언어코드 상수들
 */
var cmmLocalStorage = Storages.localStorage;
var langMas = {};
var noLangMas = [];
//-- hash history
var hisHashMap = {};

/**
 * [
 * 	docUid : {
 * 		jsonData:{},
 * 		tmpValiFuncs:[{파티클에서 셋팅1},{파티클에서 셋팅2},{파티클에서 셋팅3},...],
 * 		valiFuncs:[{파티클에서 셋팅1},{파티클에서 셋팅2},{파티클에서 셋팅3},...]
 * 	}
 * ]
 */
jsHelper_paragonCmm.prototype.formMap = new Map();


/**
 * contextPath 처리하기 위한 getUrl
 * 
 * @param targetUrl "/"으로 시작하는 url 경로
 * @returns {*}
 */
jsHelper_paragonCmm.prototype.getUrl = function(targetUrl){
	return this.CONTEXT_PATH + targetUrl;
}


jsHelper_paragonCmm.prototype.openWips = function(wkey, chulweongug_cod){
	var url;
	if(chulweongug_cod == undefined){
	    url = this.wipsLink+wkey;
	}else{
	    url = this.wipsLinkSs + chulweongug_cod + this.wipsLinkEs + wkey;
	}

	var target = 'WipsPopup'+wkey;
	this.openWindow(url, '1280', '650', target , "yes", "yes");
}
/**
 * siteLocal 반환
 * 설정은 menu.top.jsp onLoad 할떄 함.
 */
jsHelper_paragonCmm.prototype.getSiteLocale = function () {

	return cmmLocalStorage.get("SITE_LOCALE");
};
/**
 * lnagMas 값 초기화
 */
jsHelper_paragonCmm.prototype.initLangStorage = function (langVerSion) {

	//-- 기존 저장 스토리지 삭제
	var oldVersion =cmmLocalStorage.get("LANG_VERSION");
	cmmLocalStorage.remove(oldVersion);
	var data = {};
	data["NO_PAGE"] = "Y";
	this.callAjax('/viself/mlang/mLangInit/json',data,function(json){
		langMas = {};
		$(json.data).each(function(i, d){
//			var lang = {};
//			lang["KO"] = d.ko;
//			$.each(d, function(key, val){
//				lang[key.toUpperCase()] = val;
//			});
//			console.log(lang);
			langMas[d.langCd] = d[paragonCmm.getSiteLocale().toLowerCase()] ;
//			langMas[d.langCd] = lang ;
		});
		cmmLocalStorage.set(langVerSion,langMas);
		cmmLocalStorage.set("LANG_VERSION",langVerSion);
	},false);
};

/**
 * lnagMas 값 초기화
 */
jsHelper_paragonCmm.prototype.initLangMas = function () {

	var langVersion =cmmLocalStorage.get("LANG_VERSION");
	if(cmmLocalStorage.get(langVersion) != null && cmmLocalStorage.get(langVersion) != ""){
		langMas = cmmLocalStorage.get(langVersion);
	}
};
/**
 * 미등록 다국어 추가
 */
jsHelper_paragonCmm.prototype.setNoLang = function (langCd) {

	if(langCd.startsWith("L.")
		||langCd.startsWith("B.")
		||langCd.startsWith("M.")
		||langCd.startsWith("C.")
	){
		//-- 기존 저장 스토리지 삭제
		noLangMas.push(langCd);
	}

};
/**
 * 로컬 스토리지에서 다국어 가져오기
 * @param langCd  다국어코드
 * @param label	  라벨
 */
jsHelper_paragonCmm.prototype.getLang = function (langCd, label) {
//	console.log("langCd:"+langCd);
//	console.log("label:"+label);
	var rtnLang = "";
	if(langMas == null){

	}else if(jQuery.isEmptyObject(langMas)){
		 paragonCmm.initLangMas();
	}

	var arrLangCd = []; //-- 다중 다국어 일경우 각각 구하기
	var separ	  = ""; //-- 다중 다국어 일경우 구분자
	if(langCd){
		if(langCd.indexOf("≫") > -1 ){
			arrLangCd = langCd.split("≫");
			separ = "≫";
		}else if( langCd.indexOf(",") > -1){
			arrLangCd = langCd.split(",");
			separ = ",";
		}
	}

	if(arrLangCd.length > 0){
		var tmpArrStr = [];
		$(arrLangCd).each(function(i, v){
			if("" != v){
				var tempStr = "";
				if(langMas.hasOwnProperty(v)){
//					tempStr =  langMas[v][paragonCmm.getSiteLocale()];
					tempStr =  langMas[v];
					tempStr = (tempStr == "")? "NG:"+v : tempStr; //-- 등록되있으나 번역되지 않음
				}else{
					if(langCd.startsWith("L.")
							||langCd.startsWith("B.")
							||langCd.startsWith("M.")
							||langCd.startsWith("C.")
						){
						tempStr = v;
						paragonCmm.setNoLang(v);

					}else{
						tempStr = v; //-- 넘어온값이 다국어 코드가 아닐때
					}
				}
				tmpArrStr.push(tempStr);
			}
		});
		rtnLang = tmpArrStr.join(separ);

	//-- 다중 다국어가 아닐때
	}else{

		var getLabel = function(label){//-- 라벨이 있을경우
			var rtnLabel = "";
			if(label != undefined && typeof label == 'string'){
//				console.log(label);
				if(langMas.hasOwnProperty(label)){
//					rtnLabel = langMas[label][paragonCmm.getSiteLocale()];
					rtnLabel = langMas[label];
				}else{
					rtnLabel = label;
				}
			}

			return rtnLabel;
		}

		if(langMas.hasOwnProperty(langCd)){
//			rtnLang = langMas[langCd][paragonCmm.getSiteLocale()];
			rtnLang = langMas[langCd];
			if(label != undefined){
				rtnLang = (getLabel(label) == "")? rtnLang: rtnLang.replaceAll("[LABEL]",getLabel(label));
				if("KO" == paragonCmm.getSiteLocale() && typeof label == 'string'){	//-- 한국어 일때 라벨 종성에 따른 뒷 문자열 변환
					//--종성에 따른 은/는 이/가 을/를 구분 반환
					var getKorWordByJongSung = function(word, fistVal, secondVal, defaultStr){
						var lastWord = word.charCodeAt(word.length -1, word.length);

						//-- 한글 제일 처음과 끝의 법위밖일 경우는 오류
						if(lastWord < 0xAC00 || lastWord > 0xD7A3){
							return defaultStr;
						}

						var selectVal = (lastWord - 0xAC00) %28 > 0 ? fistVal: secondVal;

						return selectVal;
					}
					rtnLang = rtnLang.replaceAll("을(를)",getKorWordByJongSung(label, "을", "를", "을(를)"));
					rtnLang = rtnLang.replaceAll("이(가)",getKorWordByJongSung(label, "이", "가", "이(가)"));
					rtnLang = rtnLang.replaceAll("은(는)",getKorWordByJongSung(label, "은", "는", "은(는)"));
				}

			}
			rtnLang = (rtnLang == "")? "NG:"+langCd : rtnLang; //-- 등록되있으나 번역되지 않음
		}else{
				if(langCd && (langCd.startsWith("L.")
						||langCd.startsWith("B.")
						||langCd.startsWith("M.")
						||langCd.startsWith("C.")	)
				){
					rtnLang = langCd;							//-- 사전등록되어 있지 않음
					paragonCmm.setNoLang(langCd);
				}else{
					rtnLang = langCd;							//-- 다국어 형식이 아닐때
				}
		}
	}

	return rtnLang;


};
/**
 * 입력 가능한 최대 문자열 길이 체크 (※ 대상 컨트롤의 onblur 이벤트에 사용하세요~!)
 * @param input 대상 컨트롤 객체
 * @param len 최대값(단위:바이트)
 */
jsHelper_paragonCmm.prototype.validateMaxLength = function (input, len) {
	var val = input.value;

	if (val != "") {
		var byteLength = 0;
		for (var idx = 0; idx < val.length; idx++) {
			var oneChar = escape(val.charAt(idx));
			if (oneChar.length == 1) {
				byteLength++;
			} else if (oneChar.indexOf("%u") != -1) {
				byteLength += 3; //유니코드 문자는 3byte
			} else if (oneChar.indexOf("%") != -1) {
				byteLength += 2; //기타 특수문자는 2byte
			}

			if (byteLength > parseInt(len)) {
				alert("입력 가능한 최대 문자열 길이("+ len +" 바이트)를 초과했습니다.\n초과한 문자는 잘립니다.");
				input.value = val.substring(0, idx);

				this.displayByte($(input).attr("id"));

				return;
			}
		}
	}
};
jsHelper_paragonCmm.prototype.displayByte = function (id) {
	if($("#"+id)){
		var len = this.chkLength($("#"+id).val());
		$("#byte_"+id).text(len);
	}
}
jsHelper_paragonCmm.prototype.chkLength = function (val) {
	var byteLength = 0;
	for (var idx = 0; idx < val.length; idx++) {
		var oneChar = escape(val.charAt(idx));
		if (oneChar.length == 1) {
			byteLength++;
		} else if (oneChar.indexOf("%u") != -1) {
			byteLength += 3; //유니코드 문자는 3byte
		} else if (oneChar.indexOf("%") != -1) {
			byteLength += 2; //기타 특수문자는 2byte
		}
	}
	return byteLength;
}

/**
 * 사용하고 있는 브라우저 종류 및 버젼 확인 메소드  2015-05-14 최
 */
navigator.sayswho = (function(){
    var ua= navigator.userAgent, tem,
    M= ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if(/trident/i.test(M[1])){
        tem=  /\brv[ :]+(\d+)/g.exec(ua) || [];
        return 'IE '+(tem[1] || '');
    }
    if(M[1]=== 'Chrome'){
        tem= ua.match(/\bOPR\/(\d+)/);
        if(tem!= null) return 'Opera '+tem[1];
    }
    M= M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
    if((tem= ua.match(/version\/(\d+)/i))!= null) M.splice(1, 1, tem[1]);
    return M.join(' ');
})();

/**
 * 첨부파일 - 유효성 체크 (필수 첨부)
 */
jsHelper_paragonCmm.prototype.validateAttachFile = function (fileTpCd) {

	if($("input:hidden[value='"+fileTpCd+"']").length > 0){
		var fileCnt = paragonFile.arrFileInfo[$("input:hidden[value='"+fileTpCd+"']").parent().find("input:hidden[name='_attachFileCtrlUuid']").val()].infos.length;
		if(fileCnt == undefined || fileCnt == 0){
			//alert("첨부파일을 등록해주세요.");
			return false;
		}else{
			return true;
		}
	}else{
		return false;
	}


//	var res = true;
//
//	var required_yn_obj = document.getElementsByName("_attachFileRequiredYn");
//	for (var i = 0; i < required_yn_obj.length; i++) {
//		if (required_yn_obj[i].value == "Y") {
//			var ctrl_uuid 	= document.getElementsByName("_attachFileCtrlUuid")[i].value;
//			var attTypeCod 	= document.getElementsByName("_attachFileTypeCode")[i].value;
//			var uuid_obj	= document.getElementsByName("_attachFileUuid"+ ctrl_uuid);
//			if("" != fileTpCd){
//				if(fileTpCd == attTypeCod){
//					if (uuid_obj.length == 0) {
//						//document.getElementById("_attachFileAddButton"+ ctrl_uuid).focus();
//						res = false;
//						break;
//					}
//				}else{
//					continue;
//				}
//			}else{
//				if (uuid_obj.length == 0) {
//					alert("첨부파일을 등록해주세요.");
//					//document.getElementById("_attachFileAddButton"+ ctrl_uuid).focus();
//					res = false;
//					break;
//				}
//			}
//		}
//	}
//
//	return res;
};

/**
 * 첨부문서 - 유효성 체크 (필수 첨부)
 */
jsHelper_paragonCmm.prototype.validateAttachDoc = function () {
	var res = true;

	var required_yn_obj = document.getElementsByName("_attachDocRequiredYn");
	for (var i = 0; i < required_yn_obj.length; i++) {
		if (required_yn_obj[i].value == "Y") {
			var ctrl_uuid 	= document.getElementsByName("_attachDocCtrlUuid")[i].value;
			var uuid_obj	= document.getElementsByName("_attachDocUuid"+ ctrl_uuid);
			if (uuid_obj.length == 0) {
				alert("첨부문서를 등록해주세요.");
				document.getElementById("_attachDocAddButton"+ ctrl_uuid).focus();
				res = false;
				break;
			}
		}
	}

	return res;
};



/**
 * 날짜 입력값 유효성 체크 (※ 형식에 맞지 않으면 null 값 리턴)
 * @param dateValue
 * @param dateSepar
 */
jsHelper_paragonCmm.prototype.validateDateValue = function (dateValue, dateSepar) {
	var res = null;

	if (dateValue == "") {
		res = "";
	} else {
		if (dateSepar == undefined) dateSepar = "-";

		//dateValue = dateValue.replace("/"+ dateSepar +"/gi", "");
		dateValue = dateValue.replaceAll(dateSepar, "");

		if (dateValue.length == 8 && !isNaN(dateValue)) {
			var yyyy 	= dateValue.substr(0, 4);
			var mm 		= dateValue.substr(4, 2);
			var dd 		= dateValue.substr(6, 2);

			if (parseInt(yyyy, 10) <= 1900 || parseInt(mm) <= 12 || parseInt(dd) <= 31) {
				res = yyyy + dateSepar + mm + dateSepar + dd;
			}
		}
	}

	return res;
};

/**
 * 날짜 입력 객체 유효성 체크
 * @param dateObj
 * @param dateSepar
 */
jsHelper_paragonCmm.prototype.validateDateObject = function (dateObj, dateSepar)
{
	var res = this.validateDateValue(dateObj.value, dateSepar);
	if (res == null) {
		alert("날짜를 형식에 맞게 다시 입력해주세요.");
		dateObj.value = "";
		dateObj.focus();
	} else {
		dateObj.value = res;
	}
};


/**
 * 금액 콤마 표시
 * @param obj 입력상자 객체 또는 문자열
 * @param maxPoint 소수점 이하 자릿수 제한값 [-1:무제한, 0:허용안함(기본값)]
 */
jsHelper_paragonCmm.prototype.getFormatCurrency = function (obj, maxPoint){
	var res		= "";

	var noMark	= "";	// 양수/음수 기호
	var str1	= "";
	var str2	= "";
	if (obj != null && typeof(obj) == "object") {
		if(event){
			if ( (event.keyCode>36)&&(event.keyCode<41) ) {
				event.returnValue = false;
				return;
			}
		}

		res = obj.value;
	} else {
		if(obj == null){
			res = "0";
		}else{
			res = String(obj);
		}
	}

	// 양수/음수 기호 셋팅!
	if ( res != "" && (res.substring(0, 1) == "+" || res.substring(0, 1) == "-") ) {
		noMark = res.substring(0, 1);
	}

	res = res.replace(/[^0-9.]/g,'');	// 숫자, 소수점을 제외한 문자 제거

	res = Number(res).toString(); // 앞에 불필요한 0 제거

	// 소수점 이하 자릿수 최대값이 없으면,
	if (maxPoint == undefined)
		maxPoint = 0;	// 소수점 이하 자릿수 허용안함을 기본값으로 셋팅
	else
		maxPoint = parseInt(maxPoint);

	var idxDot	= res.indexOf('.');
	if (idxDot == -1) {
		str1 = res;
	} else {
		str1 = res.substring(0, idxDot);

		if (maxPoint == -1)		// 소수점 이하 자릿수 무제한
			str2 = "."+ res.substr(idxDot).replace(/[^0-9]/g, '');
		else if (maxPoint > 0)	// 소수점 이하 자릿수 제한
			str2 = "."+ res.substr(idxDot, maxPoint+1).replace(/[^0-9]/g, '');
	}

	var ReN	= /(-?[0-9]+)([0-9]{3})/;
	while (ReN.test(str1)) {
		str1 = str1.replace(ReN, "$1,$2");
	}

	res = noMark + str1 + str2;
	if (obj != null && typeof(obj) == "object") {
		obj.value = res;
	} else {
		return res;
	}
};



/**
 * 날짜입력 컨트롤 출력 도우미 메소드
 * @param sCtrlName 컨트롤 이름
 * @param sCtrlId 컨트롤 아이디
 * @param sInitData 초기값
 * @param sCtrlEtc 컨트롤 스타일, 이벤트 등
 * @return HTML 문자열
 */
jsHelper_paragonCmm.prototype.getInputCalendar = function (sCtrlName, sCtrlId, sInitData, sCtrlEtc)
{
	var res = "";

	res += "<input type=\"text\" name=\""+ sCtrlName +"\" id=\""+ sCtrlId +"\" value=\""+ sInitData +"\" class=\"date\" onfocus=\"this.select()\" onblur=\"paragonCmm.validateDateObject(this);\" "+ sCtrlEtc +" />";
	res += "\r\n<input type=\"button\" value=\" \" onclick=\"paragonCmm.openInputCalendar('"+ sCtrlId +"');\" class=\"btn_calendar\" />";

	return res;
};


/**
 * 날짜 월 더하기
 * @param thisObj 원본 날짜개체의 개체 포인터
 * @param tarObjName 입력할 날짜개체의 개체 Name
 * @param addMonth 더할 달수
 */
jsHelper_paragonCmm.prototype.setCalendarAddMonth = function (thisObj, tarObjName, addMonth)
{
	var startDate    = thisObj.value;
	var startDateArr = startDate.split("-");


	var st = new Date(startDateArr[0],startDateArr[1]-1,startDateArr[2]);
	var st2 = new Date(st.getFullYear(),st.getMonth()+addMonth ,st.getDate());

	var year 	= st2.getFullYear();
	var month 	= st2.getMonth()+1;
	var date	= st2.getDate();

	if(parseInt(month, 10) < 10){
		month = "0"+month;
	}

	if(parseInt(date, 10) < 10){
		date = "0"+date;
	}

	document.getElementsByName(tarObjName)[0].value = year + "-" + month+ "-" +date ;
};





/**
 * 날짜입력 컨트롤 보여주기
 */
jsHelper_paragonCmm.prototype.openInputCalendar = function (inputCtrlId) {
	$(function() {
		if("KO" === paragonCmm.getSiteLocale()){
			$.datepicker.setDefaults( $.datepicker.regional[ 'ko' ] );
		}else{
			$.datepicker.setDefaults( $.datepicker.regional[ 'en' ] );
		}
		$( '#'+ inputCtrlId ).datepicker({
			changeMonth: true
			, changeYear: true
			, showButtonPanel: true
		});
	});

	document.getElementById(inputCtrlId).focus();
};

/**
 * 날짜입력 컨트롤 보여주기
 */
jsHelper_paragonCmm.prototype.openCallBackCalendar = function (inputCtrlId,callBackFunction) {
	$(function() {
		$.datepicker.setDefaults( $.datepicker.regional[ getSiteLocale() ] );
		$( '#'+ inputCtrlId ).datepicker({
			changeMonth: true
			, changeYear: true
			, showButtonPanel: true
			, onSelect: function(selectedDate){
				callBackFunction(selectedDate);
			}
		});
	});

	document.getElementById(inputCtrlId).focus();
};

/**
 * 문서 출력 버튼 클릭 시
 */
jsHelper_paragonCmm.prototype.doPopupPrintOpen = function (STU_CD, DOC_UID) {
		var actionCode = "";
		var airMode = "";

		actionCode = 'SYS_FORM';
		airMode = 'VIEW_PRINT';

		var url
		= "/ServletController"
		+ "?AIR_ACTION="+actionCode
		+ "&AIR_MODE="+airMode
		+ "&STU_CD="+STU_CD
		+ "&DOC_UID="+DOC_UID;

		paragonCmm.openWindow(url, "900", "700", "POPUP_VIEW", "yes", "yes", "");

};

/**
 * 지정된 레이어에 달력 컨트롤 출력
 * @param layerCrlId
 * @param isShowChangeCombo 년/월 변경콤보 보이기 여부 [true:보이기, false:숨기기(기본값)]
 */
jsHelper_paragonCmm.prototype.printCalendar = function (layerCrlId, isShowChangeCombo) {
	if (isShowChangeCombo != true) isShowChangeCombo = false;

	$(function() {
		$.datepicker.setDefaults( $.datepicker.regional[ 'ko' ] );
		$( "#"+ layerCrlId ).datepicker({
			changeMonth: isShowChangeCombo
			, changeYear: isShowChangeCombo
		});
	});
};





/**
 * 에디터에 입력한 값 가져오기
 * @param id 에디터 컨트롤 아이디
 * @param isTextOnly 텍스트만 가져오기 여부 [true:텍스트만 반환, false:HTML 텍스트 반환(기본값)]
 * @param productName 제품명 [FCKEDITOR:FCKeditor(기본값)]
 * @returns {String}
 */
jsHelper_paragonCmm.prototype.getEditorValue = function (id, editorType, isTextOnly ) {
var res = "";

	editorType = ((editorType == undefined || editorType == "") ? "CKEDITOR" : editorType);

	if (editorType == "CKEDITOR") {
		res = new Function("return CKEDITOR.instances." + id + ".getData()")();

	} else if (editorType == "DEXT5") {

		res = DEXT5.isEmpty(id)

	} else if (editorType == "NAMO") {

		res = new Function("return CrossEditor" + id + ".GetTextValue()")();

	} else if (editorType == "X_FREE") {

		res = new Function("return XfreeEditor" + id + ".getTextValue().trim() ")();

	} else {
		res = document.getElementById(id).value;
	}

	return res;
};

/**
 * 에디터에 따른 포커스 처리
 * @param id 에디터 컨트롤 아이디
 * @param isTextOnly 텍스트만 가져오기 여부 [true:텍스트만 반환, false:HTML 텍스트 반환(기본값)]
 * @param productName 제품명 [FCKEDITOR:FCKeditor(기본값)]
 * @returns {String}
 */
jsHelper_paragonCmm.prototype.getEditorFocus = function (id, editorType ) {
	var res = "";

	editorType = ((editorType == undefined || editorType == "") ? "CKEDITOR" : editorType);

	if (editorType == "CKEDITOR") {
		CKEDITOR.instances[id].focus();

	} else if (editorType == "DEXT5") {
		$('#'+id).focus();

	} else if (editorType == "NAMO") {
		res = new Function("return CrossEditor" + id + ".SetFocusEditor()")(); // 크로스에디터 Focus 이동

	} else if (editorType == "X_FREE") {
		res = new Function("return XfreeEditor" + id + ".setFocus()")(); // 크로스에디터 Focus 이동

	} else {
		res = document.getElementById(id).fucus();
	}

	return res;
};

/**
 * 에디터에 따른 서브밋 전처리
 * @param id 에디터 컨트롤 아이디
 * @param isTextOnly 텍스트만 가져오기 여부 [true:텍스트만 반환, false:HTML 텍스트 반환(기본값)]
 * @param productName 제품명 [FCKEDITOR:FCKeditor(기본값)]
 * @returns {String}
 */
jsHelper_paragonCmm.prototype.setEditorSubmit = function (editorType ) {
	var res = "";

	editorType = ((editorType == undefined || editorType == "") ? "CKEDITOR" : editorType);

	if (editorType == "CKEDITOR") {

		for ( instance in CKEDITOR.instances )
	        CKEDITOR.instances[instance].updateElement();

	} else if (editorType == "DEXT5") {

		$(DextEditor).each(function(i,el){

			$("textarea[name='"+el.editorName+"']").eq(0).val(DEXT5.getBodyValue(el));

		});

	} else if (editorType == "NAMO") {
		/*
		*	나모웹 에디터 처리 Submit 처리
		*   나모에디터를 사용하지 않아도 Exception 발생하지 않으므로 코드 지우기 있기? 없기?
		*/
		$(CrossEditor).each(function(i,el){
			$("textarea[name='"+el.editorName+"']").eq(0).val(el.GetBodyValue());
		});

	} else if (editorType == "X_FREE") {
		/*
		*	X free 에디터  Submit 처리
		*   X free 사용하지 않아도 Exception 발생하지 않으므로 코드 지우기 있기? 없기?
		*/
		$(XfreeEditor).each(function(i,el){
			$("textarea[name='"+el.getRenderId()+"']").eq(0).val(el.getBodyValue());
		});
	}



};


/**
 * 문자열 좌우공백 제거
 * @param str
 */
jsHelper_paragonCmm.prototype.getTrim = function (str) {
	return str.replace(/(^\s*)|(\s*$)/gi, "");
};

/**
 * 문자열 좌측공백 제거
 * @param str
 */
jsHelper_paragonCmm.prototype.getLTrim = function (str) {
	return str.replace(/^\s+/, "");
};

/**
 * 문자열 우측공백 제거
 * @param str
 */
jsHelper_paragonCmm.prototype.getRTrim = function (str) {
	return str.replace(/\s+$/, "");
};


/***************************************************************************
* 제목 : 선택상자 초기화
* 인자 : id - 선택상자 아이디
*        codestr - 옵션 구성용 문자열 ex> VALUE1[separ1]TEXT1[separ2]VALUE2[separ1]TEXT2[separ2]...
*        initdata - 선택된 옵션 값(값이 여러 개일 경우 쉼표(,)로 구분 ex> val1, val2, ...)
***************************************************************************/
jsHelper_paragonCmm.prototype.initializeSelect = function (id, codestr, initdata, separ1, separ2, separ3) {
  var a_temp1, a_temp2;

  // 옵션값 초기화
  initdata = (initdata == undefined ? "" : initdata);
  separ1 = (separ1 == undefined ? "|" : separ1);
  separ2 = (separ2 == undefined ? "^" : separ2);
  separ3 = (separ3 == undefined ? "," : separ3);

  var o_select = document.getElementById(id);
  for (var i = o_select.length - 1; i > -1; i--) {
      o_select.options[i] = null; //일단 null로 초기화
  }

  if (codestr != "") { // 옵션 구성용 문자열이 있으면,
      a_temp1 = codestr.split(separ2);
      for (var i = 0; i < a_temp1.length; i++) {
          a_temp2 = a_temp1[i].split(separ1);
          o_select.options[i] = new Option(a_temp2[1], a_temp2[0], true);

          a_temp3 = initdata.split(separ3);
          for (var j = 0; j < a_temp3.length; j++) {
              if (a_temp3[j] != "" && a_temp3[j] == a_temp2[0]) { // 선택된 옵션 값과 일치하면,
                  //o_select.selectedIndex = i; // 선택된 상태로..
                  o_select.options[i].selected = true;
              }
          }
      }
  }

  //o_select.fireEvent('onChange');	// OnChange 이벤트 호출~
};

/***************************************************************************
* 제목 : 팝업창 오픈 ===> (구) openBrowser()
* 메모 : ※ url 내 한글이 사용되는 값에는 escape 처리하여 보내고 unescape 로 받음!
***************************************************************************/
jsHelper_paragonCmm.prototype.openWindow = function (url, width, height, name, scrollbars, resizable, etc) {
  var left = 0;
  var top = 0;

  if (url == undefined || url == "") {
	  url = "about:blank";
  }

  if (String(width) == "100%") {
	  width = window.screen.availWidth-20;
  } else {
	  left = (window.screen.availWidth / 2) - (width / 2);
  }

  if (String(height) == "100%") {
	  height = window.screen.availHeight;
  } else {
	  top = (window.screen.availHeight / 2) - (height / 2);
  }

  if (name == undefined) {
      name = "";
  }

  if (scrollbars == "yes" || scrollbars == "1") {
      scrollbars = "yes";
  } else {
      scrollbars = "no";
  }

  if (resizable == "yes" || resizable == "1") {
      resizable = "yes";
  } else {
      resizable = "no";
  }

  if (etc == undefined) {
	  etc = "";
  } else {
	  etc = ","+ etc;
  }

  var a = window.open(encodeURI(url), name, "left=" + left + ",top=" + top + ",width=" + width + ",height=" + height + ",scrollbars=" + scrollbars + ",resizable=" + resizable + ",toolbar=no,location=no,directories=no,status=no,menubar=no"+ etc);

  $(a).focus();

  return a;
};



/***************************************************************************
* 제목 : radio/checkbox에서 선택되어졌는지 여부를 반환
***************************************************************************/
jsHelper_paragonCmm.prototype.isCheckedInput = function (input) {
  var is_checked = false;

  if (input != undefined) {
      // 폼이 있을 경우,
      if (input.length == undefined) {
          //-- 폼이 1개일 경우,
          is_checked = input.checked;
      } else {
          //-- 폼이 1개 이상일 경우,
          for (var i = 0; i < input.length; i++) {
              if (input[i].checked) {
                  is_checked = true;
                  break;
              }
          }
      }
  }

  return is_checked;
};


/***************************************************************************
* 제목 : radio에서 선택된 값을 가져온다.
***************************************************************************/
jsHelper_paragonCmm.prototype.getCheckedRadioValue = function (input) {
  var v_checked = "";

  for (var i = 0; i < input.length; i++) {
      if (input[i].checked == true) {
          v_checked = input[i].value;
          break;
      }
  }

  return v_checked;
};


/***************************************************************************
* 제목 : radio에서 선택된 값의 타이틀을 가져온다.
***************************************************************************/
jsHelper_paragonCmm.prototype.getCheckedRadioTitle = function (input) {
  var v_checked = "";

  for (var i = 0; i < input.length; i++) {
      if (input[i].checked == true) {
          v_checked = input[i].title;
          break;
      }
  }

  return v_checked;
};


/***************************************************************************
* 제목 : checkbox에서 선택된 값을 가져온다
* 인자 : input - checkbox 객체
       separ - 선택 값 구분자 (기본값:쉼표[,])
***************************************************************************/
jsHelper_paragonCmm.prototype.getCheckedCheckboxValue = function (input, separ) {
  var v_checked = "";

  if (separ == undefined || separ == "") separ = ",";

  for (var i = 0; i < input.length; i++) {
      if (input[i].checked == true) {
          if (v_checked != "")
              v_checked += separ;

          v_checked += input[i].value;
      }
  }

  return v_checked;
};


/***************************************************************************
* 제목 : checkbox에서 선택된 값의 타이틀을 가져온다
* 인자 : input - checkbox 객체
       separ - 선택 값 구분자 (기본값:쉼표[,])
***************************************************************************/
jsHelper_paragonCmm.prototype.getCheckedCheckboxTitle = function (input, separ) {
  var v_checked = "";

  if (separ == undefined || separ == "") separ = ",";

  for (var i = 0; i < input.length; i++) {
      if (input[i].checked == true) {
          if (v_checked != "")
              v_checked += separ;

          v_checked += input[i].title;
      }
  }

  return v_checked;
};


//용도 : 체크박스 전체 선택/해제 토글
//인자 : tarName - 대상 폼 이름
//      tarChecked - 선택=true, 해제=false
jsHelper_paragonCmm.prototype.toggleCheckbox = function (tarName, tarChecked) {
  try {
      var o_tar = document.getElementsByName(tarName);
      for (var i = 0; i < o_tar.length; i++) {
          o_tar[i].checked = tarChecked;
      }
  } catch (e) {
	  console.log(e.message);
  }
};


//용도 : 아이프레임 사이즈를 재조정
//인자 : id - 아이프레임 아이디(또는 이름)
//      w - 넓이(없으면 무조정, "auto"면 자동조정)
//      h - 높이(없으면 무조정, "auto"면 자동조정)
jsHelper_paragonCmm.prototype.resizeIFrame = function (id, w, h) {


		if ( !w ) return;
		if ( !h ) return;
		var o_iframe = document.getElementById(id);
		var $iframe = $("#" + id);
		var beforeScrollTop = $(window).scrollTop();

		// 넓이 조정
		o_iframe.style.width = "0px";
		if (w === "auto") w = o_iframe.contentWindow.document.body.scrollWidth + 20;
		//-- 숫자형이 아닐 경우 단위를 픽셀로 지정(※ 미지정시 웹표준 준수 브라우저에서 오동작!)
		if (!isNaN(w)) w = w +"px";
		o_iframe.style.width = w;


		// 높이 조정
		o_iframe.style.height = "0px";
		if ( h === "auto") h = o_iframe.contentWindow.document.body.scrollHeight + 50;

		//-- 숫자형이 아닐 경우 단위를 픽셀로 지정(※ 미지정시 웹표준 준수 브라우저에서 오동작!)
		if ( !isNaN(h) ) h = h + "px";
		o_iframe.style.height = h;

		// iframe 의 도메인과 top frame의 도메인이 다르면 리사이징을 수행하지않도록 방어코드 작성
		var isNotResizable = (function() {
			try{
				var t0 = $iframe.get(0).contentWindow.parent.top.document;
				return false;
			}catch(e) {
				return true;
			}
		})();
		if ( isNotResizable ) {
			return;
		}
		function iframeResize() {
			var $el = $(this);
			var isPopup = !!window.opener;
			var selectedId = $("#tepTabsLayer").tabs('getSelected').attr('id');
			// 통합이력화면은 두개로 쪼개져있기때문에 height 계산을 케이스별로 새로 해야된다.
			if ( selectedId == 'tepTabs-TEP_HISTORY') {
				var defaultHeight = 700;
				var $iframe = $('#tepViewLayer').find('iframe');
				var rightMenuHeight = $($iframe[0].contentWindow.document).height() + 10;
				var treeHeight = $('#tepTreeListLayer').outerHeight() + 87;

				var max = Math.max.apply(null, [defaultHeight, rightMenuHeight, treeHeight]);
				h = max;
				$('.layout').css('height', h +'px');
				setTimeout(function() {
					$('.easyui-layout').layout('resize');
				},500)
			}
			$("#tepTabsLayer .tabs-wrap").css('width','');

			$el.attr("height", parseInt(h) + 50);
			$el.parent().css("height", (parseInt(h) + 53) + "px");
		}

		$($iframe.get(0).contentWindow.parent.top.document).find("iframe[name|='listTabsFrame']").each(iframeResize);
		/*if ( $($iframe.get(0).contentWindow.parent.top.document).find("iframe[name|='listTabsFrame']").length == 0 ) { // 팝업인경우에
			if($iframe[0].contentWindow){
				var defaultHeight = 700;
				var $iframe = $('#tepViewLayer').find('iframe');
				var rightMenuHeight = $($iframe[0].contentWindow.document).height() + 10;
				var treeHeight = $('#tepTreeListLayer').outerHeight() + 87;

				var max = Math.max.apply(null, [defaultHeight, rightMenuHeight, treeHeight]);
				h = max;
				$('.layout').css('height', h +'px');
				setTimeout(function() {
					$('.easyui-layout').layout('resize');
				},500);
			}
		}*/

		this.gridResize();
		if ( beforeScrollTop ) $(window).scrollTop(beforeScrollTop);
	try{
	}catch(e){
		console.log(e.message);
	}

};


//용도 : 쿠키값 저장하기
//인자 : name - 쿠키명
//      value - 쿠키값
//      expiredays - 쿠키유효일  (1:1일, 2:2일, 365:일년)
jsHelper_paragonCmm.prototype.setCookie = function (name, value, expiredays) {
  var todayDate = new Date();
  todayDate.setDate(todayDate.getDate() + expiredays);
  document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";

};


/**
 * 용도 : 쿠키값 가져오기
 * @param name 쿠키명
 */
jsHelper_paragonCmm.prototype.getCookie = function (name) {
  var nameOfCookie = name + '=';
  var x = 0;
  while (x <= document.cookie.length) {
      var y = (x + nameOfCookie.length);
      if (document.cookie.substring(x, y) == nameOfCookie) {
          if ((endOfCookie = document.cookie.indexOf(';', y)) == -1)
              endOfCookie = document.cookie.length;
          return unescape(document.cookie.substring(y, endOfCookie));
      }
      x = document.cookie.indexOf(' ', x) + 1;
      if (x == 0) break;
  }

  return '';
};


/**
 * 코드정보 문자열에서 비교 값과 일치하는 그룹의 대상 값을 반환
 * @param srcValue 비교 값
 * @param codestr 코드정보 문자열
 * @param separ1 값 구분자
 * @param separ2 그룹 구분자
 * @param separ3 비교 값 구분자
 * @param validx 비교 값 인덱스
 * @param taridx 대상 값 인덱스
 * @returns {String}
 */
jsHelper_paragonCmm.prototype.getCodestrValue = function (srcValue, codestr, separ1, separ2, separ3, srcIndex, tarIndex) {
	var v_res = "";

	separ1 		= (separ1 == undefined ? "|" : separ1);
	separ2 		= (separ2 == undefined ? "^" : separ2);
	separ3 		= (separ3 == undefined ? "," : separ3);

	srcIndex 	= (srcIndex == undefined ? 0 : parseInt(srcIndex));
	tarIndex 	= (tarIndex == undefined ? 1 : parseInt(tarIndex));

	var a_val		= srcValue.split(separ3);
	var a_codestr 	= codestr.split(separ2);

	for (var i = 0; i < a_val.length; i++) {
		for (var j = 0; j < a_codestr.length; j++) {
			var a_temp = a_codestr[j].split(separ1);

			if (a_temp[srcIndex] == a_val[i].replace(/ /g, "")) {
				if (v_res != "") v_res += separ3;	//비교 값이 1개 이상일 경우 반환값에 구분자 삽입

				v_res += a_temp[tarIndex];
			}
		}
	}

	return v_res;
};



/**
 * 영문 여부 체크
 * @param obj
 * @param str
 * @returns {Boolean}
 */
jsHelper_paragonCmm.prototype.validateAlpha = function (obj, str){

//	val=obj.value;
//	re=/[^a-zA-Z]/gi;
//	obj.value=val.replace(re,"");


	var regStr = /^[A-Za-z]*$/;
	if(regStr.test(str)){
		return true;
	}else{
		alert("영문만 입력 가능합니다.");
		obj.value = "";
		return false;
	}

};


/**
 * 숫자 여부 체크
 * @param obj
 * @param str
 * @returns {Boolean}
 */
jsHelper_paragonCmm.prototype.validateNumber = function (obj, str){
	var regStr = new RegExp("^[0-9]*$");
	if(regStr.test(str)){
		return true;
	}else{
		alert("숫자만 입력 가능합니다.");
		obj.value = "";
		return false;
	}
};

/**
 * 숫자/콤마만 허용
 * @param obj
 * @param str
 * @returns {Boolean}
 */
jsHelper_paragonCmm.prototype.validateCommaNumber = 	function (obj, str){
	var regStr = new RegExp("^[0-9,]*$");
	if(regStr.test(str)){
		return true;
	}else{
		alert("'숫자' 와 ',' 만 입력 가능합니다.");
		obj.value = "";
		return false;
	}
};

/**
 * 숫자/소수점만 허용
 * @param obj
 * @param str
 * @returns {Boolean}
 */
jsHelper_paragonCmm.prototype.validatePointNumber = 	function (obj, str){
	if(str == null || str == ""){return;}
	var regStr =  new RegExp("^[0-9.]*$");
	if(regStr.test(str)){
		return true;
	}else{
		alert("'숫자' 와 '.' 만 입력 가능합니다.");
		obj.value = "";
		return false;
	}

};


/**
 * 특수문자 입력여부 체크
 * @param obj
 * @returns {Boolean}
 */
jsHelper_paragonCmm.prototype.validateSpecialChars = function (obj) {
	var str = "";
	if (typeof(obj) == "object") {
		str = obj.value;
	} else {
		str = obj;
	}

	if (str.indexOf("\\") > -1 || str.indexOf("^") > -1 || str.indexOf("|") > -1 || str.indexOf("≪") > -1 || str.indexOf("≫") > -1) {
		alert("특수문자(\\^|≪≫)는 사용할 수 없습니다.");
		str = str.replaceAll("\\", "");
		str = str.replaceAll("^", "");
		str = str.replaceAll("|", "");
		str = str.replaceAll("≪", "");
		str = str.replaceAll("≫", "");
		if (typeof(obj) == "object") { obj.focus(); }

		return false;
	} else {
		return true;
	}
};


/**
 * 대상 문자열을 자바스크립트 출력용 문자열로 변환
 * @param str
 * @returns
 */
jsHelper_paragonCmm.prototype.convertForJavascript = function (str) {
	if (str == undefined || str == null) {
		str = "";
	} else {
		str = ""+ str;
	}

	str = str.replace(/\\/g, "\\\\");
	str = str.replace(/\"/g, "\\\"");
	str = str.replace(/\'/g, "\\'");
	str = str.replace(/\r/g, "\\r");
	str = str.replace(/\n/g, "\\n");
	str = str.replace(/\t/g, "\\t");
	str = str.replace(/\f/g, "\\f");

	//alert("convertForJavascript => "+ str);

	return str;
};

/**
 * 대상 문자열을 뷰 출력용 문자열로 변환
 * @param str
 * @returns
 */
jsHelper_paragonCmm.prototype.convertForView = function (str) {
	if (str == undefined || str == null) {
		str = "";
	} else {
		str = ""+ str;
	}
	var replaceAll = function(str, searchStr, replaceStr){
		return str.split(searchStr).join(replaceStr);
	}
	str = replaceAll(str, "\&", "&amp;");
	str = replaceAll(str, "\"", "&#34;");
	str = replaceAll(str, "\'", "&#39;");
	str = replaceAll(str, "<", "&#60;");
	str = replaceAll(str, ">", "&#62;");
//	str = replaceAll(str, "\\", "&#92;");
	str = replaceAll(str, "  ", "&#32;&#32;");
	str = replaceAll(str, "\t", "&#32;&#32;&#32;");
	str = replaceAll(str, "\r\n", "<br />");
	str = replaceAll(str, "\n", "<br />");

	return str;
};

/**
 * 대상 문자열을 폼값 출력용 문자열로 변환
 * @param str
 * @returns
 */
jsHelper_paragonCmm.prototype.convertForInput = function (str) {
	if (str == undefined || str == null) {
		str = "";
	} else {
		str = ""+ str;
	}

	str = str.replace(/\&/g, "&amp;");
	str = str.replace(/\#/g, "&#35;");
	str = str.replace(/\"/g, "&#34;");
	str = str.replace(/\'/g, "&#39;");
	str = str.replace(/\</g, "&#60;");
	str = str.replace(/\>/g, "&#62;");
	str = str.replace(/\\/g, "&#92;");

	return str;
};


/**
 * Date 관련 월/일 이 한자리인 경우 '0'을 붙혀주는 함수
 * @param str
 * @returns
 */
jsHelper_paragonCmm.prototype.addZero = function (str)
{
	var tmpStr;
	if(typeof(str) == "number"){
		tmpStr = str.toString();
	}else{
		tmpStr = str;
	}
	//alert(tmpStr.length);
	if(tmpStr.length == 1){
		tmpStr = "0" + tmpStr;
	}
	return tmpStr;
};


/**
 * 문자열의 길이가 제한된 길이보다 길 경우 자르고 말줄임표 삽입
 * @param str 문자열
 * @param len 길이
 * @param apos 말줄임표
 * @return
 */
jsHelper_paragonCmm.prototype.getTrunc = function(str, len, apos)
{
	var res = "";

	if (apos == undefined || apos == null) {
		apos = "...";
	}

	len = parseInt(len);

	if (str != null) {
		if (str.length > len) {
			res = str.substring(0, len);
			if (apos != "") {
				res += apos;
			}
		} else {
			res = str;
		}
	}

	return res;
};


/**
 * URL로 부터 XmlHttpRequest 객체 가져오기 (동기식)
 * @param url
 * @param queryString
 * @returns
 */
jsHelper_paragonCmm.prototype.getXmlHttpRequestFromUrl = function (url, queryString)
{
	url = (url == undefined || url == null ? "" : url);
	queryString = (queryString == undefined || queryString == null ? "" : queryString);

	var res = null;

	if (url != "") {
		// XML객체를 생성한다.
		var xmlHttp = null;

		if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (xmlHttp == null) {
			alert("XMLHttpRequest 객체 생성에 실패했습니다.");
			return false;
		}

		// XML DATA를 처리해줄 페이지를 호출한다(동기식:false, 비동기식:true)
		xmlHttp.open("POST", encodeURI(url), false);
		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"); //한글파라미터깨짐 해결
		xmlHttp.send(encodeURI(queryString).replace(/%20/g, "+")); // POST방식 사용시 공백(%20)을 + 기호로 치환해야 함

		//console.log("url is "+ url);
		//console.log("queryString is "+ queryString);
		//console.log("responseText is "+ xmlHttp.responseText);

		res = xmlHttp;
	 }

	 return res;
};

/**
 * 용도 : 	XML로 부터 각종 코드정보 문자열 받기
 * 인자 : 	arguments[0] - 모드 코드
 *		    arguments[1] - 코드정보문자열 기본값
 *			arguments[2] - 코드정보문자열 그룹 구분자
 *   		arguments[3~] - 파라메타
 * 메모 : 	※ 한글이 사용되는 값에는 escape 처리하여 보내고 unescape 로 받음!
 */
jsHelper_paragonCmm.prototype.getCodeStrFromXML = function (modeCode, defaultCodestr, groupSeparator)
{
	defaultCodestr = (defaultCodestr == undefined || defaultCodestr == null ? "" : defaultCodestr);
	groupSeparator = (groupSeparator == undefined || groupSeparator == null || groupSeparator == "" ? "^" : groupSeparator);

	var v_url 		= "/ServletController";
	var v_qstr 		= "AIR_ACTION=CMM_XML&AIR_MODE="+ modeCode;
	var v_res 		= defaultCodestr;
	var v_separ		= groupSeparator;

	//console.log("modeCode is "+ modeCode);
	//console.log("arguments[3] is "+ arguments[3]);
	//console.log("arguments[4] is "+ arguments[4]);
	//console.log("arguments[5] is "+ arguments[5]);
	//console.log("arguments[6] is "+ arguments[6]);

	// 모드 코드 인자값에 따라 작업이 결정됨
	switch (modeCode) {
		case "SYS_CODE_BY_PARENT_CODE_ID" :
			//-- 주어진 상위 코드 아이디에 해당되는 정보 반환
			v_qstr += "&PARENT_CODE_ID=" + arguments[3];
			v_qstr += "&STATUS_CODE=" + (arguments[4] == undefined || arguments[4] == null ? "N,S" : arguments[4]);
			v_qstr += "&FIELD_NAMES=" + (arguments[5] == undefined || arguments[5] == null ? "" : arguments[5]);
			v_qstr += "&ORDER_CLAUSE=" + (arguments[6] == undefined || arguments[6] == null ? "" : arguments[6]);
			break;

		case "SYS_CODE_BY_PARENT_UUID" :
			//-- 주어진 상위 코드 아이디에 해당되는 정보 반환
			v_qstr += "&PARENT_UUID=" + arguments[3];
			v_qstr += "&STATUS_CODE=" + (arguments[4] == undefined || arguments[4] == null ? "N,S" : arguments[4]);
			v_qstr += "&FIELD_NAMES=" + (arguments[5] == undefined || arguments[5] == null ? "" : arguments[5]);
			v_qstr += "&ORDER_CLAUSE=" + (arguments[6] == undefined || arguments[6] == null ? "" : arguments[6]);
			break;

		case "SYS_CODE_BY_UUID" :

		case "SYS_GISULBUNRYU_BY_UUID" :

		case "CMM_CABINET_BY_UUID" :
			v_qstr += "&UUID=" + arguments[3];
			v_qstr += "&FIELD_NAMES=" + (arguments[4] == undefined || arguments[4] == null ? "" : arguments[4]);
			break;

		case "SYS_USER_BY_UUID" :
			//-- 주어진 UUID에 해당되는 정보 반환
			v_qstr += "&UUID=" + arguments[3];
			v_qstr += "&FIELD_NAMES=" + (arguments[4] == undefined || arguments[4] == null ? "" : arguments[4]);
			break;

		case "SYS_USER_BY_GROUP_CODE" :
			//-- 부서코드로 사용자 조회
			v_qstr += "&GROUP_CODE=" + arguments[3];
			v_qstr += "&FIELD_NAMES=" + (arguments[4] == undefined || arguments[4] == null ? "" : arguments[4]);
		    break;

		case "GET_FILE_UID" :
			//-- t_system_attach_file TB uuid COL 조회 BY master_doc_id
			v_qstr += "&MASTER_DOC_ID=" + arguments[3];
			break;

		case "DEPT_SUB_LIST" :
			//-- GROUP OR DEPT 코드의 하위 부서 OR 사용자를 RETURN
			v_qstr += "&PARENT_CODE=" + arguments[3];
			v_qstr += "&STATUS_CODES=" + (arguments[4] == undefined || arguments[4] == null ? "" : arguments[4]);
			v_qstr += "&FIELD_NAMES=" + (arguments[5] == undefined || arguments[5] == null ? "" : arguments[5]);
			v_qstr += "&ORDER_CLAUSE=" + (arguments[6] == undefined || arguments[6] == null ? "" : arguments[6]);
			break;

		case "DEF_DOC_MAIN_LIST" :
			//-- 업무구분에 해당하는
			v_qstr += "&WHERE_FIELD=" + arguments[3];
			v_qstr += "&WHERE_VALUE=" + arguments[4];
			v_qstr += "&SEOSIK_GBN="  + arguments[5];
			v_qstr += "&FIELD_NAMES=" + arguments[6];
			v_qstr += "&ORDER_CLAUSE="+ arguments[7];
			break;

		case "LOGIN_ID_CHK" :
			//-- 기본결재선 가져오기
			v_qstr += "&LOGIN_ID="    + arguments[3];
			break;


		case "DEFAULT_APV_LINE_LIST" :
			//-- 기본결재선 가져오기
			v_qstr += "&EOBMU_GBN="  		+ arguments[3];
			v_qstr += "&SOL_MAS_UID="  		+ arguments[4];
			v_qstr += "&CHEORIJA_GBN="  	+ arguments[5];
			v_qstr += "&CHEORIJA_VAL="  	+ arguments[6];
			break;

		case "FLOW_ALREADY_CHEORI_YN" :
			//-- 기본결재선 가져오기
			v_qstr += "&CRNT_DOC_FLOW_UID=" + arguments[3];
			break;

		case "TIMESHEET_WORKTIME_CHK" :
			//-- TIMESHEET 입력 시 기존 입력시간과 겹치는지 확인
			v_qstr += "&TIMESHEET_INS_TYPE=" + arguments[3];
			v_qstr += "&TIMESHEET_YYYYMMDD=" + arguments[4];
			v_qstr += "&START_WORK_HH=" 		+ arguments[5];
			v_qstr += "&START_WORK_MM=" 		+ arguments[6];
			v_qstr += "&END_WORK_HH=" 		+ arguments[7];
			v_qstr += "&END_WORK_MM=" 		+ arguments[8];

			//-- 수정모드에서 지금 수정하려고 하는 건은 제외하고 시간이 중복되는 것이 있나 체크하기 위해 T/S테이블의 키 3개를 넘김
			v_qstr += "&WORK_DATE=" 		+ arguments[9];
			v_qstr += "&F_EMPNO=" 		+ arguments[10];
			v_qstr += "&SEQ_NO=" 		+ arguments[11];

			break;

		case "BOSANG_COST_EDIT" :
			//-- 보상금 수정
			v_qstr += "&IP_BOSANG_UID="  		+ arguments[3];
			v_qstr += "&BOSANG_EDIT_COST="  	+ arguments[4];

			break;

		case "BIYONG_IF" :
			//-- 비용인터페이스 처리
			v_qstr += "&MUGEUM_UID="  		+ arguments[3];

			break;

		case "AJAXS_AGENCY_LIST"	:
			//-- 국가 코드에 의한 대리인코드 가져오기
			v_qstr += "&NAT_CODE="  	+ arguments[3];

		case "PART_DAMDANGJA_LIST":
			//파트 변경시 해당 담당자 변경
			v_qstr += "&PARENT_CODE_ID=" + arguments[3];

			break;
	}

	if (v_url != "") {
		var o_xmlHttp = this.getXmlHttpRequestFromUrl(v_url, v_qstr);

		if (o_xmlHttp != null) {
			// XML 중 코드정보 문자열 텍스트 추출
			var v_codestr = o_xmlHttp.responseXML.getElementsByTagName("DATA").item(0).firstChild.nodeValue;

			// 코드정보 문자열 값이 있으면,
			if (v_codestr != "") {
				if (v_res != "") v_res += v_separ;

				v_res += v_codestr;
			}
		}
	 }

	 return v_res;
};

/**
 * 외부변호사 선택 팝업
 * @param callbackFunction 선택시 호출할 함수
 * @param params 각종 파라메터
 */
jsHelper_paragonCmm.prototype.popupLawfirmSelect = function (callbackFunction, params)
{
	var url = "/ServletController?AIR_ACTION=LMS_LAWFIRM&AIR_MODE=POPUP_LAWFIRM_SELECT" ;
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!

	$.each(params, function(k, v){
		url += "&"+k+"="+ v;

	})
	/*
	if(params["groupCodestr"]){
		url += "&groupCodestr="+ params["groupCodestr"];
	}
	if(params["defaultUser"]){
		url += "&defaultUser="+ params["defaultUser"];
	}
	if(params["userType"]){
		url += "&userType="+ params["userType"];
	}
	if(params["multiselect"]){
		url += "&multiselect="+ params["multiselect"];
	}
	*/
	this.openWindow(url, '1024', '600', 'popupUserSelect', "yes", "no");
};

/**
 * 사용자 선택 팝업
 * @param callbackFunction 선택시 호출할 함수
 * @param viewType 뷰 유형 [DTREE:트리 뷰, (나머지):리스트 뷰]
 * @param rootCodeId 트리 뷰 루트 부서코드
 * @param deptType 조직유형 코드's [IG:내부, OG:외부]
 * @param companyClsCodes 업체분류 코드's [TS:특허사무소, BS:법률사무소]
 */
jsHelper_paragonCmm.prototype.popupUserSelect = function (callbackFunction, params)
{
	var url = "/ServletController?AIR_ACTION=SYS_USER&AIR_MODE=POPUP_USER_SELECT" ;
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!

	$.each(params, function(k, v){
		url += "&"+k+"="+ v;

	})
	/*
	if(params["groupCodestr"]){
		url += "&groupCodestr="+ params["groupCodestr"];
	}
	if(params["defaultUser"]){
		url += "&defaultUser="+ params["defaultUser"];
	}
	if(params["userType"]){
		url += "&userType="+ params["userType"];
	}
	if(params["multiselect"]){
		url += "&multiselect="+ params["multiselect"];
	}
	*/
	this.openWindow(url, '1024', '600', 'popupUserSelect', "yes", "no");
};

/**
 * 오픈창에서 선택한 값을 지정하는 callbackFunction
 * @param v_id
 * @param h_id
 * @param uid
 * @param name
 */
jsHelper_paragonCmm.prototype.setPopupValue = function (h_id, v_id, uid, name){
	var hObj = document.getElementById(h_id);
	var vObj = document.getElementById(v_id);
	hObj.value = uid;
	vObj.value = name;
}

/**
 * 오픈창에서 선택한 값을 지정하는 callbackFunction
 * @param v_id
 * @param h_id
 * @param uid
 * @param name
 */
jsHelper_paragonCmm.prototype.setPopupValues = function (h_id, v_id, p_id, n_id, uid, name, code, codeName){
	var hObj = document.getElementById(h_id);
	var vObj = document.getElementById(v_id);
	var pObj = document.getElementById(p_id);
	var nObj = document.getElementById(n_id);
	hObj.value = uid;
	vObj.value = name;
	pObj.value = code;
	nObj.value = codeName;
};



/**
 * 부서 선택 팝업(체크박스)
 * @param callbackFunction 선택시 호출할 함수
 * @param typeCodes 유형 코드들 [IG:내부, OG:외부, (빈값):(전체)]
 */
jsHelper_paragonCmm.prototype.popupDeptSelects = function (callbackFunction, params)
{
	var url = "/ServletController?AIR_ACTION=SYS_DEPT&AIR_MODE=POPUP_DEPT_SELECTS";
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!
	if(params["initFunction"]){
		url += "&initFunction="+ params["initFunction"];
	}
	if(params["groupCodestr"]){
		url += "&groupCodestr="+ params["groupCodestr"];
	}
	if(params["deptType"]){
		url += "&deptType="+ params["deptType"];
	}
	if(params["typeCodes"]){
		url += "&typeCodes="+ params["typeCodes"];
	}

	this.openWindow(url, '1024', '500', 'popupDeptSelects', "yes", "no");
};



/**
 * 코드 선택 팝업
 * @param callbackFunction 선택시 호출할 함수
 * @param rootCodeId 루트 코드 아이디
 * @param selectType 선택 유형 [ALL:전체, LAST:마지막 노드]
 * @param statusCodes 상태 코드들 [N:정상, D:폐기, S:시스템전용]
 */
jsHelper_paragonCmm.prototype.popupCodeSelect = function (callbackFunction, rootCodeId, multiSelect, statusCodes, etc)
{
	if (rootCodeId == undefined || rootCodeId == null) {
		rootCodeId = "";
	}

	if (statusCodes == undefined || statusCodes == null) {
		statusCodes = "N,S";
	}

	var url = "/viself/code/codeSelect.popup";
	url += "?callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!
	url += "&multiSelect="+ multiSelect;
	url += "&popupNm=L.코드";
//	url += "&statusCodes="+ statusCodes;
//	url += "&listLayerHeight=300";
//	url += etc;

	this.openWindow(url, '1024', '500', 'popupCodeSelect', "yes", "no");
};


/**
 * 코드 선택 팝업
 * @param callbackFunction 선택시 호출할 함수
 * @param rootCodeId 루트 코드 아이디
 * @param selectType 선택 유형 [ALL:전체, LAST:마지막 노드]
 * @param statusCodes 상태 코드들 [N:정상, D:폐기, S:시스템전용]
 */
jsHelper_paragonCmm.prototype.popupCodeSelects = function (callbackFunction, rootCodeId, selectType, statusCodes)
{

	var url = "/ServletController?AIR_ACTION=SYS_CODE&AIR_MODE=POPUP_CODE_SELECTS";
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!
	url += "&rootCodeId="+ rootCodeId;
	url += "&selectType="+ selectType;
	url += "&statusCodes="+ statusCodes;
	url += "&listLayerHeight=300";

	this.openWindow(url, '1024', '500', 'popupCodeSelect', "yes", "no");
};



/**
 * 양식 열기 팝업
 * @param typeCode
 * @param fileName
 */
jsHelper_paragonCmm.prototype.popupFormOpen = function (file_type_cd, fileName)
{
	var url = "/ServletController";
	url += "?AIR_ACTION=SYS_ATCH";
	url += "&AIR_MODE=FORM_SRC";
	url += "&file_type_cd="+ file_type_cd;
	url += "&file_nm="+ escape(fileName);

	this.openWindow(url, '100%', '100%', '', 'yes', 'yes', '');
};


/**
 * 양식 다운로드 팝업
 * @param typeCode
 * @param fileName
 */
jsHelper_paragonCmm.prototype.formDownload = function (typeCode, fileName)
{
	var url = "/ServletController";
	url += "&fileTpCd="+ typeCode;
	url += "&fileNm="+ encodeURIComponent(fileName);

	//this.openWindow(url, '50', '50', '', 'no', 'no');
	document.getElementById("airBackgroundProcessFrame").src = url;
};

/**
 * 파일 열기 팝업
 * @param typeCode
 * @param fileName
 */
jsHelper_paragonCmm.prototype.popupDirectFileOpen = function (file_type_cd, fileName)
{
	var url = "/ServletController";
	url += "?AIR_ACTION=SYS_ATCH";
	url += "&AIR_MODE=DIRECT_FILE_SRC";
	url += "&file_type_cd="+ file_type_cd;
	url += "&file_nm="+ escape(fileName);

	this.openWindow(url, '100%', '100%', '', 'yes', 'yes', '');
};

/**
 * 파일 다운로드 팝업
 * @param typeCode
 * @param fileName
 */
jsHelper_paragonCmm.prototype.popupDirectFileDownload = function (file_type_cd, fileName)
{
	var url = "/ServletController";
	url += "?AIR_ACTION=SYS_ATCH";
	url += "&AIR_MODE=DIRECT_FILE_DOWNLOAD";
	url += "&file_type_cd="+ file_type_cd;
	url += "&file_nm="+ escape(fileName);

	//this.openWindow(url, '50', '50', '', 'no', 'no');
	document.getElementById("airBackgroundProcessFrame").src = url;
};

/**
 * 첨부파일 추가 팝업
 * @param callbackFunction 업로드 완료시 호출할 함수
 * @param masterDocId 문서 아이디
 * @param systemTypeCode 시스템 유형 코드
 * @param typeCode 유형 코드
 * @param maxFileSize 최대 첨부 크기
 * @param maxFileCount 최대 첨부 수
 * @param fileFilter 첨부 가능한 파일 필터 ex> All Files|*.*|Image Files|*.jpg;*.jpeg;*.gif;*.bmp|
 * @param fileRFilter 첨부 불가한 파일 필터 ex> *.jpg;*.jpeg;*.bmp
 * @param randomFileNameYn 랜덤파일명 생성여부
 * @param overwriteYn 덮어쓰기 여부
 */
jsHelper_paragonCmm.prototype.popupAttachFileUpload = function (callbackFunction, masterDocId, systemTypeCode, typeCode, maxFileSize, maxFileCount, fileFilter, fileRFilter, randomFileNameYn, overwriteYn)
{
	maxFileSize = (maxFileSize == undefined || maxFileSize == null ? "" : maxFileSize);
	maxFileCount = (maxFileCount == undefined || maxFileCount == null ? "" : maxFileCount);
	fileFilter = (fileFilter == undefined || fileFilter == null ? "" : fileFilter);
	fileRFilter = (fileRFilter == undefined || fileRFilter == null ? "" : fileRFilter);
	randomFileNameYn = (randomFileNameYn == undefined || randomFileNameYn == null ? "" : randomFileNameYn);
	overwriteYn = (overwriteYn == undefined || overwriteYn == null ? "" : overwriteYn);

	var url = "/ServletController?AIR_ACTION=SYS_ATCH&AIR_MODE=POPUP_FILE_UPLOAD_FORM";
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!
	url += "&masterDocId="+ masterDocId;
	url += "&systemTypeCode="+ systemTypeCode;
	url += "&typeCode="+ typeCode;
	url += "&maxFileSize="+ maxFileSize;
	url += "&maxFileCount="+ maxFileCount;
	url += "&fileFilter="+ escape(fileFilter);
	url += "&fileRFilter="+ escape(fileRFilter);
	url += "&randomFileNameYn="+ randomFileNameYn;
	url += "&overwriteYn="+ overwriteYn;

	this.openWindow(url, '1024', '400', 'popupAttachFileUpload', "no", "no");
};

/**
 * 첨부파일 추가 팝업
 * @param callbackFunction 업로드 완료시 호출할 함수
 * @param masterDocId 문서 아이디
 * @param systemTypeCode 시스템 유형 코드
 * @param typeCode 유형 코드
 * @param maxFileSize 최대 첨부 크기
 * @param maxFileCount 최대 첨부 수
 * @param fileFilter 첨부 가능한 파일 필터 ex> All Files|*.*|Image Files|*.jpg;*.jpeg;*.gif;*.bmp|
 * @param fileRFilter 첨부 불가한 파일 필터 ex> *.jpg;*.jpeg;*.bmp
 * @param randomFileNameYn 랜덤파일명 생성여부
 * @param overwriteYn 덮어쓰기 여부
 */
jsHelper_paragonCmm.prototype.popupAttachJQueryFileUpload = function (callbackFunction, masterDocId, systemTypeCode, typeCode, maxFileSize, maxFileCount, fileFilter, fileRFilter, randomFileNameYn, overwriteYn)
{
	maxFileSize = (maxFileSize == undefined || maxFileSize == null ? "" : maxFileSize);
	maxFileCount = (maxFileCount == undefined || maxFileCount == null ? "" : maxFileCount);
	fileFilter = (fileFilter == undefined || fileFilter == null ? "" : fileFilter);
	fileRFilter = (fileRFilter == undefined || fileRFilter == null ? "" : fileRFilter);
	randomFileNameYn = (randomFileNameYn == undefined || randomFileNameYn == null ? "" : randomFileNameYn);
	overwriteYn = (overwriteYn == undefined || overwriteYn == null ? "" : overwriteYn);

	var url = "/ServletController?AIR_ACTION=SYS_ATCH&AIR_MODE=POPUP_JQUERY_FILE_UPLOAD_FORM";
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!
	url += "&masterDocId="+ masterDocId;
	url += "&systemTypeCode="+ systemTypeCode;
	url += "&typeCode="+ typeCode;
	url += "&maxFileSize="+ maxFileSize;
	url += "&maxFileCount="+ maxFileCount;
	url += "&fileFilter="+ escape(fileFilter);
	url += "&fileRFilter="+ escape(fileRFilter);
	url += "&randomFileNameYn="+ randomFileNameYn;
	url += "&overwriteYn="+ overwriteYn;

	this.openWindow(url, '800', '450', 'popupAttachJQueryFileUpload', "no", "no");
};

/**
 * 일괄 ZIP 다운로드
 * @param uuid
 */
jsHelper_paragonCmm.prototype.zipFileDownload = function (typeCode,masterDocId, callbackFunction)
{
	var url = "/ServletController";
	url += "?AIR_ACTION=SYS_ATCH";
	url += "&AIR_MODE=ZIP_DOWNLOAD";
	url += "&typeCode="+ typeCode;
	url += "&masterDocId="+ masterDocId;

	/*
	$.ajax({
		url: url
		, type: "POST"
		, dataType: "json"
	})
	.done(function(data) {
		callbackFunction(data);
   })
   .fail(function() {
   	// 도중 에러가 발생했습니다.
	   alert("ERROR!!");
//       alert("<%=StringUtil.getLocaleWord("M.처리중오류발생관리자문의하세요",siteLocale, StringUtil.getLocaleWord("L.수정", siteLocale))%>");
   });

	*/
	document.getElementById("airBackgroundProcessFrame").src = url;
};


/**
 * 문서 작성 후 첨부파일 추가팝업
 * @param masterDocId 문서 아이디
 * @param systemTypeCode 시스템 유형 코드
 * @param typeCode 유형 코드
 */
jsHelper_paragonCmm.prototype.popupAfterAttachFileUpload = function (masterDocId, systemTypeCode, typeCode)
{
	var url = "/ServletController?AIR_ACTION=SYS_ATCH&AIR_MODE=POPUP_AFTER_ADD_WRITE_FORM";
	url += "&masterDocId="+ masterDocId;
	url += "&systemTypeCode="+ systemTypeCode;
	url += "&typeCode="+ typeCode;

	this.openWindow(url, '1024', '300', 'popupAfterAttachFileUpload', "no", "no");
};


/**
 *
 * @param doc_uuid
 */
jsHelper_paragonCmm.prototype.popupBatchFileDownload = function (taskMasUid, mrgeHistUid, histSeqNo, typeCode, systemTypeCode)
{
	var url = "/ServletController";
	url += "?AIR_ACTION=SYS_ATCH";
	url += "&AIR_MODE=FILE_BATCH_DOWNLOAD";
	url += "&taskMasUid="+ taskMasUid;
	url += "&mrgeHistUid="+ mrgeHistUid;
	url += "&histSeqNo="+ histSeqNo;
	url += "&typeCode="+ typeCode;
	url += "&systemTypeCode="+ systemTypeCode;

	this.openWindow(url, '1024', '500', '', 'no', 'no');
};


/**
 * 첨부파일 이력 팝업
 * @param uuid
 */
jsHelper_paragonCmm.prototype.popupAttachFileHistory = function (uid)
{
	var url = "/ServletController";
	url += "?AIR_ACTION=SYS_LOG_ACC";
	url += "&AIR_MODE=POPUP_HISTORY_LIST";
	url += "&atchFileUid="+ uid;

	this.openWindow(url, '1024', '600', 'popupAttachFileHistory', 'yes', 'no');
};


/**
 * 첨부문서 선택 팝업
 * @param callbackFunction 업로드 완료시 호출할 함수
 * @param masterDocId 문서 아이디
 * @param systemTypeCode 시스템 유형 코드
 * @param typeCode 유형 코드
 * @param filterSystemTypeCodes 시스템 유형 코드 필터값
 * @param filterTypeCodes 유형 코드 필터값
 */
jsHelper_paragonCmm.prototype.popupAttachDocSelect = function (callbackFunction, masterDocId, systemTypeCode, typeCode, filterSystemTypeCodes, filterTypeCodes)
{
	var url = "/ServletController?AIR_ACTION=SYS_ATCH&AIR_MODE=POPUP_DOC_SELECT";
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!
	url += "&masterDocId="+ masterDocId;
	url += "&systemTypeCode="+ systemTypeCode;
	url += "&typeCode="+ typeCode;
	url += "&filterSystemTypeCodes="+ filterSystemTypeCodes;
	url += "&filterTypeCodes="+ filterTypeCodes;

	this.openWindow(url, '1024', '500', 'popupAttachDocSelect', "yes", "no");
};




/**
 * 일정 목록 팝업
 * @param schType 유형 검색 기본값
 * @param schFromDate 기간-시작일 기본값
 * @param schToDate 기간-종료일 기본값
 */
jsHelper_paragonCmm.prototype.popupScdlList = function (schType, schFromDate, schToDate)
{
	if (schType == undefined || schType == null) {
		schType = "";
	}

	if (schFromDate == undefined || schFromDate == null) {
		schFromDate = "";
	}

	if (schToDate == undefined || schToDate == null) {
		schToDate = "";
	}

	var url = "/ServletController?AIR_ACTION=LMS_SCDL&AIR_MODE=LIST";
	url += "&schType="+ schType;
	url += "&schFromDate="+ schFromDate;
	url += "&schToDate="+ schToDate;

	this.openWindow(url, '1024', '500', 'popupScdlList', "yes", "yes");
};


/**
 * TEP 팝업창 오픈
 * @param docMasUid
 * @param solMasUid
 * @param docFlowUid
 */
jsHelper_paragonCmm.prototype.popupTepIndex = function (docMasUid, solMasUid, docFlowUid)
{
	if (solMasUid == undefined) solMasUid = "";
	if (docFlowUid == undefined) docFlowUid = "";

	var url = "/ServletController"
			+ "?AIR_ACTION=SYS_TEP"
			+ "&AIR_MODE=POPUP_INDEX"
			+ "&DOC_UID="+ docMasUid
			+ "&sol_mas_uid="+ solMasUid
			+ "&doc_flow_uid="+ docFlowUid;

	this.openWindow(url, "1024", "600", "TEP_"+ (solMasUid != "" ? solMasUid : docMasUid), "yes", "yes");
};


/**
 * 문서작성 팝업창 오픈
 * @param gwanriMasUid
 * @param solMasUid
 * @param uiroeNo
 * @param sysGbnCodeId
 */
jsHelper_paragonCmm.prototype.popupDocSelect = function (gwanriMasUid, solMasUid, uiroeNo, sysGbnCodeId)
{
	var url = "/ServletController"
			+ "?AIR_ACTION=SYS_DOC_MAS"
			+ "&AIR_MODE=POPUP_DOC_SELECT"
			+ "&gwanri_mas_uid="+ gwanriMasUid
			+ "&sol_mas_uid="+ solMasUid
			+ "&uiroe_no="+ uiroeNo
			+ "&munseo_bunryu_gbn_sys_cod_id="+ sysGbnCodeId;

	this.openWindow(url, "1024","600", "popupDocSelect", "yes", "yes");
};


/**
 * 결재선 지정[담당자] 팝업
 * @param signType
 * @param uidx
 */
jsHelper_paragonCmm.prototype.approvalSignAddButton_Click = function ( signType, uidx ) {
	var user_uuid_obj		= document.getElementsByName("_approvalSignUserUuid");
	var user_id_obj			= document.getElementsByName("_approvalSignUserId");
	var user_name_obj		= document.getElementsByName("_approvalSignUserName");
	var user_pos_code_obj	= document.getElementsByName("_approvalSignUserPosCode");
	var user_pos_name_obj	= document.getElementsByName("_approvalSignUserPosName");
	var grp_uuid_obj		= document.getElementsByName("_approvalSignGrpUuid");
	var grp_name_obj		= document.getElementsByName("_approvalSignGrpName");

	//-- 결재선 코드정보 문자열 셋팅!
	var user_codestr = "";
	for (var i = 0; i < user_uuid_obj.length; i++) {
		if (i != 0) user_codestr += "^";

		user_codestr += user_uuid_obj[i].value;
		user_codestr += "|";
		user_codestr += user_id_obj[i].value;
		user_codestr += "|";
		user_codestr += user_name_obj[i].value;
		user_codestr += "|";
		user_codestr += user_pos_code_obj[i].value;
		user_codestr += "|";
		user_codestr += user_pos_name_obj[i].value;
		user_codestr += "|";
		user_codestr += grp_uuid_obj[i].value;
		user_codestr += "|";
		user_codestr += grp_name_obj[i].value;
	}

	//-- 결재선 지정 팝업 호출!
	this.popupUserSignSelect("_approvalSignList_AddNode(\'" + uidx + "\', \'[IDX]\', \'[UUID]\', \'[LOGIN_ID]\', \'[NAME]\', \'[POSITION_CODE]\', \'[POSITION_NAME]\', \'[GROUP_UUID]\', \'[GROUP_NAME]\')", signType, user_codestr);
};


/**
 * URL 형식 체크
 * @param strUrl
 * @returns
 */
jsHelper_paragonCmm.prototype.validateUrl = function ( strUrl ){
	var expUrl = /^([a-z]+):\/\/((?:[a-z가-힣\d\-]{2,}\.)+[a-z]{2,})(:\d{1,5})?(\/[^\?]*)?(\?.+)?$/i;
	return expUrl.test(strUrl);
};


/**
 * Email 형식 체크
 * @param strEmail
 * @returns {Boolean}
 */
jsHelper_paragonCmm.prototype.validateEmail = function ( strEmail ){
	var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	if (filter.test(strEmail)) {
		return true;
	}else{
		return false;
	}
};


/**
 * 숫자를 원문자로 변환 (※ 15번까지만 지원!)
 * @param num
 * @returns {String}
 */
jsHelper_paragonCmm.prototype.getCircleChar = function (num) {
	var res = "";

	if (res != undefined && res != null) {
		switch (String(num))
		{
			case "1" : res = "①"; break;
			case "2" : res = "②"; break;
			case "3" : res = "③"; break;
			case "4" : res = "④"; break;
			case "5" : res = "⑤"; break;
			case "6" : res = "⑥"; break;
			case "7" : res = "⑦"; break;
			case "8" : res = "⑧"; break;
			case "9" : res = "⑨"; break;
			case "10" : res = "⑩"; break;
			case "11" : res = "⑪"; break;
			case "12" : res = "⑫"; break;
			case "13" : res = "⑬"; break;
			case "14" : res = "⑭"; break;
			case "15" : res = "⑮"; break;
		}
	}

	return res;
};


/**
 * UUID 생성
 * @param separ 구분자 [기본값:(없음)]
 * @param isUpperCase 대문자 변환여부 [기본값:true]
 * @returns
 */
jsHelper_paragonCmm.prototype.getRandomUUID = function (separ, isUpperCase) {
	function s4() {
		var array = new Uint32Array(10);
		if(navigator.sayswho.startsWith("IE")){
			window.msCrypto.getRandomValues(array);
		}else{
			window.crypto.getRandomValues(array);
		}
		var a = array[1];
		var result = Math.floor((1 + a) * 0x10000).toString(16).substring(1);
		return result.substring(1,5);
	}

	if (separ == undefined) separ = "";
	if (isUpperCase == undefined) isUpperCase = true;

	var res = s4() + s4() + separ + s4() + separ + s4() + separ + s4() + separ + s4() + s4() + s4();
	if (isUpperCase) res = res.toUpperCase();

	return res;
};


/**
 * 첨부파일 등록/상세보기 폼 HTML 로드
 * @param mode 모드 [WRITE:등록 폼, VIEW:상세보기 폼]
 * @param masterDocId 마스터 문서 아이디
 * @param systemTypeCode 시스템 코드
 * @param typeCode 첨부유형 코드
 * @param dataOptions 기타 옵션 ex> requiredYn:'Y',requiredHeaderText:'(테스트)'
 * @param callbackFunction 콜백 함수 ex> loadAttachFileHtml('[DATA]')
 */
jsHelper_paragonCmm.prototype.loadAttachFileHtml = function (mode, masterDocId, systemTypeCode, typeCode, dataOptions, callbackFunction) {
	var res = "";

	var sendData = "AIR_ACTION=SYS_ATCH"
				 + "&AIR_MODE=LOAD_FILE_"+ mode
				 + "&masterDocId="+ encodeURIComponent(masterDocId)
				 + "&systemTypeCode="+ encodeURIComponent(systemTypeCode)
				 + "&typeCode="+ encodeURIComponent(typeCode);

	if (dataOptions != "") {
		var options =  this.parseObjectLiteral(dataOptions);
		for(var key in options) {
			sendData += "&"+ key +"="+ encodeURIComponent(options[key]);
		}
	}

	var xmlHttp = this.getXmlHttpRequestFromUrl("/ServletController", sendData);
	if (xmlHttp != null) {
		res = xmlHttp.responseText;
	}

	return res;
};


/**
 * 주어진 문자열을 JSON 객체로 변환
 * @param s 문자열
 */
jsHelper_paragonCmm.prototype.parseJson = function (s) {
	var res = {};

	if (s){
		if (s.replace(/\n|\s/g, '').substring(0, 1) != '{'){
			s = '{' + s + '}';
		}

		res = $.parseJSON(s);
	}

	return res;
};

/**
 * 주어진 문자열을 객체 리터럴으로 변환
 * @param s 문자열
 */
jsHelper_paragonCmm.prototype.parseObjectLiteral = function (s) {
	var res = {};

	if (s){
		if (s.replace(/\n|\s/g, '').substring(0, 1) != '{'){
			s = '{' + s + '}';
		}

		res = (new Function("return "+ s))();
	}

	return res;
};

/**
 * (jQuery EasyUI) Refresh Selected Tabs Content
 * @param tabsId ID of tabs UI
 */
jsHelper_paragonCmm.prototype.refreshSelectedTabs = function (tabsId) {
	$("#"+ tabsId).tabs("getSelected").panel("refresh");
};

/**
 * (jQuery EasyUI 전용) Refresh Panel Content
 * @param panelId ID of panel UI
 */
jsHelper_paragonCmm.prototype.refreshPanel = function (panelId,url) {
	if(url == ""){
		$("#"+ panelId).panel('open').panel("refresh");
	}else{
		$("#"+ panelId).panel('open').panel("refresh",url);
	}
};



jsHelper_paragonCmm.prototype.doEditNoRevPageOpen = function (val_def_doc_main_uid, val_DOC_UID, val_sol_mas_uid) {
	window.open('/ServletController?AIR_ACTION=SYS_DOC_MAS&AIR_MODE=UPDATE_FORM_NOREV_EDIT&def_doc_main_uid='+val_def_doc_main_uid+'&DOC_UID='+val_DOC_UID+'&sol_mas_uid='+val_sol_mas_uid,'write_form','width=1024,height=700,left=50,top=20,status=0,scrollbars=yes');
};

jsHelper_paragonCmm.prototype.doEditRevPageOpen = function (val_def_doc_main_uid, val_DOC_UID, val_crnt_doc_flow_uid) {
	window.open('/ServletController?AIR_ACTION=SYS_DOC_MAS&AIR_MODE=UPDATE_FORM_REV_EDIT&def_doc_main_uid='+val_def_doc_main_uid+'&DOC_UID='+val_DOC_UID+'&crnt_doc_flow_uid='+val_crnt_doc_flow_uid,'write_form','width=1024,height=700,left=50,top=20,status=0,scrollbars=yes');
};

jsHelper_paragonCmm.prototype.doEditRevPageOpenFlowIngDocEditYn = function (val_def_doc_main_uid, val_DOC_UID, val_crnt_doc_flow_uid) {
	window.open('/ServletController?AIR_ACTION=SYS_DOC_MAS&AIR_MODE=UPDATE_FORM_REV_EDIT&def_doc_main_uid='+val_def_doc_main_uid+'&DOC_UID='+val_DOC_UID+'&crnt_doc_flow_uid='+val_crnt_doc_flow_uid+'&flow_ing_doc_edit_yn=Y','write_form','width=1024,height=700,left=50,top=20,status=0,scrollbars=yes');
};

jsHelper_paragonCmm.prototype.doDocSelect = function (code_id){
	window.open('/ServletController?AIR_ACTION=SYS_DOC_MAS&AIR_MODE=POPUP_DOC_SELECT&gwanri_mas_uid=<%=gwanri_mas_uid%>&sol_mas_uid=<%=sol_mas_uid%>&uiroe_no=<%=uiroe_no%>&munseo_bunryu_gbn_sys_cod_id='+code_id,'popup_pati_select','width=1024,height=700,left=50,top=20,status=0,scrollbars=yes');
};

jsHelper_paragonCmm.prototype.doOpenHistory = function (group_uid){
	window.open('/ServletController?AIR_ACTION=SYS_FORM&AIR_MODE=POPUP_VIEW_HISTORY&group_uid='+group_uid,'POPUP_VIEW_HISTORY','width=1024,height=700,left=50,resizable=yes,top=20,status=0,statustoolbar=no,location=no,scrollbars=yes');
};
jsHelper_paragonCmm.prototype.doGangjaeJinhangPageOpen = function (sol_mas_uid, DOC_UID, doc_flow_uid){
	window.open('/ServletController?AIR_ACTION=SYS_DOC_MAS&AIR_MODE=WRITE_FORM_GANGJAE&sol_mas_uid='+sol_mas_uid+'&DOC_UID='+DOC_UID+'&doc_flow_uid='+doc_flow_uid,'popup_doc_gangjae_view','width=1024,height=400,left=50,resizable=yes,top=20,status=0,statustoolbar=no,location=no,scrollbars=yes');
};

jsHelper_paragonCmm.prototype.showBackDrop = function() {
	$("#backdrop").remove();
	var t0 = $("<div/>").attr("class","fa-4x")
//		.append($("<div/>").text("Processing..."))
		.append($("<i />").attr("class", "fa fa-spinner fa-spin"));
	$("<div/>").attr("id","backdrop")
		.append(t0).appendTo("body");

//	<i class="fa fa-spinner"></i>

	$("#backdrop").show();
};
jsHelper_paragonCmm.prototype.hideBackDrop = function() {
	$("#backdrop").remove();
};
/**
 * 임시 땜빵코드..
 * 앞으론 이렇게 하지맙시다 -_-
 */
jsHelper_paragonCmm.prototype.gridResize = function () {
	var t0, i;
	for ( i in (t0 = {
		0:function gridResize() {
			setTimeout(function(){
				var w = $('.panel.datagrid').width(),
				t0 = w-12, t1 = w-2, t2 = w-28;
				$('.panel.datagrid .panel-header').css('width',t0 +'px');
				$('.panel.datagrid .panel-body').css('width', t1 + 'px');
				$('.panel.datagrid .datagrid-view').css('width', t1 + 'px');
				$('.datagrid-view2').css('width', t2 + 'px');
				$('.datagrid-header').css('width', t2 + 'px');
				$('.datagrid-body').css('width', t2 + 'px');
				$('.datagrid-footer').css('width',t2 + 'px');
			}, 100);
		},
		1: function tabsAndPanelsResize() {
			var t0, t1, t2;
			if (typeof (t0 = $(".easyui-tabs")).tabs === "function") t0.tabs('resize');
			if ((t1 = t0.find("iframe")).length === 0 ) return;

			t2 = $(t1.get(0).contentWindow.document).find(".easyui-tabs");
			// 팝업인경우 tabs 타겟을 현재 창에서 찾는다
			if ( t2.size() == 0 ) t2 = $('.easyui-tabs');
			t2.find("iframe").each(function(i,v){
				var el, t0;
				(el = $(v)).parent().css('width','');
				(t0 = $(el.get(0).contentWindow.document)).find('.panel-header').css('width','');
				t0.find('.easyui-panel').css('width','');
			});
			// 기본정보 스크롤 2개생기는문제 해결
			// $('#tepViewLayer').css('height','');
		}
	})) t0[i]();
};

jsHelper_paragonCmm.prototype.formToJson = function (selector) {
	var model = {};
	$.each($(selector).serializeArray(), function(k,v) { model[v.name] = v.value; });
	return model;
}

jsHelper_paragonCmm.prototype.setBatchText =	function (obj){

	var str = obj.value;
	str = str.replace(/'/g, "");
	str = str.replace(/"/g, "");
	str = str.replace(/ /g, "");
	str = str.replace(/\r/g, "");
	str = str.replace(/,/g, "','");  //Space를 ',' 로 변경함
	str = str.replace(/\n/g, "','"); //개행을  ','로 변경함

	if(str.substr(str.length-2) == ",'")
		str = "'" + str.substr(0,str.length-2);

	//첫행이 ' 가 아닐경우 '를 붙여준다.
	if(str != "" && str.charAt(0) != "'"){
		str = "'" + str;
	}

	//첫행이 ' 가 아닐경우 '를 붙여준다.
	if(str != "" && str.charAt(str.length-1) != "'"){
		str = str + "'";
	}

	if(str == ''){
		str = "";
	}

	//빈값은 삭제한다.
	str = str.replace(/,''/g, "");
	str = str.replace(/,','/g, "");

	obj.value = str;
};
/**
 * (jQuery EasyUI 전용) Refresh Panel Content
 * @param panelId ID of panel UI
 */
jsHelper_paragonCmm.prototype.setDefaultMsg = function (objGrid,pMsg) {

	var opts = ''+objGrid.datagrid('getColumnFields');
	var msg  = "검색 해주세요!";
	if(pMsg) msg = pMsg;

	if(opts){

		var cols     = (opts).split(',');
		var sidx     = 0;
		var colcnt   = 0;
		var isfirst  = true;

		$.each(cols,function(i){

			if(objGrid.datagrid('getColumnOption',cols[i]).hidden) return true; //continue;

			if(isfirst){
				sidx = i;
				isfirst = false;
			}

			colcnt++;
		});

		var params = [];
		params[cols[sidx]] = msg;

		//원본 Align
		var curalign = objGrid.datagrid('getColumnOption',cols[sidx]).align;
		objGrid.datagrid('getColumnOption',cols[sidx]).align = 'CENTER';

		objGrid.datagrid('appendRow',
			params
		).datagrid('mergeCells',{
			field   : cols[sidx],    //field 명
			index   : 0,             //row index
			colspan : colcnt
		});

		//align 을 원래 버젼으로 원상복귀한다.
		objGrid.datagrid('getColumnOption',cols[sidx]).align = curalign;
	}
};

//sDate, tDate (데이터형 yyyy-MM-dd) 사이에 해당하는 달을 년도월 로 반환함
//return "201401" 형식으로 배열 반환
jsHelper_paragonCmm.prototype.getYyyyMmFromPeriod = function (sDate, eDate) {

	var returnVal = new Array();

	var syy = parseInt(sDate.substr(0, 4), 10);
    var smm = parseInt(sDate.substr(5, 2), 10);
    var sdd = parseInt(sDate.substr(8)   , 10);

    var eyy = parseInt(eDate.substr(0, 4), 10);
    var emm = parseInt(eDate.substr(5, 2), 10);
    var edd = parseInt(eDate.substr(8)   , 10);

    var dateS = new Date(syy, smm-1, sdd);
    var dateE = new Date(eyy, emm-1, edd);

    //해당 함수를 사용하기 전에 선언되어야 함
    //date 형을 yyyymm으로 변환 함수
    var _parseYyyymm = function(d){

    	yy = d.getFullYear();
    	mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : '' + mm;
    	return yy+mm;
    }

    while(_parseYyyymm(dateE) >= _parseYyyymm(dateS)){

    	returnVal.push(_parseYyyymm(dateS));
    	dateS.setMonth(dateS.getMonth()+1); //한달증가
    	if(_parseYyyymm(dateS) >_parseYyyymm(dateE)) break;
    }

    //배열을 return 한다.
    return returnVal;
}

//sDate, tDate (데이터형 yyyy-MM-dd) 사이에 해당하는 년도를 반환함
//return "201401" 형식으로 배열 반환
jsHelper_paragonCmm.prototype.getYyyyFromPeriod = function (sDate, eDate) {

    var returnVal = new Array();

	var syy = parseInt(sDate.substr(0, 4), 10);
    var eyy = parseInt(eDate.substr(0, 4), 10);

    while(eyy >= syy){
    	returnVal.push(syy);
    	syy++;
    }

    //배열을 return 한다.
    return returnVal;
}

//초기 데이터를 표시하기 위해 설정함
//return 시작일 종료일 배열 반환;
jsHelper_paragonCmm.prototype.getDefaultPeriod = function(option) {

	var returnVal = new Array();

	//해당 함수를 사용하기 전에 선언되어야 함
    //date 형을 yyyymm으로 변환 함수
    var _parseYyyy_mm_dd = function(d){

    	yy = d.getFullYear();
    	mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : '' + mm;
    	dd = d.getDate();      dd = (dd < 10) ? '0' + dd : '' + dd;
    	return yy+'-'+mm+'-'+dd;
    }

    var dateS = new Date(); //오늘날짜
    var dateE = new Date(); //오늘날짜
    var dateA = new Date(); dateA.setMonth(8);  dateA.setDate(31);  //9월31일 //실적기준일짜 금년 9월 31일

	switch(option){
		case "THIS_MONTH":    //(해당달 1일 ~ 오늘)
			dateS.setDate(1); //해당달의 첫날로 셋팅함
			break;
		case "THIS_YEAR":
			dateS.setMonth(0);  dateS.setDate(1);  //1월1일
			//dateE.setMonth(11); dateE.setDate(31); //12월31일
			break;
		case "THIS_ACTUAL":
			if(_parseYyyy_mm_dd(dateS) > _parseYyyy_mm_dd(dateA)){
				//내년까지의 실적기간을 표시한다.
				dateS.setMonth(9);  dateS.setDate(1);                                        //올해 10월 1일
				//dateE.setYear(dateE.getFullYear()+1); dateE.setMonth(8);  dateE.setDate(30); //내년 9월 30일
			}else{
				//금년까지의 실적기간을 표시한다.
				dateS.setYear(dateS.getFullYear()-1); dateS.setMonth(9);  dateS.setDate(1); //전년 10월 1일
				//dateE.setMonth(8);  dateE.setDate(30);                                       //올해 9월 30일
			}
			break;
		default:
			//기본은 오늘 날짜를 보낸다.
			break;
	}

	returnVal.push(_parseYyyy_mm_dd(dateS)); //시작일
	returnVal.push(_parseYyyy_mm_dd(dateE)); //종료일

	//배열을 Return 한다.
	return returnVal;
}

//초기 데이터를 표시하기 위해 설정함
//return 시작일 종료일 배열 반환;
jsHelper_paragonCmm.prototype.getDayDiff = function(sDate, eDate) {

   var dateS = new Date(sDate.substring(0,4), sDate.substring(5,7), sDate.substring(8,10));
   var dateE = new Date(eDate.substring(0,4), eDate.substring(5,7), eDate.substring(8,10));
  //해당 함수를 사용하기 전에 선언되어야 함
  //date 형을 yyyymm으로 변환 함수
  var diffDays = function(dateS, dateE){
	  return (dateE-dateS)/(1000*60*60*24);
  }

  return diffDays(dateS, dateE);
}

//용도 : 그리드 Row Merge 작업 수행
//인자 :
//    ojbGird       - 그리드 객체 (예: $(#listGrid))
//    mergeColNames - 그리드 컬럼 ID를 컴마로 구분하여 입력
//    option        - 기본 CHAINNING : 컬럼의 순서대로 Row Merge됨, SINGLE : 단위 행 별로 Merge 됨
jsHelper_paragonCmm.prototype.gridMergeRow = function (objGrid,mergeColNames,option) {

	var colArr = mergeColNames.split(',');
	var colCnt = colArr.length; //합치기 컬럼 개수
	var rows   = objGrid.datagrid("getRows");
	var rowCnt = rows.length;  //전체 데이터 개수
	var _DEFAULT_VAL = "!@#$@#!^^$%1&%#*%&*(%6^#$%#$%^$#&2#^&&#$%^$@#4%@5#$@!$!!$";

	if(rowCnt <= 0) return;

	//Merge Data 구성
	var mergeColVal = new Array(); //merge를 할 값의 배열(컬럼명, index, rowspan)
	var rowIdxArr   = new Array(); //merge를 시작 할 Row Index 배열 (대상컬럼 개수)
	var rowspanArr  = new Array(); //merge를 시작 Index로 부터 몇개의 Row를 합칠지에 대한 RowSpan 배열
	var chgFlagArr  = new Array(); //현재 Row의 값과 다음Row의 값이 다르면 false 를 입력함

	//컬럼개수만큼  변수 초기화
	for(var i=0; i < colCnt; i++){
		rowIdxArr [colArr[i]] = 0;
		rowspanArr[colArr[i]] = 1;
		chgFlagArr[colArr[i]] = false;
	}

	//현재 Row의 다음 Row가 존재 하는지 체크
	var isNextRowExists = function(i){
		if(rowCnt > i+1){
			return true;
		}else{
			return false;
		}
	}

	for(var i=0; i < rowCnt; i++){

		//상위 컬림이 false인 경우 하위 Column도 false 셋팅 하기 위함
		var tempMergeFlag = true;

		for(var j=0; j < colCnt; j++){

			//현재 Value
			var currValue = rows[i][colArr[j]];
			var nextValue = (isNextRowExists(i))? rows[i+1][colArr[j]] : _DEFAULT_VAL;

			if(tempMergeFlag && currValue == nextValue){
				chgFlagArr[colArr[j]] = true;
				rowspanArr[colArr[j]]++;
				tempMergeFlag = true;
			}else{
				chgFlagArr[colArr[j]] = false;
				tempMergeFlag = (option == "SINGLE")? true : false;
			}
		}

		//상태에 따라 Merge Value를 구성한다.
		for(var j=0; j < colCnt; j++){

			//Merge할 컬럼이 있을 경우
			if(chgFlagArr[colArr[j]] == false){

				if(rowspanArr[colArr[j]] > 1){ //RowSpan이 1 이상인 경우
					mergeColVal.push(colArr[j]+"|"+rowIdxArr[colArr[j]]+"|"+rowspanArr[colArr[j]]);
				}

				//다음 Merge할 Row의 정보를 지정하기 위해 초기화 수행
				rowIdxArr [colArr[j]] = i+1;
				rowspanArr[colArr[j]] = 1;
			}
		}
	}

	//그리드에 Merge를 적용시킨다.
	for(var i=0; i < mergeColVal.length; i++){

		var mergeData = mergeColVal[i].split("|");
		objGrid.datagrid('mergeCells',{
			field   : mergeData[0],
			index   : mergeData[1],
			rowspan : mergeData[2]
		});
	}
}

/********************************* Windows Onload Event 추가 시작 *********************************/
//화면 로드시 처음 처리되는 이벤트
var onloadArray         = [];  // 일반 onload function array
var onloadPreArray      = []; // 먼저 실행되어야 할 function array
var onloadTailArray     = []; // 나중에 실행되어야 할 function array
var onloadTailLastArray = []; // 가장 나중에 실행되어야 할 function array

// onload 추가 : 일반적인 경우는 flag 를 명시하지 않음
// func : 추가될 function
// flag : preFirst  - 먼저 실행되어야 할 function 중에 가장 먼저 실행되어야할 function
//        first     - 먼저 실행되어야 할 function (first 내에서 순차적으로 추가됨)
//        tailFirst - 나중에 실행되어야 할 function 중에 가장 먼저 실행되어야 할 function
//        tail      - 나중에 실행되어야 할 function (tail 내에서 순차적으로 추가됨)
function addOnLoadEvent(func, flag) {
	if(flag == "preFirst")        onloadPreArray.unshift(func);
	else if(flag == "first")     onloadPreArray.push(func);
	else if(flag == "tailFirst") onloadTailArray.unshift(func);
	else if(flag == "tail")      onloadTailArray.push(func);
	else if(flag == "tailLast")  onloadTailLastArray.push(func);
	else onloadArray.push(func);
}

// window onload event 에서 실행되는 function
function windowOnload(){
	for(var i=0, size = onloadPreArray.length ; i < size ; i ++ ) {
		if(typeof onloadPreArray[i] == "function")
			onloadPreArray[i]();
	}
	for(var i=0, size = onloadArray.length ; i < size ; i ++ ) {
		if(typeof onloadArray[i] == "function")
			onloadArray[i]();
	}
	for(var i=0, size = onloadTailArray.length ; i < size ; i ++ ) {
		if(typeof onloadTailArray[i] == "function")
			onloadTailArray[i]();
	}
	for(var i=0, size = onloadTailLastArray.length ; i < size ; i ++ ) {
		if(typeof onloadTailLastArray[i] == "function")
			onloadTailLastArray[i]();
	}
}

//지원하는 브라우져 별 windowOnLoad 이벤트 등록
if(window.addEventListener) window.addEventListener("load", windowOnload, false);
else if(window.attachEvent) window.attachEvent("onload", windowOnload);
else window.onload=windowOnload;
/********************************* Windows Onload Event 추가   끝 *********************************/

function StringBuffer(string) {
	this.buffer = [];
	this.append = function(string) {
		this.buffer.push(string);
		return this;
	};
	this.toString = function toString() {
		return this.buffer.join("");
	};
	if(string != undefined)
		return this.append(string);
}

/************************************ Ajax Combo 설정 추가 시작 ************************************/
(function($){

	//Combo 구성용 전역 변수 설정
	var _AirComboFirstSearch = true; //최초 설정 여부 (Page Loading시 최초 한번 수행)
	var _AirComboCallBackFunction;

	var _AirComboIds   = new Array();
	var _AirComboInit  = new Array();

	var _AirComboMultiIds   = new Array();
	var _AirComboMultiValue = new Array();

    $.fn.airCombo = function(options) {

    	//Default 값 정의 방법
    	var settings = $.extend({
    		combo         : this,
    		query         : "",
            param         : "",
            add           : "",
            selected      : "",
            parent        : null,
            onLoadSuccess : ""
        }, options );

    	var vComboId = this.attr("id");

    	//입력받은 Option 으로 기본 값을 설정한다.
    	if(settings.parent != null){
    		//상위 콤보에 onChage Event를 등록한다.
    		settings.parent.change(function(){
    			//부모값 변경 시 하위 콤보를 재 조회 한다.
    			var objChild = $(new StringBuffer("#").append(vComboId).toString());

    			objChild.airComboBind({
    				combo         : objChild,
		    		query         : (this.value)? settings.query : "dummy",
		            param         : this.value,
		            add           : settings.add,
		            selected      : settings.selected,
		            parent        : this,
		            onLoadSuccess : settings.onLoadSuccess
    			});
    		});
    	}

    	_AirComboIds.push(vComboId);
    	_AirComboInit[vComboId] = false;

    	//조회 한다.
    	if(_AirComboFirstSearch && settings.parent != null){
    		//다중 콤보일 경우 부모가 조회 끝난 후 조회 해야 하므로 바로 조회 하지 않고
    		//별도의 리스트로 분리하여 부모의 조회가 끝난 후 조회를 실행한다.
    		_AirComboMultiIds.push(vComboId);
    		_AirComboMultiValue[vComboId] = settings;
    	}else{

    		this.airComboBind(settings);
    	}

        return this;
    };

    $.fn.airComboBind = function(params){

    	//Default 값 정의 방법
    	var settings = $.extend({
    		combo         : null,
    		query         : "",
            param         : "",
            add           : "",
            selected      : "",
            parent        : null,
            onLoadSuccess : ""
        }, params );

    	//조회 파라메터 구성
    	var vParam = new Array();
        vParam.push("AIR_ACTION="   + "CMM_COMBO");
        vParam.push("AIR_MODE="     + "JSON_LIST");
        vParam.push("ComboQuery="   + settings.query);
        vParam.push("ComboParam="   + settings.param);
        vParam.push("ComboAddText=" + settings.add);

        //AJAX 조회
    	$.ajax({
            url      : "/ServletController?" + vParam.join('&'),
            //async    : "false",
            dataType : "json",
            error    : function(){
            	_AirComboInit[settings.combo.attr("id")] = false;
                alert('Error!');
            },
            success  : function(jsonData){

                //Option Tag를 구성하여 Select HTML을 만든다.
            	settings.combo.html('');  //Option 전체 삭제

            	$.each(jsonData.rows,function(i){ //Option 추가
            		settings.combo.append("<option value='"+jsonData.rows[i].CODE+"'>"+jsonData.rows[i].NAME+"</option>");
        		});

            	//Default 값 셋팅함(최초에만 기본값을 세팅한다);
            	if(_AirComboFirstSearch && settings.selected){
            		settings.combo.val(settings.selected);
            	}

            	//성공 여부를 내부 CallBack 함수로 전달한다.
                airComboInitCallBack(settings.combo.attr("id"));
            }
        });
    }

    // 등록 된 모든 콤보의 초기화가 완료된 후 콤보
    function airComboInitCallBack(vComboId){

    	var isAllInitilized = false;

    	if(!_AirComboFirstSearch) return;

    	//해당 콤보는 검색 완료로 표시함
    	_AirComboInit[vComboId] = true;

    	//Multi콤보 대상리스트에 값이 있을 경우 부모의 조회가 끝났는지 확인하여 자신을 조회 한다.
    	$.each(_AirComboMultiIds, function(i){

    		//부모의 ID 조회
    		var settings = _AirComboMultiValue[_AirComboMultiIds[i]];
    		var comboId  = settings.combo.attr("id");
    		var parentId = settings.parent.attr("id");

    		//자신은 조회 되지 않았고 부모의 조회가 완료 됐으면
    		if(!_AirComboInit[comboId] && _AirComboInit[parentId]){

				settings.combo.airComboBind({
    				combo         : settings.combo,
		    		query         : (settings.parent.val()) ? settings.query : "dummy",
		            param         : settings.parent.val(),
		            add           : settings.add,
		            selected      : settings.selected,
		            parent        : settings.parent,
		            onLoadSuccess : settings.onLoadSuccess
    			});

				return false;
    		}
		});

    	//전체 콤보가 조회가 모두 끝났는지 체크함
    	$.each(_AirComboIds, function(i){
    		isAllInitilized = _AirComboInit[_AirComboIds[i]];

    		if(!isAllInitilized){
    			return false;
    		}
		});

    	//모든 콤보의 셋팅이 완료 되었으면 최종 CallBack 함수를 호출해 준다.
    	if(isAllInitilized && typeof _AirComboCallBackFunction == "function"){
    		_AirComboCallBackFunction();
    		_AirComboFirstSearch = false;
    	}
    }

    // 모든 콤보가 셋팅 완료 된 후 조회 시 해당 함수를 통해 콤보를 초기화 해야 함
    $.airComboInitialize = function(callBackFunction){

    	if(typeof callBackFunction == "function"){
    		_AirComboCallBackFunction = callBackFunction;
    	}
    }

}( jQuery ));
/************************************ Ajax Combo 설정 추가  끝 ************************************/

/************************************ Ajax Tree 설정 추가  시작 ************************************/
var treeProperties = {};
var treeInitSet = function(url, mode,depth, selectType){
	var arrDepth = [];
	if(typeof(depth) != "undefined") arrDepth = JSON.parse(depth);
	treeProperties.URL = url;
	treeProperties.Tmpl = "addTreeTmpl_"+mode;
	treeProperties.defaultDEPTH = arrDepth;
	treeProperties.nowDEPTH = 0;
	treeProperties.mode = mode;
	treeProperties.selectType = selectType;
	if(mode == "SKILL"){
		treeProperties.defaultLev = 4;
	}else if(mode == "DEPT"){
		treeProperties.defaultLev = 0;
	}else{
		treeProperties.defaultLev = 0;
	}
}
var treeAppend = function(id,data){
	$("#"+id).append($("#"+treeProperties.Tmpl).tmpl(data.data));
}
var treeDrawChild = function(id ,rootCodeId, jsonData){
	var json = {};
	if(jsonData){
		json = jsonData;
	}
	if(rootCodeId && rootCodeId != ""){
		json["parentCd"] = rootCodeId;
	}else{
		json["parentCd"] = "";
	}
    $.ajax({
    	url: treeProperties.URL
    	, type: "POST"
		, dataType: "json"
		, data: json

	})
	.done(function(data) {
		treeAppend(id,data);
		if(treeProperties.defaultDEPTH.length > 0 &&  treeProperties.defaultDEPTH.length >  treeProperties.nowDEPTH){
			nodeOpenClick(treeProperties.defaultDEPTH[treeProperties.nowDEPTH]);
			treeProperties.nowDEPTH = treeProperties.nowDEPTH+1;
		}else if(treeProperties.defaultDEPTH.length > 0 &&  treeProperties.defaultDEPTH.length ==  treeProperties.nowDEPTH){
			var deptCd = treeProperties.defaultDEPTH[treeProperties.defaultDEPTH.length-1];
			$("#treeArea").scrollTop(0);
			var offtop = ($("#"+id).position() !== undefined)? $("#"+id).position().top:0;
			$("#treeArea").scrollTop(offtop-150);
		}
    })
    .fail(function(jqXHR, textStatus, errorThrown) {
        alert("트리를 그리는 도중 에러가 발생 하였습니다.\n관리자에게 문의 하세요.\n"+errorThrown);
    });
}

var setPadding = function(lev){
	var left = (lev-treeProperties.defaultLev);
	if(left > 0){
		return 15;
	}else{
		return 0;
	}
}
var nodeOpenClick = function(id){
	id = (id == undefined || id == null ? "" : id);
	if(id != ""){
		var childNode = $("#"+id).children("div [data-id='div_"+id+"']");
		if(typeof($("#"+id).children("div [data-id='div_"+id+"']").css("display")) == 'undefined'){
			$("#img_"+id).attr("src","/img/ico/icon-down.png");
			treeDrawChild(id,id,treeProperties.searchPram);
		}else if($("#"+id).children("div [data-id='div_"+id+"']").css("display") == "block"){
			$("#img_"+id).attr("src","/img/ico/icon-right.png");
			childNode.hide();
		}else{
			$("#img_"+id).attr("src","/img/ico/icon-down.png");
			childNode.show();
		}
	}
}
/************************************ Ajax Tree 설정 추가  끝 ************************************/

/************************************ Ajax Call  		시작 ************************************/
/**
 * 공통 ajax call function
 */
jsHelper_paragonCmm.prototype.callAjax = function (url, data, callback, async, errorBack){

	async = (async == undefined || async == null ? false : async);
	$.ajax({
		url : url,
		async : async,
		type : "POST",
		data : JSON.stringify(data),
		dataType: "json",
	    contentType: "application/json"
	})
	.done(function( json ) {
		//-- 콜백함수 리턴
		callback(json);
	})
	.fail(function (jqXHR, textStatus, errorThrown) {
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
		var msg="처리에 실패 하였습니다.";
		msg += "\n관리자에게 문의 하세요.";
//		msg += "\nERROR CODE:"+errorThrown;
//		msg += "\nACTION CODE:"+airAction;
//		msg += "\nMODE CODE:"+airMode;
//		msg += "\nCALLBACK:"+callback;
//		msg += "\nDATA:"+data;

		alert(msg,function(){
			paragonCmm.hideBackDrop();

			if(errorBack){
				errorBack();
			}
		});


	});
}

/**
 * 공통 ajax submit function
 */
jsHelper_paragonCmm.prototype.submitAjax = function (url, data, callback, async, errorBack){

	async = (async == undefined || async == null ? false : async);

	if(paragonFile.delFileInfo.length > 0){	//-- 첨부는 없으면서 파일 삭제 꺼리가 있을 경우 삭제 처리후 후처리 진행.
		var fileUrl = "/paragon/file/File/beDelete/json";
		//	fileUrl += "&delAtchs="+ paragonFile.delFileInfo.join(",");
		//원래 위와 같았는데 아래와 같이 수정함
		var param = {
			 delAtchs: paragonFile.delFileInfo.join(",")
		};


		$.ajax({
			url : fileUrl,
			async : false,
			data : param,
			dataType : "json",
			type : "POST"
		})
		.done(function( json ) {
		})
		.fail(function (jqXHR, textStatus, errorThrown) {
			var msg="처리에 실패 하였습니다.";
			msg += "\n관리자에게 문의 하세요.";
			alert(msg,function(){
				paragonCmm.hideBackDrop();
				if(errorBack){
					errorBack();
				}
			});
		});
	}
	//-- 첨부할 파일이 있는지 체크
	if(!jQuery.isEmptyObject(paragonFile.arrFileInfo)){

		var ctrlUuids = $("input:hidden[name='_attachFileCtrlUuid']");
		var bool = true;
		//--파일 유형 갯수만큼 each
		$(ctrlUuids).each(function(i, o){
			if(!bool) return false;
			var formData = new FormData();
			var sol_mas_uid = ($("input:hidden[name='solMasUid']").val() != undefined) ? $("input:hidden[name='solMasUid']").val() : "";

			var fileUrl = "/paragon/file/File/saveProc/json";
			fileUrl += "?fileTpCd="+ paragonFile.fileInit[$(o).val()].fileTpCd;
			fileUrl += "&randomFileNameYn="+paragonFile.fileInit[$(o).val()].randomFileNameYn;
			fileUrl += "&overwriteYn="+paragonFile.fileInit[$(o).val()].overwriteYn;
			fileUrl += "&relUid="+paragonFile.fileInit[$(o).val()].relUid;
			fileUrl += "&sol_mas_uid="+ sol_mas_uid;

			var files = paragonFile.arrFileInfo[$(o).val()].files;
			console.log("files:"+$(files).length);
			if($(files).length == 0){	//-- 첨부된 파일이 없다면 break;
				return false;
			}
			$(files).each(function(i, o){
				formData.append('file',o);
			});

			var fileList = [];
			var lis   = $("li","div[class='file_Element_"+$(o).val()+"']");
			var infos = paragonFile.arrFileInfo[$(o).val()].infos;
			$(lis).each(function(i, li){
				var liID = $(li).attr("id");
				$(infos).each(function(j,o){
					if(liID == o.atchUid){
						fileList.push(o);
						return false;
					}
				});
			});

			fileUrl += "&fileInfos="+encodeURIComponent(JSON.stringify(fileList));

			$.ajax({
				url : fileUrl
				, enctype: 'multipart/form-data'
				, processData : false
				, contentType : false
				, async : false
				, type : "POST"
				, data : formData
			})
			.done(function( json ) {
			})
			.fail(function (jqXHR, textStatus, errorThrown) {
				bool = false;
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
				var msg="첨부파일 업로드에 실패 하였습니다.";
				msg += "\n관리자에게 문의 하세요.";
//				msg += "\nERROR CODE:"+errorThrown;
//				msg += "\nACTION CODE:"+airAction;
//				msg += "\nMODE CODE:"+airMode;
//				msg += "\nCALLBACK:"+callback;
//				msg += "\nDATA:"+data;

				alert(msg,function(){
					paragonCmm.hideBackDrop();

					if(errorBack){
						errorBack();
					}
				});

			});
		});
		if(bool){
			paragonCmm.callAjax(url, data, callback, async, function(){
				if(errorBack){
					errorBack();
				}
			});
		}
	}else{
		paragonCmm.callAjax(url, data, callback, async, function(){
			if(errorBack){
				errorBack();
			}
		});
	}
}

/************************************ Ajax Call		  끝 ************************************/

/**
 * 검색 쿼리 파라메터 반환
 */
jsHelper_paragonCmm.prototype.getSearchQueryParams = function (frm) {
	var arrObj = null;
	if( typeof(frm) != 'undefined' ){
		arrObj = $("[data-type='search']", $(frm));
	}else{
		arrObj = $("[data-type='search']", "form[name='form1']");
	}

	var jsondata = {"schFlag":"Y"};
	arrObj.each(function(){
		var tagNm = $(this).get(0).tagName;
		if("SELECT" == tagNm){
			var oNm = $(this).eq(0).attr("name");
			var oVal = $("select[name="+oNm+"] option:selected").val();
			if(oNm == undefined){
				oNm = $(this).eq(0).attr("id");
			}

			oVal = (function(obj){
							var arr = [];
							$(obj).find("option:selected").each(function(i, e){
								arr.push($(this).val());
							});
							return arr.join(",");
						  }
					)($(this))


			var jObj = "{\""+oNm+"\" : \""+oVal+"\" }";
			$.extend(jsondata, jQuery.parseJSON( jObj));
		}else{
			var oTyp = $(this).eq(0).attr("type");
			var oNm = $(this).eq(0).attr("name");
			var oCls = $(this).eq(0).attr("class");
			var obj ;
			var oVal = "";
			if(oTyp == "checkbox"){

				if( typeof(frm) != 'undefined' ){
					obj = $("input:checkbox[name='"+oNm+"']:checked", $(frm));
				}else{
					obj = $("input:checkbox[name='"+oNm+"']:checked", "form[name='form1']");
				}

			}else if(oTyp == "radio"){

				if( typeof(frm) != 'undefined' ){
					obj = $("input:radio[name='"+oNm+"']:checked", $(frm));
				}else{
					obj = $("input:radio[name='"+oNm+"']:checked", "form[name='form1']");
				}

			}else{

				if( typeof(frm) != 'undefined' ){
					obj = $("input[name='"+oNm+"']", $(frm));
				}else{
					obj = $("input[name='"+oNm+"']", "form[name='form1']");
				}

			}
			if(obj.length > 1){
				var imsi = [];
				$(obj).each(function(i, e){
					imsi.push($(e).val());
				});
				oVal = "{\""+oNm+"\" : "+JSON.stringify(imsi)+" }";
			}else{
				if("cost" == oCls){//비용값일때 콤마 제거 로직 추가 20180910 강세원

					oVal = "{\""+oNm+"\" : \""+obj.val().replaceAll(",","")+"\" }";
				}else{
					oVal = "{\""+oNm+"\" : \""+obj.val()+"\" }";

				}
			}
			$.extend(jsondata, jQuery.parseJSON( oVal));
		}
	});

	return jsondata;
}

//-- doc_mas_proc.jsp 에 있는 코딩 옮겨옴
//-- Ajax로 처리 될때를 대비하여 공통으로 뺌
jsHelper_paragonCmm.prototype.docWriteProc = function (dangyeGbnCodeId, jsonData){

	var url = "/ServletController?AIR_ACTION=SYS_DOC_MAS&AIR_MODE=VIEW"
		url +="&gwanri_mas_uid="+jsonData.GWANRI_MAS_UID
		url +="&sol_mas_uid="+jsonData.SOL_MAS_UID
		url +="&DOC_UID="+jsonData.DOC_UID
		url +="&doc_flow_uid="+jsonData.DOC_FLOW_UID
		url +="&dangye_gbn_code_id="+jsonData.DANGYE_GBN_CODE_ID;

//	console.log("Tab controll Start...");
	try{
		//부모창 tab 리로드
		opener.parent.tepTabs_change(dangyeGbnCodeId, url);
	}catch(e3){
//		console.log("opener.parent tab_change Fail...");
		try{
			//부모의 opener tab 리로드
			parent.opener.parent.tepTabs_change(dangyeGbnCodeId, url);
		}catch(e4){
//			console.log("parent.opener.parent tab_change Fail...");
			try{
				//부모의  tab 리로드
				parent.tepTabs_change(dangyeGbnCodeId, url);
			}catch(e4){
//				console.log("parent tab_change Fail...");
//				console.log("LIST controll Start...");
				try{
					//기본 opener 리스트 리로드
					opener.doSearch(opener.document.form1);
				}catch(e){
//					console.log("opener.doSearch Fail...");
					try{
						//parent 리스트 리로드
						parent.doSearch(parent.document.form1);
					}catch(e1){
//						console.log("parent.doSearch Fail...");
						try{
							//parent.opener 리스트 리로드
							parent.opener.doSearch(parent.opener.document.form1);
						}catch(e2){
							console.log(e2.message);
//							console.log("parent.opener.doSearch Fail...");

						}
					}
				}
			}
		}
	}
}

//string 객체에 replaceAll추가
String.prototype.replaceAll = function(o,r) {
	var _m = this;
	try {
		_m.html = _m.split(o).join(r);
		return _m.html;
	} catch(ex) {
		return this;
	}
};

String.prototype.startsWith = function(str) {
	if (this.length < str.length) { return false; }
	return this.indexOf(str) == 0;
}
String.prototype.endsWith = function(str) {
	if (this.length < str.length) { return false; }
	return this.lastIndexOf(str) + str.length == this.length;
}

/* Object의 키를 구하는 메서드 임(IE:8 대응 코드 ... 그 이상에서는 정상동작함.)
 * 심현삼과장 제공 2016.09.09
**/
if (!Object.keys) {
   Object.keys = function(o) {
      "use strict";
      //if (o != Object(o)) log.debug('Object.keys must call for object');
      var k = []
      var p;
      for (p in o) {
         if (Object.prototype.hasOwnProperty.call(o,p)) k.push(p);
      }
      return k;
   };
}

/**
 * SM 메인 호출
 */
jsHelper_paragonCmm.prototype.SM = function (val) {
	var url = "/ServletController?AIR_ACTION=SYS_SM&AIR_MODE=POPUP_MAIN&val="+val;
	this.openWindow(url, '1024', '700', 'POPUP_MAIN', "yes", "no");
}
/**
 * 문서 마스터 수정
 * @param DOC_UID
 * @param sol_mas_uid
 * @param apr_no
 * @param update_type
 */
jsHelper_paragonCmm.prototype.openDocUpdate = function (DOC_UID, sol_mas_uid, apr_no, update_type) {
	//-- 문서 수정모드로 열기
	//-- 팝업창에서 권한 체크 하므로 그냥 진행 하면 됨
		var url = "/ServletController";
		url += "?AIR_ACTION=SYS_FORM";
		url += "&AIR_MODE=POPUP_UPDATE_FORM";
		url += "&sol_mas_uid="+sol_mas_uid;
		url += "&DOC_UID="+DOC_UID;
		url += "&apr_no="+apr_no;
		url += "&update_type="+update_type;

		paragonCmm.openWindow(url, "1024", "650", "POPUP_UPDATE_FORM", "yes", "yes", "");
}
jsHelper_paragonCmm.prototype.openWindowPOST = function (url, width, height, name, scrollbars, resizable, etc ,param) {
  var left = 0;
  var top = 0;

  if (url == undefined || url == "") {
	  url = "about:blank";
  }

  if (String(width) == "100%") {
	  width = window.screen.availWidth-20;
  } else {
	  left = (window.screen.availWidth / 2) - (width / 2);
  }

  if (String(height) == "100%") {
	  height = window.screen.availHeight;
  } else {
	  top = (window.screen.availHeight / 2) - (height / 2);
  }

  if (name == undefined) {
      name = "";
  }

  if (scrollbars == "yes" || scrollbars == "1") {
      scrollbars = "yes";
  } else {
      scrollbars = "no";
  }

  if (resizable == "yes" || resizable == "1") {
      resizable = "yes";
  } else {
      resizable = "no";
  }

  if (etc == undefined) {
	  etc = "";
  } else {
	  etc = ","+ etc;
  }


  var a= window.open(encodeURI(url), name, "left=" + left + ",top=" + top + ",width=" + width + ",height=" + height + ",scrollbars=" + scrollbars + ",resizable=" + resizable + ",toolbar=no,location=no,directories=no,status=no,menubar=no"+ etc);


  var form = document.createElement("form");
  form.setAttribute("id", "postfrm");
  form.setAttribute("method", "post");
  form.setAttribute("target", name);
  form.setAttribute("action", url);
  document.body.appendChild(form);

  var inputHTML ="";
  if(param != "" ){
	  var paramArr = param.split("|");
	  for(var i=0; i < paramArr.length ; i++){
		  var tempArr = paramArr[i].split("=");
		  inputHTML += "<input type='hidden' name='"+tempArr[0] +"' value='"+tempArr[1]+"'>";
	  }
  }

  document.getElementById("postfrm").innerHTML = inputHTML;
  form.submit();

  document.body.removeChild( document.getElementById("postfrm"));
  $(a).focus();
};


/**
 * 20190809 류대웅
 *  드레그 앤 드랍
 *  tBodyId 테이블의 <tbody> 테그의 아이디
 *     - 테이블 아이디를 적으면 <thead> 부분까지 드레그앤 드롭 됨.(안되!!)
 */
jsHelper_paragonCmm.prototype.tableTrDragSet = function (tBodyId,dragstopFunc) {
    //여기부터 TDnD시작
    //참고 사이트  = https://isocra.com/2008/02/table-drag-and-drop-jquery-plugin
	var $tbody = "";
    if(typeof tBodyId === "string"){
    	$tbody = $("#"+tBodyId);
    }else if(typeof tBodyId === "object"){
    	$tbody = tBodyId;
    }else{
    	return false;
    }
    // Make a nice striped effect on the table
//     $("#tb tr:even').addClass('alt')"); 동적으로 만든 부분이라 에러가 나와서 동적 부분에 class 추가.
    $tbody.tableDnD({
        onDragClass: "myDragClass",
        onDragStop: function(table, row) {
        	if(typeof dragstopFunc === "function"){
        		dragstopFunc();
        	}
        },
        onDragStart: function(table, row) {
            $('#debugArea').html("Started dragging row "+row.id);
        }
    });
}


/**
 * 문서 열람(공통)
 * @param actionCode
 * @param modeCode
 * @param etcQStr
 */
jsHelper_paragonCmm.prototype.goPopupIndex = function (gbn, sol_mas_uid, gb_doc_mas_uid, apr_no) {

	var url = "";
	if("SS" == gbn){
		url = "/ServletController?AIR_ACTION=LMS_SU_MAS&AIR_MODE=POPUP_INDEX&sol_mas_uid="+ sol_mas_uid+"&gb_doc_mas_uid="+ gb_doc_mas_uid;

	}else if("GY" == gbn){
		url = "/ServletController?AIR_ACTION=LMS_GY_LIST_MAS&AIR_MODE=POPUP_INDEX&sol_mas_uid="+ sol_mas_uid;

	}else if("JM" == gbn){
		url = "/ServletController?AIR_ACTION=LMS_JM_LIST_MAS&AIR_MODE=POPUP_INDEX&sol_mas_uid="+ sol_mas_uid;

	}else if("BH" == gbn){
		url = "/ServletController?AIR_ACTION=LMS_BH_LIST_MAS&AIR_MODE=POPUP_INDEX&sol_mas_uid="+ sol_mas_uid;

	}else if("CP" == gbn){
		url = "/ServletController?AIR_ACTION=LMS_CP_LIST_MAS&AIR_MODE=POPUP_INDEX&sol_mas_uid="+ sol_mas_uid;

	}else if("IJ" == gbn){
		url = "/ServletController?AIR_ACTION=LMS_IJ_LIST_MAS&AIR_MODE=POPUP_INDEX&sol_mas_uid="+ sol_mas_uid;


	}else if("CL" == gbn){
		url = "/ServletController?AIR_ACTION=LMS_CL_LIST_MAS&AIR_MODE=POPUP_INDEX&sol_mas_uid="+ sol_mas_uid;

	}else if("APR" == gbn){
		url = "/ServletController?AIR_ACTION=SYS_APR_TEP&AIR_MODE=INDEX&sol_mas_uid="+ sol_mas_uid+"&apr_no="+ apr_no+"&view_doc_uid="+ gb_doc_mas_uid;

	}

	if( "" != url){
		paragonCmm.openWindow(url, "1024", "800", "POPUP_TEP_VIEW_"+sol_mas_uid, "yes", "yes", "");
	}
}

String.prototype.capitalize = function () {
	   return this.toLowerCase().replace(/(?:^|\s)[a-z]/g, function (m) {
		      return m.toUpperCase();
		   });
		};

/**
 * easyui  그리드 데이터 Filter
 */
jsHelper_paragonCmm.prototype.easyuiLoadFilter = function(json){
	var data = {};

	if(json.hasOwnProperty("data") && json.data.length > 0){
		data["total"] = json.data[0].totCnt;
		data["rows"] = json.data;
	}else if(json.hasOwnProperty("data") && json.data.length == 0) {
		data["total"] = 0;
		data["rows"] = [];
	}else if(json.hasOwnProperty("data") && json.data.hasOwnProperty("list")){
		data["total"] = json.data.totalCount.totCnt;
		data["rows"] = json.data.list;
	}else{
		data = json;
	}

    return data;
};

/**
 * easyui  콤보박스등 데이터 Filter
 * data.id = 아이디 컬럼명
 * data.txt = Label 컬럼명
 * data.initVal = 초기셋팅 값
 * data.initTxt = 초기셋팅 Label
 * return {{"id":"1","text":"첫번쨰"},{"id":"2","text":"두번쨰"}}
 */
jsHelper_paragonCmm.prototype.easyuiLoadFilterForData = function(json){
	var data = [];
	var id = (json.hasOwnProperty("id")) ? json.id : "";
	var txt = (json.hasOwnProperty("txt")) ? json.txt : "";
	var initVal = (json.hasOwnProperty("initVal")) ? json.initVal : "";
	var initTxt = (json.hasOwnProperty("initTxt")) ? json.initTxt : "";
	var selectVal = (json.hasOwnProperty("selectVal")) ? json.selectVal : "";

	if(json.hasOwnProperty("data") && json.data.length > 0){
		if(initTxt != null && initTxt != ""){
			data.push({"id":initVal , "text": initTxt});
		}
		$(json.data).each(function(i, v){
			var rtn = {};

			rtn["id"] = v[id];
			rtn["text"] = paragonCmm.getLang(v[txt]);
			if(selectVal != "" && selectVal == v[id]){
				rtn["selected"] = "true";
			}
			data.push(rtn);
		});
	}else if(json.hasOwnProperty("data") && json.data.length == 0){
		if(initTxt != null && initTxt != ""){
			data.push({"id":initVal , "text": initTxt});
		}
	}else{
		data = json;
	}
	return data;
};

window.old_alert = window.alert;
//-- alert 창 easyui Message 사용으로 Override
window.alert = function(message, callbackFn,fallback){
	if(fallback)
    {
		old_alert(message);
        return;
    }
	if(typeof message === "string"){
		if(message.startsWith("L.")
				||message.startsWith("B.")
				||message.startsWith("M.")
				||message.startsWith("C.")
		){

			message = paragonCmm.getLang(message);
		}
	}

	$.messager.alert("Info",message,"info",function(){
    	if(callbackFn){
    		callbackFn();
    	}
    });

    setTimeout(function(){
		$('body').children('div.messager-window').focus();
		$('.messager-button .l-btn').eq(0).focus();
	},300);
};

window.old_confirm = window.confirm;
//-- confirm 창 easyui Message 사용으로 Override
window.confirm = function(message,okButtonFnc,  fallback){
	if(fallback)
    {
        old_confirm(message);
        return;
    }

	$.messager.confirm(paragonCmm.getLang("L.확인"),message ,function(r){
		if(okButtonFnc){
			okButtonFnc(r);
		}
	});
	setTimeout(function(){
		$('body').children('div.messager-window').focus();
		$('.messager-button .l-btn').eq(0).focus();
	},300);

};

/**
 * jquery serialize 를 json 형태로 반환
 * 출처: https://cofs.tistory.com/184 [CofS]
 * @returns {*}
 */
jQuery.fn.serializeObject = function () {
	var result = {};
	var extend = function (i, element) {
		var node = result[element.name];
		if ('undefined' !== typeof node && node !== null) {
			if ($.isArray(node)) {
				node.push(element.value);
			} else {
				result[element.name] = [node, element.value];
			}
		} else {
			result[element.name] = element.value;
		}
	};

	$.each(this.serializeArray(), extend);
	return result;
};
var trim = function(val) {
	if (val==null || val=='undefined') return '';
	if (typeof val == 'number') {
		val = val + '';
	}
	if (typeof val == 'string') {
		val = val.replace(/(^\n*)/g,"");
		val = val.replace(/(^\r*)/g,"");
		val = val.replace(/(^\s*)|(\s*$)/g,"");
	}
	return val;
};
/**
 * jquery attr 셀렉터의 IE8 오동작 보완을 위한 필터
 * 특정 속성을 갖고 있는 객체 필터
 */
$.fn.hasAttr = function(attrNm, exValue) {
	var selector = '[' + attrNm + '][' + attrNm + '!=""]';
	if (trim(exValue) !== '') selector += '[' + attrNm + '!="' + exValue + '"]';
	return $(this).filter(selector);
}
//폼 데이터를 JSON 형태로
$.fn.serializeJSON = function(options) {
	var arrayData;
	var objectData = {};
	var tagName = $(this).prop('tagName');
	var opts = $.extend({
		filter:null,
		isList:false
	}, options||{});

	// 초기화
	$(this).find('[data-serialized][data-serialized!=""]').removeAttr('data-serialized');

	// list 형태에 대해 먼저 정리
	var incList = false;
	//if (opts.isList) {
		var tmpListData = {};
		$(this).find('table').hasAttr('data-list-key').each(function() {
			var key = $(this).attr('data-list-key');
			var listData = [];
			$(this).find('tbody > tr').each(function() {
				var rowData = $(this).serializeObject(opts);
				listData.push(rowData);
			});
			tmpListData[key] = listData;
			objectData[key] = listData;
		});
	//}
	if (Object.keys(tmpListData)>0) {
		incList = true;
	}

	var $obj = $(this).find('input,select,textarea').filter('[id][id!=""],[name][name!=""]').filter('[data-serialized!="Y"]');
	if (opts.filter) $obj = $obj.filter(opts.filter);
	$obj.each(function() {
		var nm = trim($(this).attr('name'));
		var id = trim($(this).attr('id'));
		var val = trim($(this).val());
		if (val === '' && $(this).prop('type') === 'textarea') val = trim($(this).text());
		var ty = $(this).attr('type');
		var chk = true;
		if (nm == '') nm = id;
		if (ty == 'radio' || ty == 'checkbox') {
			chk = $(this).prop('checked');
		}

		if (nm!='' && chk) {
			var chkRe = /[a-zA-Z0-9_]+\[[0-9]*\]\./;
			nm = nm.replaceAll(chkRe, '');

			if (objectData[nm] != null) {
				if (!objectData[nm].push)
					objectData[nm] = [objectData[nm]];
				objectData[nm].push(val);
				// 테이블이나 list 형태일 경우 리스트 데이터 확인
				if (incList) {
					//var $table = $('table').has(this).hasAttr('data-list-key').last();
				}
			} else {
				objectData[nm] = val;
			}
		}
		// 확인한놈에 대해 표시
		$(this).attr('data-serialized','Y');
	});
	//}
	return objectData;
};

//폼 데이터를 JSON 형태로
$.fn.tableDataToJson = function(id) {

	var tagName = $(this).prop('tagName');
	var tbody, tr;
	if("TABLE" == tagName){
		tbody = $(this).find("TBODY");
	}else if("TR" == tagName){
		tbody = $(this).parent("TBODY");
	}else if("TD" == tagName){
		tbody = $(this).parent("TBODY");
	}else if("TBODY" == tagName){
		tbody = $(this);
	}
	tr =  $(tbody).children("TR");
	var arrTr = [];
	$(tr).each(function(i, o){
		arrTr.push($(o).serializeJSON())
	});
	return arrTr;
}
/**
 * 다국어 변환 작업
 *   - parentObj : 부모 오브젝트(해당 영역만 영역만 변경이 필요 할때.
 */
jsHelper_paragonCmm.prototype.convertLang = function(parentObj){
	parentObj = ((parentObj == undefined || parentObj == "") ? "" : parentObj);

	var target;
	if(parentObj != ""){
		target = $("[data-term]" ,$(parentObj));
	}else{
		target = $("[data-term]");
	}

	target.each(function(i, e){
		var $span = $("<span class='langSpan'>");

		if($(e).prop('tagName') == "IMG"){
			$(e).attr("title",paragonCmm.getLang($(e).data("term")));
		}else if($(e).prop('tagName') == "LABEL"){
			$(e).attr("title",paragonCmm.getLang($(e).data("term")));
			$(e).find(".langSpan").remove();
			$(e).append($span.append(paragonCmm.getLang($(e).data("term"))));
		}else if($(e).prop('tagName') == "A"){
			$(e).html("");
			$(e).append(paragonCmm.getLang($(e).data("term")));
		}else if($(e).prop('tagName') == "DIV"){
			$(e).attr("title",paragonCmm.getLang($(e).data("term")));
		}else if($(e).prop('tagName') == "INPUT"){
			if($(e).attr('type') == "button"){
				$(e).val(paragonCmm.getLang($(e).data("term")));
			}else if($(e).attr('type') == "text"){
				if( $(e).attr('placeholder') != undefined && $(e).attr('placeholder') != ""){
					$(e).attr('placeholder', paragonCmm.getLang($(e).data("term")));
				}else{
					$(e).val(paragonCmm.getLang($(e).data("term")));
				}
			}
		}else{
			$(e).find(".langSpan").remove();
			$(e).append($span.append(paragonCmm.getLang($(e).data("term"))));
		}
	});

	this.updateLangMas();
}
jsHelper_paragonCmm.prototype.updateLangMas = function(){
	if($(noLangMas).length > 0){
		var final_data = [];
		$.each(noLangMas,function(i,value){
		    if(final_data.indexOf(value) == -1 ) final_data.push(value);
		});

		paragonCmm.callAjax("/viself/mlang/mLangUpdate/deleteNoLang/json",{}, function(){
		});
		$(final_data).each(function(i, d){
			var data = {};
			data.noLang = d;
			data.uuid = paragonCmm.getRandomUUID();
			paragonCmm.callAjax("/viself/mlang/mLangUpdate/notYetInsert/json",data, function(){
			});
		});

		paragonCmm.callAjax("/viself/mlang/mLangUpdate/notYetSelectInsert/json",{}, function(){
		});

//		console.log(final_data);
	}
}
$(function(){
	paragonCmm.convertLang();
})
