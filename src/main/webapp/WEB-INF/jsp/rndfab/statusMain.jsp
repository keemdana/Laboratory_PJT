<%--
  - Author(s): Dana kim
  - Date: 2022-06-27
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
  -      연구설비 > 가동현황
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
 
 
<script type="text/javascript">
    function chartList(){

        var $form     = $("#rndfabListForm");
        var $resetBtn     = $("#optResetBtn");
        var $searchBtn     = $("#statusSearchBtn");

        var doInit = function(frm){
            frm.reset();
        }

        
        var doSearch = function(isCheckEnter){
            if (isCheckEnter && event.keyCode != 13) {
                return;
            }
            $('#chartContainer').datagrid('reload', $form.serializeObject());

        }


        var attchmentEvent = function(){

            $form.off();
            $form.on("submit", function(){
                doSearch();
                return false;
            });

            $searchBtn.off();
            $searchBtn.on("click",function(){
            	var stdt = $('#stdt').val();
            	var eddt = $('#eddt').val();

            	if(stdt!=null && stdt!='') {
            		if(eddt==null || eddt=='') {
            			alert('날짜 조건이 정상적으로 선택되지 않았습니다.');
            			return;
            		}
            	}

            	if(eddt!=null && eddt!='') {
            		if(stdt==null || stdt=='') {
            			alert('날짜 조건이 정상적으로 선택되지 않았습니다.');
            			return;
            		}
            	}

            	if(eddt < stdt) {
           			alert('종료일자는 시작일자보다 빠를 수 없습니다.');
           			return;
            	}
            	
                doSearch();
                return false;
            });

            $("input:text[data-type='search']", $form).off();
            $("input:text[data-type='search']", $form).on("keyup", function(e){
                if(e.keyCode != 13) return false;
                doSearch(true);
                return false;
            });

            $resetBtn.on("click", function(){
            	$("#pjt").val("");
            	$("#stdt").val("");
            	$("#eddt").val("");
            });
            

        }
        var init = function(){

            attchmentEvent();    //-- 이벤트 등록

        }
        
        return{
            init : init,
            doSearch : doSearch
        }
    }
    
    var chartList;
    
    $(document).ready(function(){
    	chartList = new chartList();
        chartList.init();
        
        var stdt = document.getElementById("stdt").value;
		var eddt = document.getElementById("eddt").value;
		var pjt = document.getElementById("pjt").value;
		var chk = $("input[name=checkboxlist]");
		var runstat = new Array();
		
		for(var i=0; i<chk.length; i++) {
			if(chk[i].checked) {
				runstat.push(chk[i].value);
			}
		}
		

		var eqPm = new Array();
		var partNm = new Array();
		var status = new Array();
		var label = new Array();
		var chartXml = "";
		
		//chart 그리기 _test 2022.06.28
		$.ajax({
        	url: "/rndfab/mainStatusChart/json"
          , type: "POST"
          , data : JSON.stringify({"stdt" : stdt, "eddt" : eddt, "pjt" : pjt, "runstat" : runstat })
          , dataType: "json"
          , contentType: "application/json"
	      , success : function(data) {
	    	  chartXml = data.data;
	    	  
	    	  var myChart = new FusionCharts({
	              "type": "gantt",
	              "renderAt": "chartContainer",
	              "width": "100%",
	              "height": "850",
	              "dataFormat": "xml",
	              "dataSource": chartXml
	              //"dataSource": "/Laboratory_PJT/src/main/webapp/WEB-INF/XML/Status_Main_hourly.xml"
	          }); 
	    	  myChart.render();
	      }
		, error : function(status) {
			alert(status + " error");
		      }
        });
		
		function fn_print(val) {
			
		}
        
        
    });
</script>


<form id="rndfabListForm" method="post">
    <div class="row mt">
        <h5 class="sub1_title"><i class="fa fa-file-text"></i> 연구설비가동현황 </h5>
        <div class="col-md-12 col-sm-12">
            <div class="white-panel pn-sub1-top donut-chart">
                <div class="white-header">
                    <!-- Search AREA -->
                    <div class="row sub1_search">
                        <div class="col-md-9">
                			<div>
                				<span data-tp="th">가동일자</span>
                				<input type="date" name="stdt" id=stdt class="form-control" style="width: 15%;">
                                <span class="p-1">~</span>
                                <input type="date" name="eddt" id="eddt" class="form-control" style="width: 15%;">
                			</div>
                			<div>
                				<span data-tp="th" >가동설비</span>
                				<select id="pjt" name="pjt" class="form-control input-sm" style="width:120px">
                					<option value="" selected="selected">선택</option>
									<option value="">전체</option>
									<option value="ALD01">ALD01</option>
									<option value="ALD02">ALD02</option>
									<option value="ALD03">ALD03</option>
									<option value="ALD05">ALD05</option>
									<option value="ALD06">ALD06</option>
									<option value="ALD07">ALD07</option>
									<option value="ALD22">ALD22</option>
									<option value="ALD23">ALD23</option>
									<option value="ALD24">ALD24</option>
									<option value="ALD25">ALD25</option>
									<option value="ALD26">ALD26</option>
									<option value="ALD27">ALD27</option>
									<option value="ALD28">ALD28</option>
									<option value="BA-01">BA-01</option>
									<option value="BA-02">BA-02</option>
									<option value="BA-03">BA-03</option>
									<option value="BHK-01">BHK-01</option>
									<option value="BHK-02">BHK-02</option>
									<option value="CM01">CM01</option>
									<option value="CM02">CM02</option>
									<option value="CM03">CM03</option>
									<option value="CM04">CM04</option>
									<option value="CM05">CM05</option>
									<option value="CVD04">CVD04</option>
									<option value="CVD05">CVD05</option>
									<option value="CVD06">CVD06</option>
									<option value="CVD07">CVD07</option>
									<option value="CVD08">CVD08</option>
									<option value="CVD09">CVD09</option>
									<option value="CVD10">CVD10</option>
									<option value="CVD11">CVD11</option>
									<option value="CVD21">CVD21</option>
									<option value="CVD22">CVD22</option>
									<option value="CVD23">CVD23</option>
									<option value="CVD24">CVD24</option>                            
									<option value="DPDoorKit">DPDoorKit</option>
									<option value="DPDRY08G">DPDRY08G</option>
									<option value="DPRPAH6G">DPRPAH6G</option>
									<option value="DPPECVD8G">DPPECVD8G</option>
									<option value="DPPECVDH6G">DPPECVDH6G</option>
									<option value="LMS108">LMS108</option>
									<option value="MBA-01">MBA-01</option>
									<option value="MBA-02">MBA-02</option>
									<option value="MBA-03">MBA-03</option>
									<option value="OXIDE-01">OXIDE-01</option>
									<option value="OXIDE-02">OXIDE-02</option>
									<option value="OXIDE-03">OXIDE-03</option>
									<option value="OXIDE-04">OXIDE-04</option>
									<option value="POLY-01">POLY-01</option>
									<option value="POLY-02">POLY-02</option>
									<option value="POLY-03">POLY-03</option>
									<option value="PRESTO">PRESTO</option>
									<option value="Quad">Quad</option>
									<option value="SELAID">SELAID</option>
                				</select>
                			</div>
                			<div>
                				<span data-tp="th">설비상태</span>
                				<input type="checkbox" name="checkboxlist" value="0" style="width:3%">NotUse
	                            <input type="checkbox" name="checkboxlist" value="1" style="width:3%">DisConnect
	                            <input type="checkbox" name="checkboxlist" value="2" style="width:3%" checked="checked">ATM
	                            <input type="checkbox" name="checkboxlist" value="3" style="width:3%" checked="checked">Vacuum
	                            <input type="checkbox" name="checkboxlist" value="4" style="width:3%" checked="checked">MaintRcp
	                            <input type="checkbox" name="checkboxlist" value="5" style="width:3%" checked="checked">StanbyRcp
	                            <input type="checkbox" name="checkboxlist" value="6" style="width:3%" checked="checked">Process
	                            <input type="checkbox" name="checkboxlist" value="7" style="width:3%" checked="checked">Clean
                			</div>
                			<div>
                				<span data-tp="th">반도체</span>
                				<input type="button" value="1F" onclick="fn_print('f1')" style="width:10%">
                				<input type="button" value="2F" onclick="fn_print('f2')" style="width:10%">
                				<input type="button" value="UT" onclick="fn_print('ut')" style="width:10%">
                				<input type="button" value="3F" onclick="fn_print('f3')" style="width:10%">
                				<input type="button" value="2F CDA" onclick="fn_print('SMC_2F_CDA')" style="width:10%">
                				<input type="button" value="2F PCW" onclick="fn_print('SMC_2F_PCW')" style="width:10%">
                				<input type="button" value="3F CDA" onclick="fn_print('SMC_3F_CDA')" style="width:10%">
                				<input type="button" value="3F PCW" onclick="fn_print('SMC_3F_PCW')" style="width:10%">
                			</div>
                			<div>
                				<span data-tp="th">디스플레이</span>
                				<input type="button" value="진위 #1(1F)" onclick="fn_print('JW_DP_1_1')" style="width:10%">
                				<input type="button" value="진위 #1(2F)" onclick="fn_print('JW_DP_1_2')" style="width:10%">
                				<input type="button" value="진위 #2" onclick="fn_print('JW_DP_2')" style="width:10%">
                				<input type="button" value="동탄 D1" onclick="fn_print('DT_DP_D1')" style="width:10%">
                				<input type="button" value="동탄 D2" onclick="fn_print('DT_DP_D2')" style="width:10%">
                			</div>
                        </div>
                        <div class="col-md-3" style="text-align:center;">
                            <button type="button" class="btn btn-default sear_st" id="optResetBtn" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                            <button type="button" class="btn btn-primary sear_st" id="statusSearchBtn" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<!-- LIST 시작 -->

<div class="row mt">
    <div class="col-md-12 col-sm-12">
        <div class="white-panel pn-sub1-table donut-chart">
        	<div id="chartContainer">
        		설비현황 차트그리기
        	</div>
        </div>
    </div>
</div>
    <input type="hidden" name="_csrf" id="csrf" value=""/>
