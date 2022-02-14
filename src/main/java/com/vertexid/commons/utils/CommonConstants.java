package com.vertexid.commons.utils;

public class CommonConstants {

	/**
	 * the instance
	 */
	private static CommonConstants instance;
	/**
	 * REQUEST PARAMETER - 멀티파트여부
	 */
	public static final String IS_MULTIPART 		= "IS_MULTIPART";

	/**
	 * REQUEST PARAMETER - 다국어 최종 버전
	 */
	public static final String LAST_LANG_VERSION 	= "lastLangVersion";

	/**
     * REQUEST PARAMETER - 페이지 번호
     */
    public static final String PAGE_NO 				= "page";

    /**
     * REQUEST PARAMETER - 페이지당 행 수
     */
    public static final String PAGE_ROWSIZE 		= "rows";

    /**
     * REQUEST PARAMETER - 페이지 정렬 필드
     */
    public static final String PAGE_ORDERBY_FIELD 		= "sort";

    /**
     * REQUEST PARAMETER - 페이지 정렬 방식
     */
    public static final String PAGE_ORDERBY_METHOD 		= "order";

    /**
	 * REQUEST PARAMETER - 액션 코드
	 */
    public static final String ACTION_CD 			= "AIR_ACTION";

    /**
	 * REQUEST PARAMETER - 파티클 코드
	 */
    public static final String PARTICLE_CODE 			= "AIR_PARTICLE";

    /**
	 * REQUEST PARAMETER - 모드 코드
	 */
    public static final String MODE_CD 			= "AIR_MODE";

    /**
	 * REQUEST ATTRIBUTE - 메뉴 코드
	 */
    public static final String MENU_CODE			= "AIR_MENU";

    /**
	 * REQUEST ATTRIBUTE - 리디렉션 코드 [00:FORWARD, 10:INCLUDE]
	 */
    public static final String REDIRECTION_CODE 	= "AIR_REDIRECTION";

    /**
	 * REQUEST ATTRIBUTE - 클래스 경로
	 */
    public static final String CLASS_PATH 			= "AIR_CLASS_PATH";

    /**
	 * REQUEST ATTRIBUTE - 템플릿 페이지 경로
	 */
    public static final String TEMPLATE_PATH 		= "AIR_TEMPLATE_PATH";

    /**
	 * REQUEST ATTRIBUTE - 내용 페이지 경로
	 */
    public static final String CONTENT_PATH 		= "AIR_CONTENT_PATH";

    /**
	 * REQUEST ATTRIBUTE - 내용 페이지 이름
	 */
    public static final String CONTENT_NAME 		= "AIR_CONTENT_NAME";

    /**
     * Request referer site code
     */
    public static final String REFERER_SITE = "REFERER_SITE";

    /**
     * 에러 코드 - 일반
     */
    public static final String ERROR_CODE_DEFAULT		= "DEFAULT";

    /**
     * 에러 코드 - 로그인정보없음
     */
	public static final String ERROR_CODE_NOTLOGIN		= "NOTLOGIN";

	/**
	 * 에러 코드 - 다중접속
	 */
	public static final String ERROR_CODE_MULTILOGIN		= "MULTILOGIN";

	/**
     * 에러 코드 - 권한없음
     */
	public static final String ERROR_CODE_NOPERMISSION	= "NOPERMISSION";

	/**
     * 구분자 - 연결 경로
     */
    public static final String SEPAR_CONNECTPATH	= "≫";

    /**
     * 구분자 - 코드정보 문자열 값
     */
    public static final String SEPAR_CODESTRVALUE	= "|";

    /**
   	 * SESSION ATTRIBUTE - 사용자 정보
   	 */
    public static final String SESSION_USER 		= "sessionUser";

	public static String _LOGIN_USER_ID = "_LOGIN_USER_ID";

	public static String _LOGIN_USER_NO = "_LOGIN_USER_NO";

	public static String _LOGIN_CORP_CD = "_LOGIN_CORP_CD";

	public static String _LOGIN_CORP_NM = "_LOGIN_CORP_NM";

	public static String _LOGIN_USER_IP = "_LOGIN_USER_IP";

	public static String _LOGIN_USER_NM = "_LOGIN_USER_NM";

	public static String _IS_CHARGE_USER = "_IS_CHARGE_USER";

	public static String _LOGIN_USER_DPT_CD = "_LOGIN_USER_DPT_CD";

	public static String _LOGIN_USER_DPT_NM = "_LOGIN_USER_DPT_NM";

	public static String _LOGIN_USER_AUTHS = "_LOGIN_USER_AUTHS";

	public static String _JSON_DATA = "_JSON_DATA";

    /**
     * SITE LOCALE - 사이트 언어
     */
    public static final String _SITE_LOCALE 		= "siteLocale";


    /**
     * 관리자 권한 코드 - 시스템 관리자
     */
    public static final String ADMIN_AUTH_SYS = "CMM/SYS";



    /**
     * @return the instance
     */
    public static CommonConstants getInstance() {
    	if (instance == null) {
    		instance = new CommonConstants();
    	}

    	return instance;
    }

}
