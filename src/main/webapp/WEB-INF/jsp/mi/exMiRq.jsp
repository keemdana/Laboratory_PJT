<%@page import="com.vertexid.spring.utils.SessionUtils" %>
<%@page import="com.vertexid.commons.utils.DateUtil" %>
<%@page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@page import="com.vertexid.commons.utils.StringUtil" %>
<%@page import="com.vertexid.commons.utils.HtmlUtil" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
    String siteLocale = loginUser.getSiteLocale();

    String schFieldCodestr = "Y|사용^N|미사용";
%>

<style>
    .slot {
    	border: 1px solid #444444;
    	width: 250px;
    	height: 25px;
    	font-weight: bold;
    }
    
</style>


<div class="content-panel p-3" id="exMiRqWrite">
    <h5 class="sub1_title"><i class="fa fa-file-text"></i>예외측정</h5> ( <span
        class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
    <div>
        <form name="exMiRqWriteForm" id="exMiRqWriteForm" method="post">
                <div id="exMiRqWriteForm2" data-opener-data="<c:out value='${param.openerData}'/>">
                <table class="basic">
                    <colgroup>
                        <col style="width:10%;">
                        <col style="width:20%;">
                        <col style="width:20%;">
                        <col style="width:20%;">
                        <col style="width:30%;">
                    </colgroup>
                    <tr>
                        <th data-term="L.등록일"></th>
                        <td colspan="3"><%=DateUtil.getCurrentDate()%>
                            <input type="hidden" name="in_date" id="in_date" class="form-control"
                                   data-col="in_date" value="<%=DateUtil.getCurrentDate()%>" readonly>
                        </td>
                        <td><b>슬롯선택 (<input type="text" value="0" id="selectSlot" name="selectSlot" readonly style="border:none; width: 30px; text-align: center;"> /<input type="text" value="0" id="maxSlot" name="maxSlot" readonly style="border:none; width: 30px; text-align: center;"> ) </b> 
                        </td>
                    </tr>
                    <tr>
                        <th data-term="L.등록자"></th>
                        <td colspan="3"><%=loginUser.getDspNmKo()%>
                            <input type="hidden" name="miRegNm" id="miRegNm" class="form-control" data-col="miRegNm"
                                   value="<%=loginUser.getDspNmKo()%>" readonly>
                            <input type="hidden" name="miRegLoginId" id="miRegLoginId"
                                   value="<%=loginUser.getLoginId() %>"/>
                            <input type="hidden" name="miUptLoginId" id="miUptLoginId"
                                   value="<%=loginUser.getLoginId() %>"/>
                        </td>
                        <td rowspan="10">
                        <table style="margin-left:auto; margin-right:auto">
                    			<tr style="">
	                    		<td class="slot" id="wafer_25" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 25 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_24" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 24 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_23" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 23 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_22" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 22 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_21" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 21 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_20" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 20 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_19" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 19 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_18" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 18 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_17" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 17 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_16" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 16 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_15" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 15 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_14" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 14 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_13" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 13 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_12" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 12 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_11" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 11 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_10" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 10 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_9" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 09 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_8" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 08 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_7" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 07 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_6" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 06 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_5" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 05 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_4" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 04 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_3" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 03 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_2" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 02 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_1" style="background-color: #FFFFFF;" onclick="fn_slotSelect(this)">&nbsp; 01 </td>
	                    		</tr>
	                    		<tr>
                    		</table>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="ui_icon required" data-term="L.제목"></span></th>
                        <td colspan="3">
                            <input type="text" id="title" name="title" class="form-control" data-col="title" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th>FOUP ID</th>
                        <td colspan="3">
                           <input type="text" id="foupId" name="foupId" class="form-control" data-col="foupId" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th>LOT NAME</th>
                        <td colspan="3">
                           <input type="text" id="lotNm" name="lotNm" class="form-control" data-col="lotNm" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th>폴더</th>
                        <td colspan="3">
                           <input type="text" id="folder" name="folder" class="form-control" data-col="folder" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th>카세트</th>
                        <td colspan="3">
                           <input type="text" id="caset" name="caset" class="form-control" data-col="caset" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th>RECIPE</th>
                        <td colspan="3">
                           <input type="text" id="recipe" name="recipe" class="form-control" data-col="recipe" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th>선택사항</th>
                        <td>
                        	<select id="miKey" name="miKey" class="form-control input-sm" style="width:120px" onchange="fn_itemSelect()">
               				</select>
                        </td>
                        <td>
                        	<select id="item" name="item" class="form-control input-sm" style="width:150px" onchange="fn_pointSelect()">
               				</select>
                        </td>
                        <td>
                        	<select id="point" name="point" class="form-control input-sm" style="width:120px" onchange="fn_maxSlot()">
               				</select>
                        </td>
                    </tr>
<!--                     <tr>
                        <th>슬롯</th>
                        <td>최대선택매수 : <input type="text" id ="eainfo" name="eainfo" readonly></input>
                        <td> 선택슬롯 : 
                        </td>
                        <td>선택매수 : <input type="text" id ="slotea" name="slotea" readonly></input></td>
                    </tr> -->
                    <tr>
                        <th>의뢰내용</th>
                        <td colspan="3"><%=HtmlUtil.getHtmlEditor(request, true, "comment", "comment", "", "data-col=\"comment\"",
                                "100%", "", "Default") %>
                        </td>
                    </tr>
                </table>
                
                <div class="buttonlist">
                    <div class="right">
                        <span class="ui_btn medium icon" id="btnSave" name="btnSave"><i class="fa fa-save"><a href="javascript:void(0)">예외측정</a></i></span>
                    </div>
                </div>
        </form>
    </div>
</div>


<script type="text/javascript">

    function BbsWrite() {
        var openerData = $("#exMiRqWriteForm2").data("opener-data");
        console.log(openerData);
       // $("#bbsUid").val(openerData.bbsUid);
       // var BBS_SELECT_ONE_URL = "/paragon/bbs/bbsMas/bbsMasView/json"; //수정모드 조회용
       // var BBS_INSERT_URL = "/paragon/bbs/bbsMas/insert/json";     //신규 등록
       // var BBS_UPDATE_URL = "/paragon/bbs/bbsMas/update/json";        //수정

        //var $bbsUid = openerData.bbsUid;
        var $isNew = openerData.isNew;
        var $exMiRqWriteForm = $("#exMiRqWriteForm");
        //var $bbsUid = $("#bbsUid");
        var $bbsPopupStDte = $("#bbsPopupStDte");
        var $bbsPopupEdDte = $("#bbsPopupEdDte");
        var $saveBtn = $("#btnSave");


        var doValidation = function () {    //-- 저장 필수체크
            if ($("input:text[name='bbsTit']", $exMiRqWriteForm).val() == "") {
                alert("제목을 입력해주세요.", function () {
                    $("input:text[name='bbsTit']", $exMiRqWriteForm).focus();
                });
                return false;
            }
            //상신일자, 결재일자 검색조건 시작일 > 결재일일 경우 알림
            var popupFromDate = $bbsPopupStDte.val();
            var popupToDate = $bbsPopupEdDte.val();

            if (popupFromDate > popupToDate) {
                alert("팝업종료일이 시작일보다 빠릅니다. <P> 팝업기간을 올바르게 입력해주세요.");
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
                    var data = $exMiRqWriteForm.serializeObject();

                    // console.log(data);

                    // HACK
                    // CKEditor 에서 작성한 것을 serializeObject() 할경우
                    // String 변환하기 때문에 alt="" -> alt=\"\" 형태로 변경
                    // 해서 직접값을 받아서 다시 설정함
                    data.bbsContent = $exMiRqWriteForm.find("textarea[name=bbsContent]").val().replace(/\"/gi, "'");

                    // console.log($miRqWriteForm.find("textarea[name=bbsContent]").val());
                    //
                    // console.log(data.bbsContent);
                    // console.log(data);

                    // paragonCmm.submitAjax(saveUrl, JSON.stringify(data), function (json) {
                    //callAjax 를 submitAjax로 변경
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

        var loadData = function (jsonData) {
            var data = $.extend({}, openerData, jsonData);
            paragonCmm.callAjax("/paragon/bbs/bbsMas/bbsMasView/json", data, function (json) {
                if (typeof json === "object") {
                    var master = json.data;
                    $.each(master, function (key, val) {
                        var obj = $("[data-col=" + key + "]", $exMiRqWriteForm);
                        var tagNam = $(obj).prop("tagName");
                        if ("INPUT" == tagNam) {
                            var typeNm = $(obj).attr("type");
                            if ("radio" == typeNm || "checkbox" == typeNm) {
                                $("input[data-col=" + key + "][value='" + val + "']", $exMiRqWriteForm).prop("checked", true);
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
            console.log("options")
            console.log(options)

            try{

            htmlUtils.loadFileHtml(attchId, options);
            }catch (e){
                console.log(e);
            }

        }

        var initFormComponent = function () {
            //날짜컴포넌트 : start date
            $bbsPopupStDte.datebox({});
            //날짜컴포넌트 : end date
            $bbsPopupEdDte.datebox({
                //  validType: ["date"]
            });
        }
        var attchmentEvent = function () {
            $saveBtn.off();
            $saveBtn.on("click", function () {
                doSubmit();
            });
        }

        var init = function () {

            loadForm();                            //-- 양식 로드
            initFormComponent();
            attchmentEvent();
            if ($isNew === "FALSE") {
                loadData();
            }
        }
        return {
            init: init
        }

    }

		var selectSlot = 0;
        
         function fn_initSlot() {
			var slot = document.getElementsByClassName('slot');
			
        	selectSlot = 0;
        	$('input[name=selectSlot]').attr('value',0);
        	$('input[name=maxSlot]').attr('value',0);
        	
        	for(var i=0; i<25; i++) {
        		slot[i].style.backgroundColor = "#FFFFFF";
        	}
        }

    
	    function fn_maxSlot() {	//point에 따른 최대 slot 매수
	    	var point = $("#point option:selected").val();
	        var maxSlot = "0";
	        selectSlot = 0;
	        
	        fn_initSlot();
	    	
	    	if(point == "5PD")
	    		maxSlot = "25";
	    	
	    	if(point == "49PD")
	    		maxSlot = "13";
	    	
	    	if(point == "49PU")
	    		maxSlot = "6";
	    	
	    	if(point == "100PU")
	    		maxSlot = "3";
	    	
	    	if(point == "200PU")
	    		maxSlot = "2";
	    	
	    	$('input[name=maxSlot]').attr('value',maxSlot);
	    }
    
	    
	    function fn_slotSelect(val) {
	    	var backColor = val.style.backgroundColor;
	    	var maxSlot = document.getElementById('maxSlot').value;
	    	
	    	if(backColor == "rgb(255, 255, 255)") {
				
	    		if(maxSlot <= selectSlot) {
		    		alert("최대 선택 매수를 초과하였습니다.");
		    		return;
		    	}
	    		
	    		val.style.backgroundColor = "#FAF4C0";
				selectSlot++;
	    	}
	    	
	    	if(backColor == "rgb(250, 244, 192)") {
				val.style.backgroundColor = "#FFFFFF";
				selectSlot--;
	    	}
	    	
	    	$('input[name=selectSlot]').attr('value',selectSlot);
	    }      
	    
        function fn_itemSelect() {
        	var miKey = document.getElementById('miKey').value;
        	
        	$("select[name='item'] option").not("[value='']").remove();
        	$("select[name='point'] option").not("[value='']").remove();
        	
        	fn_initSlot();
        	
        	$.ajax({
            	url: "/mi/itemList/json"
              , type: "POST"
              , data: JSON.stringify ({"miKey" : miKey})
              , dataType: "json"
              , contentType: "application/json"
    	      , success : function(data) {
    	    	  var obj = data.data;
    	    	  var len = obj.length;
    	      	
    	    	  //console.log(obj);
    	    	  
    	    	  if(len!=0) {
    	    		  for(var i=0; i<len; i++) {
    	    			  $('#item').append($('<option>', {
    			    		    value: obj[i].miCd,
    			    		    text: obj[i].miNm
    			    		}));
    	    		  }
    	    	  }
    	    	  
    	      }
    		, error : function(status) {
    			alert(status + " error");
    		      }
            });
        	
        }

        function fn_pointSelect() {
        	var item = document.getElementById('item').value;
        	
        	$("select[name='point'] option").not("[value='']").remove();
        	
        	fn_initSlot();
        	
        	$.ajax({
            	url: "/mi/pointList/json"
              , type: "POST"
              , data: JSON.stringify ({"item" : item})
              , dataType: "json"
              , contentType: "application/json"
    	      , success : function(data) {
    	    	  var obj = data.data;
    	    	  var len = obj.length;
    	      	
    	    	  //console.log(obj);
    	    	  
    	    	  if(len!=0) {
    	    		  for(var i=0; i<len; i++) {
    	    			  $('#point').append($('<option>', {
    			    		    value: obj[i].miCd,
    			    		    text: obj[i].miNm
    			    		}));
    	    		  }
    	    	  }
    	    	  
    	      }
    		, error : function(status) {
    			alert(status + " error");
    		      }
            });
        }
        
    $(document).ready(function(){
        var exMiRqWrite = new BbsWrite();
        exMiRqWrite.init();
        
		$('#miKey').append($('<option>', {
			value: '',
  		    text: '계측기 선택'
  		}));

		 $('#item').append($('<option>', {
  		    value: '',
  		    text: '의뢰항목 선택'
  		}));

		$('#point').append($('<option>', {
   		    value: '',
   		    text: 'POINT 선택'
   		}));
        
        //계측기 리스트
        $.ajax({
        	url: "/mi/miKeyList/json"
          , type: "POST"
          , dataType: "json"
          , contentType: "application/json"
	      , success : function(data) {
	    	  var obj = data.data;
	    	  var len = obj.length;
	      	
	    	  //console.log(obj);
	    	  
	    	  if(len!=0) {
	    		  for(var i=0; i<len; i++) {
	    			  $('#miKey').append($('<option>', {
			    		    value: obj[i].miCd,
			    		    text: obj[i].miNm
			    		}));
	    		  }
	    	  }
	    	  
	      }
		, error : function(status) {
			alert(status + " error");
		      }
        });
        
    });
</script>