/**
 * AIR 시스템 공용 자바스크립트 도우미 객체
 * @returns {jsHelper_htmlUtils}
 */
function jsHelper_htmlUtils () { }
// IE console.log polyfill
if ( !window.console ) window.console = { log:function() {} };

/**
 * AIR 시스템 공용 자바스크립트 도우미 인스턴스
 */
var htmlUtils = new jsHelper_htmlUtils();

/**
 * 날짜입력 From~To 컨트롤 보여주기
 */
jsHelper_htmlUtils.prototype.openDualCalendar = function (fromId, toId) {

	$(function() {
		if("KO" === paragonCmm.getSiteLocale()){
			$.datepicker.setDefaults( $.datepicker.regional[ 'ko' ] );
		}else{
			$.datepicker.setDefaults( $.datepicker.regional[ 'en' ] );
		}
		var dateFormat = "yy-mm-dd",
		 from = $( "#"+ fromId )
	        .datepicker({
	        	changeMonth: true
				, changeYear: true
				, defaultDate: "+1w"
				, showButtonPanel: true
				, numberOfMonths: 2
	        })
	        .on( "change", function() {
	        	to.datepicker( "option", "minDate", getDate( this ) );
	        }),
	        to = $( "#"+ toId ).datepicker({
	        	changeMonth: true
				, changeYear: true
				, defaultDate: "+1w"
				, showButtonPanel: true
	        	, numberOfMonths: 2
	        })
	        .on( "change", function() {
	        	from.datepicker( "option", "maxDate", getDate( this ) );
	        });

		 function getDate( element ) {
			 var date;
			 try {
				 date = $.datepicker.parseDate( dateFormat, element.value );
			 } catch( error ) {
				 date = null;
			 }

			 return date;
		 }

	});

//	document.getElementById(fromId).focus();
};

/***************************************************************************
 * 제목 : 선택상자 초기화 for JSON
 * 인자 : id - 선택상자 아이디
 *       name - 선택상자 이름(여러개일경우)
 *        data	   	- JSON 데이터[{},{},{}]
 *        initdata 	- 선택된 옵션 값(값이 여러 개일 경우 쉼표(,)로 구분 ex> val1, val2, ...)
 *        valNm 	- 값속성 컬럼명
 *        txtNm		- Text 속성 컬럼명
 ***************************************************************************/
jsHelper_htmlUtils.prototype.initializeSelectJson = function (id, name, data, initdata, valNm, txtNm) {

	// 옵션값 초기화
	id = (id == undefined || id == "" ? "" : id);
	name = (name == undefined || name == "" ? "" : name);
	initdata = (initdata == undefined ? "" : initdata);
	valNm = (valNm == undefined ? "cd" : valNm);
	txtNm = (txtNm == undefined ? "langCd" : txtNm);
	var target;
	if(id != ""){
		target = $("#"+id);
	}else if(name != ""){
		target = $("select[name='"+name+"']");
	}
	if(target != undefined){
		$(target).find("option").remove();
		$(target).each(function(k,o){
			if(initdata != ""){
				var initArr = initdata.split("|");
				var initOpt = $("<option>").val(initArr[0]).text(initArr[1]).data("cd","" );
				$(o).append(initOpt);
			}

			$(data).each(function(i, d){
				var opt = $("<option>");
				opt.val(d[valNm]);
				if(txtNm.toUpperCase().indexOf("LANGCD") > -1){
					opt.text( paragonCmm.getLang( d[txtNm] ));
				}else{
					opt.text( d[txtNm] );
				}
				opt.data("row",d);
				opt.data("abb",d.cdAbb);
				$(o).append(opt);
			});

		});
	}

};

/***************************************************************************
 * 제목 : 선택상자 리턴 HtmlUtil.java getSelect와 동일하게 동작
 * 인자 : name - 선택상자 이름(여러개일경우)
 *       id - 선택상자 아이디
 *       옵션 코드 str - 선택상자 구성용 문자열 ex> {value1}[separ1]{text1}[separ2]{value2}[separ1]{text2} ...
 *       기본데이터    - 선택된 옵션 값(값이 여러 개일 경우 쉼표(,)로 구분 ex> val1, val2, ...)
 ***************************************************************************/
jsHelper_htmlUtils.prototype.getSelect = function (name, id, codestr, initdata, etc, separ1, separ2, separ3) {
	var res = "";
	var arrCode, arrInit, arrTemp;
	var strSelected, strValue, strText, strTitle;

// 옵션값 초기화
	initdata = (initdata == undefined ? "" : initdata);
	etc = (etc == undefined ? "" : etc);
	separ1 = (separ1 == undefined ? "|" : separ1);
	separ2 = (separ2 == undefined ? "^" : separ2);
	separ3 = (separ3 == undefined ? "," : separ3);

	arrCode = codestr.split(separ2);
	arrInit = initdata.split(separ3);

	res = "<SELECT NAME=\""+ name +"\""+ (id != "" ? " id=\""+ id +"\"" : "") + (etc != "" ? " "+ etc : "") +" class='form-control input-sm' >";
	for (var i = 0; i < arrCode.length; i++) {
		arrTemp = arrCode[i].split(separ1);
		strSelected = "";
		for (var j = 0; j < arrInit.length; j++) {
			if (arrTemp[0] == arrInit[j].replace(/(^\s*)|(\s*$)/gi, "")) {
				strSelected = " selected";
				break;
			}
		}

		if (arrTemp.length > 2) {
			strValue = arrTemp[0];
			strText = arrTemp[1];
			strTitle = arrTemp[2];
		} else if (arrTemp.length = 2) {
			strValue = arrTemp[0];
			strText = arrTemp[1];
			strTitle = arrTemp[1];
		} else {
			strValue = arrTemp[0];
			strText = arrTemp[0];
			strTitle = arrTemp[0];
		}

		res += "<OPTION VALUE=\""+ strValue +"\" TITLE=\""+ strTitle +"\" " + strSelected + ">"+ strText +"</OPTION>";
	}
	res += "</SELECT>";

	return res;
};
/***************************************************************************
 * 제목 : 체크박스 Html 리턴 HtmlUtil.java getInputCheckbox와 동일하게 동작
 * 인자 : name - 선택상자 이름(여러개일경우)
 *       코드 str - 체크상자 구성용 문자열 ex> {value1}[separ1]{text1}[separ2]{value2}[separ1]{text2} ...
 *       기본데이터    - 선택된 옵션 값(값이 여러 개일 경우 쉼표(,)로 구분 ex> val1, val2, ...)
 ***************************************************************************/
jsHelper_htmlUtils.prototype.getInputCheckbox = function (name, codestr, initdata, chketc, lbletc, separ1, separ2, separ3) {
	  var res = "";
	  var arrCode, arrInit, arrTemp;
	  var strChecked = "";
	  // 옵션값 초기화
	  initdata = (initdata == undefined ? "" : initdata);
	  chketc = (chketc == undefined ? "" : chketc);
	  lbletc = (lbletc == undefined ? "" : lbletc);
	  separ1 = (separ1 == undefined ? "|" : separ1);
	  separ2 = (separ2 == undefined ? "^" : separ2);
	  separ3 = (separ3 == undefined ? "," : separ3);

	  arrCode = codestr.split(separ2);
	  arrInit = initdata.split(separ3);

	  for (var i = 0; i < arrCode.length; i++) {
	      arrTemp = arrCode[i].split(separ1);
	      strChecked = "";
	      for (var j = 0; j < arrInit.length; j++) {
	          if (arrTemp[0] == arrInit[j]) {
	              strChecked = "checked";
	              break;
	          }
	      }

	      var value	= arrTemp[0];
	      var text	= arrTemp[1];
	      var title	= (arrTemp.length == 2 ? arrTemp[1] : arrTemp[2]);

	      if (i != 0) res += "\r\n";

	      res += "<label><input type=\"checkbox\" name=\""+ name +"\" id=\""+ name + i +"\" value=\""+ value +"\" title=\""+ title +"\" "+ strChecked +" "+ chketc +" />"+ text +"</label>";
//	      res += "<label for=\""+ name + i +"\" title=\""+ title +"\" style=\"cursor:pointer;\" "+ lbletc +">"+ text +"</label>";
	  }

	  return res;
};

/***************************************************************************
 * 제목 : 코드 데이터 Str 리턴 HtmlUtil.java getCodeStrFromData와 동일하게 동작
 * 인자 : data 		- 기본 데이터 셋
 *       fieldNames - 필드명
 *       defaultCdStr    - 선택된 옵션 값(값이 여러 개일 경우 쉼표(,)로 구분 ex> val1, val2, ...)
 ***************************************************************************/
jsHelper_htmlUtils.prototype.getCodeStrFromData = function (data, fieldNames, defaultCdStr, separ1, separ2) {
	var res = "";
	var arrFields, arrTemp;
	defaultCdStr = (defaultCdStr == undefined ? "" : defaultCdStr);
	separ1 = (separ1 == undefined ? "|" : separ1);
	separ2 = (separ2 == undefined ? "^" : separ2);

	if (defaultCdStr != null && defaultCdStr != "") {
		res += defaultCdStr;
	}

	arrFields = fieldNames.split(",");
	$(data).each(function(i, d){
		if(i > 0 || (i == 0 &&  res != "")){
			res += separ2;
		}
		$(arrFields).each(function(j,arr){
			if(j > 0){
				res += separ1;
			}
			var txt = d[arr];
			if(txt.toUpperCase().indexOf(("LANGCD"))){
				txt = paragonCmm.getLang(txt);
			}
			res += txt;
		});

	});

	return res;
}

/************************************************************************************************
 * <summary>
 *  라디오버튼 출력 도우미 함수
 *  </summary>
 *  <param name="name">라디오버튼 이름</param>
 *  <param name="codestr">라디오버튼 구성용 문자열 ex> {value1}[separ1]{text1}[separ2]{value2}[separ1]{text2} ...</param>
 * <param name="initdata">선택된 값</param>
 * <param name="rdoetc">라디오버튼 스타일, 이벤트 등</param>
 * <param name="lbletc">레이블 스타일, 이벤트 등</param>
 * <param name="separ1">라디오버튼 구성용 문자열 value-text 구분자 ex> | </param>
 * <param name="separ2">라디오버튼 구성용 문자열 value-text 그룹 구분자 ex> ^ </param>
 *<returns></returns>
 **********************************************************************************************/
jsHelper_htmlUtils.prototype.getInputRadio = function (name, codestr, initdata, rdoetc, lbletc, separ1, separ2) {
	var res = "";
	var arrCode, arrTemp;
	var strChecked = "";

// 옵션값 초기화
	initdata = (initdata == undefined ? "" : initdata);
	rdoetc = (rdoetc == undefined ? "" : rdoetc);
	lbletc = (lbletc == undefined ? "" : lbletc);
	separ1 = (separ1 == undefined ? "|" : separ1);
	separ2 = (separ2 == undefined ? "^" : separ2);

	arrCode = codestr.split(separ2);

	for (var i = 0; i < arrCode.length; i++) {
		arrTemp = arrCode[i].split(separ1);
		strChecked = "";
		if (arrTemp[0] == initdata) {
			strChecked = "checked";
		}

		var value	= arrTemp[0];
		var text	= arrTemp[1];
		var title	= (arrTemp.length == 2 ? arrTemp[1] : arrTemp[2]);

		if (i != 0) res += "\r\n";
		var radio = "&nbsp;<input type=\"radio\" name=\""+ name +"\" id=\""+ name + i +"\" value=\""+ value +"\" title=\""+ title +"\" "+ strChecked +" "+ rdoetc +" />&nbsp;";
		res += "<label for=\""+ name + i +"\" title=\""+ title +"\" style=\"cursor:pointer;\" "+ lbletc +">"+radio + text +"</label>&nbsp;";
	}

	return res;
};

/***************************************************************************
 * 제목 : 코드 데이터 select option 생성
 * 인자 : options 데이터 생성에 필요한 옵션 {parentCd:"SYS_SOL",targetId:"targetId"}
 * 		 targetId 	- 생성대상 Select ID
 *       targetNm 	- 생성대상 Select name
 *       parentCd 	- 부모코드 CD
 *       initdata 	- 옵션절 기본	( |--전체-- ,|--선택-- )
 *       valNm	    - option value 컬럼명
 *       txtNm	    - option text 컬럼명
 ***************************************************************************/
jsHelper_htmlUtils.prototype.getCodeSelectOpt = function(param){
	var options = $.extend({
		targetId:"",
		targetNm:"",
		parentCd:"",
		initdata:"",
		valNm:"cd",
		txtNm:"langCd"
	},param);
	var data = {};
	if(options.parentCd == ""){
		htmlUtils.initializeSelectJson(options.targetId,options.targetNm, "", options.initdata, "cd", "langCd");
	}else{
		data["parentCd"] = options.parentCd;
		data["useYn"] 	= "Y";
		paragonCmm.callAjax(paragonCmm.getUrl("/viself/code/codeMng/listCode/json"),data, function(json){
			htmlUtils.initializeSelectJson(
						options.targetId,
						options.targetNm,
						json.data,
						options.initdata,
						options.valNm,
						options.txtNm
			);
		});
	}
}

/************************************ Ajax List 추가  시작 ************************************/
/**
 * 생성 테이블 페이징 처리
 */
jsHelper_htmlUtils.prototype.createPageDiv  = function(id, totalCount, pageNo, rowSize, func) {

	var $pageDiv = $("#"+id+"Page");
	$pageDiv.attr("class","dataTables_paginate paging_bootstrap pagination");
	$pageDiv.html($("<ul>").attr("id", "pageUl"));

	if (pageNo <= 0) pageNo = 1;
	if (rowSize <= 0) rowSize = 10;
	var pageListSize = 10;
	var lastPageNo  = 1;

	var totalPage = Math.ceil(totalCount/rowSize);
	if(pageListSize > totalPage)pageListSize = totalPage;
	var pageGroup = Math.ceil(pageNo/pageListSize);

	var last = pageGroup * pageListSize;    // 화면에 보여질 마지막 페이지 번호
	if(last > totalPage)
	last = totalPage;
	var first = last - (pageListSize-1);    // 화면에 보여질 첫번째 페이지 번호
	var next = last+1;
	var prev = first-1;

	//--first
	$("<li>").append($("<a href='#'>").attr("onClick", func+"(1)").text(" << ")).appendTo($("#pageUl"));

	if(prev < 1){
		prev = pageNo -1;
		if(prev < 1){
			prev = 1;
		}
	}
	//--prev
	$("<li>").append($("<a href='#'>").attr("onClick", func+"("+prev+")").text(" < ")).appendTo($("#pageUl"));
	for(var i=first; i<=last; i++ ){
		if(i > first){
			//$pageDiv.append($("<span class=\"page_separ\">").text("|"));
		}
		if(i == pageNo){
			$("<li class='active'>").append($("<a href='#'>").attr("onClick", func+"("+i+")").text(i)).appendTo($("#pageUl"));
//			$("<li>").attr("onClick", func+"("+i+")").append($("<span class=\"page_no\">").text(i)).appendTo($("#pageUl"));
		}else{
			$("<li>").append($("<a href='#'>").attr("onClick", func+"("+i+")").text(i)).appendTo($("#pageUl"));
//			$("<li>").attr("onClick", func+"("+i+")").text(i).appendTo($("#pageUl"));
		}
	}

	if(next > totalPage){
		next = pageNo +1;
		if(next > totalPage){
			next = totalPage;
		}
	}
	//--next
	$("<li>").append($("<a href='#'>").attr("onClick", func+"("+next+")").text(" > ")).appendTo($("#pageUl"));
//	$("<li>").attr("onClick", func+"("+next+")").append($("<span> > </span>")).appendTo($("#pageUl"));
	$("<li>").append($("<a href='#'>").attr("onClick", func+"("+totalPage+")").text(" >> ")).appendTo($("#pageUl"));
//	$("<li>").attr("onClick", func+"("+totalPage+")").append($("<span> >> </span>")).appendTo($("#pageUl"));

}

/**
 * jsonData 로 테이블 rows 생성 / 페이징 처리
 * @param id   :  적용할 요소 ID
 * @param jsonData  : {"total":n,"rows":[{},{},{}....]} 형식 유지 필요
 *        total : 게시물 총갯수
 *        rows : 실 게시물 데이터
 * @param pageNo  : 현재 페이징 번호 해당 값이 없다면 페이징 하지 않는다.
 * @param rowSize  : row 갯수
 * @param func   : 페이징 함수 명
 */
jsHelper_htmlUtils.prototype.createTableRow  = function (id ,jsonData, pageNo, rowSize, func) {
	var total = jsonData.total;
	var rows;

	rows = jsonData;
	if(jsonData.rows != undefined ){
		rows = jsonData.rows;
	}

	var tr = $("tr","#"+id);
	var $th = $("th","#"+id);
	var $tbody = $("<tbody id='"+id+"Body'>");

	if(rows != "" && "NO_RESULT" != rows.RESULT){
//		console.log(JSON.stringify(rows));
		if(pageNo != "undefined" && pageNo > 0 && "NO_RESULT" != rows.RESULT){
			this.createPageDiv(id, total, pageNo, rowSize, func);
		}

		$("#"+id+"Body").remove();
		$(rows).each(function(i, d){
			var $tr = $("<tr>");

			var trOpt = $(tr).data("opt");

			//-- TR tag에 링크가 존재 하는지 확인
			if(trOpt && trOpt["onClick"]){

				//-- 클릭 이벤트가 존재할 경우
				var href = trOpt["onClick"];
				var cnt = (trOpt["onClick"].match(/@{/g) || []).length;
				for(var i=0; i<cnt; i++){
					var startIdx = (href.indexOf("@{"));
					var endIdx  = (href.indexOf("}", href.indexOf("@{"))) ;
					var colNm = href.substring(startIdx+2,endIdx);
					var fullTxt = href.substring(startIdx,endIdx+1);

					href = href.replace(fullTxt, d[colNm]);
				}
				$tr.attr("onClick", href);
				$tr.css("cursor", "pointer");

			}
			$th.each(function(j, e){

				var $td = $("<td>");
				var opt = $(e).data("opt");
				//-- tr key 설정
				if( opt["trKey"]){
					$tr.attr("id", d[opt["trKey"]]);
				}
				//-- CSS
				if( opt["align"]){
					$td.css("text-align", opt["align"]);
				}
				if( opt["width"]){
					$td.css("width", opt["width"]);
				}
				if(opt["style"]){
					$td.css(opt["style"]);
				}

				//-- 링크가 존재 하는지 확인
				if( opt["href"] || opt["onClick"]){

					var aT = $("<a>");
					if(opt["href"]){					//-- 링크가 존재 할 경우
						var href = opt["href"];
						var cnt = (opt["href"].match(/@{/g) || []).length;
						for(var i=0; i<cnt; i++){
							var startIdx = (href.indexOf("@{"));
							var endIdx  = (href.indexOf("}", href.indexOf("@{"))) ;
							var colNm = href.substring(startIdx+2,endIdx);
							var fullTxt = href.substring(startIdx,endIdx+1);

							href = href.replace(fullTxt, d[colNm]);
						}
						aT.attr("href", href);
						aT.attr("target", "_blank");
						if(opt["col"].toUpperCase().indexOf(("LANGCD"))  > -1){
							//-- 언어코드 적용
							aT.html(paragonCmm.getLang( d[opt["col"]] ));

						}else{
							aT.html(d[opt["col"]]);
						}

						$td.append(aT);

					}else if(opt["onClick"]){			//-- 클릭 이벤트가 존재할 경우

						var href = opt["onClick"];
						var cnt = (opt["onClick"].match(/@{/g) || []).length;
						for(var i=0; i<cnt; i++){
							var startIdx = (href.indexOf("@{"));
							var endIdx  = (href.indexOf("}", href.indexOf("@{"))) ;
							var colNm = href.substring(startIdx+2,endIdx);
							var fullTxt = href.substring(startIdx,endIdx+1);

							href = href.replace(fullTxt, d[colNm]);
						}
						$td.attr("onClick", href);
						$td.css("cursor","pointer");
						if(opt["col"].toUpperCase().indexOf(("LANGCD"))  > -1){
							//-- 언어코드 적용
							$td.append(paragonCmm.getLang( d[opt["col"]] ));
						}else{
							$td.append(d[opt["col"]]);
						}

					}

				}else{
					if( opt["inputHidden"]){				//-- 생성할 hidden TAG가 있을경우
						var ids = opt["inputHidden"].split(";");
						$(ids).each(function(i, e){
							var $input = $("<input type=\"hidden\">");
							$input.attr("name", ids[i]);
							$input.val(d[ids[i]]);
							$td.append($input)
						});
//						$td.append(d[opt["col"]]);   //-- 아래 로직에서 추가 해 줌으로 여기선 주석
					}

					if(opt["html"]){						//-- content가 Html일경우 col은 무시된다.
						var $html = opt["html"];
						if("BTN" == $html["type"]){			//-- html type이 BTN(버튼) 일경우
							var $span = $("<span class=\"ui_btn small icon\">");
							var $i	  = $("<i class=\""+$html["class"]+"\">");
							var $a = $("<a href=\"javascript:void(0)\">");
							if($html["title"]){
								$a.text(paragonCmm.getLang($html["title"]));
							}
							$i.append($a);

							var href = $html["callback"];	//-- 버튼에 걸릴 callback 링크
							var cnt = ($html["callback"].match(/@{/g) || []).length;
							for(var i=0; i<cnt; i++){
								var startIdx = (href.indexOf("@{"));
								var endIdx  = (href.indexOf("}", href.indexOf("@{"))) ;
								var colNm = href.substring(startIdx+2,endIdx);
								var fullTxt = href.substring(startIdx,endIdx+1);

								href = href.replace(fullTxt, d[colNm]);
							}
							$i.attr("onClick", href);

							$span.append($i);
							$td.append($span);
						}else if("fileDown" == $html["type"]){	//-- html type이 파일다운 일경우
							var fileNm = d[$html["name"]];
							var fileVal = d[$html["value"]];

							var arrNm = fileNm.split("/");
							var arrVal = fileVal.split("/");
							if(fileNm != "" && arrNm.length > 0){
								var $ul = $("<ul>").attr("class","attach_file_view");
								$(arrNm).each(function(k,a){
									var $li = $("<li class=\"fa fa-save\" style=\"color:#666\">");
									var $a = $("<a>");

									$a.attr("href","javascript:paragonCmm.popupAttachFileDownload(\""+arrVal[k]+"\")");
									$a.text(" " + arrNm[k]);

									$li.append($a);
									$ul.append($li);
								});
								$td.append($ul);
							}
						}else if("link" == $html["type"]){
							var $a = $("<a href=\"javascript:void(0);\">");

							if($html["event"]){
								$($html["event"]).each(function(i, e){

									var $event = e;	//-- 이벤트 처리
									var $href   = $event["href"];
									var cnt = ($event["href"].match(/@{/g) || []).length;
									for(var i=0; i<cnt; i++){
										var startIdx = ($href.indexOf("@{"));
										var endIdx  = ($href.indexOf("}", $href.indexOf("@{"))) ;
										var colNm = $href.substring(startIdx+2,endIdx);
										var fullTxt = $href.substring(startIdx,endIdx+1);

										$href = $href.replace(fullTxt, d[colNm]);
									}
									$a.attr($event["type"],$href);

								});
							}
							$a.text(  d[$html["name"]] );
							$td.append($a);
						}else if("checkbox" == $html["type"]){	//-- html type이 checkbox 일경우
							var $check = $("<input type='checkbox'>");
							$check.attr("name",$html["name"]);
							if($html["name"]){ //-- 체크박스의  이름이 있을경우 id 설정
								$check.attr("id",$html["name"]+"_"+j);
							}
							if($html["valueField"]){	//-- 체크박스의  Value 값 지정
								$check.val(d[$html["valueField"]]);
							}
							if($html["checkAll"]){	//-- 체크박스 전체 체크 여부
								var $checkAll = $("<input type='checkbox' id='checkAll'>");
								$checkAll.attr("onclick","($(this).prop('checked'))?$('input:checkbox[name=\""+$html["name"]+"\"]').prop('checked',true):$('input:checkbox[name=\""+$html["name"]+"\"]').prop('checked',false)");
								$(e).html($checkAll);	//-- th 태그에 추가
							}
							if($html["event"]){
								$($html["event"]).each(function(i, e){

									var $event = e;	//-- 이벤트 처리
									var $href   = $event["href"];
									var cnt = ($event["href"].match(/@{/g) || []).length;
									for(var i=0; i<cnt; i++){
										var startIdx = ($href.indexOf("@{"));
										var endIdx  = ($href.indexOf("}", $href.indexOf("@{"))) ;
										var colNm = $href.substring(startIdx+2,endIdx);
										var fullTxt = $href.substring(startIdx,endIdx+1);

										$href = $href.replace(fullTxt, d[colNm]);
									}
									$check.attr($event["type"],$href);

								});

							}
							$td.append($check);
						}else if("radio" == $html["type"]){	//-- html type이 radio 일경우
							var $check = $("<input type='radio'>");
							$check.attr("name",$html["name"]);
							if($html["name"]){ //-- 라디오의  이름이 있을경우 id 설정
								$check.attr("id",$html["name"]+"_"+j);
							}
							if($html["valueField"]){	//-- 라이도의  Value 값 지정
								$check.val(d[$html["valueField"]]);
							}
							if($html["event"]){
								$($html["event"]).each(function(i, e){

									var $event = e;	//-- 이벤트 처리
									var $href   = $event["href"];
									var cnt = ($event["href"].match(/@{/g) || []).length;
									for(var i=0; i<cnt; i++){
										var startIdx = ($href.indexOf("@{"));
										var endIdx  = ($href.indexOf("}", $href.indexOf("@{"))) ;
										var colNm = $href.substring(startIdx+2,endIdx);
										var fullTxt = $href.substring(startIdx,endIdx+1);

										$href = $href.replace(fullTxt, d[colNm]);
									}
									$check.attr($event["type"],$href);

								});

							}
							$td.append($check);

						}else if("combobox" == $html["type"]){	//-- html type이 combobox 일경우
							var $combo = $("<select >");
							$combo.attr("name",$html["name"]);
							if($html["options"]){
								var opts = $html["options"];
								$(opts["data"]).each(function(idx, sub){
									var opt = $("<option>");
									opt.val(sub[opts["valueField"]]);
									opt.text(sub[opts["textField"]]);

									$combo.append(opt);
								});
							}

							if($html["event"]){
								$($html["event"]).each(function(i, e){

									var $event = e;	//-- 이벤트 처리
									var $href   = $event["href"];
									var cnt = ($event["href"].match(/@{/g) || []).length;
									for(var i=0; i<cnt; i++){
										var startIdx = ($href.indexOf("@{"));
										var endIdx  = ($href.indexOf("}", $href.indexOf("@{"))) ;
										var colNm = $href.substring(startIdx+2,endIdx);
										var fullTxt = $href.substring(startIdx,endIdx+1);

										$href = $href.replace(fullTxt, d[colNm]);
									}
									$combo.attr($event["type"],$href);

								});

							}
							$combo.val(d[$html["name"]]);
							$td.append($combo);

						}else if("text" == $html["type"]){

							var $input = $("<input type=\"text\">");

							if($html["event"]){
								$($html["event"]).each(function(i, e){

									var $event = e;	//-- 이벤트 처리
									var $href   = $event["href"];
									var cnt = ($event["href"].match(/@{/g) || []).length;
									for(var i=0; i<cnt; i++){
										var startIdx = ($href.indexOf("@{"));
										var endIdx  = ($href.indexOf("}", $href.indexOf("@{"))) ;
										var colNm = $href.substring(startIdx+2,endIdx);
										var fullTxt = $href.substring(startIdx,endIdx+1);

										$href = $href.replace(fullTxt, d[colNm]);
									}
									$input.attr($event["type"],$href);

								});

							}

							$input.attr("name",$html["name"]);
							$input.attr("class",$html["class"]);
							$input.val(d[$html["name"]]);
							$td.append($input);
						}

					}else if(opt["col"]){
						//-- 라인번호 설정
						if(opt["col"] == "ROWSEQ" && total){

							var pagingRowNo = d["rn"];

							$td.append((total - parseInt(pagingRowNo) + 1));

						}else if( opt["dataTp"]){					//-- 데이터 타입이 존재 할 경우

							if("currency" == opt["dataTp"]){
								$td.append( paragonCmm.getFormatCurrency(d[opt["col"]], 0 ));
							}else if("date" == opt["dataTp"]){
								$td.append( paragonCmm.validateDateValue(d[opt["col"]], 0 ));
							}else if(opt["dataTp"].startsWith("trunc")){
								var len = opt["dataTp"].split("__")[1];
								/*if(len > 20){
									len = 20;
								}*/
								//$td.append(paragonCmm.getTrunc( d[opt["col"]], len));
								$td.append("<p title=\""+d[opt["col"]]+"\">"+paragonCmm.getTrunc( d[opt["col"]], len)+"</p>");
							}else{
								$td.append(d[opt["col"]]);
							}
						}else{
							if(opt["col"].toUpperCase().indexOf(("LANGCD"))  > -1){

								//-- 언어코드 적용
								var txtValue = paragonCmm.getLang( d[opt["col"]] ) ;
								if( opt["formater"]){
									txtValue = (new Function("return "+opt["formater"] + '("'+txtValue+'");'))();
								}
								$td.append(txtValue);

							}else{
								var txtValue = d[opt["col"]];
								if( opt["formater"]){
									txtValue = (new Function("return "+opt["formater"] + '("'+txtValue+'");'))();
								}
								$td.append(txtValue);
							}

						}
					}
				}
					$tr.append($td);
			});
				$tbody.append($tr);
		});
		$("#"+id).append($tbody);

	}else{
		var $pageDiv = $("#"+id+"Page");
		$pageDiv.html("");
		$("#"+id+"Body").html("");
		var $tr = $("<tr>");
		var $td = $("<td>");
		$td.attr("colspan",$th.length);
		$td.css("text-align","center");
		$td.text("No result.");
		$tr.append($td);
		$("#"+id+"Body").html($tr);
	}
}
/************************************ Ajax List 추가  끝 ************************************/

/**
 * code 데이터 codeStr 형태로 반환 (값|텍스트^값|텍스트)
 * @param parentCd	: 부모코드
 * @param fields    : 코드 컬럼명 value,text
 * @param defaultStr: 기본이 되는 데이터 셋 ( |--전체-- ,|--선택-- )
 * @param callBackFnc : 콜백함수
 */
jsHelper_htmlUtils.prototype.loadCodeStr = function(parentCd, fields, defaultStr, callBackFnc){
	fields = (fields == undefined || fields == null ? "cd,langCd" : fields);

	var data = {"parentCd" : parentCd};
	data["useYn"] = "Y";

	paragonCmm.callAjax(paragonCmm.getUrl("/viself/code/codeMng/listCode/json"),data, function(json){
		callBackFnc(htmlUtils.getCodeStrFromData(json.data,fields,defaultStr));
	});
}

/**
 * 파일 업로드 영역 Html load
 * @param targetId	: 파일첨부가 되어야 하는 ID
 * @param options   : 파일이 그려지기위한  옵션값
 * 				- 필수  : relUid, fileTpCd, defaultRelUid(수정시 필수)
 */
jsHelper_htmlUtils.prototype.loadFileHtml = function(targetId, options ){
	targetId = (targetId == undefined || targetId == null ? "" : targetId);

	if(targetId != ""){
		var url = paragonCmm.getUrl("/paragon/file/fileWrite");

		$("#"+targetId).load(url, options);
	}else{
		console.debug("targetId is null!!");
	}
}
/**
 * 파일 뷰 영역 Html load
 * @param targetId	: 파일첨부가 되어야 하는 ID
 * @param options   : 파일이 그려지기위한  옵션값
 * 				- 필수  : relUid, fileTpCd, defaultRelUid(수정시 필수)
 */
jsHelper_htmlUtils.prototype.loadFileView = function(targetId, options ){
	targetId = (targetId == undefined || targetId == null ? "" : targetId);

	if(targetId != ""){
		var url = paragonCmm.getUrl("/paragon/file/fileView");

		$("#"+targetId).load(url, options);
	}else{
		console.debug("targetId is null!!");
	}
}

/**
 * code 데이터 codeStr 형태로 반환 (값|텍스트^값|텍스트)
 * @param targetId	: 파일첨부가 되어야 하는 ID
 * @param options    : 파일이 그려지기위한  옵션값
 * 				- 필수  : fileNm
 */
jsHelper_htmlUtils.prototype.fileDownload = function(atchUid ){
	var url = paragonCmm.getUrl("/paragon/file/download?atchUid="+atchUid);
	location.href = url
}

/**
 * code 데이터 codeStr 형태로 반환 (값|텍스트^값|텍스트)
 * @param targetId	: 파일첨부가 되어야 하는 ID
 * @param options    : 파일이 그려지기위한  옵션값
 * 				- 필수  : fileNm
 */
jsHelper_htmlUtils.prototype.formDownload = function(fileNm ){
	fileNm = (fileNm == undefined || fileNm == null ? "" : fileNm);

	var url = paragonCmm.getUrl("/paragon/file/download/form?fileNm="+encodeURIComponent(fileNm));
	location.href = url
}

/**
 * code 데이터 codeStr 형태로 반환 (값|텍스트^값|텍스트)
 * @param targetId	: 에디터가 그려져야 되는 Area ID
 * @param options    : 에디터가 그려지기위한  옵션값
 * 				- 필수  : sCtrlName
 *              - 비필수 : sCtrlId,editorType,sInitData,sCtrlEtc,sWidth,sHeight,sToolbarSet
 */
jsHelper_htmlUtils.prototype.getHtmlEditor = function( options ){
	var sCtrlName = (options.sCtrlName == undefined || options.sCtrlName == null ? "" : options.sCtrlName);
	var sCtrlId = (options.sCtrlId == undefined || options.sCtrlId == null ? sCtrlName : options.sCtrlId);
	var editorType = (options.editorType == undefined || options.editorType == null ? "" : options.editorType);
	var sInitData = (options.sInitData == undefined || options.sInitData == null ? "" : options.sInitData);
	var sCtrlEtc = (options.sCtrlEtc == undefined || options.sCtrlEtc == null ? "" : options.sCtrlEtc);
	var sWidth = (options.sWidth == undefined || options.sWidth == null ? "100%" : options.sWidth);
	var sHeight = (options.sHeight == undefined || options.sHeight == null ? "150px" : options.sHeight);
	var sHeight = (options.sToolbarSet == undefined || options.sToolbarSet == null ? "Default" : options.sToolbarSet);



	if(editorType.toUpperCase() == "NAMO"){

	}else{
		CKEDITOR.replace(sCtrlId, {
			width:sWidth,
			height:sHeight,
			language:paragonCmm.getSiteLocale().toLowerCase()});
	}
}

var colsProperties = {};
/**
 * 컬럼지정 기본 셋팅
 */
jsHelper_htmlUtils.prototype.setColsProperties = function(initVal,actionCd,gridID, jsonURL){
	colsProperties["initVal"] = initVal;
	colsProperties["actionCd"] = actionCd;
	colsProperties["gridID"] = gridID;
	colsProperties["jsonURL"] = jsonURL;


	$("li", "#source").css({'padding': '5px 5px 5px 5px','border': '1px solid #cdcdcd','width': '120px','margin':'0px 0px 10px 10px','background':'#ffffff','cursor':'pointer', 'list-style-type':'none', 'float':'left'})

	$("li", "#source").on('click',function(e){
		if(e.target.tagName == "INPUT"){
			//-- 체크박스를 직접 체크 했을때.
			if($(this).find("input:checkbox").prop('checked')){
				var clone =  $(this).clone();
				clone.text($(this).text());
				//clone.css("box-shadow","2px 1px 1px 1px #777777");
				clone.css("background-color","#d0491f");
				clone.css("font-weight","bold");
				//clone.css("text-shadow","1px 0px 1px #fff");
				$("#target").append(clone);

			}else{
				var id= $(this).attr("id");
				$("#"+id,"#target").remove();

			}

		}else{
			//-- li 클릭되었을때.
			if(!$(this).find("input:checkbox").prop('checked')){
				$(this).find("input:checkbox").prop('checked',true);
				var clone =  $(this).clone();
				clone.text($(this).text());
				//clone.css("box-shadow","2px 1px 1px 1px #777777");
				var id = $(this).attr("id");
				if(initVal.search(id) == -1){
					clone.css("background-color","#d0491f");
				}else{
					clone.css("background-color","#468fb5");
				}

				clone.css("font-weight","bold");
				//clone.css("text-shadow","1px 0px 1px #fff");
				$("#target").append(clone);
			}else{
				$(this).find("input:checkbox").prop('checked',false);
				var id= $(this).attr("id");
				$("#"+id,"#target").remove();

			}
		}
	});

	$('#target').sortable();
}
/**
 * 컬럼 읽어 들임 및 그리드 실행 URL, queryParams 를 여기서 지정한다. 기존코드에서는 제거
 */
jsHelper_htmlUtils.prototype.loadCols = function(){

	var arrData = [];
	arrData.push({field:'SOL_MAS_UID',width:0,hidden:true});
	$("li", "#target").each(function(i,e){
		var data = "{"+$(e).data("options")+"}";
		var jData = (new Function("return "+data))();
		jData["title"] = $(e).text();
		arrData.push(jData);
	});
	if(arrData.length > 1){
		$("#"+colsProperties["gridID"]).datagrid({
			url:colsProperties["jsonURL"],
			columns:[arrData],
		    queryParams:paragonCmm.getSearchQueryParams()
		});
	}
}

/**
 * 개인 컬럼 지정
 * @param defaultUser 기본 사용자
 * @param toObj 텍스트 input
 */
jsHelper_htmlUtils.prototype.initCols = function(type){
	if(type == "init"){
//		var initVal = "MNG_NO,CORP_NM,CT_TYPE_1_LANG_CD,CHR_USER_NM,TIT,REQ_DEPT_NM,CHR_USER_NM,REQ_USER_NM,NOW_REQ_DTE,REW_DTE,STU_NAM";
		var arr = colsProperties["initVal"].split(",");
		//-- 기존 선택된 것들 초기화
		$("input:checkbox:checked", "#source").each(function(i, e){
			$(e).parent().trigger('click');
		});

		for(var i = 0; i < arr.length; i++){
			var id = arr[i];
			$("#"+id, "#source").trigger('click');
		}

	}else{
		$.ajax( { url   : paragonCmm.getUrl("/ips/cmm/preset/PresetInfo/myList/json")
			, type  : "POST"
			, async : true
			, cache : false
			, data  : { "PRE_TYPE"  : colsProperties["actionCd"]+"_COL" }
			, dataType: "json"
		}).done(function(data){
			if(Object.keys(data.data).length > 0){

				var preData = data[0].PRE_DATA;

				var arr = preData.split(",");

				for(var i = 0; i < arr.length; i++){
					var id = arr[i];
					$("#"+id, "#source").trigger('click');
				}

			}else{
				var arr = colsProperties["initVal"].split(",");

				for(var i = 0; i < arr.length; i++){
					var id = arr[i];
					$("#"+id, "#source").trigger('click');
				}
			}
			htmlUtils.loadCols();
		}).fail(function(){
			alert(paragonCmm.getLang("M.에러처리"));
		});

	}
};
/**
 * 컬럼 저장처리
 */
jsHelper_htmlUtils.prototype.preSetSave = function(){

	var ids = "";
	$("li", "#target").each(function(i,e){
		if(i > 0) ids+=",";
		ids += $(e).attr("id");
	});

	$.ajax( { url   : paragonCmm.getUrl("/ServletController")
			, type  : "POST"
			, async : true
			, cache : false
			, data  : { "AIR_ACTION"  : "SYS_USER"
					  , "AIR_MODE"    : "USER_GROUP_SAVE"
					  , "PRE_TYPE"    : colsProperties["actionCd"]+"_COL"
					  , "PRE_TITLE"   : '리스트컬럼'
					  , "PRE_CONTENT" : ''
					  , "PRE_DATA"    : ids }
			, dataType: "json"
	}).done(function(data){

		htmlUtils.loadCols();
		htmlUtils.closeCols();

	}).fail(function(){
		alert(paragonCmm.getLang("M.에러처리"));
	});

}
/**
 * 컬럼지정 닫기
 */
jsHelper_htmlUtils.prototype.closeCols = function(){ //-- 컬럼닫기
	$("#user_cols").window('close');
}
/**
 * 컬럼 사용자 변경 열기
 */
jsHelper_htmlUtils.prototype.openCols = function(){ //-- 컬럼열기
	$("#user_cols").window('open');
}