<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.vertexid.commons.utils.DateUtil"%>

<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<div class="content-panel">
	<form id="ecrListform" name="ecrListform" method="post" onsubmit="return false;">
	<p>
	    <table class="box">
		    <tr>
		        <td class="corner_lt"></td><td class="border_mt"></td><td class="corner_rt"></td>
		    </tr>
		    <tr>
		        <td class="border_lm"></td>
		        <td class="body">
		            <table>
		                <colgroup>
		                    <col width="15%" />
		                    <col width="25%" />
		                    <col width="45%" />
		                    <col width="5%" />
		                    <col />
		                </colgroup>
		                <tr>
		                	<th>ECR/SCR No.</th>
							<td><input type="text" name="ecrNo" id="ecrNo" data-type="search" maxlength="30" class="text width_max" /></td>
							
							<td>
	                            <div class="input-group">
	                                <input type="text" name="sDate" id=sDate data-col="sDate" class="form-control" style="width: 50%;">
	                                <span class="p-1">~</span>
	                                <input type="text" name="eDate" id="eDate" data-col="eDate" class="form-control" style="width: 50%;">
	                            </div>                        
	                        </td>
							
							
			                <th><span class="ui_btn medium icon" id="searchBtn"><i class="fa fa-search" ><a data-term="B.SEARCH"></a></i></span></th>
							
							
							
		                </tr>
		            </table>
		        </td>
		        <td class="border_rm"></td>
		    </tr>
		    <tr>
		        <td class="corner_lb"></td><td class="border_mb"></td><td class="corner_rb"></td>
		    </tr>
	    </table>
	</form>
	<div class="buttonlist">
		<div class="left">
        </div>
        <div class = "right">
          	<span class="ui_btn small icon" id="ecrListProc"><i class="fa fa-check"><a class="btn_search" data-term="B.처리"></a></i></span>
        </div>
     </div>
    <table class="list" id="EcrListTable">
		<thead >
		<tr>
			<th style="width:10%"  data-opt='{"align":"center","html":{"type":"radio","name":"chkVal","valueField":"dcode"}}'></th>
			<th style="width:20%" data-opt='{"align":"center","col":"dcode"}' >ECR/SCR No.</th>		
			<th style="width:40%" data-opt='{"align":"left","col":"dname"}' >제목</th>
			<th style="width:20%" data-opt='{"align":"center","col":"ecrStatus"}' >진행상태</th>
			<th style="width:20%" data-opt='{"align":"center","col":"ecrEmpNm"}' >작성자</th>
				
		</tr>
		</thead>
		<tbody id="EcrListTableBody">
		</tbody>
	</table>
	<%-- 페이지 목록 --%>
	<div class="pagelist" id="EcrListTablePage"></div>
</div>
<script>
function Module_List(){

	var loadTable = function(pageNo, sDate, eDate){
		if(pageNo == undefined) pageNo =1;
		var data = paragonCmm.getSearchQueryParams($("#ecrListform"));
		data["page"] = pageNo;
		//data["rows"] = "10";
		data["deptArea"] = "SMC";
		data["ecrFrDate"] = sDate;
		data["ecrEdDate"] = eDate;

		if(!doValidation(sDate, eDate)){
			return;
		}else{
			paragonCmm.callAjax("/voc/getEcrList/json",data, function(json){
			  	var data = paragonCmm.easyuiLoadFilter(json);
			 	var page = pageNo;
			  	var rowCnt = 10;
			  	htmlUtils.createTableRow("EcrListTable", data, page, rowCnt, "moduleList.loadTable");	
			});
		}
		
		
	}
	
	var doValidation = function (sDate, eDate) {		
	    if (sDate > eDate) {
	        alert("종료일이 시작일보다 빠릅니다. <P> 기간을 올바르게 입력해주세요.");
	        return false;
	    }
	    return true;
	}
    
	var setCallback;
	var attachEvents = function(){
		$("#ecrListProc").off();
		$("#ecrListProc").on("click",function(){
			var $chkId = $("input:radio[name='chkVal']:checked");
			if($chkId.length == 0){
				alert("모듈을 선택해 주세요.");
				return false;
			}
			if(typeof setCallback === "function"){
				//setCallback($chkId.val());
				//var code = $chkId.val();
				//var name = $("input[type=radio]:checked").parent().parent().find("td:last").text();
				//setSchPjt(code);
				setCallback($chkId.val());
			}
		});
		$("#searchBtn").off();
		$("#searchBtn").on("click",function(){
			var data = paragonCmm.getSearchQueryParams($("#ecrListform"));
			var sDate = $("#sDate").val();
			var eDate = $("#eDate").val();
			loadTable('', sDate, eDate);
		});
		
	}
	var init = function(initFunc, callbackFunc){
		if(typeof callbackFunc === "function"){
			setCallback = callbackFunc;
		}
		
		
		var today = new Date();
		var sYear = today.getFullYear() - 1;
		var eYear = today.getFullYear();		
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);

		var sDate = sYear + '-' + month  + '-' + day;
		var eDate = eYear + '-' + month  + '-' + day;
							
		$("#sDate").datebox({});
		$("#sDate").datebox('setValue', sDate);		
		$("#eDate").datebox({});
		$("#eDate").datebox('setValue', eDate);
		
		loadTable('',sDate, eDate);
		attachEvents();
		
		
		
		/* $("#searchBtn").off();
		$("#searchBtn").on("click",function(){
			var custNm = $("input:text[id='custNm']").val();

			alert(custNm);
		}); */
	}
	return {
		init:init,
		loadTable:loadTable
	}
	
	
}
var moduleList = new Module_List();


</script>

