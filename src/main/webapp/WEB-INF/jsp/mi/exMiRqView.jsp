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

%>

<style>
    .slot {
    	border: 1px solid #444444;
    	width: 250px;
    	height: 25px;
    	font-weight: bold;
    }
    
</style>


<div class="content-panel p-3" id="exMiRqView">
    <h5 class="sub1_title"><i class="fa fa-file-text"></i>예외현황</h5> 
    <div>
        <form name="exMiRqViewForm" id="exMiRqViewForm" method="post">
                <div id="exMiRqViewForm2" data-opener-data="<c:out value='${param.openerData}'/>">
                <input type="hidden" name="bbsUid" id="bbsUid" data-col="bbsUid" value=""/>
                <input type="hidden" name="bbsTpCd" id="bbsTpCd" value="CMM_BBS_NOTICE"/>
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
                        <td colspan="3" data-col="insertDt"></td>
                        <td data-col="slotCnt" style="font-weight: bold;"> </td>
                    </tr>
                    <tr>
                        <th data-term="L.등록자"></th>
                        <td colspan="3" data-col="miRqUserNm"></td>
                        <td rowspan="11">
                        <table style="margin-left:auto; margin-right:auto">
                    			<tr style="">
	                    		<td class="slot" id="wafer_25" style="background-color: #FFFFFF;" >&nbsp; 25 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_24" style="background-color: #FFFFFF;" >&nbsp; 24 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_23" style="background-color: #FFFFFF;" >&nbsp; 23 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_22" style="background-color: #FFFFFF;" >&nbsp; 22 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_21" style="background-color: #FFFFFF;" >&nbsp; 21 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_20" style="background-color: #FFFFFF;" >&nbsp; 20 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_19" style="background-color: #FFFFFF;" >&nbsp; 19 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_18" style="background-color: #FFFFFF;" >&nbsp; 18 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_17" style="background-color: #FFFFFF;" >&nbsp; 17 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_16" style="background-color: #FFFFFF;" >&nbsp; 16 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_15" style="background-color: #FFFFFF;" >&nbsp; 15 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_14" style="background-color: #FFFFFF;" >&nbsp; 14 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_13" style="background-color: #FFFFFF;" >&nbsp; 13 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_12" style="background-color: #FFFFFF;" >&nbsp; 12 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_11" style="background-color: #FFFFFF;" >&nbsp; 11 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_10" style="background-color: #FFFFFF;" >&nbsp; 10 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_9" style="background-color: #FFFFFF;" >&nbsp; 09 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_8" style="background-color: #FFFFFF;" >&nbsp; 08 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_7" style="background-color: #FFFFFF;" >&nbsp; 07 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_6" style="background-color: #FFFFFF;" >&nbsp; 06 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_5" style="background-color: #FFFFFF;" >&nbsp; 05 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_4" style="background-color: #FFFFFF;" >&nbsp; 04 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_3" style="background-color: #FFFFFF;" >&nbsp; 03 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_2" style="background-color: #FFFFFF;" >&nbsp; 02 </td>
	                    		</tr>
	                    		<tr>
		                    	<td class="slot" id="wafer_1" style="background-color: #FFFFFF;" >&nbsp; 01 </td>
	                    		</tr>
	                    		<tr>
                    		</table>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="" data-term="L.제목"></span></th>
                        <td colspan="3" data-col="miRqTitle"></td>
                    </tr>
                    <tr>
                        <th>진행상태</th>
                        <td colspan="3" data-col="statusNm"></td>
                    </tr>
                    <tr>
                        <th>FOUP ID</th>
                        <td colspan="3" data-col="miRqFoupId"></td>
                    </tr>
                    <tr>
                        <th>LOT NAME</th>
                        <td colspan="3" data-col="miRqLot"></td>
                    </tr>
                    <tr>
                        <th>폴더</th>
                        <td colspan="3" data-col="miFolder"></td>
                    </tr>
                    <tr>
                        <th>카세트</th>
                        <td colspan="3" data-col="miCaset"></td>
                    </tr>
                    <tr>
                        <th>RECIPE</th>
                        <td colspan="3" data-col="miRqRecipe"></td>
                    </tr>
                    <tr>
                        <th>선택사항</th>
                        <td>
                        	<select id="miKey" name="item" class="form-control input-sm" style="width:150px" disabled="disabled">
               				</select>
                        </td>
                        <td>
                        	<select id="item" name="item" class="form-control input-sm" style="width:150px" disabled="disabled">
               				</select>
                        </td>
                        <td>
                        	<select id="point" name="point" class="form-control input-sm" style="width:120px" disabled="disabled">
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
                        <td colspan="3" data-col="miRqComment" style="height:300px; vertical-align: top;"></td>
                    </tr>
                </table>
        </form>
    </div>
</div>


<script type="text/javascript">
	
	
     var exMiRqView = function () {

         var openerData = $("#exMiRqViewForm2").data("opener-data");
         console.log("openerData")
         console.log(openerData)
         var exMiRqViewForm = $("#exMiRqViewForm");
         var $bbsUid = openerData.bbsUid
         var miRqKey = openerData.miRqKey;
         var $openType = openerData.openType;
         var $bbsRegLoginId;
         var $bbsLoginId = $("#bbsRegLoginId").val()

         if ($openType == "MAIN") {
             $("#checkDiv").show();
         } else {
             $("#checkDiv").hide();
         }

         var loadData = function (jsonData) {

             var data = $.extend({}, openerData, jsonData);
             console.log("data..")
             console.log(data)
             //$("#miRqView").find("input[name=miRqKey]").html(data.bbsUid);
             
/*          	$.ajax({
            	url: "/lab/mi/controller/miMng/miRqView/json"
              , type: "POST"
              , data: JSON.stringify ({"miRqKey" : miRqKey})
              , dataType: "json"
              , contentType: "application/json"
    	      , success : function(data) {
    	    	  //var obj = data.data;
    	    	  //var len = obj.length;
    	    	  
    	    	  console.log(data);
    	    	  
    	      }
    		, error : function(status) {
    			alert(status + " error");
    		      }
            }); */
             
             
             paragonCmm.callAjax("/mi/exMiRqViewList/json", data, function (json) {
                 if (typeof json === "object") {
                     //-- 마스터
                     var master = json.data[0];
                     console.log("master..")
                     console.log(master)
                     
                     master.slotCnt = "선택매수 : " + master.slotCnt;

                     $.each(master, function (key, val) {
                         $("[data-col='" + key + "']", "#exMiRqView").html(val);
                     });
                     
                     $('#miKey').append($('<option>', {
               		    value: master.miKey,
               		    text: master.miKey
               		}));
                     
                     $('#item').append($('<option>', {
               		    value: master.miRqG,
               		    text: master.miRqG
               		}));
                     
                     $('#point').append($('<option>', {
               		    value: master.miRqPoint,
               		    text: master.miRqPoint
               		}));
                     
                    <%--  $bbsRegLoginId = master["bbsRegLoginId"]
                     $("#miRqView").find("#bbsRegLoginId").val($bbsRegLoginId)
                     if ($bbsRegLoginId == "<%=loginUser.getLoginId()%>" || <%=loginUser.isUserAuth("CMM_SYS") %> || <%=loginUser.isUserAuth("IMS_CHR")%>) {
                         $("#buttonDiv").show();
                     } else {
                         $("#buttonDiv").hide();
                     } --%>

                     fn_slotList(master.miRqKey);
                 }
             });
             
         }
         
         function fn_slotList(val) {
        	 $.ajax({
        		 url: "/mi/slotList/json"
        		 , type: "POST"
                 , data: JSON.stringify ({"miRqKey" : val})
                 , dataType: "json"
                 , contentType: "application/json"
          	     , success : function(data) {
          	    	 var obj = data.data;
          	    	 var len = obj.length;
          	    	 
          	    	 //console.log(obj);
          	    	 
          	    	 if(len!=0) {
          	    		 for(var i=0; i<len; i++) {
          	    			 var slotNum = obj[i].miRqSlotNo;
          	    			 var slot = document.getElementsByClassName('slot');
          	    			 slotNum = 25 - slotNum;
							
          	    			 slot[slotNum].style.backgroundColor = '#FAF4C0';
          	    		 }
          	    	 }
          	     }
          		, error : function(status) {
          			alert(status + " error");
          		      }
                  });
         }

         var doModify = function (openerData) {
             var imsiForm = $("<form method='POST'>").attr("action", "/mi/exMiRq.popup");
             //imsiForm.append($("<input type='hidden' name='bbsUid'>").val(openerData.bbsUid));
             imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
             imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
             paragonCmm.openWindow("", "900", "1200", "POPUP_WRITE", "yes", "yes", "");
             imsiForm.attr("target", "POPUP_WRITE");
             imsiForm.appendTo("body");
             imsiForm.submit();
             imsiForm.remove();

         };

         var doDelete = function (openerData) {
             var data = {};
             data.bbsUid = openerData.bbsUid

             paragonCmm.callAjax("/paragon/bbs/bbsMas/delete/json", data, function (json) {
                 alert("처리되었습니다.");
                 window.opener.BBSLIST.doSearch();
             });
             window.close();
         };
         var attchmentEvent = function () {
             //수정
             $("#btnModify").on("click", function () {
                 confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.수정"), function (r) {
                     if (r) {
                         doModify(openerData);
                         //window.close();
                     }
                 })
             });
             //삭제
             $("#btnDelete").on("click", function () {
                 confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.삭제"), function (r) {
                     if (r) {
                         doDelete(openerData);
                     }
                 })
             });

             //오늘 창닫기
             if ($("#showCheck").prop("checked")) {
                 paragonCmm.setCookie(seq, "ok", 1);
                 window.close();
             }
         }
         //-- 첨부파일 Form 로드
         var loadForm = function () {

             var options = {}

             options.relUid = $bbsUid;        //-- 관례 키 UID
             options.fileTpCd = "CMM/BBS";    //-- 파일 유형 코드
             options.defaultRelUid = "";        //-- 기본 로드 첨부파일(수정시)
             htmlUtils.loadFileView("bbsFile", options);    //-- 첨부파일 로드

         }
         var init = function () {
             attchmentEvent();
             loadForm();
             loadData();                    //-- 초기 데이터 및 설정
         }
         return {
             init: init
         }
     }

     var exMiRqView = new exMiRqView();
    $(function () {
    	exMiRqView.init();
    })
    
</script>