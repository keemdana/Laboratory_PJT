/**
 * air-IPS 자바스크립트 도우미 객체
 * @returns {jsHelper_paragonIps}
 */
function jsHelper_paragonIps() {}

/**
 * air-IPS 자바스크립트 도우미 인스턴스
 */
var paragonIps = new jsHelper_paragonIps();


/**
 * 변호사 선택 팝업
 * @param callbackFunction 선택시 호출할 함수
 */
jsHelper_paragonIps.prototype.popupByeonhosaSelect = function (callbackFunction)
{
	var url = "/ServletController?AIR_ACTION=SYS_USER&AIR_MODE=POPUP_USER_SELECT";
	url += "&callbackFunction="+ escape(callbackFunction); //XSS필터링 통과를 위해 escape 적용!
	url += "&companyClsCodes=TS";

	paragonCmm.openWindow(url, '800', '400', 'popupUserSelect', "yes", "no");
};

jsHelper_paragonIps.prototype.popupInsertOuUserForm = function (uuid)
{
	var url = "/ServletController?AIR_ACTION=SYS_USER&AIR_MODE=POPUP_USER_SELECT";
	if(uuid){
		url += "&uuid="+uuid;
	}

	paragonCmm.openWindow(url, '800', '500', '', "yes", "no");
};

/**
 * 외부발명자 마스터 다중 선택 팝업
 * @param callbackFunction 선택시 호출할 함수
 */
jsHelper_paragonIps.prototype.popupUserExtSelect = function (callback)
{
	//groupTypeCodes : IG:내부인만 , OG:외부인만, OR:내부+외부발명자만
	var url = "/ServletController?AIR_ACTION=SYS_USER_EXT&AIR_MODE=POPUP_USER_SELECT_EXT";
	url += "&callbackFunction="+ escape(callback); //XSS필터링 통과를 위해 escape 적용!

	paragonCmm.openWindow(url, '800', '600', 'popupUserSelects', "yes", "no");
};

/*
 * 출원인추가 팝업창 호출
 */
jsHelper_paragonIps.prototype.popupInsertCwiForm = function ()
{
	var url = "/ServletController?AIR_ACTION=CORP_MANAGE&AIR_MODE=POPUP_CWI_ADD_FORM";

	paragonCmm.openWindow(url, '800', '400', '', "yes", "no");
};


/*
 * 평가항목 미리보기
 */
jsHelper_paragonIps.prototype.popupPgPreview = function (revNo,pgType)
{
	var url = "/ServletController?AIR_ACTION=IPS_PYEONGGA_ITEM_MNG&AIR_MODE=PYEONGGA_HISTORY_PREVIEW";
	url += "&REVNO="+revNo;
	url += "&PGTYPE="+pgType;

	paragonCmm.openWindow(url, '1000', '750', 'preview', "yes", "no");
};


/**
 * 특허사무소 유저 상세보기
 */
jsHelper_paragonIps.prototype.popupCompanyUserDetail = function (uuid, company_uuid, company_code)
{
	var url = "/ServletController?AIR_ACTION=CMM_AGENT&AIR_MODE=POPUP_WRITE_FORM";
	url += "&uuid=" + uuid;
	url += "&company_uuid=" + company_uuid;
	url += "&company_code=" + company_code;

	paragonCmm.openWindow(url, '800', '750', 'User Detail', "yes", "no");
};

/**
 * TEP 팝업창 오픈
 * @param docMasUid
 * @param solMasUid
 * @param docFlowUid
 */
jsHelper_paragonIps.prototype.popupTepIndex = function (docMasUid, solMasUid, docFlowUid)
{
	if (solMasUid == undefined) solMasUid = "";
	if (docFlowUid == undefined) docFlowUid = "";

	var url = "/ServletController"
			+ "?AIR_ACTION=IPS_IP_TEP"
			+ "&AIR_MODE=POPUP_INDEX"
			+ "&doc_mas_uid="+ docMasUid
			+ "&sol_mas_uid="+ solMasUid
			+ "&doc_flow_uid="+ docFlowUid;

	paragonCmm.openWindow(url, "1200", "790", "TEP_"+ (solMasUid != "" ? solMasUid : docMasUid), "yes", "yes");
};


/**
 * 기술군TEP 팝업창 오픈
 * @param docMasUid
 * @param solMasUid
 * @param docFlowUid
 */
jsHelper_paragonIps.prototype.popupSkillGroupTepIndex = function (uuid)
{

	var url = "/ServletController"
			+ "?AIR_ACTION=IPS_SKILL_GROUP_TEP"
			+ "&AIR_MODE=POPUP_INDEX"
			+ "&uuid="+ uuid
			;

	paragonCmm.openWindow(url, "1200", "740", "TEP_SKILL", "yes", "yes");
};


/**
 * 필드검색 팝업창 오픈
// * @param docMasUid
 * @param solMasUid
 * @param docFlowUid
 */
jsHelper_paragonIps.prototype.popupFieldView = function (docMasUid, solMasUid, docFlowUid)
{
	if (solMasUid == undefined) solMasUid = "";
	if (docFlowUid == undefined) docFlowUid = "";

	var url = "/ServletController"
			+ "?AIR_ACTION=IPS_FIELD_SEARCH"
			+ "&AIR_MODE=VIEW"
			+ "&doc_mas_uid="+ docMasUid
			+ "&sol_mas_uid="+ solMasUid
			+ "&doc_flow_uid="+ docFlowUid;

	paragonCmm.openWindow(url, "1000", "600", "TEP_"+ (solMasUid != "" ? solMasUid : docMasUid), "yes", "yes");
};

/**
 * 관리번호에 의한 팝업창 오픈
 */
jsHelper_paragonIps.prototype.popupGwanriTepIndex = function (gwanri_no,docMasUid, solMasUid, docFlowUid)
{
	if (gwanri_no == undefined) gwanri_no = "";
	if (solMasUid == undefined) solMasUid = "";
	if (docFlowUid == undefined) docFlowUid = "";

	var popUpNam = "TEP_"+ (solMasUid != "" ? solMasUid : gwanri_no.split("-").join(""));
	var url = "/ServletController"
			+ "?AIR_ACTION=IPS_IP_TEP"
			+ "&AIR_MODE=POPUP_INDEX"
			+ "&doc_mas_uid="+ docMasUid
			+ "&sol_mas_uid="+ solMasUid
			+ "&doc_flow_uid="+ docFlowUid
			+ "&gwanri_no="+ gwanri_no;

	paragonCmm.openWindow(url, "1200", "740", popUpNam , "yes", "yes");
};

/**
 * 평균점수에 의한 팝업창 오픈
 */
jsHelper_paragonIps.prototype.popupAvgTepIndex = function (sol_mas_uid,simuiUid)
{
	if (sol_mas_uid == undefined) sol_mas_uid = "";
	if (simuiUid == undefined) simuiUid = "";

	var popUpNam = "TEP_"+ (simuiUid != "" ? simuiUid : sol_mas_uid);
	var url = "/ServletController"
			+ "?AIR_ACTION=IPS_SIMUI"
			+ "&AIR_MODE=POPUP_AVG_INDEX"
			+ "&simui_uuid="+ simuiUid
			+ "&rel_sol_mas_uid="+ sol_mas_uid;

	paragonCmm.openWindow(url, "800", "500", popUpNam , "yes", "yes");
};


/**
 * 문서작성 팝업창 오픈
 * @param gwanriMasUid
 * @param solMasUid
 * @param uiroeNo
 * @param sysGbnCodeId
 */
jsHelper_paragonIps.prototype.popupDocSelect = function (gwanriMasUid, solMasUid, uiroeNo, sysGbnCodeId,sysCodeId)
{
	var url = "/ServletController"
			+ "?AIR_ACTION=IPS_DOC_MAS"
			+ "&AIR_MODE=POPUP_DOC_SELECT"
			+ "&gwanri_mas_uid="+ gwanriMasUid
			+ "&sol_mas_uid="+ solMasUid
			+ "&uiroe_no="+ uiroeNo
			+ "&munseo_bunryu_gbn_sys_cod="+ sysCodeId
			+ "&munseo_bunryu_gbn_sys_cod_id="+ sysGbnCodeId;

	paragonCmm.openWindow(url, "1000","600", "popupDocSelect", "yes", "yes");
};

/**
 * 용도 : 	XML로 부터 각종 코드정보 문자열 받기
 * 인자 : 	arguments[0] - 모드 코드
 *		    arguments[1] - 코드정보문자열 기본값
 *			arguments[2] - 코드정보문자열 그룹 구분자
 *   		arguments[3~] - 파라메타
 * 메모 : 	※ 한글이 사용되는 값에는 escape 처리하여 보내고 unescape 로 받음!
 */
jsHelper_paragonIps.prototype.getCodeStrFromXML = function (modeCode, defaultCodestr, groupSeparator)
{
	defaultCodestr = (defaultCodestr == undefined || defaultCodestr == null ? "" : defaultCodestr);
	groupSeparator = (groupSeparator == undefined || groupSeparator == null || groupSeparator == "" ? "^" : groupSeparator);

	var v_url 		= "/ServletController";
	var v_qstr 		= "AIR_ACTION=IPS_XML&AIR_MODE="+ modeCode;
	var v_res 		= defaultCodestr;
	var v_separ		= groupSeparator;

	//console.log("modeCode is "+ modeCode);
	//console.log("arguments[3] is "+ arguments[3]);
	//console.log("arguments[4] is "+ arguments[4]);
	//console.log("arguments[5] is "+ arguments[5]);
	//console.log("arguments[6] is "+ arguments[6]);

	// 모드 코드 인자값에 따라 작업이 결정됨
	switch (modeCode) {



		case "DUP_CHECK_INVOICE_NO" :
			//-- Invoice no 중복체크
			v_qstr += "&S_FIRM_CODE="  		+ arguments[3];
			v_qstr += "&INV_NO="  			+ arguments[4];
			break;

		case "GET_LAMS_CHILD_BIYONG_CODE" :
			//-- 주어진 상위 코드 아이디에 해당되는 정보 반환
			v_qstr += "&CODE=" + arguments[3];
			break;

		case "GET_LAMS_CHILD_BIYONG_CODE2" :
			//-- 주어진 상위 코드 아이디에 해당되는 정보 반환
			v_qstr += "&COST_GRAND=" + arguments[3];
			v_qstr += "&COST_MID="   + arguments[4];
			break;

		case "GET_INVOICE_INFO_BY_LG_REF" :
			//-- 주어진 상위 코드 아이디에 해당되는 정보 반환
			v_qstr += "&LG_REF=" + arguments[3];
			break;

		case "GET_IP_INFO_BY_REF_NO" :
			//-- 검색번호에 대한 IP정보 반환
			v_qstr += "&REF_NO=" + arguments[3];
			v_qstr += "&IN_OUT_GBN=" + arguments[4];
			break;

		case "GET_HAEOE_DAERI_TONGHWA_INFO" :
			//-- 검색번호에 대한 IP정보 반환
			v_qstr += "&DAERI_COD2=" + arguments[3];
			break;

		case "CALC_BY_DATABASE" :
			//-- 주어진 상위 코드 아이디에 해당되는 정보 반환
			v_qstr += "&FORMULA=" + arguments[3];
			break;

		case "GET_HWANYUL_DATE_EXIST_YN" :
			//-- 주어진 상위 코드 아이디에 해당되는 정보 반환
			v_qstr += "&HWANYUL_DATE=" + arguments[3];
			v_qstr += "&SAVE_PARAM=" + arguments[4];
			v_qstr += "&FROM=" + arguments[5];
			break;

		case "BIYONG_IF" :
			//-- 기본결재선 가져오기
			v_qstr += "&MUGEUM_UID="  		+ arguments[3];

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
 * 사용자 메뉴얼 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupUserManualDownload = function () {
	paragonCmm.popupFormDownload("seosig", "발명신고서_양식.hwp");
};

/**
 * 담당자 메뉴얼 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupChargeManualDownload = function () {
	paragonCmm.popupFormDownload("manual", "kips_charge_manual.pdf");
};

/**
 * 특허사무소 메뉴얼 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupAgencyManualDownload = function () {
	paragonCmm.popupFormDownload("manual", "kips_agency_manual.pdf");
};

/**
 * 경쟁사특허 엑셀 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupIPExcelDownload = function () {
	paragonCmm.popupFormDownload("excel", "ip_upload_sample.xlsx");
};

/**
 * 특허유 엑셀 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupDBExcelDownload = function () {
	paragonCmm.popupFormDownload("excel", "upload_sample.xlsx");
};

/**
 * 양도증 서식 다운로드
 */
jsHelper_paragonIps.prototype.popupYangDoDownload = function () {
	paragonCmm.popupFormDownload("seosig", "양도증_서식.ppt");
};

/**
 * 외부발명자 서약서 서식 다운로드
 */
jsHelper_paragonIps.prototype.popupSeoYagDownload = function () {
	paragonCmm.popupFormDownload("seosig", "개인정보동의서_외부발명자.docx");
};

/**
 * 연차유지 평가정보 서식 다운로드
 */
jsHelper_paragonIps.prototype.popupRgtYnDownload = function () {
	paragonCmm.popupFormDownload("seosig", "평가정보upload.xlsx");
};
/**
 * 전담사무소 팝업(비용)
 */
jsHelper_paragonIps.prototype.popupBosuDownload = function () {
	paragonCmm.popupFormDownload("seosig", "비전담특허사무소_보수기준액.pdf");
};

/**
 * 기술이전내용 서식 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupTTPlanDownload = function () {
	paragonCmm.popupFormDownload("seosig", "기술이전내용.hwp");
};

/**
 * 기술이전 업체 신청서 서식 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupTTComDownload = function () {
	paragonCmm.popupFormDownload("seosig", "기술이전신청서.hwp");
};

/**
 * 기술이전 인센티브 신청 서식 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupTTIncenReqDownload = function () {
	paragonCmm.popupFormDownload("seosig", "인신티브_신청서.hwp");
};
/**
 * 기술이전 지분변경 동의서 서식 다운로드 팝업 오픈
 */
jsHelper_paragonIps.prototype.popupTTConsentDownload = function () {
	paragonCmm.popupFormDownload("seosig", "지분변경_동의서.hwp");
};

/**
 * 2017.09.07 강세원 추가
 * 마크프로 엑셀서식 다운로드
 */
jsHelper_paragonIps.prototype.popupMarkproSampleDownload = function () {
	paragonCmm.popupFormDownload("markpro", "markpro_sample.xlsx");
};


/**
 * URL로 부터 XmlHttpRequest 객체 가져오기 (동기식)
 * @param url
 * @param queryString
 * @returns
 */
jsHelper_paragonIps.prototype.getXmlHttpRequestFromUrl = function (url, queryString)
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
 * 패밀리도식화 팝업창 오픈
 * @param solMasUid
 * @param ipMasUid
 */
jsHelper_paragonIps.prototype.popupFamilyDiagram = function (solMasUid, ipMasUid)
{
	var url = "/ServletController"
			+ "?AIR_ACTION=IPS_COMMON"
			+ "&AIR_MODE=POPUP_FAMILY_DIAGRAM"
			+ "&sol_mas_uid="+ solMasUid
			+ "&ip_mas_uid="+ ipMasUid;
	paragonCmm.openWindow(url, window.screen.width-400,window.screen.height-300, "popupFamilyDiagram", "yes", "yes");
};

/**
 * 기술군 패밀리도식화 팝업창 오픈
 * @param solMasUid
 * @param ipMasUid
 */
jsHelper_paragonIps.prototype.popupSkillGroupFamilyDiagram = function (group_uuid)
{
	var url = "/ServletController"
		+ "?AIR_ACTION=IPS_COMMON"
		+ "&AIR_MODE=POPUP_SKILL_GROUP_FAMILY_DIAGRAM"
		+ "&group_uuid="+ group_uuid;

	paragonCmm.openWindow(url, window.screen.width-400,window.screen.height-300, "popupSkillFamilyDiagram", "yes", "yes");
};

/**
 * 키프리스 정보 보기
 * @param gwanriMasUid
 * @param solMasUid
 * @param uiroeNo
 * @param sysGbnCodeId
 */
jsHelper_paragonIps.prototype.popupKipris = function (appNo)
{
	var url = "http://kpat.kipris.or.kr/kpat/biblioa.do?method=biblioFrame&getType=BASE&applno=" + appNo;
	paragonCmm.openWindow(url, "1000","600", "popupKipris", "yes", "yes");
};

/**
 * 발명자 기여도 체크
 * @param obj
 */
jsHelper_paragonIps.prototype.limitGiyeodo = function(obj){
	if(obj.value == ""){return;}
	var intVal = parseInt(obj.value);
	if(intVal >= 0 && intVal < 101){
	}else{
		alert("0~100 사이의 값만 입력 가능합니다.")
		obj.value = "";
		return ;
	}
}
/**
 * 발명자 정보
 */
jsHelper_paragonIps.prototype.popupInventorInfo = function(solMasUid){
	var url = "/ServletController"
		+ "?AIR_ACTION=IPS_POPUP"
		+ "&AIR_MODE=POPUP_INVENTOR_INFO"
		+ "&sol_mas_uid="+ solMasUid ;
	paragonCmm.openWindow(url, "1000","600", "popupInventorInfo", "yes", "yes");
}

/**
 * 연차이관 업로드 팝업
 */
jsHelper_paragonIps.prototype.popupMarkproUpload = function (callbackFunction)
{

	var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_MARKPRO_UPLOAD_FORM";
    paragonCmm.openWindow(url ,"800","500", "POPUP_MARKPRO_UPLOAD_FORM",true,true);

};

/**
 * 연차이관 확정결과 업로드 팝업
 */
jsHelper_paragonIps.prototype.popupMarkproDecideUpload = function (callbackFunction)
{

	var rmGrp =  $("#checkRmGrp").val();

	var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_MARKPRO_DECIDE_UPLOAD_FORM&WRITE_MODE=WRITE&RM_GRP="+rmGrp;
    paragonCmm.openWindow(url ,"800","500", "POPUP_MARKPRO_DECIDE_UPLOAD_FORM",true,true);

};

/**
 * 출원인선택 팝업
 * @param callbackFunction
 * @param viewType
 * @param rootCodeId
 * @param groupTypeCodes
 * @param companyClsCodes
 */
jsHelper_paragonIps.prototype.popupCorpSelect = function (callbackFunction)
{

	var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_CORP_SELECT";

	var uuids = $('input:hidden[name=ips_pati_cwi_uuid]');
	var paramUuids = "";
	uuids.each(function(i,d){
		if( i > 0 ){
			paramUuids += ",";
		}
		paramUuids += $(this).val();
	});

	url += "&WHERE_UUIDS="+paramUuids;
    url += "&callbackFunction="+escape(callbackFunction);
//    url += "&multiSelect=Y&initcode="+initNat;
//    url += "&type="+type;
//    url += "&selectMode="+selectMode;
    paragonCmm.openWindow(url ,"650","650", "popup_corp_select",true,true);

};

/**
 * 국가 선택 팝업
 * @param initNat 기본 지정된 국가 코드(,)
 * @param callbackFunction
 * @param type			 FOR:한국 제외 국가 , 그외 값: 모든 국가
 * @param selectMode
 */
jsHelper_paragonIps.prototype.popupNationSelect = function (initNat,callbackFunction, type, selectMode, etc)
{
    var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_NATION_SELECT";
    url += "&multiSelect=Y&initcode="+initNat;
    url += "&callbackFunction="+escape(callbackFunction);
    url += "&type="+type;
    url += "&selectMode="+selectMode;
    if(etc){
		url += etc;
	}
    paragonCmm.openWindow(url,"650","600", "popup_nation_select",true,true);
}

/**
 * 지재권 선택 팝업
 * @param initNat 기본 지정된 국가 코드(,)
 * @param callbackFunction
 * @param type			 FOR:한국 제외 국가 , 그외 값: 모든 국가
 * @param selectMode
 */
jsHelper_paragonIps.prototype.popupPatentSelect = function (callbackFunction, initFunction, etc)
{

	var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_PATENT_SELECT";
	url += "&callbackFunction="+escape(callbackFunction);
	url += "&initFunction="+escape(initFunction);
	url += "&menuParamId=popup_patent_select";
	if(etc){
		url += etc;
	}


	paragonCmm.openWindow(url,"1280","750", "popup_patent_select",true,true);

}

/**
 * 원 기술이전 선택 팝업
 * @param initNat 기본 지정된 국가 코드(,)
 * @param callbackFunction
 * @param type			 FOR:한국 제외 국가 , 그외 값: 모든 국가
 * @param selectMode
 */
jsHelper_paragonIps.prototype.popupTechSelect = function (callbackFunction, etc)
{
	var url = "/ServletController?AIR_ACTION=IPS_COMMON&AIR_MODE=POPUP_TECH_SELECT";
	url += "&callbackFunction="+escape(callbackFunction);
	if(etc){
		url += etc
	}
	paragonCmm.openWindow(url,"1080","750", "popup_tech_select",true,true);
}


/**
 * 심의자 선택 팝업
 * @param initNat 기본 지정된 국가 코드(,)
 * @param callbackFunction
 * @param type			 FOR:한국 제외 국가 , 그외 값: 모든 국가
 * @param selectMode
 */
jsHelper_paragonIps.prototype.popupSimuiUserSelect = function (callbackFunction, initFunction)
{

	var url = "/ServletController?AIR_ACTION=IPS_SIMUI&AIR_MODE=POPUP_USER_GLIST";
	url += "&callbackFunction="+escape(callbackFunction);
	url += "&initFunction="+escape(initFunction);

	paragonCmm.openWindow(url,"800","620", "POPUP_SIMUI_END_FORM2",true,true);

}

/**
 * 관련건 선택 팝업(지재권/조사분석/심판)
 * @param callbackFunction
 * @param listGbn 구해오는 값 구분(I:지재권,J:조사분석,S:심판)
 */
jsHelper_paragonIps.prototype.popupRelPropertiesSelect = function (callbackFunction, listGbn, is_minus)
{

	var url = "/ServletController?AIR_ACTION=IPS_COMMON&AIR_MODE=POPUP_VARIOUS_DOC_SELECT";
	url += "&callbackFunction="+escape(callbackFunction);
	url += "&listGbn="+listGbn;
	url += "&is_minus="+is_minus;

	paragonCmm.openWindow(url,"1024","600", "popup_patent_select",true,true);

}



/**
 * 사무소 담당자 선택 팝업
 * @param callbackFunction
 */
jsHelper_paragonIps.prototype.popupDaeriInSelect = function (callbackFunction)
{

	var url = "/ServletController?AIR_ACTION=CMM_AGENT&AIR_MODE=POPUP_SAMUSO_SELECT";
	url += "&callbackFunction="+escape(callbackFunction);

	paragonCmm.openWindow(url,"1024","800", "popup_daeriIn_select",true,true);

}

/**
 * 관련연구과제 선택 팝업
 * @param callbackFunction
 */
jsHelper_paragonIps.prototype.popupProjectSelect = function (callbackFunction, etc)
{

	var uuids = "";//$('input:hidden[name=ips_pati_rel_prj_mas_uid]');
	var paramUuids = "";
	$(uuids).each(function(i,d){
		if( i > 0 ){
			paramUuids += ",";
		}
		paramUuids += $(this).val();
	});

	var url = "/ServletController?AIR_ACTION=IPS_COMMON&AIR_MODE=POPUP_PROJECT_SELECT";
	url += "&callbackFunction="+escape(callbackFunction);
	url += "&UUIDS="+paramUuids;
	if(etc){
		url += etc
	}
	paragonCmm.openWindow(url,"1080","750", "popup_poject_select",true,true);

}

/**
 * 관련연구과제 선택 팝업
 * @param callbackFunction
 */
jsHelper_paragonIps.prototype.popupSkillSelect = function (callbackFunction, rootCodeId)
{


	//2016.09.27 김형종 기존에 선택된 것은 팝업화면에서 다시 클릭시 선택금지==================>>
	var uuids;
	var paramCodes = "";

	if(rootCodeId == "IPS_6T_GBN"){

		uuids = $('input:hidden[name=IPS_6T_GBN_code_id]');

	}else if(rootCodeId == "IPS_SKILL_GBN"){

		uuids = $('input:hidden[name=IPS_SKILL_GBN_code_id]');

	}else if(rootCodeId == "IPS_INC_GBN"){

		uuids = $('input:hidden[name=IPS_INC_GBN_code_id]');

	}else{

	}
	if(uuids){
		uuids.each(function(i,d){

			if( i > 0 ){
				paramCodes += ",";
			}

			paramCodes += $(this).val();

		});
	}
	//==========================================================================<<

	var url = "/ServletController?AIR_ACTION=IPS_COMMON&AIR_MODE=POPUP_SKILL_SELECT";
	url += "&callbackFunction="+escape(callbackFunction);
	url += "&rootCodeId="+rootCodeId;
	url += "&codes="+paramCodes;

	paragonCmm.openWindow(url,"800","570", "popup_skill_select",true,true);

}
/**
 * CMS 거래 내역 팝업
 * @param callbackFunction
 */
jsHelper_paragonIps.prototype.popupCmsSelect = function (callbackFunction, uuid)
{


	var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_CMS_SELECT";
	url += "&callbackFunction="+escape(callbackFunction);
	url += "&uuid="+uuid;

	paragonCmm.openWindow(url,"800","600", "popup_cms_select",true,true);

}

/**
 * 전담사무소 팝업창
 * @param callbackFunction
 */
jsHelper_paragonIps.prototype.popupJeondamSelect = function ()
{

	var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_JEONDAM_INFO";

	paragonCmm.openWindow(url,"570","300", "popup",true,true);

}


/**
 * 출원국 선택 팝업
 */
//jsHelper_paragonIps.prototype.popupNationSelect = function (callbackFunction, multiSelect,initCode,selectMode  )
//{
//
//
//	var url = "/ServletController?AIR_ACTION=IPS_POPUP&AIR_MODE=POPUP_NATION_SELECT";
//	url += "&callbackFunction="+escape(callbackFunction);
//	url += "&multiSelect="+multiSelect;
//	url += "&initCode="+initCode;
//	url += "&selectMode="+selectMode;
//
//	paragonCmm.openWindow(url,"800","600", "popup_nation_select",true,true);
//
//}

/**
 * 업무연락 작성팝업
 */
jsHelper_paragonIps.prototype.popupWriteWorkCont = function (sol_mas_uid,doc_mas_uid)
{
	var url = "/ServletController?AIR_ACTION=IPS_WORK_CONT";
	url += "&AIR_MODE=POPUP_WRITE_FORM";
	url += "&sol_mas_uid="+sol_mas_uid;
	if(doc_mas_uid){
		url += "&doc_mas_uid="+doc_mas_uid;
	}

	paragonCmm.openWindow(url, 800, 580, 'popup_write_form', 'yes', 'yes');
};

/**
 * 업무연락 리스트 팝업
 */
jsHelper_paragonIps.prototype.popupListWorkCont = function (sol_mas_uid,doc_mas_uid)
{
	var url = "/ServletController?AIR_ACTION=IPS_WORK_CONT";
	url += "&AIR_MODE=POPUP_GLIST";
	url += "&sol_mas_uid="+sol_mas_uid;
	if(doc_mas_uid){
		url += "&doc_mas_uid="+doc_mas_uid;
	}
	paragonCmm.openWindow(url, 1280, 800, 'popup_work_list', 'yes', 'yes');
};



