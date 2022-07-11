<%--
  - Author(s): Dana kim
  - Date: 2022-06-03
  -
  - Copyright (c) 2021 Vertex ID., KOREA
  - All rights reserved.
  -
  - This software is the confidential
  - and proprietary information of emFrontier.com ("Confidential Information").
  - You shall not disclose such Confidential Information
  - and shall use it only in accordance with
  - the terms of the license agreement you entered into
  - with Vertex ID. Networks
  -
  - @(#)
  - Description:
  -      계측기예약 > 홈
  --%>
<%@page import="com.vertexid.spring.utils.SessionUtils" %>  
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<%
    SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
%>
<script type="text/javascript">
	$( document ).ready( function() {
	   $( '.bxliider' ).bxSlider();

		//수정완료 버튼 숨기기
		$("#editok").hide();
		
		//사용자 관리자 권한 확인하고 수정 버튼 숨기기
		if('PCF_MNG' != "<%=loginUser.getAuthCd()%>") {
			$("#edit").hide();
		}
		   
	   //의뢰현황차트
 		$.ajax({
            url: "/mi/requestList/json"
            , type: "POST"
            , dataType: "json"
            , contentType: "application/json"
			, success : function(data) {
				var obj = data.data;
				var len = obj.length;
				
				//console.log(obj[0].miKey);
				
				var miKey = "";
				var val1 = "";
				var val3 = "";
				var val4 = "";
				var val5 = "";
				var val6 = "";
				
				var trTxt = "";
				var tdTxt = "";
				
				for(var i=0; i<len; i++) {
					miKey = obj[i].miKey;
					val1 = obj[i].val1;
					val3 = obj[i].val3;
					val4 = obj[i].val4;
					val5 = obj[i].val5;
					val6 = obj[i].val6;
					
					trTxt = '<tr id="requestListTxt'+i+'" style="height: 42px;">';
					
					tdTxt = '<td style="width: 17%; text-align: center; height: 40px; color:black; font-weight: bold;">'+miKey+'</td>';
					miKey = "'"+miKey+"'";
/* 					tdTxt += '<td style="width: 16%; text-align: center; height: 40px; color:black; font-weight: bold;"><a onclick="fn_viewList('+miKey+', 1) style="color:Black;">'+val1+'</a></td>'; */
					tdTxt += '<td style="width: 16%; text-align: center; height: 40px; color:black; font-weight: bold;"><a href="mi/miRqList?miKey='+miKey+'&status=1" style="color:Black;">'+val1+'</a></td>';
					tdTxt += '<td style="width: 16%; text-align: center; height: 40px; color:black; font-weight: bold;"><a onclick="fn_viewList('+miKey+', 4)" style="color:Black;">'+val3+'</a></td>';
					tdTxt += '<td style="width: 16%; text-align: center; height: 40px; color:black; font-weight: bold;"><a onclick="fn_viewList('+miKey+', 5)" style="color:Black;">'+val4+'</a></td>';
					tdTxt += '<td style="width: 16%; text-align: center; height: 40px; color:black; font-weight: bold;"><a onclick="fn_viewList('+miKey+', 6)" style="color:Black;">'+val5+'</a></td>';
					tdTxt += '<td style="width: 16%; text-align: center; height: 40px; color:black; font-weight: bold;"><a onclick="fn_viewList('+miKey+', 7)" style="color:Black;">'+val6+'</a></td>';
					
					$("#requestListTb>tbody").append(trTxt + tdTxt + '</tr>');
					
				}
				
				
				//MI_KEY : 계측기
				//VAL1 : 계측의뢰
				//VAL2 : 의뢰접수 (사용X)
				//VAL3 : 실물접수
				//VAL4 : 계측시작
				//VAL5 : hold
				//VAL6 : 계측종료
				
				//$("#requestList").text("작성일자 : " + insertDt + "\n" + txt);
				
			}
			, error : function(status) {
				alert(status + " error");
			}
		}); 
		   
		   //주요안내
			$.ajax({
	            url: "/mi/noticeList/json"
	            , type: "POST"
	            , dataType: "json"
	            , contentType: "application/json"
				, success : function(data) {
					var obj = data.data[0];
					var insertDt = obj.insertDt;
					var txt = obj.content;
					
					//console.log(obj);
					
					$("#noticeList").text("작성일자 : " + insertDt + "\n" + txt);
					
				}
				, error : function(status) {
					alert(status + " error");
				}
			});
		
		
	  });
	
	function fn_viewList(miKey, status) {
		location.href="/mi/miRqList?miKey='"+miKey+"'&status='"+status+"'";
		
/*         $.ajax({
        	url: "/mi/miRqList"
          , type: "GET"
          , dataType: "json"
          , data : JSON.stringify({"miKey" : miKey})
          , contentType: "application/json"
	      , success : function(data) {
	      	
	    	  location.href="/mi/miRqList";
	    	  
	      }
		, error : function(status) {
			console.log(status);
			alert(status + " error");
		      }
        }); */
	}
	
	function fn_edit() {
		$("#editok").show();
		$("#edit").hide();
		
		// 내용 수정 가능하게
		$("#noticeList").attr("readonly", false);
	}
	
	function fn_editok() {
		//수정 내용 저장 로직 추가
		$("#editok").hide();
		$("#edit").show();

		// 내용 수정 불가하게
		$("#noticeList").attr("readonly", true);
	}

	
</script>

<div class="row mt">
    <h5 class="sub1_title" data-term="L.MI_MAIN"><i class="fa fa-file-text"></i> </h5>
</div>
<div>
    <div class="col-md-6 col-sm-6" id="moduleMngLayer1">
        <h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i>의뢰현황</h6>
        <table id="requestListTb" style="border-collapse: collapse; width: 100%; height: 40px;" border="1">
			<tr id="requestListHeader" style="height: 42px;">
				<td style="width: 17%; text-align: center; height: 40px; color:white; font-weight: bold; background-color: #353535">계측기</td>
				<td style="width: 16%; text-align: center; height: 40px; color:white; font-weight: bold; background-color: #353535">계측의뢰</td>
				<td style="width: 16%; text-align: center; height: 40px; color:white; font-weight: bold; background-color: #353535">실물접수</td>
				<td style="width: 16%; text-align: center; height: 40px; color:white; font-weight: bold; background-color: #353535">계측시작</td>
				<td style="width: 16%; text-align: center; height: 40px; color:white; font-weight: bold; background-color: #353535">HOLD</td>
				<td style="width: 16%; text-align: center; height: 40px; color:white; font-weight: bold; background-color: #353535">계측종료</td>
			</tr>
		</table>
        <div id="requestList"></div>
        <form id="ContentPlaceHolder1_Form1" name="ContentPlaceHolder1_Form1" class="p-1">
                <div id="ContentPlaceHolder1_Grid1"></div>
        </form>
        <br>
        <h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i>주요안내</h6>
        <textarea id="noticeList" readonly style="width:100%; height:130px; font-weight:bold;"></textarea>
        <button id="edit" onclick="fn_edit()">수정</button>
        <button id="editok" onclick="fn_editok()">수정완료</button>
    </div>
    <div class="col-md-6 col-sm-6" id="moduleMngLayer2">
        <h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 계측기 </h6>
        <div style="width:100%;height:200px;">
	        <ul class="bxliider">
	             <li><img src="../img/EQUIMENT/RS-100.jpg" title="one" width="555"/></li>
	             <li><img src="../img/EQUIMENT/Wet Station.jpg" title="tow" width="555"/></li>
	             <li><img src="../img/EQUIMENT/XRF.jpg" width="555"/></li>
	        </ul>
	    </div>
    </div>
</div>