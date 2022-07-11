<%@page import="com.vertexid.spring.utils.SessionUtils" %>
<%@page import="com.vertexid.commons.utils.DateUtil" %>
<%@page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@page import="com.vertexid.commons.utils.StringUtil" %>
<%@page import="com.vertexid.commons.utils.HtmlUtil" %>
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


<div class="content-panel p-3" id="miRqView">
    <h5 class="sub1_title"><i class="fa fa-file-text"></i>의뢰현황</h5> 
    <div>
        <form name="miRqViewForm" id="miRqViewForm" method="post">
       		<div class="conButtonlist">
        		<div style="float: right;" style="display:none;" id="buttonDiv">
        			<input type="hidden" id="userId" value="<%=loginUser.getLoginId()%>">
        			<button type="button" class="btn btn-primary" id="Button1" data-term="의뢰반려" disabled="disabled" ><i class="fa fa-check"></i></button>
					<button type="button" class="btn btn-primary" id="Button3" data-term="실물접수" disabled="disabled" ><i class="fa fa-check"></i></button>
					<button type="button" class="btn btn-primary" id="Button9" data-term="순서변경" disabled="disabled" ><i class="fa fa-check"></i></button>
					<button type="button" class="btn btn-primary" id="Button4" data-term="계측시작" disabled="disabled" ><i class="fa fa-check"></i></button>
					<button type="button" class="btn btn-primary" id="Button5" data-term="HOLD" disabled="disabled" ><i class="fa fa-check"></i></button>
					<button type="button" class="btn btn-primary" id="Button6" data-term="계측종료" disabled="disabled" ><i class="fa fa-check"></i></button>
				</div>
			</div>
                <div id="miRqViewForm2" data-opener-data="<c:out value='${param.openerData}'/>">
                <input type="hidden" name="miRqKey" id="miRqKey" value=""/>
                <input type="hidden" name="miRegId" id="miRegId" data-col="insertId" value=""/>
                <input type="hidden" name="reason" id="reason" value=""/>
                <input type="hidden" name="comment" id="comment" value=""/>
                <input type="hidden" name="status" id="status" value=""/>
                <input type="hidden" name="subun" id="subun" value=""/>
                <input type="hidden" name="miRqSubun" id="miRqSubun" value=""/>
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
                        <td colspan="3" data-col="miRqUser"></td>
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
                <div class="buttonlist">
					<div style="float: right;">
<!-- 						<button type="button" class="ui_btn medium icon" id="reqCancle" disabled="disabled" ><i class="fa fa-minus"></i>의뢰취소</button>
						<button type="button" class="ui_btn medium icon" id="reqDelete" disabled="disabled" ><i class="fa fa-minus"></i>삭제</button> -->
						<button type="button" class="btn btn-primary" id="reqCancle" style="padding: 3px 5px; background-color: #333; border-color: #333" disabled="disabled"> <i class="fa fa-minus"></i>의뢰취소</button>
						<button type="button" class="btn btn-primary" id="reqDelete" style="padding: 3px 5px; background-color: #333; border-color: #333" disabled="disabled"> <i class="fa fa-minus"></i>삭제</button>
						<!-- <button type="button" class="btn btn-primary" id="btnEmpSave" data-term="목룍"><i class="fa fa-check"></i></button> -->
					</div>
				</div>
        </form>
    </div>
</div>


<script type="text/javascript">
	
	
	function fn_pop(val) {
		
		if(val=="reject")
			fn_reject();
		
		if(val=="hold")
			fn_hold();
		
		if(val=="change")
			fn_change();
	}
	
     //var miRqView = function () {}
     
     

         var openerData = $("#miRqViewForm2").data("opener-data");
         console.log("openerData")
         console.log(openerData)
         var miRqViewForm = $("#miRqViewForm");
         //var $bbsUid = openerData.bbsUid
         var miRqKey = openerData.miRqKey;
         var $openType = openerData.openType;
         var $bbsRegLoginId;
         var $bbsLoginId = $("#bbsRegLoginId").val();
         
         var comment = "";
         var status = "";
         var userid = "<%=loginUser.getLoginId()%>";
         
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
             
             
             
             paragonCmm.callAjax("/mi/miRqViewList/json", data, function (json) {
                 if (typeof json === "object") {
                     //-- 마스터
                     var master = json.data[0];
                     console.log("master..")
                     console.log(master)
                     
                     //작성자 본인+의뢰취소 상태가 아닌 경우에만 의뢰취소, 삭제 가능하도록
                     var regId = master.insertId;
                     var reqStatus = master.miRqStatus;
                     
                     if(regId == "<%=loginUser.getLoginId()%>" && reqStatus!=('0')) {
                    	 document.getElementById('reqCancle').disabled = false;
                    	 document.getElementById('reqDelete').disabled = false;
                     }
                     
                     // 연구소 관리자인 경우 삭제 가능
                     if('PCF_MNG' == "<%=loginUser.getAuthCd()%>") {
                    	 document.getElementById('reqDelete').disabled = false;
                     }
                     
                     master.slotCnt = "선택매수 : " + master.slotCnt;
                     $('input[name=miRqKey]').attr('value',master.miRqKey);

                     $.each(master, function (key, val) {
                         $("[data-col='" + key + "']", "#miRqView").html(val);
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
                     
                     var status = master.miRqStatus;
                     var subun = master.miRqSubun;
                     
                     $('#status').val(status);
                     $('#subun').val(subun);
                     
                     if(status==1) { // 계측의뢰
                    	document.getElementById('Button1').disabled = false;
                    	document.getElementById('Button3').disabled = false;
                     }
                     
                     if(status==4) { // 실물접수
                    	document.getElementById('Button1').disabled = false;
                    	document.getElementById('Button9').disabled = false;
                    	document.getElementById('Button4').disabled = false;
                    	document.getElementById('Button5').disabled = false;
                     }
                     
                     if(status==5) { // 계측시작
                    	document.getElementById('Button5').disabled = false;
                    	document.getElementById('Button6').disabled = false;
                     }
                     
                     if(status==6) { // HOLD
                    	document.getElementById('Button4').disabled = false;
                     }
                     
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
             var imsiForm = $("<form method='POST'>").attr("action", "/mi/miRq.popup");
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
             //data.bbsUid = openerData.bbsUid

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
             $("#reqDelete").on("click", function () {
                 confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.삭제"), function (r) {
                     if (r) {
                    	 fn_delete(miRqKey, userid);
                         //doDelete(openerData);
                     }
                 })
             });
             //의뢰취소
             $("#reqCancle").on("click", function () {
                 confirm("의뢰를 취소하시겠습니까?", function (r) {
                     if (r) {
                    	 fn_cancle(miRqKey);
                         //doDelete(openerData);
                     }
                 })
             });
             
             
             //의뢰반려 > 사유입력
             $("#Button1").on("click", function () {
            	 var reason = document.getElementById("reason");
            	 reason.value = "reject";
            	 
            	 window.open('/mi/reasonpop','pop','width=500, height=300');
/*                  confirm("요청을 반려하시겠습니까?", function (r) {
                     if (r) {
                    	 fn_reject();
                         //doDelete(openerData);
                     }
                 }) */
             });
             
             //실물접수
             $("#Button3").on("click", function () {
            	 fn_receipt();
             });
             
             //순서변경 > 사유입력
             $("#Button9").on("click", function () {
            	 var reason = document.getElementById("reason");
            	 reason.value = "change";
            	 
            	 window.open('/mi/reasonpop','pop','width=500, height=300');
             });
             
             //계측시작
             $("#Button4").on("click", function () {
            	 fn_start();
              /*   confirm("계측을 시작하겠습니까?", function (r) {
                     if (r) {
                    	 fn_start();
                         //doDelete(openerData);
                     }
                 })	*/
             });
             
             //HOLD > 사유입력
             $("#Button5").on("click", function () {
            	 var reason = document.getElementById("reason");
            	 reason.value = "hold";
            	 
            	 window.open('/mi/reasonpop','pop','width=500, height=300');
            	 
            	 /*     confirm("HOLD 하시겠습니까?", function (r) {
                     if (r) {
                    	 fn_hold();
                         //doDelete(openerData);
                     }
                 })*/
             });
             
             //계측종료
             $("#Button6").on("click", function () {
                 confirm("계측을 종료하시겠습니까?", function (r) {
                     if (r) {
                    	 fn_end();
                         //doDelete(openerData);
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

             //options.relUid = $bbsUid;        //-- 관례 키 UID
             options.fileTpCd = "CMM/BBS";    //-- 파일 유형 코드
             options.defaultRelUid = "";        //-- 기본 로드 첨부파일(수정시)
             htmlUtils.loadFileView("bbsFile", options);    //-- 첨부파일 로드

         }
         var init = function () {
             attchmentEvent();
             loadForm();
             loadData();                    //-- 초기 데이터 및 설정
         }
     
         function fn_cancle(key) {	//의뢰취소
        	 $.ajax({
        		 url: "/mi/miRqCancle/json"
            		 , type: "POST"
                     , data: JSON.stringify ({"miRqKey" : miRqKey})
                     , dataType: "json"
                     , contentType: "application/json"
              	     , success : function(data) {
              	    	 alert("의뢰가 취소되었습니다.");
              	    	 window.open('','_self').close(); 
              	    	 window.opener.RqList.doSearch();
              	     }
              		, error : function(status) {
              			alert(status + " error");
              		      }
                      });
         }
         
         
         function fn_delete(key, id) { //삭제
    	    	 $.ajax({
    	    		 url: "/mi/miRqDelete/json"
    	        		 , type: "POST"
    	                 , data: JSON.stringify ({"miRqKey" : key, "delId" : id})
    	                 , dataType: "json"
    	                 , contentType: "application/json"
    	          	     , success : function(data) {
    	          	    	 alert("삭제되었습니다.");
    	          	    	 window.open('','_self').close(); 
    	          	    	 window.opener.RqList.doSearch();
    	          	     }
    	          		, error : function(status) {
    	          			alert(status + " error");
    	          		      }
    	                  });
         }    
         
         
         function fn_reject() {	//의뢰반려
        	 comment = $('#comment').val();
        	 status = $('#status').val();
        	 $.ajax({
        		 url: "/mi/miRqReject/json"
        		 , type: "POST"
            	 , async: false
                 , data: JSON.stringify ({"miRqKey" : miRqKey, "comment" : comment, "userid" : userid, "status" : status})
                 , dataType: "json"
                 , contentType: "application/json"
          	     , success : function(data) {
          	    	 alert("요청을 반려하였습니다.");
          	    	 window.open('','_self').close(); 
          	    	 window.opener.RqList.doSearch();
          	     }
          		, error : function(status) {
          			alert(status + " error");
          		      }
                  });
        	 
         }
         
         function fn_receipt(){	//실물접수
        	 var miRqG = $("#item").val();
        	 $.ajax({
        		 url: "/mi/miRqReceipt/json"
        		 , type: "POST"
            	 , async: false
                 , data: JSON.stringify ({"miRqKey" : miRqKey, "miRqG" : miRqG, "userid" : userid})
                 , dataType: "json"
                 , contentType: "application/json"
          	     , success : function(data) {
          	    	 alert("실물을 접수하였습니다.");
          	    	 window.open('','_self').close(); 
          	    	 window.opener.RqList.doSearch();
          	     }
          		, error : function(status) {
          			alert(status + " error");
          		      }
                  });

         }
         
         function fn_change(){	//순서변경
        	 var miRqSubun = $("#miRqSubun").val();
        	 var nowSubun = $("#subun").val();

        	 $.ajax({
        		 url: "/mi/miRqChagne/json"
        		 , type: "POST"
        		 , async: false
                 , data: JSON.stringify ({"miRqKey" : miRqKey, "nowSubun" : nowSubun, "miRqSubun" : miRqSubun})
                 , dataType: "json"
                 , contentType: "application/json"
          	     , success : function(data) {
          	    	 alert("순번을 변경하였습니다.");
          	    	 window.open('','_self').close(); 
          	    	 window.opener.RqList.doSearch();
          	     }
          		, error : function(status) {
          			alert(status + " error");
          		      }
                  });
         }
         
         function fn_start(){	//계측시작
        	 status = $('#status').val();
         
        	 $.ajax({
        		 url: "/mi/miRqStrat/json"
        		 , type: "POST"
        		 , async: false
                 , data: JSON.stringify ({"miRqKey" : miRqKey, "userid" : userid, "status" : status})
                 , dataType: "json"
                 , contentType: "application/json"
          	     , success : function(data) {
          	    	 alert("계측을 시작하였습니다.");
          	    	 window.open('','_self').close(); 
          	    	 window.opener.RqList.doSearch();
          	     }
          		, error : function(status) {
          			alert(status + " error");
          		      }
                  });
         
         }
         
         function fn_hold(){	// hold
        	 comment = $('#comment').val();
        	 $.ajax({
        		 url: "/mi/miRqHold/json"
        		 , type: "POST"
                 , data: JSON.stringify ({"miRqKey" : miRqKey, "comment" : comment, "userid" : userid})
                 , dataType: "json"
                 , contentType: "application/json"
          	     , success : function(data) {
          	    	 alert("중단하였습니다.");
          	    	 window.open('','_self').close(); 
          	    	 window.opener.RqList.doSearch();
          	     }
          		, error : function(status) {
          			alert(status + " error");
          		      }
                  });
        	 
         }
         
         function fn_end(){	// 계측종료
        	 $.ajax({
        		 url: "/mi/miRqEnd/json"
        		 , type: "POST"
                 , data: JSON.stringify ({"miRqKey" : miRqKey, "userid" : userid})
                 , dataType: "json"
                 , contentType: "application/json"
          	     , success : function(data) {
          	    	 alert("계측을 종료하였습니다.");
          	    	 window.open('','_self').close(); 
          	    	 window.opener.RqList.doSearch();
          	     }
          		, error : function(status) {
          			alert(status + " error");
          		      }
                  });
        	 
         }
     
     
     

     //var miRqView = new miRqView();
    $(function () {
		// 연구소 관리자가 아니면 작업처리 버튼 안보이게
         if ('PCF_MNG' == "<%=loginUser.getAuthCd()%>") {
        	 $("#buttonDiv").show();
         } else {
        	 $("#buttonDiv").hide();
         }

     	init();
		
    })

    
</script>