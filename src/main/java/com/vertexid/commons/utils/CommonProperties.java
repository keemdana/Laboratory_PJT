package com.vertexid.commons.utils;

import java.io.IOException;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

/**
 * @deprecated BaseProperties, CmmProperties 사용
 */
public class CommonProperties {

	/**
	 * the instance
	 */
	private static CommonProperties instance;


	/** 설정파일 이름 */
	private static final String propertiesPath = "/conf/air-common.properties";

    /**
     * 운영모드 properties를 저장할 Properties 클래스
     */
    private static Properties prop;


    /**
     * 개발 properties를 저장할 Properties 클래스
     */
    private static Properties devProp;

    /**
     * the constructor
     */
    private CommonProperties() {
    }

    /**
     * @return the instance
     */
    public static CommonProperties getInstance() {
    	init();

    	return instance;
    }
    public static Map<Object,Object> getPropMap() {
    	Map<Object,Object> map = new HashMap<Object, Object>();
    	for(Entry<Object, Object> s : prop.entrySet() )
    		map.put(s.getKey(), s.getValue());
    	return map;
    }
    @Autowired
    public static ApplicationContext context;

    public static void getTest() {
    	Environment environment = context.getEnvironment();
    	System.out.println("SSSSYYYSSS"+environment.getProperty("sys.operation.mode"));
    }
    /**
     * 초기화. .properties 파일을 읽어들인다.
     */
    private static void init() {
        try {
        	if (instance == null) {
        		instance = new CommonProperties();
        	}

        	try {
        		devProp = new Properties();
        		devProp.load(CommonProperties.class.getResourceAsStream("/conf/air-common-"+InetAddress.getLocalHost().getHostName()+".properties"));
        	}catch(IOException e) {

        		devProp = null;

        	}finally {
        		if (prop == null) {
        			prop = new Properties();
        			prop.load(CommonProperties.class.getResourceAsStream(propertiesPath));

        		}

			}

        } catch (Exception e) {
        	instance =  null;
            prop = null;
            System.out.println("Connection Exception occurred");
        }
    }


    /*
  	public static void main(String args[]) {

    	logger.debug(CommonProperties.class.getResource("").getPath());
    	logger.debug(CommonProperties.class.getResource("/").getPath());

    	logger.debug(CommonProperties.load("jdbc.databaseName"));
    	logger.debug(CommonProperties.load("jdbc.driverName"));
    	logger.debug(CommonProperties.load("smtp.user"));
    	logger.debug(CommonProperties.load("test"));
  	}
     */

	/**
     * 요청한 property를 리턴한다.
     * @param property property name
     * @return String property value
     * @deprecated BaseProperties.get
     */
    public static String load(String property) {
        String res = null;

        if (prop == null) {
            init();
        }

        if(devProp != null) {
        	res = devProp.getProperty(property);
        }
        if(StringUtil.isBlank(res)) {
        	res = prop.getProperty(property);
        }

        if (res != null) {
            res = res.trim();
        }

        return res;
    }

    /**
     * 시스템 모드 값 반환 [DEV:개발, TEST:테스트, (없음):운영]
     * @return
     * @deprecated CmmProperties.getOperationMode
     */
    public static String getSystemMode() {
    	return load("system.mode");
    }

    /**
     * 시스템 솔루션 값 반환 [lms,ips]
     * @return
     * @deprecated CmmProperties.getSolutionName
     */
    public static String getSystemSolusion() {
    	return load("system.solusion");
    }

    /**
     * 시스템 기본 로케일 값 반환 [KO:한국어, EN:영어]
     * @return
     * @deprecated CmmProperties.getDefaultLang
     */
    public static String getSystemDefaultLocale() {
    	return load("system.defaultLocale");
    }

    /**
     * 시스템 캐릭터셋 값 반환
     * @return
     * @deprecated CmmProperties.getCharSet
     */
    public static String getSystemCharSet() {
    	return load("system.charSet");
    }

    /**
     * 로케일 설정별 시스템 타이틀 반환
     * @param localeCode
     * @return
     * @deprecated CmmProperties.getSystemTitle
     */
    public static String getSystemTitle(String localeCode) {
    	if ("EN".equals(localeCode)) {
    		return load("system.title_en");
    	} else {
    		return load("system.title_ko");
    	}
    }

    /**
     * 시스템 루트 경로 반환
     * @return
     * @deprecated CmmProperties.getSrcRootPath
     */
    public static String getSystemRootPath() {

    	return load("system.rootPath");

    }

    /**
     * 로케일 설정별 시스템 기관명 반환
     * @param localeCode
     * @return
     */
    public static String getSystemOrganization(String localeCode) {
    	if ("EN".equals(localeCode)) {
    		return load("system.organization_en");
    	} else {
    		return load("system.organization_ko");
    	}
    }

    /**
     * 시스템 관리자 이름 반환
     * @return
     * @deprecated CmmProperties.getAdminName
     */
    public static String getSystemAdminName() {
    	return load("system.adminName");
    }

    /**
     * 시스템 관리자 이메일 주소 반환
     * @return
     * @deprecated CmmProperties.getAdminEmail
     */
    public static String getSystemAdminEmail() {
    	return load("system.adminEmail");
    }

    /**
     * 시스템 기본 이메일 주소 반환
     * @return
     * @deprecated CmmProperties.getSenderOnlyMailAddr
     */
    public static String getSystemDefaultEmail() {
    	String res = (!"".equals(getSystemAdminName()) ? "\""+ getSystemAdminName() +"\" " : "");
    	if (!"".equals(res)) {
    		res += "<"+ getSystemAdminEmail() +">";
    	} else {
    		res = getSystemAdminEmail();
    	}

    	return res;
    }

    /**
     * 시스템 기본 컨텐츠 경로 반환
     * @return
     * @deprecated CmmProperties.getDefaultContentUrl
     */
    public static String getSystemDefaultContentUrl() {
    	return load("system.defaultContentUrl");
    }

    /**
     * 시스템 주소 (Default Protocol + Domain Name + Context Path)
     * @return
     * @deprecated CmmProperties.getSystemUrl
     */
    public static String getSystemDefaultUrl() {
    	return getWasProtocol() + getWasDomainName() + getWasContextPath();
    }

    /**
     * 시스템 보안 주소 (Security Protocol + Security Domain Name + Context Path)
     * @return
     * @deprecated CmmProperties.getSystemUrl
     */
    public static String getSystemSecurityUrl() {
    	return getWasSecurityProtocol() + getWasSecurityDomainName() + getWasContextPath();
    }

    /**
     * 데이터 베이스 타입 반환
     * @return
     */
    public static String getDatabaseName() {
    	return load("jdbc.databaseName");
    }

    /**
     * WAS 이름 [TOMCAT:Tomcat, JEUS:제우스, WEBLOGIC:웹로직]
     * @return
     */
    public static String getWasName() {
    	return load("was.name");
    }

    /**
     * WAS 버전
     * @return
     */
    public static String getWasVersion() {
    	return load("was.version");
    }

    /**
     * WAS 도메인  이름
     * @return
     */
    public static String getWasDomainName() {
    	return load("was.domainName");
    }

    /**
     * WAS Context Path ex> /web
     * @return
     */
    public static String getWasContextPath() {
    	return load("was.contextPath");
    }

    /**
     * WAS IP
     * @return
     */
    public static String getWasIP() {
    	return load("was.ip");
    }

    /**
     * WAS Port
     * @return
     */
    public static String getWasPort() {
    	return load("was.port");
    }

    /**
     * WAS Protocol ex> http://
     * @return
     */
    public static String getWasProtocol() {
    	String res = load("was.protocol");

    	res = (res == null || "".equals(res) ? "http://" : res);
    	res = (load("was.securityProtocol") == null || "".equals(load("was.securityProtocol")) ? res : load("was.securityProtocol"));

    	return res;
    }

    /**
     * WAS Security Protocol ex> https://
     * @return
     */
    public static String getWasSecurityProtocol() {
    	String res = load("was.securityProtocol");
    	res = (res == null || "".equals(res) ? getWasProtocol() : res);

    	return res;
    }

    /**
     * WAS Security Domain Name ex> localhost:443
     * @return
     */
    public static String getWasSecurityDomainName() {
    	String res = load("was.securityDomainName");
    	res = (res == null || "".equals(res) ? getWasDomainName() : res);

    	return res;
    }

    /**
     * WAS AMS도메인  이름
     * @return
     */
    public static String getWasAMSDomainName() {
    	return load("was.amsDomainName");
    }


    /**
     * 페이징 - 한 페이지에 보여줄 Row 수 기본값
     * @return
     * @deprecated CmmProperties.getDefaultRowCount
     */
    public static Integer getPagingDefaultRowSize() {
    	return Integer.parseInt(load("paging.defaultRowSize"));
    }

    /**
     * 페이징 - 한 페이지에 보여줄 Row 50 기본값
     * @return
     */
    public static Integer getPagingDefaultRowSize50() {
    	return Integer.parseInt(load("paging.defaultRowSize50"));

    }
    /**
     * 페이징 - 한 페이지에 보여줄 페이지 목록 수 기본값
     * @return
     * @deprecated CmmProperties.getDefaultPageCount
     */
    public static Integer getPagingDefaultPageListSize() {
    	return Integer.parseInt(load("paging.defaultPageListSize"));
    }

    /**
     * 첨부 - 기본 저장 경로
     * @return
     * @deprecated CmmProperties.getSaveRootPath
     */
    public static String getAttachmentDefaultSavePath() {
    	return load("attachment.defaultSavePath");
    }

    /**
     * 첨부 - 기본 최대 파일 크기
     * @return
     */
    public static Integer getAttachmentDefaultMaxFileSize() {
    	return Integer.parseInt(load("attachment.defaultMaxFileSize"));
    }

    /**
     * 첨부 - 기본 최대 파일 수
     * @return
     */
    public static Integer getAttachmentDefaultMaxFileCount() {
    	return Integer.parseInt(load("attachment.defaultMaxFileCount"));
    }

    /**
     * 각종 양식 - 기본 경로
     * @return
     */
    public static String getFormDefaultPath() {
    	return load("form.defaultPath");
    }


    /**
     * @deprecated CmmProperties.useBatchDownload
     * @return
     */
    public static String getBatchDownload() {
    	return load("fnc.batchDownload");
    }

}
