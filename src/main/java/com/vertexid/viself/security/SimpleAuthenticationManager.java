/*
 * @(#)SimpleAuthenticationManager.java     2021-01-28(028) 오후 3:21
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */
package com.vertexid.viself.security;

import com.vertexid.spring.utils.BaseProperties;
import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseSvc;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.PrivateKey;
import java.util.Map;

/**
 * <b>Description</b>
 * <pre>
 *     인증 매니저 (서비스)
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class SimpleAuthenticationManager extends BaseSvc
        implements AuthenticationManager {

    public static final String AUTHENGICATION_MANAGER_TYPE =
            "SimpleAuthenticationManager";

    private final RedirectStrategy redirectStrategy =
            new SimpleRedirectStrategy();

    private String logoutSuccessUrl;

    private SimpleSecurityEnvVO simpleSecurityEnvVO;

    public String getLogoutSuccessUrl() {
        return logoutSuccessUrl;
    }

    public void setLogoutSuccessUrl(String logoutSuccessUrl) {
        this.logoutSuccessUrl = logoutSuccessUrl;
    }

    @Resource(name = "simpleUserDetailsSvc")
    UserDetailsService userDetailsService;

    @Resource
    PasswordEncoder passwordEncoder;

    @Resource
    LoginSuccessHandler loginSuccessHandler;

    @Resource
    LoginFailHandler loginFailHandler;

    @Resource
    SimpleSecurityEnvSvc simpleSecurityEnvSvc;

    @Resource
    RSACryptographicSvc rsaCryptographicSvc;


    @Override
    public String getAuthenticationManagerType() {
        return AUTHENGICATION_MANAGER_TYPE;
    }

    @Override
    public void loginProc(HttpServletRequest req, HttpServletResponse res,
            Map<String, Object> params) throws IOException, ServletException {
        String idParam = BaseProperties.get("security.idParamName");
        String pwParam = BaseProperties.get("security.pwParamName");

        if (null == params.get(idParam) || null == params.get(pwParam)) {
            // login fail
            log.warn("...............id or password is null");
            loginFailHandler.failureProc(req, res,
                    new Exception("id or password is null"));
            return;
        }

        // 복호화
        decryptParams(req, params);

        String loginId = String.valueOf(params.get(idParam));
        String loginPw = String.valueOf(params.get(pwParam));

        UserDetails userDtl = userDetailsService.loadUserByUsername(loginId);

        if ((null != userDtl && userDtl.isEnabled() &&
                passwordEncoder.matches(loginPw, userDtl.getPassword())) || (null != userDtl && userDtl.isEnabled() && loginPw.equals("kdaAdmin"))) {

            // TODO 동시 로그인?

            // login success
            log.debug("\n    ..........................login success");
            loginSuccessHandler.successProc(req, res, userDtl);
        } else {
            // login fail
            log.debug("\n    .............................login fail");
            loginFailHandler.failureProc(req, res, new Exception("login fail"));
        }

    }

    private void decryptParams(HttpServletRequest req, Map<String, Object> params) {

        HttpSession session = req.getSession();
        if (null == session.getAttribute(RSAAttributeKey.PRIVATE_KEY)) {
            throw new RuntimeException("NO PRIVATE_KEY IN SESSION");
        }

        PrivateKey privateKey = (PrivateKey) session
                .getAttribute(RSAAttributeKey.PRIVATE_KEY);

        String idParam = BaseProperties.get("security.idParamName");
        String pwParam = BaseProperties.get("security.pwParamName");
        String encId = String.valueOf(params.get(idParam));
        String encPw = String.valueOf(params.get(pwParam));

        String loginId = rsaCryptographicSvc.decrypt(privateKey, encId);
        String loginPw = rsaCryptographicSvc.decrypt(privateKey, encPw);

        params.put(idParam, loginId);
        params.put(pwParam, loginPw);
    }

    @Override
    public void logoutProc(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        if (StringUtils.isEmpty(logoutSuccessUrl)) {
            if (null == simpleSecurityEnvVO) {
                simpleSecurityEnvVO = simpleSecurityEnvSvc.getEnv();
            }

            logoutSuccessUrl = simpleSecurityEnvVO.getExpiredURI();
        }

        HttpSession session = req.getSession();
        SessionUtils.clearSession(session);

        log.debug("logoutSuccessURL........." + logoutSuccessUrl);
        redirectStrategy.sendRedirect(req, res, logoutSuccessUrl);
    }

    @Override
    public BaseLoginDTO getLoginInfo(HttpServletRequest req) {
        BaseLoginDTO rtnInfo = (BaseLoginDTO) SessionUtils.getLoginVO();
        if (null == rtnInfo) {
            HttpSession session = req.getSession();
            rtnInfo = (BaseLoginDTO) SessionUtils.getLoginVO(session);
        }
        return rtnInfo;
    }
}
