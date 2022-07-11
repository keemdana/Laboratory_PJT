<%--
  - MENU ID : regVoc
  - Description : VOC 등록
--%>

<%@page import="com.vertexid.spring.utils.SessionUtils" %>
<%@page import="com.vertexid.commons.utils.DateUtil" %>
<%@page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@page import="com.vertexid.commons.utils.StringUtil" %>
<%@page import="com.vertexid.commons.utils.HtmlUtil" %>
<%@page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>

<%
    SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
    String siteLocale = loginUser.getSiteLocale();
%>
 
<style>
    .datagrid-header {
        font-weight: bold;
    }
    
    TABLE.basic TH {
    	text-align : center;
    }
    
    TABLE.basic TH.left {
    	text-align : left;
    	padding: 7px 10px 7px 10px !important;
    }
    
    DIV.buttonlist {
    	padding: 15px 2px 15px 2px;
    }
    
    DIV.title_left {
    	width : 50%; 
    	float : left;
    }
    
    DIV.button_right {
    	width: 50%; 
    	float: right;
    	text-align: right;
    	padding: 5px 2px 5px 2px;
    }
</style>

<div class="row mt">
	<h5 class="sub1_title" data-term="L.VOC 등록"><i class="fa fa-file-text"></i></h5>(<span class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)	
    <div>
        <form name="bbsWriteForm" id="bbsWriteForm" method="post">
            <div id="bbsWriteForm2" data-opener-data="<c:out value='${param.openerData}'/>">
                
                <%-- 기본정보 작성 화면 --%>
                <table class="basic">
                    <colgroup>
                        <col style="width:10%;">
                        <col style="width:15%;">
                        <col style="width:10%;">
                        <col style="width:15%;">
                        <col style="width:10%;">
                        <col style="width:15%;">
                        <col style="width:10%;">
                        <col style="width:15%;">
                    </colgroup>
                    <tr>
                        <th>관리번호</th>
                        <td><input type="text" id="vocNo" name="vocNo" class="form-control" value="" readonly/></td>
                        <th><span class="ui_icon required"></span>구분</th>
                        <td><select id="vocTpNm" name="vocTpNm" class="form-control input-sm" data-type="search" ></select></td>                        
                        <th><span class="ui_icon required"></span>고객사</th>
                        <td><input type="text" id="custNm" name="custNm" class="form-control" value=""/></td>
                        <th><span class="ui_icon required"></span>고객담당자</th>
                        <td><input type="text" id="custMngNm" name="custMngNm" class="form-control" value=""/></td>
                    </tr>
                    <tr>
                    	<th><span class="ui_icon required"></span>제목</th>
                        <td colspan="5"><input type="text" id="vocTitle" name="vocTitle" class="form-control" data-col="vocTitle" value=""/></td>
                        <th><span class="ui_icon required"></span>장비군</th>
                        <td><select id="prodGroup" name="prodGroup" class="form-control input-sm" data-type="search" ></select></td>
                    </tr>
                    <tr>
                        <th><span class="ui_icon required"></span>접수유형</th>
                        <td><select id="rcptTpNm" name="rcptTpNm" class="form-control input-sm" data-type="search" ></select></td>
                        <th>접수부서</th>
                        <td><%=loginUser.getDeptNmKo()%><input type="hidden" name="deptCd" id="deptCd" class="form-control" data-col="deptCd" value="<%=loginUser.getDeptCd()%>" readonly></td>
                        <th>접수자</th>
                        <td><%=loginUser.getNmKo()%><input type="hidden" name="loginId" id="loginId" value="<%=loginUser.getLoginId() %>"/></td>
                        <th>접수일</th>
                        <td><%=DateUtil.getCurrentDate()%>
                            <input type="hidden" name="vocReqDate" id="vocReqDate" class="form-control" data-col="vocReqDate" value="<%=DateUtil.getCurrentDate()%>" readonly>
                        </td>
                    </tr>
                    <!-- <tr style="height:300px;">
						<th>요청내용</th>
						<td colspan="7"><textarea name="vocReqContents" id="vocReqContents" class="memo" style="width:100%; height:300px;" data-meaning="TMP" onkeyup="paragonCmm.validateMaxLength(this, '4000');"></textarea></td>
					</tr> -->
					<tr style="height:300px;">
                        <th><span class="ui_icon required"></span>주요 작업 내용</th>
                        <td colspan="7"><%=HtmlUtil.getHtmlEditor(request, true, "bbsContent", "bbsContent", "", "data-col=\"bbsContent\"", "100%", "", "Default") %></td>
                    </tr>
                </table>
              
              	<%-- 대상 설비 선택 화면 --%>
                <div style="width: 100%; margin-top:10px;">
	                <div class="title_left">
	                	<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 대상 설비</h6>
	                </div>
	                <div class="button_right">
	                	<button type="button" class="btn btn-primary" id="addSulbi"><i class="fa fa-check"></i>추가 </button>	
	                	<button type="button" class="btn btn-primary" id="removeSulbi"><i class="fa fa-check"></i>삭제 </button>
	                </div>
                </div>                
                <table class="basic" id="sulbiTb">
                    <colgroup>
                        <col style="width:5%;">
                        <col style="width:30%;">
                        <col style="width:30%;">
                        <col style="width:30%;">
                    </colgroup>
                    <thead>
	                    <tr>
	                        <th>No.</th>
	                        <th>Line</th>
	                        <th>제품유형</th>
	                        <th>Process</th>
	                    </tr>
                    </thead>
                    <tbody id="sulbiList">
                    </tbody>
                </table>
             
                <%-- 처리담당 선택 화면 --%>
                <div style="width: 100%; margin-top:10px;">
	                <div class="title_left">
	                	<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 처리 담당</h6>
	                </div>
	                <div class="button_right">
	                	<button type="button" class="btn btn-primary" id="addEmp"><i class="fa fa-check"></i>추가 </button>	
	                	<button type="button" class="btn btn-primary" id="removeEmp"><i class="fa fa-check"></i>삭제 </button>
	                </div>
                </div>                
                <table class="basic" id="empTb">
                    <colgroup>
                        <col style="width:5%;">
                        <col style="width:10%;">
                        <col style="width:10%;">
                        <col style="width:35%;">
                        <col style="width:20%;">
                        <col style="width:20%;">
                    </colgroup>
                    <thead>
	                    <tr>
	                        <th>No.</th>
	                        <th>담당부서</th>
	                        <th>담당자</th>
	                        <th>진행요청내용</th>
	                        <th>접수일</th>
	                        <th>고객납기일</th>
	                        <th style="display:none;">userId</th>
	                    </tr>
                    </thead>
                    <tbody id="empList">
                    </tbody>
                </table>
                
                
                <div class="buttonlist">
                    <div class="right">
                        <!-- <span class="ui_btn medium icon" id="btnSave" name="btnSave"><i class="fa fa-save"><a
                                href="javascript:void(0)" data-term="B.SAVE"></a></i></span> -->
                        <button type="button" class="btn btn-primary" id="btnSave" data-term="L.저장"><i class="fa fa-check"></i> </button>
	        			<button type="button" class="btn btn-primary" id="btnRequest"  style="color: #f5f5f5; background-color: #a94442; border-color: #a94442;" data-term="L.요청"><i class="fa fa-check"></i> </button>
                    </div>
                </div>
        	</div>  
        	
        	<%-- <input type="hidden" name="<c:out value='${_csrf.parameterName}'/>" value="<c:out value='${_csrf.token}'/>"> --%>
        	<input type="hidden" id="lineList" name="lineList" >
        	<input type="hidden" id="prodList" name="prodList" >
        	<input type="hidden" id="processList" name="processList" >
        	
        </form>
    </div>
</div>

<script type="text/javascript">

$(document).ready(function () {
	
    console.info("[Loading Module: URL관리].....................");
	
    var workVocReg = new WorkVocReg();
    workVocReg.init();
    
    
    
});

var WorkVocReg = function () {

    var openerData = $("#bbsWriteForm2").data("opener-data");
	$("#bbsUid").val(openerData.bbsUid);
	
	//ajax URL
	var BBS_SELECT_ONE_URL = "/pcf/registerPcf/json"; //수정모드 조회용
	var BBS_INSERT_URL = "/paragon/bbs/bbsMas/insert/json";     //신규 등록
	var BBS_UPDATE_URL = "/paragon/bbs/bbsMas/update/json";        //수정
	
	var $isNew = openerData.isNew;	// 신규/수정 구분
	var $bbsWriteForm = $("#bbsWriteForm");
	var $bbsUid = $("#bbsUid");
	var $bbsPopupStDte = $("#bbsPopupStDte");
	var $saveBtn = $("#btnSave");
	var $requestBtn = $("#requestBtn");

	var doValidation = function () {    // 저장 필수체크
		if ($("input:text[name='labTitle']", $bbsWriteForm).val() == "") {
			alert("작업명을 입력해주세요.", function () {
				$("input:text[name='labTitle']", $bbsWriteForm).focus();
			});
			return false;
		}
	
		var popupFromDate = $bbsPopupStDte.val();
		if (popupFromDate == "") {
			alert("작업예정일을 선택해주세요");
			return false;
		}
			
		return true;
	}

	var doSubmit = function () {
		var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장");
		if (!doValidation()) {
			return false;
		}
		confirm(msg, function (r) {
			if (r) {

				/* var cbFncInsert = function(){
					window.opener.BBSLIST.doSearch();
					window.close();
				}; */
				
				/* var cbFncUpdate = function(){
					window.opener.opener.BBSLIST.doSearch();
					window.opener.close();
					window.close();
				}; */
				
				//var saveUrl = "/voc/saveMst/json";
				//var cbFnc = cbFncInsert;
				
				//UPDATE
				/* if ($isNew === "FALSE") {
					saveUrl = BBS_UPDATE_URL;
					cbFnc = cbFncUpdate;
				} */

				//paragonCmm.setEditorSubmit("");
				var data = $bbsWriteForm.serializeObject();

				//data.bbsContent = $bbsWriteForm.find("textarea[name=bbsContent]").val().replace(/\"/gi, "'");
				
				//파일저장이 필요할 땐 submitAjax를 써야한다 (callAjax에는 파일처리가 미포함)
				paragonCmm.submitAjax("/voc/saveMst/json", data, function (json) {
					if (json.errYn === "E") {
						//오류처리
						alert(json.msg);
						return false;
					}
					//cbFnc();
				});
			}
		});	
	}
	
	var loadData = function () {
		var data = $.extend({}, openerData, jsonData);
		paragonCmm.callAjax("/pcf/registerPcf/json", data, function (json) {
			if (typeof json === "object") {
				var master = json.data;
				$.each(master, function (key, val) {
					var obj = $("[data-col=" + key + "]", $bbsWriteForm);
					var tagNam = $(obj).prop("tagName");
					if ("INPUT" == tagNam) {
						var typeNm = $(obj).attr("type");
						if ("radio" == typeNm || "checkbox" == typeNm) {
							$("input[data-col=" + key + "][value='" + val + "']", $bbsWriteForm).prop("checked", true);
						} else if (key == "bbsPopupStDte" || key == "bbsPopupEdDte") {
							$("#" + key).datebox('setValue', val);
						} else {
							$(obj).val(val);
						}
					} else {
						$(obj).val(val);
					}
				});
			}
		});
	}

	//-- 웹에디터 첨부파일 Form 로드
	var loadForm = function () {

		var attchId = "bbsFile";
		var options = {}

		options.relUid = $("#bbsUid").val();    //-- 관례 키 UIDH
		options.fileTpCd = "CMM/BBS";    //-- 파일 유형 코드
		options.defaultRelUid = "";                //-- 기본 로드 첨부파일(수정시)
		console.log("options");
		console.log(options);

		try{

		htmlUtils.loadFileHtml(attchId, options);
		}catch (e){
			console.log(e);
		}

	}

	var initFormComponent = function () {
		$bbsPopupStDte.datebox({});            
	}
	
	var attchmentEvent = function () {
		$saveBtn.off();
		$saveBtn.on("click", function () {
			doSubmit();
		});
	}

	//기준정보 조회
	var getDdList = function () {
		var iData = {};
		paragonCmm.callAjax("/voc/getDdList/json", iData, function (json) {
			//구분
			for(var i = 0; i < json.vocTp.length; i++){
				//alert(json.data[i].mcodeNm);
				$("#vocTpNm").append("<option value='"+ json.vocTp[i].dcode +"'>"+ json.vocTp[i].dname +"</option>");
			}
			//장비군
			for(var i = 0; i < json.prodGroup.length; i++){
				$("#prodGroup").append("<option value='"+ json.prodGroup[i].dcode +"'>"+ json.prodGroup[i].dname +"</option>");
			}
			//접수유형
			for(var i = 0; i < json.rcptTp.length; i++){
				$("#rcptTpNm").append("<option value='"+ json.rcptTp[i].dcode +"'>"+ json.rcptTp[i].dname +"</option>");
			}
			
		});
	}
	
	//고객사 선택 모달
	var $modalDiv1;
	
	var modalTitle = "";
	var modalUrl = "";
	var width = "";
	
    $("input:text[name='custNm']", "#bbsWriteForm").off();
    $("input:text[name='custNm']", "#bbsWriteForm").on("click",function(){
        modalTitle = "고객사 선택";
        modalUrl = "/voc/schCustDialog.modal";
        width = 500;
    	openModal(this, modalTitle, modalUrl);
    });
    
    $("#addSulbi").on("click", function () {
    	modalTitle = "대상 설비 선택";
        modalUrl = "/voc/schSulbiDialog.modal";
        width = 1500;
        openModal(this, modalTitle, modalUrl);
    });
    
    $("#addEmp").on("click", function () {
    	modalTitle = "처리 담당 선택";
        modalUrl = "/voc/schEmpDialog.modal";
        width = 1000;
        openModal(this, modalTitle, modalUrl);
    });
    
	var openModal = function(obj, modalTitle, modalUrl){
        $(obj).val("");// 클릭시 값 초기화
        if( typeof $modalDiv1 != "object"){
            $modalDiv1 = $("<div>");
        }
        $modalDiv1.window({
            iconCls:'icon-search',
            width:width,
            height:600,
            title:modalTitle,//"고객사 선택",
            href:modalUrl,//"/voc/schCustDialog.modal",  //"/viself/module/moduleListDialog.modal",
            modal:true,
            onClose:function(){
                $modalDiv1.window("destroy");
            },
            onLoad:function(){
                moduleList.init(function(){
                    //-- init Function
                }, function(moduleId){
                    //-- callback Function
                    $(obj).val(moduleId);
                    $modalDiv1.window("destroy");
                });            //-- init,콜백 Function 지정
                paragonCmm.convertLang($modalDiv1);             //-- 다국어 처리
            }
        });
    }
	
	
	
	/* var empVocRegDte = $empVocRegDte.val();
	if (empVocRegDte == "") {
		alert("접수일을 선택해주세요");
		return false;
	}
	
	var empVocCustDate = $empVocCustDate.val();	
	if (empVocCustDate == "") {
		alert("고객납기일을 선택해주세요");
		return false;
	} */
	
	
	
	<%--
	var mCmm = new ModuleMngCommon();
    var moduleUrlMng = null;
    var model = new ModuleMngViewModel();
    $("#addSulbi").on("click", function () {
		/* var trCnt = $('#sulbiList tr').length;
		var innnerHtml = "";
		innnerHtml += '<tr>'
		innnerHtml += '<th>' + trCnt + '</th>';
		innnerHtml += '<th>' + "11Line" + '</th>';
		innnerHtml += '<th>' + "A" + '</th>';
		innnerHtml += '<th>' + "B" + '</th>';
		innnerHtml += '</tr>'
		
		$('#sulbiTb > tbody:last').append(innnerHtml); */
		
		// 1. init modal
        var $dialog = mCmm.initModal();
		var moduleData = "";
        // 2. open modal
        $dialog.dialog({
            iconCls: "fa fa-info-circle",
            title: "Module Info.",
            width: 500,
            height: 200,
            method: "post",
            cache: false,
            modal: true,
            href: model.getModuleDialogUrl(),
            // maximizable: true,
            // maximized: true,
            queryParams: {
                openerData: JSON.stringify(moduleData)
            },
            onClose: function(){
                // HACK 이벤트를 지우지 않으면 계속 쌓인다.
                // 1. HTML 지우기
                $dialog.dialog("destroy");
                // 2. 이벤트 지우기
                $("#moduleMngPop1 *").off();
            },
            onLoad: function(){
                // 1. 가운데 열기
                $dialog.dialog("center");

                // 2. 다국어 설정
                paragonCmm.convertLang($dialog);

                // 3. call-back 설정
                // include 페이지 최상위 DOM id
                var $DIALOG_ROOT_NODE = $("#moduleMngPop1Frm0");
                $DIALOG_ROOT_NODE.data("callback", function(isSchFlag){
                    if(isSchFlag){
                        searchModule();
                    }
                    $dialog.dialog("close");
                });
            }
        });
	});
	--%>
	
    var init = function () {
    	loadForm(); // 양식 로드
		initFormComponent();
		attchmentEvent();
		
		//기준정보 선택 값 조회
		getDdList();
		
		if ($isNew == "FALSE") {
			loadData();
		}
		
    };

    return {
        init: init
    };
}


var ModuleMngViewModel = function(){
    "use strict";

    // 모듈 조회
    //var MODULE_SEARCH_URL = "/voc/module/moduleMng/moduleList/json";

    // 모듈 다이얼로그 URL
    var MODUEL_DIALOG_URL = "/voc/schSulbiDialog.include";

    /* var getModuleListUrl = function(){
        return paragonCmm.getUrl(MODULE_SEARCH_URL);
    }; */

    var getModuleDialogUrl = function(){
        return paragonCmm.getUrl(MODUEL_DIALOG_URL);
    };

    return{
        //getModuleListUrl: getModuleListUrl,
        getModuleDialogUrl: getModuleDialogUrl
    };
};


var ModuleMngCommon = function(){
    "use strict";
    var getGridHeight = function(){
        var ENURI = 240;
        var SCH_HEIGHT = 0; //$searchFrm.innerHeight();
        var windowHeight = window.innerHeight;
        return windowHeight - SCH_HEIGHT - ENURI;
    };

    var getPageSize = function(){
        var gHeight = getGridHeight();

        // console.log(gHeight);
        if(gHeight > 500){
            return 20;
        }
        return 10;
    };

    var showMsg = function(data){
        if(data.errYn !== "E"){
            $.messager.show({
                title: "Info",
                msg: paragonCmm.getLang(data.msg),
                icon: "info",
                timeout:1000
            });
        }else{
            $.messager.alert("Warning",data.msg, "warning");
        }
    };

    var initModal = function(modalId){

        modalId = (typeof modalId === "undefined")? "modalPop" : modalId;

        var $dialog = document.getElementById(modalId);
        if(!$dialog){
            var DIALOG_HTML = "<div id='"+modalId+"'/>"
            $("body").append(DIALOG_HTML);
        }
        $dialog = $("#"+modalId);
        $dialog.html("");

        return $dialog;
    };

    return {
        getGridHeight: getGridHeight,
        initModal: initModal,
        getPageSize: getPageSize,
        showMsg: showMsg
    };
};

var lineList = [];
var prodList = [];
var processList = [];

function setSulbiList(line, prod, process){
	var trCnt = $("#sulbiTb >tbody tr").length+1;
	var innerHtml = "";
	innerHtml += '<tr>';
	innerHtml += '<td>'+trCnt+'</td>';
	innerHtml += '<td>'+line["lineNm"]+'</td>';
	innerHtml += '<td>'+prod["prodNm"]+'</td>';
	innerHtml += '<td>'+process["processNm"]+'</td>';
	innerHtml += '</tr>';
	
	$("#sulbiTb > tbody:last").append(innerHtml);
	
	lineList.push(line["lineCd"]);
	prodList.push(line["prodCd"]);
	processList.push(line["processCd"]);

	//$modalDiv1.window("destroy");
	
	
}

var empList = [];
function setEmpList(emp){
	var trCnt = $("#empTb >tbody tr").length+1;
	var innerHtml = "";
	innerHtml += '<tr>';
	innerHtml += '<td>'+trCnt+'</td>';
	innerHtml += '<td>'+emp["deptNm"]+'</td>';
	innerHtml += '<td>'+emp["empNm"]+'</td>';
	innerHtml += '<td><input type="text" id="empReqContents_'+trCnt+'" name="empReqContents" class="form-control" value=""/></td>';
	innerHtml += '<td><input type="text" id="empVocRegDte_'+trCnt+'" name="empVocRegDte" class="form-control" data-col="empVocRegDte" style="width: 100%;"></td>';
	innerHtml += '<td><input type="text" id="empVocCustDate_'+trCnt+'" name="empVocCustDate" class="form-control" data-col="empVocCustDate" style="width: 100%;"></td>';
	innerHtml += '<td style="display:none;">'+emp["userId"]+'</td>';
	innerHtml += '</tr>';	
	
	$("#empTb > tbody:last").append(innerHtml);
	
	var $empVocRegDte = $("#empVocRegDte_"+trCnt);
	$empVocRegDte.datebox({});   
	
	var $empVocCustDate = $("#empVocCustDate_"+trCnt);
	$empVocCustDate.datebox({});   
	
	empList.push(emp["userId"]);
	
	
	//$modalDiv1.window("destroy");
	
}
</script>

<%-- <script src="<c:url value='/js/module/viself/auth/urlMng.js'/>"></script> --%>
