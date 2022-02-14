<%--
  - Author: Yang, Ki Hwa
  - Date: 2018-05-24
  -
  - Copyright 2018 Yang, Ki Hwa
  -
  - Licensed under the Apache License, Version 2.0 (the "License");
  - you may not use this file except in compliance with the License.
  - You may obtain a copy of the License at
  -
  - http://www.apache.org/licenses/LICENSE-2.0
  -
  - Unless required by applicable law or agreed to in writing, software
  - distributed under the License is distributed on an "AS IS" BASIS,
  - WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  - See the License for the specific language governing permissions and
  - limitations under the License.
  -
  - @(#)
  - Description: include용 JS Link
  --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<!-- base js lib -->

<!-- HTML5 Boilerplate v 6.1.0 -->
<!-- modernizer -->
<script type="text/javascript" src="<c:url value='/js/vendor/modernizr-3.6.0.min.js'/>"></script>
<!-- jqeury -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery/3.5.1/jquery-3.5.1.min.js'/>"></script>
<!-- jQuery - UI -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-ui/1.12.1/jquery-ui.js'/>"></script>
<!-- plugins -->
<script type="text/javascript" src="<c:url value='/js/plugins.js'/>"></script>

<!-- big.js: 자바스크립트 연산 라이브러리 -->
<script type="text/javascript" src="<c:url value='/js/vendor/bigjs/6.1.1/big.js'/>"></script>

<!-- bootstrap 4 -->
<script type="text/javascript" src="<c:url value='/js/vendor/bootstrap/4.5.0/js/bootstrap.min.js'/>"></script>

<!-- dashio JS 순서변경에 주의 !!-->
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/dashio/js/jquery-ui-1.9.2.custom.min.js'/>"></script> --%>
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/dashio/js/bootstrap.min.js'/>"></script> --%>
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/dashio/js/jquery.ui.touch-punch.min.js'/>"></script> --%>
<script type="text/javascript" src="<c:url value='/js/vendor/dashio/1.0.0/js/jquery.dcjqaccordion.2.7.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/dashio/1.0.0/js/jquery.scrollTo.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/dashio/1.0.0/js/jquery.nicescroll.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/dashio/1.0.0/js/chart-master/Chart.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/dashio/js/chartjs-conf.js'/>"></script>
 --%>
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/dashio/js/common-scripts.js'/>"></script> --%>

<!-- jqwidgets -->
<script type="text/javascript" src="<c:url value='/js/vendor/jqwidgets/13.1.0/jqx-all.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/jqwidgets/13.1.0/jqxcore.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jqwidgets/13.1.0/jqxdraw.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jqwidgets/13.1.0/jqxchart.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jqwidgets/13.1.0/jqxchart.core.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jqwidgets/13.1.0/jqxdata.js'/>"></script>
 --%>
<!-- UI Library -->

<!-- js Storage -->
<script type="text/javascript" src="<c:url value='/js/vendor/js-storage/1.0.4/js.storage.js'/>"></script>
<!-- Jquery Tmpl -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery/plugin/jquery-templates/1.4.2/jquery.tmpl.js'/>"></script>
<!-- 테이블 TR Drag And Drop 부분 -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery/plugin/jquery-tablednd/1.0.3/jquery.tablednd.js'/>"></script>

<!-- Ck Editor -->
<script type="text/javascript" src="<c:url value='/js/vendor/ckeditor/4.16.2/ckeditor.js'/>"></script>

<!-- es6-promise -->
<script type="text/javascript" src="<c:url value='/js/vendor/es6-promise/es6-promise.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/es6-promise/es6-promise.auto.min.js'/>"></script>

<!-- html2canvas -->
<script type="text/javascript" src="<c:url value='/js/vendor/html2canvas/1.3.2/html2canvas.min.js'/>"></script>

<!-- 보안 : xss util https://github.com/leizongmin/js-xss -->
<script type="text/javascript" src="<c:url value='/js/vendor/js-xss/1.0.10/xss.min.js'/>"></script>

<!-- jquery 확장 - (보안 : jquery csrf 처리) 등 -->
<script type="text/javascript" src="<c:url value='/js/vendor/paragon/plugin/jquery.js'/>"></script>

<!-- easy-ui -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/1.9.14/jquery.easyui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/extension/datagrid-export/xlsx.full.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/extension/datagrid-export/datagrid-export.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/extension/datagrid-cellediting/datagrid-cellediting.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/extension/jquery-easyui-edatagrid/jquery.edatagrid.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/1.9.14/locale/easyui-lang-ko.js'/>"></script>



<!-- [주의!] 아래는 순서 준수!! -->
<%-- 공통 스크립트 --%>

<script type="text/javascript" src="<c:url value='/js/vendor/paragon/paragonCmm.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/paragon/htmlutils.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/paragon/paragonFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vendor/paragon/paragonIps.js'/>"></script>

<!-- easy-ui Custom override -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/jquery.easyui.custom.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/jayu/plugins/easyui.js'/>"></script> --%>
<script type="text/javascript">


    var addEventWriter = function(){
        var textObj = $("input:text");

        $(document).on("keyup","[max-length][max-length!='']",function(){

            var length = $(this).attr("max-length");
            var id = $(this).attr("id");
            if( id == undefined ){
                id = $(this).attr("name");
            }
            /*
                2017.06.15 김형종 IF문으로 감싸는 작업 추가.
                'id' 가 없고 'name' 만 존재하는 태그가 있을지 모르므로 감싸준다. 'id'가 없으면 스트립트 에러가 남..
                ex) 동적으로 추가되는 input 태그는 동일한 name값을 가지되, id가 없을 수도 있음.
            */
            if( id != undefined ){
                var style = $(this).attr("style");
                //초기화
//  			$(this).removeAttr("style");
                $(this).removeAttr("onKeyUp");
                $(this).removeAttr("onBlur");
                $("#span_"+id).remove();

                var objWidth = $(this).width();
                var preWidth = $(this).parent().width();
                var tarWidth = $(this).width()-65;

                var gapWidth = (objWidth/preWidth)*100;

                var lastWidth = (tarWidth/preWidth)*100;

                if($(this).attr("id") == undefined){
                    $(this).attr("id",$(this).attr("name"));
                }
                //설정 시작
//  			var styleStr = "width:"+lastWidth.toFixed(0)+"%";
                if(gapWidth.toFixed(0) > 88){
                    $(this).css("width",lastWidth.toFixed(0)+"%");//소수점이하 버림
                }
                $(this).attr("onKeyUp","paragonCmm.displayByte('"+id+"')");
                $(this).parent().append("<span id=\"span_"+id+"\" >(<span id=\"byte_"+id+"\">0</span>/"+length+")</span>")
                paragonCmm.displayByte(id);



            }

            paragonCmm.validateSpecialChars(this);

        }).on("blur","[maxlength][maxlength!='']",function(){
            var length = $(this).attr("maxlength");

            paragonCmm.validateMaxLength(this,length);
            paragonCmm.getTrim(this.value);
        });

        $(document).on("keyup",".cost",function(){

            paragonCmm.getFormatCurrency(this,2,true)
        });
        $(document).on("keyup",".number",function(){

            paragonCmm.validateNumber(this,$(this).val());
        });
        $(document).on("keyup",".pointnumber",function(){

            paragonCmm.validatePointNumber(this,$(this).val());
        });

        $("[maxlength][maxlength!='']").trigger("keyup");
    }

	var pageResize = function(){
		console.log("page resize")
		$(".easyui-tabs").tabs('resize');		//-- tab resize
		$('.datagrid-f').datagrid('resize');	//-- data-grid resize
		$(".panel-body").panel("resize");
		$(".easyui-accordion").accordion("resize");
   	}
    $(function() {
        //-- 작성 이벤트 삽입
        addEventWriter();

        pageResize();
    	$(window).bind('resize', function(){
    		pageResize();

    	});

    });
</script>
<script id="addTreeTmpl_USER" type="text/x-jquery-tmpl">
	<div id="\${uuid}" data-id="div_\${parentDeptCd}" style="padding-left:\${setPadding(levelNo)}px;" class="treeNode">
		{{if childCnt > 0 }}
			<img id="img_\${uuid}" src="/img/ico/icon-right.png" style="vertical-align:middle" onClick="nodeOpenClick('\${uuid}');">
			<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
			<span style="margin-left:-4px;cursor:pointer;{{if useYn == 'N' }}color:red{{/if}}" onClick="nodeOpenClick('\${uuid}');">\${nmKo}</span>
		{{else}}
				<img src="/img/ico/empty.gif" style="vertical-align:middle" alt="">
			{{if usrSeq == '0' }}
				<img id="img_\${uuid}" src="/img/ico/page.gif" style="vertical-align:middle" onClick="treeDrawChild('\${uuid}','\${uuid}','')">
				<span onClick="USER.selectNode('\${uuid}')" style="margin-left:-4px;cursor:pointer;{{if useYn == 'N'}}color:red{{/if}}">\${nmKo} {{if dutyLangCd != null}}[\${paragonCmm.getLang(dutyLangCd)} /\${deptNmKo}] {{else}}[\${paragonCmm.getLang(posLangCd)} /\${deptNmKo}]{{/if}}</span>
			{{else}}
				<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;{{if useYn == 'N'}}color:red{{/if}}">\${nmKo}</span>
			{{/if}}
		{{/if}}
		<input type="hidden" name="uuid" value="\${uuid}"/>
		<input type="hidden" name="nmKo" value="\${nmKo}"/>
		<input type="hidden" name="nmEn" value="\${nmEn}"/>
		<input type="hidden" name="dspNmKo" value="\${dspNmKo}"/>
		<input type="hidden" name="dspNmEn" value="\${dspNmEn}"/>
		<input type="hidden" name="dspNmJa" value="\${dspNmJa}"/>
		<input type="hidden" name="dspNmZh" value="\${dspNmZh}"/>
		<input type="hidden" name="userNo" value="\${userNo}"/>
		<input type="hidden" name="loginId" value="\${loginId}"/>
		<input type="hidden" name="parentDeptCd" value="\${parentDeptCd}"/>
		<input type="hidden" name="parentCd" value="\${parentDeptCd}"/>
		<input type="hidden" name="parentDeptNmKo" value="\${parentDeptNmKo}"/>
		<input type="hidden" name="parentDeptNmEn" value="\${parentDeptNmEn}"/>
		<input type="hidden" name="dutyCd" value="\${dutyCd}"/>
		<input type="hidden" name="dutyLangCd" value="\${dutyLangCd}"/>
		<input type="hidden" name="posCd" value="\${posCd}"/>
		<input type="hidden" name="posLangCd" value="\${posLangCd}"/>
		<input type="hidden" name="deptNmPathKo" value="\${deptNmPathKo}"/>
		<input type="hidden" name="deptNmPathEn" value="\${deptNmPathEn}"/>
		<input type="hidden" name="deptNmKo" value="\${deptNmKo}"/>
		<input type="hidden" name="deptNmEn" value="\${deptNmEn}"/>
		<input type="hidden" name="deptCd" value="\${deptCd}"/>
		<input type="hidden" name="addrKo" value="\${addrKo}"/>
		<input type="hidden" name="addrEn" value="\${addrEn}"/>
		<input type="hidden" name="telephoneNo" value="\${telephoneNo}"/>
		<input type="hidden" name="mobileNo" value="\${mobileNo}"/>
		<input type="hidden" name="email" value="\${email}"/>
		<input type="hidden" name="registrationNo" value="\${registrationNo}"/>
		<input type="hidden" name="deptType" value="\${deptType}"/>
		<input type="hidden" name="useYn" value="\${useYn}"/>
		<input type="hidden" name="corpCd" value="\${corpCd}"/>
		<input type="hidden" name="corpNm" value="\${corpNm}"/>
	</div>
</script>

<!--
2016.07.14 김형종 수정
영문화 작업으로 인해 템플릿을 아래 템플릿을 수정함.
NM_KO 만 가져왔던 것을 siteLocale 을 이요해서 태그의 'name'값은 'NM_KO'이지만 siteLocale 에 따라 영어 또는 한국어 등으로
유저의 선택에 따라 변경된다. NM_KO 값을 바꾸지 않은 이유는 다른팝업 JSP들에서 그대로 name='NM_KO' 로 받어오는 곳이 여러군데 있어
일일이 수정해주면 번거로워 템플릿에서만 이름을 같게하여 변경하였음..
-->
<script id="addTreeTmpl_DEPT" type="text/x-jquery-tmpl">
	<div id="\${uuid}" data-id="div_\${parentDeptCd}" style="padding-left:\${setPadding(levelNo)}px;" class="treeNode">
		{{if childCnt > 0 }}
			<img id="img_\${uuid}" src="/img/ico/icon-right.png" style="vertical-align:middle" onClick="nodeOpenClick('\${uuid}');">
			{{if treeProperties.selectType == 'CHILD_ONLY' }}
				<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;" onClick="nodeOpenClick('\${uuid}')">\${nmKo}</span>
			{{else}}
				<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;" onClick="DEPT.selectNode('\${uuid}')">\${nmKo}</span>
			{{/if}}
		{{else}}
			<img src="/img/ico/empty.gif" style="vertical-align:middle" alt="">
			{{if usrSeq == '1' }}
				<img id="img_\${uuid}" src="/img/ico/page.gif" style="vertical-align:middle" onClick="treeDrawChild('\${uuid}','\${uuid}','')">
				<span onClick="DEPT.selectNode('\${uuid}')" style="margin-left:-4px;cursor:pointer;">\${nmKo}</span>
			{{else}}
				<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;">\${nmKo}</span>
			{{/if}}
		{{/if}}
		<input type="hidden" name="uuid" value="\${uuid}"/>
		<input type="hidden" name="usrSeq" value="\${usrSeq}"/>
		<input type="hidden" name="nmKo" value="\${nmKo}"/>
		<input type="hidden" name="nmEn" value="\${nmEn}"/>
		<input type="hidden" name="deptCd" value="\${deptCd}"/>
		<input type="hidden" name="childCnt" value="\${childCnt}"/>
		<input type="hidden" name="parentDeptCd" value="\${parentDeptCd}"/>
		<input type="hidden" name="parentDeptNmKo" value="\${parentDeptNmKo}"/>
		<input type="hidden" name="parentDeptNmEn" value="\${parentDeptNmEn}"/>
		<input type="hidden" name="parentDeptNmJa" value="\${parentDeptNmJa}"/>
		<input type="hidden" name="parentDeptNmZh" value="\${parentDeptNmZh}"/>
		<input type="hidden" name="deptCdPath" value="\${deptCdPath}"/>
		<input type="hidden" name="deptNmPathKo" value="\${deptNmPathKo}"/>
		<input type="hidden" name="deptNmPathEn" value="\${deptNmPathEn}"/>
		<input type="hidden" name="deptNmPathJa" value="\${deptNmPathJa}"/>
		<input type="hidden" name="deptNmPathZh" value="\${deptNmPathZh}"/>
	</div>
</script>
<script id="addTreeTmpl_LAWFIRM" type="text/x-jquery-tmpl">
	<div id="\${LAWY_REG_NO}" data-id="div_\${PARENT_LAWFM_UID}" style="padding-left:\${setPadding(levelNo)}px;" class="treeNode">
		{{if childCnt > 0 }}
			<img id="img_\${LAWY_REG_NO}" src="/img/ico/icon-right.png" style="vertical-align:middle" onClick="nodeOpenClick('\${LAWY_REG_NO}');">
			<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
			<span style="margin-left:-4px;cursor:pointer;" onClick="nodeOpenClick('\${LAWY_REG_NO}')">\${NM_KO}</span>

		{{else}}
				<img src="/img/ico/empty.gif" style="vertical-align:middle" alt="">
			{{if USR_SEQ == '0' }}
				<img id="img_\${LAWY_REG_NO}" src="/img/ico/page.gif" style="vertical-align:middle" onClick="treeDrawChild('\${LAWY_REG_NO}','\${LAWY_REG_NO}','')">
				<span onClick="selectNode('\${LAWY_REG_NO}')" style="margin-left:-4px;cursor:pointer;">\${NM_KO}</span>
			{{else}}
				<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;">\${NM_KO}</span>
			{{/if}}
		{{/if}}
		<input type="hidden" name="lawy_reg_no" value="\${LAWY_REG_NO}"/>
		<input type="hidden" name="parent_lawfm_uid" value="\${PARENT_LAWFM_UID}"/>
		<input type="hidden" name="lawfm_nm_ko" value="\${LAWFM_NM_KO}"/>
		<input type="hidden" name="lawfm_nm_en" value="\${LAWFM_NM_EN}"/>
		<input type="hidden" name="nm_ko" value="\${NM_KO}"/>
		<input type="hidden" name="nm_en" value="\${NM_EN}"/>
	</div>
</script>
<script id="addTreeTmpl_CODE" type="text/x-jquery-tmpl">
	<div id="\${cd}" data-id="div_\${parentCd}" style="padding-left:\${setPadding(levelNo)}px;" class="treeNode">
		{{if childCnt > 0 }}
			<img id="img_\${cd}" src="/img/ico/icon-right.png" style="vertical-align:middle" data-cd="\${cd}" onClick="nodeOpenClick('\${cd}');">
			{{if treeProperties.selectType == 'CHILD_ONLY' }}
				<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;{{if useYn == 'N'}}color:red{{/if}}" onClick="nodeOpenClick('\${cd}');">\${paragonCmm.getLang(langCd)}</span>
			{{else}}
				<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;{{if useYn == 'N'}}color:red{{/if}}" onClick="CODE.selectNode('\${cd}')">\${paragonCmm.getLang(langCd)}</span>
			{{/if}}
		{{else}}
				<img src="/img/ico/empty.gif" style="vertical-align:middle" alt="">
				<img src="/img/ico/page.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;{{if useYn == 'N'}}color:red{{/if}}" onClick="CODE.selectNode('\${cd}')">\${paragonCmm.getLang(langCd)}</span>
		{{/if}}
		<input type="hidden" name="cd"	        value="\${cd}">
		<input type="hidden" name="cdAbb"	        value="\${cdAbb}">
		<input type="hidden" name="ordNo"		    value="\${ordNo}">
		<input type="hidden" name="langCd"	        value="\${langCd}">
		<input type="hidden" name="parentCd"	    value="\${parentCd}">
		<input type="hidden" name="parentLangcd"	value="\${parentLangcd}">
		<input type="hidden" name="parentCd"		value="\${parentCd}">
		<input type="hidden" name="levelNo"	    value="\${levelNo}">
		<input type="hidden" name="childCnt"	    value="\${childCnt}">
		<input type="hidden" name="cdPath"	    	value="\${cdPath}">
		<input type="hidden" name="langCdPath"	value="\${langCdPath}">
		<input type="hidden" name="cdAttr1"	    value="\${cdAttr1}">
		<input type="hidden" name="cdAttr2"	    value="\${cdAttr2}">
		<input type="hidden" name="cdAttr3"	    value="\${cdAttr3}">
		<input type="hidden" name="cdAttr4"	    value="\${cdAttr4}">
		<input type="hidden" name="cdData"	    	value="\${cdData}">
		<input type="hidden" name="useYn"	    value="\${useYn}">
		<input type="hidden" name="attrDesc1"	value="\${attrDesc1}">
		<input type="hidden" name="attrDesc2"	value="\${attrDesc2}">
		<input type="hidden" name="attrDesc3"	value="\${attrDesc3}">
		<input type="hidden" name="attrDesc4"	value="\${attrDesc4}">
	</div>
</script>
<script id="addTreeTmpl_MENU" type="text/x-jquery-tmpl">
	<div id="\${menuId}" data-id="div_\${parentMenuId}" style="padding-left:\${setPadding(levelNo)}px;" class="treeNode">
		{{if childCnt > 0 }}
			<img id="img_\${menuId}" src="/img/ico/icon-right.png" style="vertical-align:middle" onClick="nodeOpenClick('\${menuId}');">
			<img src="/img/ico/folder.gif" style="vertical-align:middle" alt="">
			<span style="margin-left:-4px;cursor:pointer;{{if useYn == '0'}}color:red{{else useYn == '2'}}color:gray{{/if}}" onClick="MENU.selectNode('\${menuId}')">\${paragonCmm.getLang(langCd)}</span>
		{{else}}
				<img src="/img/ico/empty.gif" style="vertical-align:middle" alt="">
				<img src="/img/ico/page.gif" style="vertical-align:middle" alt="">
				<span style="margin-left:-4px;cursor:pointer;{{if useYn == '0'}}color:red{{else useYn == '2'}}color:gray{{/if}}" onClick="MENU.selectNode('\${menuId}')">\${paragonCmm.getLang(langCd)}</span>
		{{/if}}
		<input type="hidden" name="menuId"	        value="\${menuId}">
		<input type="hidden" name="ordNo"		    value="\${ordNo}">
		<input type="hidden" name="langCd"	        value="\${langCd}">
		<input type="hidden" name="urlPath"	        value="\${urlPath}">
		<input type="hidden" name="parentMenuId"	    value="\${parentMenuId}">
		<input type="hidden" name="levelNo"	    value="\${levelNo}">
		<input type="hidden" name="jsonData"	    value='\${jsonData}'>
		<input type="hidden" name="childCnt"	    value="\${childCnt}">
		<input type="hidden" name="useYn"	    value="\${useYn}">
	</div>
</script>