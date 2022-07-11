<%--
  - MENU ID : registerPcf
  - Description : 연구소 작업 등록
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
</style>

<div class="row mt">
	<h5 class="sub1_title" data-term="L.PCF_조회"><i class="fa fa-file-text"></i> </h5> ( <span
	        class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
	<!-- <div class="content-panel p-3" id="bbsWrite"> -->
    <div>
    <!-- <div class="row">	
		<div class="col-md-12 col-sm-12 donut-chart buttonlist" style="text-align: left;">
		    <div class="right">
		    	<button type="button" class="btn btn-primary" id="urlMngAddRowBtn1" data-term="L.요청"><i class="fa fa-check"></i> </button>
		    </div>
		</div>
	</div> -->
        <form name="bbsWriteForm" id="bbsWriteForm" method="post">
            <div id="bbsWriteForm2" data-opener-data="<c:out value='${param.openerData}'/>">
                <!-- <input type="hidden" name="bbsTpCd" id="bbsTpCd" value="CMM_BBS_NOTICE"/> -->
                <table class="basic">
                    <colgroup>
                        <col style="width:10%;">
                        <col style="width:20%;">
                        <col style="width:10%;">
                        <col style="width:20%;">
                        <col style="width:10%;">
                        <col style="width:20%;">
                    </colgroup>
                    <tr>
                        <th>작업번호</th>
                        <td>
                            <input type="text" id="labNum" name="labNum" class="form-control" data-col="labNum"
                                   value=""/>
                        </td>
                        <th>요청자</th>
                        <td><%=loginUser.getDspNmKo()%>
                            <input type="hidden" name="labRegNm" id="labRegNm" class="form-control" data-col="labRegNm"
                                   value="<%=loginUser.getDspNmKo()%>" readonly>
                            <input type="hidden" name="labRegLoginId" id="labRegLoginId"
                                   value="<%=loginUser.getLoginId() %>"/>
                            <input type="hidden" name="labUptLoginId" id="labUptLoginId"
                                   value="<%=loginUser.getLoginId() %>"/>
                        </td>
                        <th>등록일</th>
                        <td><%=DateUtil.getCurrentDate()%>
                            <input type="hidden" name="labRegDte" id="labRegDte" class="form-control"
                                   data-col="labRegDte" value="<%=DateUtil.getCurrentDate()%>" readonly>
                        </td>  
                    </tr>
                    <tr>
                        <th><span class="ui_icon required"></span>작업명</th>
                        <td><input type="text" id="labTitle" name="labTitle" class="form-control" data-col="labTitle" value=""/></td>
                        <th><span class="ui_icon required"></span>작업예정일</th>
                        <td><input type="text" id="bbsPopupStDte" name="bbsPopupStDte" class="form-control" data-col="bbsPopupStDte" style="width: 100%;"></td>
                        <th><span class="ui_icon required"></span>작업예정시간</th>
                        <td><input type="time" id="timepick" name="timepick" class="form-control"  data-col="bbsPopupStDte" value=""/></td>
                    </tr>
                    <tr>
                        <th><span class="ui_icon required"></span>작업담당부서</th>
                        <td><select id="labMngDept" name="labMngDept" class="form-control input-sm" data-type="search" ></select></td>
                        <th><span class="ui_icon required"></span>작업구분1</th>
                        <td><select id="labType1" name="labType1" class="form-control input-sm" data-type="search" ></select></td>
                        <th><span class="ui_icon required"></span>작업구분2</th>
                        <td><select id="labType2" name="labType2" class="form-control input-sm" data-type="search" ></select></td>
                    <tr>
                    <tr>
                        <th><span class="ui_icon required"></span>작업층</th>
                        <td><select id="labFloor" name="labFloor" class="form-control input-sm" data-type="search" ></select></td>
                        <th><span class="ui_icon required"></span>설비명</th>
                        <td><select id="labSulbi" name="labSulbi" class="form-control input-sm" data-type="search" ></select></td>
                        <th><span class="ui_icon required"></span>챔버</th>
                        <td><select id="labChamber" name="labChamber" class="form-control input-sm" data-type="search" ></select></td>
                    <tr>
                        <th><span class="ui_icon required"></span>주요 작업 내용</th>
                        <td colspan="5"><%=HtmlUtil.getHtmlEditor(request, true, "bbsContent", "bbsContent", "", "data-col=\"bbsContent\"", "100%", "", "Default") %></td>
                    </tr>
                    <tr>
                        <th>작업 중 주의 사항<br>조립 요청 사항</th>
                        <td colspan="5"><%=HtmlUtil.getHtmlEditor(request, true, "bbsContent1", "bbsContent1", "", "data-col=\"bbsContent1\"", "100%", "", "Default") %></td>
                    </tr>
                    <tr>
                        <th>작업 시 요청 측정 Data<br>사진 촬영 요청 부위</th>
                        <td colspan="5"><%=HtmlUtil.getHtmlEditor(request, true, "bbsContent2", "bbsContent2", "", "data-col=\"bbsContent2\"", "100%", "", "Default") %></td>
                    </tr>
                    <tr>
                        <th>안전 관련 주의 사항</th>
                        <td colspan="5"><%=HtmlUtil.getHtmlEditor(request, true, "bbsContent3", "bbsContent3", "", "data-col=\"bbsContent3\"", "100%", "", "Default") %></td>
                    </tr>
                    <tr>
                        <th data-term="L.첨부"></th>
                        <td colspan="5" id="bbsFile" name="bbsFile"></td>
                    </tr>
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
        </form>
    </div>
	<!-- </div> -->
</div>
<script type="text/javascript">

	var WorkLabReg = function () {
	
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
	
					var cbFncInsert = function(){
						window.opener.BBSLIST.doSearch();
						window.close();
					};
					
					var cbFncUpdate = function(){
						window.opener.opener.BBSLIST.doSearch();
						window.opener.close();
						window.close();
					};
	
					var saveUrl = BBS_INSERT_URL;
					var cbFnc = cbFncInsert;
					
					//UPDATE
					if ($isNew === "FALSE") {
						saveUrl = BBS_UPDATE_URL;
						cbFnc = cbFncUpdate;
					}
	
					paragonCmm.setEditorSubmit("");
					var data = $bbsWriteForm.serializeObject();
	
					data.bbsContent = $bbsWriteForm.find("textarea[name=bbsContent]").val().replace(/\"/gi, "'");
					data.bbsContent1 = $bbsWriteForm.find("textarea[name=bbsContent1]").val().replace(/\"/gi, "'");
					data.bbsContent2 = $bbsWriteForm.find("textarea[name=bbsContent2]").val().replace(/\"/gi, "'");
					data.bbsContent3 = $bbsWriteForm.find("textarea[name=bbsContent3]").val().replace(/\"/gi, "'");
	
					//파일저장이 필요할 땐 submitAjax를 써야한다 (callAjax에는 파일처리가 미포함)
					paragonCmm.submitAjax(saveUrl, data, function (json) {
						if (json.errYn === "E") {
							//오류처리
							alert(json.msg);
							return false;
						}
						cbFnc();
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
	
	
		var getData = function () {
			var data = {};
			paragonCmm.callAjax("/pcf/registerPcf/json", data, function (json) {
				//alert(json.data[0].mcodeNm);
				for(var i = 0; i < json.data.length; i++){
					//alert(json.data[i].mcodeNm);
					$("#labMngDept").append("<option value='"+ json.data[i].mcode +"'>"+ json.data[i].mcodeNm +"</option>");
				}
			});
		}
		
	    var init = function () {
	    	loadForm(); // 양식 로드
			initFormComponent();
			attchmentEvent();
			
			getData();
			
			if ($isNew === "FALSE") {
				loadData();
			}
			
	    };
	
	    return {
	        init: init
	    };
}

$(document).ready(function () {
	
    console.info("[Loading Module: URL관리].....................");

    var workLabReg = new WorkLabReg();
    workLabReg.init();
    
});

</script>

<%-- <script src="<c:url value='/js/module/viself/auth/urlMng.js'/>"></script> --%>
