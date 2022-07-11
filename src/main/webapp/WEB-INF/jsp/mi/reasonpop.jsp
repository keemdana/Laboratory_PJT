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
%>
<style>
  textarea {
    width: 100%;
    height: 12em;
    border: none;
    resize: none;
  }
</style>
<div id="changeSubun" style="display: none">
<b>현재순번 :</b> <input type="text" readonly="readonly" id="subun" style="width: 30px;">
<b>변경순번 :</b> <select id="subunList" name="subunList"></select>
</div>
<br>
<div>
	<textarea id="pop_comment" placeholder="사유를 입력해주세요."></textarea>
</div>
<div style="float: center;text-align: center;">
	<button type="button" class="btn btn-primary" id="btn_close" onclick="fn_close()">닫기</button>
	<button type="button" class="btn btn-primary" id="btn_save" onclick="fn_save()" ></button>
</div>

<script type="text/javascript">
	$(function () {
		var reason = opener.document.getElementById('reason').value;
		var subun = opener.document.getElementById('subun').value;
		var miRqKey = opener.document.getElementById('miRqKey').value;
		var btn = document.getElementById('btn_save');
		
		console.log("subun", subun);
		
		if(reason=="reject")
			btn.innerText = "의뢰반려";
		
		if(reason=="hold")
			btn.innerText = "HOLD";
		
		if(reason=="change") {
			btn.innerText = "순서변경";
			$('#subun').val(subun);
			$('#changeSubun').show();
			$('#pop_comment').hide();
			
			$('#subunList').append($('<option>', {
	  		    value: '',
	  		    text: '선택'
	  		}));
			
        	$.ajax({
            	url: "/mi/subunList/json"
              , type: "POST"
              , data: JSON.stringify ({"miRqKey" : miRqKey})
              , dataType: "json"
              , contentType: "application/json"
    	      , success : function(data) {
    	    	  var obj = data.data;
    	    	  var len = obj.length;
    	      	
    	    	 // console.log(obj[2]);
    	    	  
    	    	  if(len!=0) {
    	    		  for(var i=0; i<len; i++) {
    	    			  $('#subunList').append($('<option>', {
    			    		    value: obj[i],
    			    		    text: obj[i]
    			    		}));
    	    		  }
    	    	  }
    	    	  
    	      }
    		, error : function(status) {
    			alert(status + " error");
    		      }
            });
        	
		}
		
	})
	
	function fn_save() {
		var reason = opener.document.getElementById('reason').value;
		
		if(reason=='change') {
			var miRqSubun = $('#subunList > option:selected').val();
			var nowSubun = $('#subun').val();
			
			if (!miRqSubun) {
                alert("변경순번을 선택해주세요.", function () {
                    $("input:text[name='subunList']", $miRqWriteForm).focus();
                });
                return false;
            } else if (miRqSubun == nowSubun){
				alert("현재 순번과 동일합니다.");
				return false;
			} else {
				opener.document.getElementById('miRqSubun').value = miRqSubun;
				opener.fn_pop(reason);
	        	window.close();
			}
		} else {
			// 순번 병경할때는 사유 x
			var comment = $("textarea#pop_comment").val();
			
			if(comment==null || comment == '') {
				alert("사유가 입력되지 않았습니다.");
				return false;
			} else {
				opener.document.getElementById('comment').value = comment;
				opener.fn_pop(reason);
	        	window.close();
			}
		}
	}
	
	function fn_close() {
        window.close();
	}
	
	
</script>