<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vertexid.spring.utils.CmmProperties"%>
<%@page import="com.vertexid.spring.utils.BaseProperties"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

    //-- 파라메터 셋팅


    //-- 테스트 사용자 로그인 기능 사용여부


    SysLoginVO loginUser =     (SysLoginVO) SessionUtils.getLoginVO();
    if (loginUser == null) { loginUser = new SysLoginVO(); }
    String remoteAddr = request.getRemoteAddr();
    if ("".equals(loginUser.getLoginId())) {
%>
<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<div id="login-page">
    <div class="container">
        <div style="margin:200px 0 -80px 0; text-align:center;">
<%--            <img src="/js/vendor/dashio/img/login-logo.png">--%>
            <p style="margin:30px 0 0 0; font-size:15px; font-weight:bold;">R&D Portal 을 이용하기 위해서는 로그인이 필요합니다. </p>
        </div>
        <form class="form-login" id="loginForm" name="form1" method="post">
            <input type="hidden" name="<c:out value='${_csrf.parameterName}'/>" id="<c:out value='${_csrf.parameterName}'/>" value="<c:out value='${_csrf.token}'/>"/>
            <h2 class="form-login-heading"></h2>
            <div class="login-wrap">
                <input type="text" name="loginId" class="form-control" placeholder="User ID" autofocus required>
                <br>
                <input type="password" name="loginPwd" class="form-control" placeholder="Password" required>
<%--                <label class="checkbox">--%>
<%--                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="chkSaveId" id="chkSaveId" value="Y"> 아이디저장--%>
<%--                </label>--%>
                <br>
                <button id="loginBtn" class="btn btn-theme05 btn-block" type="submit"><i class="fa fa-lock"></i> 로그인</button>
            </div>
            <!-- Modal -->
            <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Forgot Password ?</h4>
                        </div>
                        <div class="modal-body">
                            <p>Enter your e-mail address below to reset your password.</p>
                            <input type="text" name="email" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix">
                        </div>
                        <div class="modal-footer">
                            <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
                            <button class="btn btn-theme" type="button">Submit</button>
                        </div>
                    </div>
                </div>
            </div><!-- modal -->
        </form>
        <form id="encLoginForm" name="encLoginForm" method="post" action="<c:url value='/login/proc'/>" style="display: none;">
            <input type="hidden" name="encParams">
            <input type="hidden" name="loginId">
            <input type="hidden" name="loginPwd">
            <input type="hidden" name="<c:out value='${_csrf.parameterName}'/>" value="<c:out value='${_csrf.token}'/>">
        </form>
        <div style="margin:20px auto 0 auto; text-align:center;">Copyright ⓒ Vertex ID. All reserved.</div>
    </div>
</div>
<script type="text/javascript">

    var sehPassword = function(){
        var url = '/ServletController';
        url += '?AIR_ACTION=LMS_LOGIN';
        url += '&AIR_MODE=LOGIN_CHG';
        url += '&SEARCH=Y'

        paragonCmm.openWindow(url, 800, 220, 'popLoginChg', 'yes', 'yes' );
    }

    /**
     * 로그인 처리
     */
    function doSubmit(frm, isCheckEnter) {
        if (isCheckEnter && event.keyCode != 13) {
            return;
        }

        if (frm.loginId.value == "") {
            /* alert("ID를 입력해주세요.");
            frm.loginId.focus(); */
            alert("ID를 입력해주세요.", function(){
                frm.loginId.focus();
            });
            return;
        }

        if (frm.loginPwd.value == "") {
            /* alert("Password를 입력해주세요.");
            frm.loginPwd.focus(); */
            alert("Password를 입력해주세요.", function(){
                frm.loginPwd.focus();
            });
            return;
        }

        //아이디 저장 체크
        if (frm.chkSaveId.checked) {
            paragonCmm.setCookie("loginId", frm.loginId.value, 7);
        } else {
            paragonCmm.setCookie("loginId", "", 7);
        }


        form1.target = "_self";
        form1.submit();
    }

    // /**
    //  * 아이디 focus
    //  */
    // $(document).ready(function() {
//    document.form1.loginId.focus();
//     bgChgPw(document.form1.loginPwd);

//    var login_id    = paragonCmm.getCookie("loginId");

//     if (login_id == "") {
//         document.form1.loginId.focus();
//     } else {
//         document.form1.chkSaveId.checked = true;
//         document.form1.loginId.value = login_id;
//         document.form1.loginPwd.focus();
//     }
//      $.backstretch("/js/vendor/dashio/img/login-bg.jpg", {
//           speed: 500
//         });
//     });

    var ImsLogin = function(){
        var model = (function(){
            var RSA_INIT_URL = "/rsa/init";

            var encRsa = function(param, cbFnc){
                $.ajax({
                    url: paragonCmm.getUrl(RSA_INIT_URL),
                    type: "POST",
                    dataType: "json",
                    success: function(data){

                        var publicKeyModulus = data.publicKeyModulus;
                        var publicKeyExponent = data.publicKeyExponent;

                        var rsa = new RSAKey();
                        rsa.setPublic(publicKeyModulus, publicKeyExponent);

                        var loginData = {
                            encId: rsa.encrypt(param.loginId),
                            encPw: rsa.encrypt(param.password)
                        };

                        if(typeof cbFnc === "function"){
                            cbFnc(loginData);
                        }
                    }
                });
            };

            return {
                encRsa: encRsa
            };
        })();

        var $inputForm = $("#loginForm");
        var $loginBtn = $("#loginBtn");
        var $encLoginForm = $("#encLoginForm");
        var $inputLoginId = $inputForm.find("input[name=loginId]");

        var checkForm = function(){
            if ($inputLoginId.val() == "") {
                // alert("ID를 입력해주세요.", function(){
                //     $inputLoginId.focus();
                // });
                $inputLoginId.focus();
                return false;
            }

            if ($inputForm.find("input[name=loginPwd]").val() == "") {
                // alert("Password를 입력해주세요.", function(){
                //     $inputForm.find("input[name=loginPwd]").focus();
                // });
                $inputForm.find("input[name=loginPwd]").focus();
                return false;
            }

            if($inputForm.find("input:checkbox[name=chkSaveId]").is(":checked")) {

                console.log("id save");

                paragonCmm.setCookie("loginId", $inputLoginId.val(), 7);
            } else {
                console.log("id not save");
                paragonCmm.setCookie("loginId", "", 7);
            }

            return true;
        };

        var sendForm = function(param){
            $encLoginForm.find("input[name=loginId]").val(param.encId);
            $encLoginForm.find("input[name=loginPwd]").val(param.encPw);
            $encLoginForm.submit();
        };

        var doLogin = function(){
            if(checkForm()){
                var param = {
                    loginId: $inputLoginId.val(),
                    password: $inputForm.find("input[name=loginPwd]").val()
                };

                model.encRsa(param, sendForm);
            }
        };

        var initId = function(){
            var login_id    = paragonCmm.getCookie("loginId");

            if (login_id === "") {
                document.form1.loginId.focus();
            } else {
                $inputForm.find("input:checkbox[name=chkSaveId]").attr("checked", true);
                $inputLoginId.val(login_id);
                $inputLoginId.focus();
            }
        };

        var setEvent = function(){
            $inputForm.on("submit", function(){
                doLogin();
                return false;
            });
            $loginBtn.on("click", function(){
                doLogin();
                return false;
            });
        };

        var init = function(){
            initId();
            setEvent();
        };

        return {
            init: init
        };
    };

    $(document).ready(function(){
        var imsLogin = new ImsLogin();
        imsLogin.init();
    });
</script>
<% if (CmmProperties.isLocal()){ %>
        <div style=" width:700px; margin:0 auto; padding-top: 8%">
            <table style="position:relative; width:100%; margin:0 auto; font-size: 12px;">
            <colgroup>
                <col style="width:15%;" />
                <col style="width:auto;" />
            </colgroup>
            <tr>
                <th>일반 부서</th>
                <td style="padding:5px;">
                    <a href="#" onClick="javascript:autoLog('9903092','')">강사원 (일반 사용자)</a>
                </td>
            </tr>
            <tr>
                <th>관리자</th>
                <td style="padding:5px;">
                    <a href="#" onClick="javascript:autoLog('2001138','')">김전산 (시스템 관리)</a>
                </td>
            </tr>
            <tr>
                <th>개발자</th>
                <td style="padding:5px;">
                    <a href="#" onClick="javascript:autoLog('ADMIN','')">개발자 (시스템 설정)</a>
                </td>
            </tr>
            </table>
        </div>
        <br /><br />
<script type="text/javascript">
    function autoLog(no_str){
        var frm = document.form1 ;

        frm.loginId.value   = no_str;
        // frm.loginPwd.value  = "empass10!";
        frm.loginPwd.value  = "dev!@#123Pwd";

        // //아이디 저장 체크
        // if (frm.chkSaveId.checked) {
        //     paragonCmm.setCookie("loginId", frm.loginId.value, 7);
        // } else {
        //     paragonCmm.setCookie("loginId", "", 7);
        // }
        //
        // frm.submit();

        $("#loginBtn").trigger("click");
    }
</script>
<% } %>

<% } else { %>
<form name="form1" method="post" action="/login/proc" onsubmit="return false;" >
<input type="hidden" name="loginId" value=""/>
<input type="hidden" name="loginPwd" value=""/>
</form>
<script type="text/javascript">
//     location.replace('/main/loginProc');

var frm = document.form1 ;

frm.loginId.value   = "<%=loginUser.getLoginId()%>";
// frm.loginPwd.value  = "empass10!";
frm.loginPwd.value  = "dev!@#123Pwd";
// frm.submit();
$("#loginBtn").trigger("click");

</script>
<%} %>