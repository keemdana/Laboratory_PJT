package de.vogella.sap.jco.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class SapSystem {

    private String client = "";
    private String user = "";
    private String password = "";
    private String language = "KO";
    private String host = "";
    private String systemNumber = "";
    private String systemId = "";

    public void setClient(String client) {
        this.client = client;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public void setSystemNumber(String sysID) {
        this.systemNumber = sysID;
    }

    public void setSystemId(String systemId) {
        this.systemId = systemId;
    }

    public String getClient() {
        return client;
    }

    public String getUser() {
        return user;
    }

    public String getPassword() {
        return password;
    }

    public String getLanguage() {
        return language;
    }

    public String getHost() {
        return host;
    }

    public String getSystemNumber() {
        return systemNumber;
    }

    public String getSystemId() {
        return systemId;
    }

    public String toString() {
        return ToStringBuilder
                .reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}