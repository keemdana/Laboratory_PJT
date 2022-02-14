/*
 * @(#)BaseLoginDTO.java     2021-02-02(002) 오전 10:25
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

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.vertexid.viself.base.CmmDTO;
import com.vertexid.viself.login.RoleType;

/**
 * <b>Description</b>
 * <pre>
 *     UserDetails를 구현한 기본 Login DTO
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseLoginDTO extends CmmDTO implements UserDetails {
    private static final long serialVersionUID = 5467335629827610875L;

    private String username;
    private String password;
    private boolean isAccountNonExpired = true;
    private boolean isAccountNonLocked = true;
    private boolean isCredentialsNonExpired = true;
    private boolean isEnabled = true;
    private Collection<GrantedAuthority> authorities;

    public BaseLoginDTO() {
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return isAccountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return isAccountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return isCredentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return isEnabled;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setAccountNonExpired(boolean accountNonExpired) {
        isAccountNonExpired = accountNonExpired;
    }

    public void setAccountNonLocked(boolean accountNonLocked) {
        isAccountNonLocked = accountNonLocked;
    }

    public void setCredentialsNonExpired(boolean credentialsNonExpired) {
        isCredentialsNonExpired = credentialsNonExpired;
    }

    public void setEnabled(boolean enabled) {
        isEnabled = enabled;
    }

    public void setAuthorities(Collection<GrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    public boolean containsAuthorities(String authority) {
        return containsAuthorities(new SimpleGrantedAuthority(authority));
    }

    public boolean containsAuthorities(GrantedAuthority authority) {
        if (null == authorities) {
            return false;
        }
        return authorities.contains(authority);
    }

    public boolean isSuperuser(){
        return containsAuthorities(RoleType.SUPER.getAuthority());
    }

    public boolean isDeveloper(){
        return containsAuthorities(RoleType.DEV.getAuthority());
    }
}
