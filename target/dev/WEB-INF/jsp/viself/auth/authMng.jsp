<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//-- 로그인 사용자 정보 셋팅
	String schFieldCodestr 		= "LANG_CD|이름^CD|코드";
%>

<div class="row mt">
	<h5 class="sub1_title" data-term="L.시스템권한관리"><i class="fa fa-file-text"></i> </h5>	
</div>
<div class="col-sm-4">
  <h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 권한관리</h6>
     <section class="panel" style="border: 0px;">
       <div class="panel-body" style="border: 0px;">
         <ul class="nav nav-pills nav-stacked labels-info ">
         	 <li style="margin-left:5px;margin-top:5px;">				
        	 	<div class="input-append">
                 <input type="text" class="form-control" id="addAuthNm" placeholder="권한명"  style="width:35%;display:inline-block;">
                 <input type="text" class="form-control" id="addAuthCd" placeholder="권한코드"  style="width:30%;display:inline-block;">
                 <span class="ui_btn medium icon" id="addAuthBtn" ><i class="fa fa-pencil" ><a href="javascript:void(0)" data-term="B.REG"></a></i></span>
                 <span class="ui_btn medium icon" id="resAuthBtn" ><i class="fa fa-refresh" ><a href="javascript:void(0)" data-term="B.INIT"></a></i></span>
                 <span class="ui_btn medium icon" id="uptAuthBtn" style="display:none;"><i class="fa fa-pencil" ><a href="javascript:void(0)" data-term="B.MODIFY"></a></i></span>
              </div>
         	 </li>
           <li style="margin-left:5px;">
            <div class="custom-check goleft mt">
              <table class="table table-hover custom-check">
                <thead>
                	<tr>
                		<th>권한명</th>
                		<th>권한코드</th>
                	</tr>
                </thead>
                <tbody id="rolesTbody">
                </tbody>
              </table>
            </div>
            <!-- /table-responsive -->
            <span style="color: red;font-size: 10px;">
            	※권한 순서상 상단의 권한이 우선적용됩니다.<br/>
            	&nbsp;ex) 시스템관리자,법무담당자 권한을 가진 사용자는 시스템관리자 권한이 기본임<br/>
            	※일반사용자 권한은 삭제 하면 안됨.(사용자선택 필요없음)
            </span>
           </li>
         </ul>
       </div>
     </section>
     
     <h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 권한별 사용자관리</h6>
     <section class="panel mt">       	
       <div class="panel-body" style="border: 0px;">
       	<ul class="nav nav-pills nav-stacked labels-info ">
         	 <li style="width:95%;margin-left:5px;margin-top:5px;">           	 	
               <div>
                 <input type="text" id="searchUserKeyword" placeholder="M.소속_또는_이름" data-term="M.소속_또는_이름">
               </div>
         	 </li>
           <li style="width: 100%;height:275px;overflow: auto;">
            <div class="custom-check goleft mt">
              <table class="table table-hover custom-check">
               <thead>
                	<tr>
                		<th>권한 사용자명</th>
                	</tr>
                </thead>
                <tbody id="selectUserTbody">
                </tbody>
              </table>
            </div>
            <!-- /table-responsive -->
           </li>
         </ul>
       </div>
     </section>
</div>
 <div class="col-sm-8">
    <div class="buttonlistnon">
   		<div class="left">
     		<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 권한별 메뉴관리</h6>
     	</div>
      	<div class="right">
   			<span class="ui_btn medium icon" id="saveAuthMenuBtn" ><i class="fa fa-pencil" ><a href="javascript:void(0)" data-term="B.SAVE"></a></i></span>
   	 	</div>
	</div>
	<section class="panel">
	        <div class="panel-body minimal" style="border: 0px;">
	            <table id="AuthMenuTable" class="easyui-treegrid" style="width:100%;height:700px;">
			        <thead>
			            <tr>
			            	<th data-options="field:'alwCd',width:0,hidden:true"></th>
			                <th data-options="field:'langCd',formatter:paragonCmm.getLang" width="33%">Name</th>
			                <th data-options="field:'menuId'" width="33%">Menu ID</th>
			                <th data-options="field:'urlPath'" width="33%">URL</th>
			            </tr>
			        </thead>
		    	</table>
	        </div>
	</section>
</div>

<!-- /wrapper -->

<script type="text/javascript">
function Auth() {
	//-- 권한 조회
	var loadAuths = function(authCd){
		paragonCmm.callAjax("/viself/auth/authMng/list/json",{}, function(json){
			if(json.errYn === "E"){
				//-- 오류처리
				alert(json.msg);
				return false;
			}
			$("#rolesTbody").html(""); // 초기화
			$(json.data).each(function(i, d){
				var $tr = $("<tr>");
				var $td = $("<td>");
				var $label = $("<label style='margin:0px;'>");
				var $checkbox = $("<input type='radio' class='checked' name='authCd'>").val(d.authCd);
				var $button = $("<button class='close' aria-hidden='true' data-dismiss='alert' type='button' style='color:red;cursor:pointer;'>×</button>");
				$label.append($checkbox).append(" "+d.authNm);
				$td.append($label);
				$td.append($button);
				$tr.append($td);
				var $td2 = $("<td>").append(d.authCd);
				$tr.append($td2);
				$("#rolesTbody").append($tr);
				$($label, $checkbox).on("click",function(){
					loadAuthMember();
					loadAuthMenu();
					//-- 수정모드변경
					$("#addAuthCd").val(d.authCd).attr("readonly","readonly");
					$("#addAuthNm").val(d.authNm);
					$("#addAuthBtn").hide();
					$("#resAuthBtn").show();
					$("#uptAuthBtn").show();

				});
				$($button).on("click",function(){
					delAuthMng(d.authCd);
				});
			});
			if(typeof authCd === "string" && authCd != ""){
				$("input:radio[name='authCd'][value='"+authCd+"']").trigger("click");
			}
			paragonCmm.tableTrDragSet("rolesTbody",function(){
				confirm("권한 표시순서를 변경하시겠습니까?",function(r){
					if(r){
						$("input:radio[name='authCd']").each(function(i, o){
							var data = {};
							data.ordNo = i+1;
							data.authCd = $(o).val();
							// 순서변경 저장
							paragonCmm.callAjax("/viself/auth/authMng/updateSort/json",data, function(json){
								if(json.errYn === "E"){
									//-- 오류처리
									alert(json.msg);
									return false;
								}
							});
						});
					}
				})
			}); //순서변경
		});
	}
	//-- 권한 추가
	var addAuthMng = function(){
		var authCd = $("#addAuthCd").val();
		var authNm = $("#addAuthNm").val();
		if((authCd != null && authCd != "") && (authNm != null && authNm != "")){
			var data = {};
			data.authCd = authCd;
			data.authNm = authNm;
			data.authTpCd = "USER";
			data.useYn = "Y";

			paragonCmm.callAjax("/viself/auth/authMng/insert/json",data, function(json){
				if(json.errYn === "E"){
					//-- 오류처리
					alert(json.msg);
					return false;
				}
				$("#addAuthCd").val("");
				$("#addAuthNm").val("");
				loadAuths(authCd);

			});
		}
	}
	//-- 권한 수정
	var uptAuthMng = function(){
		var authCd = $("#addAuthCd").val();
		var authNm = $("#addAuthNm").val();
		if((authCd != null && authCd != "") && (authNm != null && authNm != "")){
			var data = {};
			data.authCd = authCd;
			data.authNm = authNm;
			paragonCmm.callAjax("/viself/auth/authMng/update/json",data, function(json){
				if(json.errYn === "E"){
					//-- 오류처리
					alert(json.msg);
					return false;
				}
				$("#addAuthCd").val("");
				$("#addAuthNm").val("");
				loadAuths(authCd);
			});
		}
	}
	//-- 권한삭제
	var delAuthMng = function(authCd){

		if((authCd != null && authCd != "")){
			confirm("삭제 하시면 지정된 사용자,메뉴 정보도 같이 삭제 됩니다.\n 삭제 하시겠습니까?",function(r){
				if(r){
					delAuthMember(authCd); //-- 권한 사용자 삭제
					delAuthMenu(authCd); 	//-- 권한 메뉴 삭제
					var data = {};
					data.authCd = authCd;
					paragonCmm.callAjax("/viself/auth/authMng/delete/json",data, function(json){
						if(json.errYn === "E"){
							//-- 오류처리
							alert(json.msg);
							return false;
						}
						loadAuths("CMM_SYS");
					});
				}
			});
		}
	}
	var treeDataFilter = function(json){
		var data = {};
		var parent = [];
		var child = {};

		if(json.hasOwnProperty("data") && json.data.length > 0){
			data["total"] = json.data[0].totCnt;
			data["rows"] = json.data;

			$(json.data).each(function(i, d){
				if(d.parentMenuId != null && d.parentMenuId != ""){
					if(child.hasOwnProperty(d.parentMenuId)){
						child[d.parentMenuId].push(d);
					}else{
						child[d.parentMenuId] = [];
						child[d.parentMenuId].push(d);
					}
				}else{
					parent.push(d);
				}
			});
			//--GetParent

		}else if(json.hasOwnProperty("data") && json.data.length == 0){
			data["total"] = 0;
			data["rows"] = [];
		}else{
			data = json;
		}
		console.log(parent);
		console.log(child);
		console.log(data);
		var data = [];
		$(parent).each(function(i, d){
			var prnt = d.menuId;
			if(child.hasOwnProperty(prnt)){
				d.children = child[prnt];
			}
			data.push(d);
		});
		console.log(data);
	    return data;
	}
	//-- 권한 메뉴 조회
	var loadAuthMenu = function(){

		var authCd = $("input:radio[name='authCd']:checked").val();
		if(authCd != null && authCd != ""){
			var data = {};
			data.authCd = authCd;// viself.auth.AuthMenu
			data.useYn = "1";
			$('#AuthMenuTable').treegrid({
			    url:'/viself/auth/authMenu/authList/json',
			    idField:'menuId',
			    treeField:'langCd',
			    checkbox: true,
			    cascadeCheck:true,
			    method:"post",
			    loadFilter:treeDataFilter,
		    	queryParams:data,
		    	onLoadSuccess:function(row, data){
	    			console.log(data);
		    		$(data).each(function(i, e){
		    			$("#AuthMenuTable").treegrid('uncheckNode',e.menuId);
	    				if(e.hasOwnProperty("children")){
							$(e.children).each(function(j,d){
								console.log(d.alwCd);
								if(d.alwCd != null && d.alwCd != ""){
									$("#AuthMenuTable").treegrid('checkNode',d.menuId);
								}else{
									$("#AuthMenuTable").treegrid('uncheckNode',d.menuId);
								}
							});
	    				}else{
	    					if(e.alwCd != null && e.alwCd != ""){
								$("#AuthMenuTable").treegrid('checkNode',e.menuId);
							}else{
								$("#AuthMenuTable").treegrid('uncheckNode',e.menuId);
							}
	    				}
		    		});
		    	}
			});
		}
	}
	//-- 권한 메뉴 저장
	var saveAuthMenu = function(){
		var authCd = $("input:radio[name='authCd']:checked").val();
		if(authCd != null && authCd != ""){
            var insData = {};
            var row = $("#AuthMenuTable").treegrid('getCheckedNodes');
            var indeterminateRow = $("#AuthMenuTable").treegrid('getCheckedNodes','indeterminate');

            $(indeterminateRow).each(function(i,e){
                row.push(e);
            });

            var list = [];
            $(row).each(function(i, d){
                d.alwCd = "ALLOW";
                list.push(d);
            });
            insData.authCd = authCd;
            insData["list"] = list;
            paragonCmm.callAjax("/viself/auth/authMenu/insert/json",insData, function(insJson){
                if(insJson.errYn === "E"){
                    //-- 오류처리
                    alert(insJson.msg);
                    return false;
                }
                loadAuthMenu();
            });
		}
	}
	//-- 권한 메뉴 삭제
	var delAuthMenu = function(authCd){

		authCd = ((authCd == undefined || authCd == "") ? $("input:radio[name='authCd']:checked").val() : authCd);
		if((authCd != null && authCd != "") || (loginId != null && loginId != "")){
			var data = {};
			data.authCd = authCd;
			paragonCmm.callAjax("/viself/auth/authMenu/delete/json",data, function(json){
				if(json.errYn === "E"){
					//-- 오류처리
					alert(json.msg);
					return false;
				}
				loadAuthMenu();
			});
		}
	}
	//-- 권한 사용자 조회
	var loadAuthMember = function(){

		var authCd = $("input:radio[name='authCd']:checked").val();
		if(authCd != null && authCd != ""){
			$("#selectUserTbody").html(""); // 초기화
			var data = {};
			data.authCd = authCd;//
			paragonCmm.callAjax("/viself/auth/authMember/list/json",data, function(json){
				if(json.errYn === "E"){
					//-- 오류처리
					alert(json.msg);
					return false;
				}
				$(json.data).each(function(i, d){
					var $tr = $("<tr>").data("id", d.mbrId);
					var $td = $("<td>");
					var $label = $("<label style='margin:0px;'>");
					var $button = $("<button class='close' aria-hidden='true' data-dismiss='alert' type='button' style='color:red;cursor:pointer;'>×</button>");
					$label.append(" "+d.userNm);
					$td.append($label);
					$td.append($button);
					$tr.append($td);
					$("#selectUserTbody").append($tr);
					$($button).on("click",function(){
						delAuthMember(authCd, d.mbrId);
					});
				});
			});
		}
	}
	//-- 권한 사용자 추가
	var addAuthMember = function(loginId, dspNmKo){
		var authCd = $("input:radio[name='authCd']:checked").val();
		if((authCd != null && authCd != "") && (loginId != null && loginId != "")){
			var data = {};
			data.authCd = authCd;
			data.mbrTpCd = "USER";
			data.mbrId = loginId;
			data.userNm = dspNmKo;

			paragonCmm.callAjax("/viself/auth/authMember/insertAuthUser/json",data, function(json){		//-- 추가
				if(json.errYn === "E"){
					//-- 오류처리
					alert(json.msg);
					return false;
				}
				paragonCmm.callAjax("/viself/auth/authMember/updateAuthUser/json",data, function(json){	//-- v_sys_user.auth_cd 업데이트

				});
				loadAuthMember();
				$("#searchUserKeyword").combobox("clear");
			});
		}
	}
	//-- 권한 사용자 삭제
	var delAuthMember = function(authCd, loginId){

		authCd = ((authCd == undefined || authCd == "") ? $("input:radio[name='authCd']:checked").val() : authCd);
		if((authCd != null && authCd != "") || (loginId != null && loginId != "")){
			var data = {};
			data.authCd = authCd;

			if(typeof loginId === "string" && loginId != ""){
				data.mbrId = loginId;
			}
			paragonCmm.callAjax("/viself/auth/authMember/delete/json",data, function(json){
				if(json.errYn === "E"){
					//-- 오류처리
					alert(json.msg);
					return false;
				}

				paragonCmm.callAjax("/viself/auth/authMember/updateAuthUser/json",data, function(json){	//-- v_sys_user.auth_cd 업데이트

				});
				loadAuthMember();
			});
		}
	}
	//-- 권한 사용자추가 자동완성
	var getAutoAuthMember = function(){
		var selRecord = {};
		$('#searchUserKeyword').combobox({
			width:300,
    		mode: 'remote',
    		valueField: 'value',
    		textField: 'label',
    		prompt:paragonCmm.getLang("M.소속_또는_이름"),
    		onSelect:function(record){
    			if(!jQuery.isEmptyObject(selRecord)){
    				selRecord = {}
    			}
    			selRecord = record;
    		},
    		onHidePanel:function(){
    			console.log(selRecord);
    			addAuthMember(selRecord.data.loginId,selRecord.data.dspNmKo);
    		},
    		loader: function(param, succ){
    			if (!param.q){return;}
    			$.ajax({
    				url: "/paragon/hr/hrMng/list/json",
    				data: {dspNmKo:param.q},
    				dataType: 'json',
    				success: function(data){
    					var rows = $.map(data.data, function(item){
    						return {
    							value:item.dspNmKo,
 	 			                label:item.dspNmKo,
 	 			                data:item
    						};
    					});
    					succ(rows)
    				}
    			})
    		}
    	});
	}
	var attachEvents = function(){
		$("#saveAuthMenuBtn").off();
		$("#saveAuthMenuBtn").on("click",function(){
			saveAuthMenu();
		});
		$("#addAuthBtn").off();
		$("#addAuthBtn").on("click",function(){
			addAuthMng();
		});
		$("#uptAuthBtn").off();
		$("#uptAuthBtn").on("click",function(){
			//-- 권한수정처리
			uptAuthMng();
		});
		$("#resAuthBtn").off();
		$("#resAuthBtn").on("click",function(){
			//-- 등록모드변경
			$("#addAuthCd").val("").removeAttr("readonly");
			$("#addAuthNm").val("");
			$("#addAuthBtn").show();
			$("#resAuthBtn").hide();
			$("#uptAuthBtn").hide();
		});
		getAutoAuthMember();	//-- 사용자추가 자동완성
	}


	var loadForm = function(){
		loadAuths("CMM_SYS");
	}
	var init = function () {
		attachEvents();
		loadForm();
    };
	return{
    	init : init
    }
}
var auth = new Auth();
auth.init();

</script>