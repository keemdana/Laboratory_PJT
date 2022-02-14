package com.vertexid.viself.hr;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.spring.utils.BaseProperties;
import com.vertexid.viself.login.SimpleLoginVO;
import org.apache.commons.lang3.StringUtils;
@JsonIgnoreProperties(ignoreUnknown = true)
public class SysLoginVO extends SimpleLoginVO {
    private static final long serialVersionUID = -5276392619627642679L;

    private String name = "";
    private String addr = "";
    private String companyName = "";
    private String groupName = "";
    private String dutyName = "";
    private String positionName = "";
    private String userTypeName = "";
    private String dspName = "";

    // 사용자 번호 사번
    private String userNo = "";

    // 부서 코드
    private String deptCd = "";

    // 로그인 ID
    private String loginId = "";

    // 로그인 비밀번호
    private String loginPwd = "";

    // 명칭 한글
    private String nmKo = "";

    // 명칭 영문
    private String nmEn = "";

    // 명칭 일문
    private String nmJa = "";

    // 명칭 중문
    private String nmZh = "";

    // 표시 명칭 한글
    private String dspNmKo = "";

    // 표시 명칭 영문
    private String dspNmEn = "";

    // 표시 명칭 일문
    private String dspNmJa = "";

    // 표시 명칭 중문
    private String dspNmZh = "";

    // 주민 등록 번호 주민번호
    private String residentRegNo = "";

    // 이메일
    private String email = "";

    // 전화 번호
    private String telNo = "";

    // 모바일 번호
    private String mobileNo = "";

    // 주소 한글
    private String addrKo = "";

    // 주소 영문
    private String addrEn = "";

    // 주소 일문
    private String addrJa = "";

    // 주소 중문
    private String addrZh = "";

    // 직급 코드
    private String positionCd = "";

    // 직급 언어 코드
    private String positionLangCd = "";

    // 직책 코드
    private String dutyCd = "";

    // 직책 언어 코드
    private String dutyLangCd = "";

    // 사용자 유형
    private String userType = "";

    // 사용자 유형 언어 코드
    private String userTypeLangCd = "";

    // 부서 명칭 한글
    private String deptNmKo = "";

    // 부서 명칭 영문
    private String deptNmEn = "";

    // 부서 명칭 일문
    private String deptNmJa = "";

    // 부서 명칭 중문
    private String deptNmZh = "";

    // 사업장 코드 외부일일경우 사업장 코드
    private String corpCd = "";

    // 사업장 코드 외부일일경우 사업장 코드
    private String corpNm = "";

    // 사업장 유형 외부 사용자일때 사업장 유형
    private String corpType = "";

    // 부서 코드 경로
    private String deptCdPath = "";

    // 부서 명칭 경로 한글
    private String deptNmPathKo = "";

    // 부서 명칭 경로 영문
    private String deptNmPathEn = "";

    // 부서 명칭 경로 일문
    private String deptNmPathJa = "";

    // 부서 명칭 경로 중문
    private String deptNmPathZh = "";

    // 팀장 YN
    private String chiefYn = "";

    // 사이트 로케일
    private String siteLocale = "";

    // 권한 코드
    private String authCd = "";

    // 권한 코드
    private String authLangCd = "";

    // 사용 여부
    private String useYn = "";

    // 로그인 아이피
    private String loginIp = "";

    // 관리 회계 영역(SAP 법인코드)
    private String kokrs = "";

    // 등록 일자
    private String regDte = "";

    // 등록 ID
    private String regLoginId = "";

    // 수정 일자
    private String uptDte = "";

    // 수정 ID
    private String uptLoginId = "";
    
    // 부서영역
    private String deptArea = "";
    // 부서권한
    private String deptAuth = "";

    // 부서영역
    public String getDeptArea() {
		return deptArea;
	}

    // 부서영역
	public void setDeptArea(String deptArea) {
		this.deptArea = deptArea;
	}
	// 부서권한
	public String getDeptAuth() {
		return deptAuth;
	}
	// 부서권한
	public void setDeptAuth(String deptAuth) {
		this.deptAuth = deptAuth;
	}

	public SysLoginVO() {
    }

    public void setDspName(String dspName) {
        this.dspName = dspName;
    }

    public String getName() {
        if("Y".equals(BaseProperties.get("fnc.userNameDisplay.useYn"))) return dspName;
        else return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getDutyName() {
        return dutyName;
    }

    public String getDutyName(String siteLocale) {
        return StringUtil.getLocaleWord(dutyLangCd, siteLocale);
    }

    public void setDutyName(String dutyName) {
        this.dutyName = dutyName;
    }

    public String getPositionName() {
        return positionName;
    }

    public String getPositionName(String siteLocale) {
        return StringUtil.getLocaleWord(positionLangCd, siteLocale);
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getUserTypeName() {
        return userTypeName;
    }

    public String getUserTypeName(String siteLocale) {
        return StringUtil.getLocaleWord(userTypeLangCd, siteLocale);
    }

    public void setUserTypeName(String userTypeName) {
        this.userTypeName = userTypeName;
    }

    public String getAuthLangCd() {
        return authLangCd;
    }

    public void setAuthLangCd(String authLangCd) {
        this.authLangCd = authLangCd;
    }

    public String getDspName() {
        return dspName;
    }

    public String getUserNo() {
        return userNo;
    }

    public void setUserNo(String userNo) {
        this.userNo = userNo;
    }

    public String getDeptCd() {
        return deptCd;
    }

    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    public String getNmKo() {
        return nmKo;
    }

    public void setNmKo(String nmKo) {
        this.nmKo = nmKo;
    }

    public String getNmEn() {
        return nmEn;
    }

    public void setNmEn(String nmEn) {
        this.nmEn = nmEn;
    }

    public String getNmJa() {
        return nmJa;
    }

    public void setNmJa(String nmJa) {
        this.nmJa = nmJa;
    }

    public String getNmZh() {
        return nmZh;
    }

    public void setNmZh(String nmZh) {
        this.nmZh = nmZh;
    }

    public String getDspNmKo() {
        return dspNmKo;
    }

    public void setDspNmKo(String dspNmKo) {
        this.dspNmKo = dspNmKo;
    }

    public String getDspNmEn() {
        return dspNmEn;
    }

    public void setDspNmEn(String dspNmEn) {
        this.dspNmEn = dspNmEn;
    }

    public String getDspNmJa() {
        return dspNmJa;
    }

    public void setDspNmJa(String dspNmJa) {
        this.dspNmJa = dspNmJa;
    }

    public String getDspNmZh() {
        return dspNmZh;
    }

    public void setDspNmZh(String dspNmZh) {
        this.dspNmZh = dspNmZh;
    }

    public String getResidentRegNo() {
        return residentRegNo;
    }

    public void setResidentRegNo(String residentRegNo) {
        this.residentRegNo = residentRegNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelNo() {
        return telNo;
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getMobileNo() {
        return mobileNo;
    }

    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getAddrKo() {
        return addrKo;
    }

    public void setAddrKo(String addrKo) {
        this.addrKo = addrKo;
    }

    public String getAddrEn() {
        return addrEn;
    }

    public void setAddrEn(String addrEn) {
        this.addrEn = addrEn;
    }

    public String getAddrJa() {
        return addrJa;
    }

    public void setAddrJa(String addrJa) {
        this.addrJa = addrJa;
    }

    public String getAddrZh() {
        return addrZh;
    }

    public void setAddrZh(String addrZh) {
        this.addrZh = addrZh;
    }

    public String getPositionCd() {
        return positionCd;
    }

    public void setPositionCd(String positionCd) {
        this.positionCd = positionCd;
    }

    public String getPositionLangCd() {
        return positionLangCd;
    }

    public void setPositionLangCd(String positionLangCd) {
        this.positionLangCd = positionLangCd;
    }

    public String getDutyCd() {
        return dutyCd;
    }

    public void setDutyCd(String dutyCd) {
        this.dutyCd = dutyCd;
    }

    public String getDutyLangCd() {
        return dutyLangCd;
    }

    public void setDutyLangCd(String dutyLangCd) {
        this.dutyLangCd = dutyLangCd;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getUserTypeLangCd() {
        return userTypeLangCd;
    }

    public void setUserTypeLangCd(String userTypeLangCd) {
        this.userTypeLangCd = userTypeLangCd;
    }

    public String getDeptNmKo() {
        return deptNmKo;
    }

    public void setDeptNmKo(String deptNmKo) {
        this.deptNmKo = deptNmKo;
    }

    public String getDeptNmEn() {
        return deptNmEn;
    }

    public void setDeptNmEn(String deptNmEn) {
        this.deptNmEn = deptNmEn;
    }

    public String getDeptNmJa() {
        return deptNmJa;
    }

    public void setDeptNmJa(String deptNmJa) {
        this.deptNmJa = deptNmJa;
    }

    public String getDeptNmZh() {
        return deptNmZh;
    }

    public void setDeptNmZh(String deptNmZh) {
        this.deptNmZh = deptNmZh;
    }

    public String getCorpCd() {
        return corpCd;
    }

    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
    }

    public String getCorpNm() {
        return corpNm;
    }

    public void setCorpNm(String corpNm) {
        this.corpNm = corpNm;
    }

    public String getCorpType() {
        return corpType;
    }

    public void setCorpType(String corpType) {
        this.corpType = corpType;
    }

    public String getDeptCdPath() {
        return deptCdPath;
    }

    public void setDeptCdPath(String deptCdPath) {
        this.deptCdPath = deptCdPath;
    }

    public String getDeptNmPathKo() {
        return deptNmPathKo;
    }

    public void setDeptNmPathKo(String deptNmPathKo) {
        this.deptNmPathKo = deptNmPathKo;
    }

    public String getDeptNmPathEn() {
        return deptNmPathEn;
    }

    public void setDeptNmPathEn(String deptNmPathEn) {
        this.deptNmPathEn = deptNmPathEn;
    }

    public String getDeptNmPathJa() {
        return deptNmPathJa;
    }

    public void setDeptNmPathJa(String deptNmPathJa) {
        this.deptNmPathJa = deptNmPathJa;
    }

    public String getDeptNmPathZh() {
        return deptNmPathZh;
    }

    public void setDeptNmPathZh(String deptNmPathZh) {
        this.deptNmPathZh = deptNmPathZh;
    }

    public String getChiefYn() {
        return chiefYn;
    }

    public void setChiefYn(String chiefYn) {
        this.chiefYn = chiefYn;
    }

    public String getSiteLocale() {
        return siteLocale;
    }

    public void setSiteLocale(String siteLocale) {
        this.siteLocale = siteLocale;
    }

    public String getAuthCd() {
        return authCd;
    }

    public void setAuthCd(String authCd) {
        this.authCd = authCd;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useEnable) {
        this.useYn = useEnable;
    }


    public String getLoginIp() {
        return loginIp;
    }

    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
    }

    public String getKokrs() {
        return kokrs;
    }

    public void setKokrs(String kokrs) {
        this.kokrs = kokrs;
    }
    
    
    public String getRegDte() {
        return regDte;
    }

    public void setRegDte(String regDte) {
        this.regDte = regDte;
    }

    public String getRegLoginId() {
        return regLoginId;
    }

    public void setRegLoginId(String regLoginId) {
        this.regLoginId = regLoginId;
    }

    public String getUptDte() {
        return uptDte;
    }

    public void setUptDte(String uptDte) {
        this.uptDte = uptDte;
    }

    public String getUptLoginId() {
        return uptLoginId;
    }

    public void setUptLoginId(String uptLoginId) {
        this.uptLoginId = uptLoginId;
    }

    // VSysUser 모델 복사
    public void CopyData(SysLoginVO param)
    {
        this.userNo = param.getUserNo();
        this.deptCd = param.getDeptCd();
        this.loginId = param.getLoginId();
        this.loginPwd = param.getLoginPwd();
        this.nmKo = param.getNmKo();
        this.nmEn = param.getNmEn();
        this.nmJa = param.getNmJa();
        this.nmZh = param.getNmZh();
        this.residentRegNo = param.getResidentRegNo();
        this.email = param.getEmail();
        this.telNo = param.getTelNo();
        this.mobileNo = param.getMobileNo();
        this.addrKo = param.getAddrKo();
        this.addrEn = param.getAddrEn();
        this.addrJa = param.getAddrJa();
        this.addrZh = param.getAddrZh();
        this.positionCd = param.getPositionCd();
        this.positionLangCd = param.getPositionLangCd();
        this.dutyCd = param.getDutyCd();
        this.dutyLangCd = param.getDutyLangCd();
        this.userType = param.getUserType();
        this.userTypeLangCd = param.getUserTypeLangCd();
        this.deptNmKo = param.getDeptNmKo();
        this.deptNmEn = param.getDeptNmEn();
        this.deptNmJa = param.getDeptNmJa();
        this.deptNmZh = param.getDeptNmZh();
        this.corpCd = param.getCorpCd();
        this.corpType = param.getCorpType();
        this.deptCdPath = param.getDeptCdPath();
        this.deptNmPathKo = param.getDeptNmPathKo();
        this.deptNmPathEn = param.getDeptNmPathEn();
        this.deptNmPathJa = param.getDeptNmPathJa();
        this.deptNmPathZh = param.getDeptNmPathZh();
        this.chiefYn = param.getChiefYn();
        this.siteLocale = param.getSiteLocale();
        this.authCd = param.getAuthCd();
        this.useYn = param.getUseYn();
        this.loginIp = param.getLoginIp();
        this.kokrs = param.getKokrs();
        this.regDte = param.getRegDte();
        this.regLoginId = param.getRegLoginId();
        this.uptDte = param.getUptDte();
        this.uptLoginId = param.getUptLoginId();
    }

    /**
     * 사이트 로케일 변경 처리
     * @param SiteLocale
     */
    public void changeSiteLocale(String SiteLocale) {
        setSiteLocale(SiteLocale);

        if ("EN".equals(getSiteLocale())) {            //영문
            setName(getNmEn());
            setDspName(getDspNmEn());
            setAddr(getAddrEn());
            setGroupName(getDeptNmEn());
            setCompanyName(getDeptNmEn());

        }else if ("JA".equals(getSiteLocale())) {     //일문
            setName(getNmJa());
            setDspName(getDspNmJa());
            setAddr(getAddrJa());
            setGroupName(getDeptNmJa());
            setCompanyName(getDeptNmJa());

        }else if ("ZH".equals(getSiteLocale())) {    //중문
            setName(getNmZh());
            setDspName(getDspNmZh());
            setAddr(getAddrZh());
            setGroupName(getDeptNmZh());
            setCompanyName(getDeptNmZh());

        }else {
            setName(getNmKo());
            setDspName(getDspNmKo());
            setAddr(getAddrKo());
            setGroupName(getDeptNmKo());
            setCompanyName(getDeptNmKo());

        }
        //-- 다국어 코드로 언어 사전 조회
        setDutyName(StringUtil.getLocaleWord(getDutyLangCd(), getSiteLocale()));                        //--직책
        setPositionName(StringUtil.getLocaleWord(getPositionLangCd(), getSiteLocale()));                //--직급
        setUserTypeName(StringUtil.getLocaleWord(getUserTypeLangCd(), getSiteLocale()));                //--사용자 유형 (내부/외부)

    }//end changeSiteLocale()


    /**
     * 사용자 권한 - 현재 로그인한 사용자의 권한 유무 반환
     * @param authCodes 사용자 권한 코드 (※ 여러 개일 경우 쉼표[,]로 구분하여 입력)
     * @return
     */
    public boolean isUserAuth(String authCodes) {
        if ( StringUtils.isEmpty(authCodes) ) return false;

        String[] authCodeArr = authCodes.split(",");
        for (int i = 0; i < authCodeArr.length; i++) {
            if ( (","+ this.authCd +",").indexOf(","+authCodeArr[i]+",") > -1 ) return true;
        }
        return false;
    }

    /**
     * 사용자의 메인이 되는 권한을 반환
     * @return 법무팀 : CHR , 일반  :  REQ
     */
    public String getMainAuth() {
        if(isUserAuth("LMS_BCD,LMS_BJD")) {
            return "CHR";
        }else {
            return "REQ";
        }
    }

    /**
     * 담당자여부
     * @return
     */
    public boolean isCharger(){
        if(isUserAuth("LMS_BCD,LMS_BJD") ){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 담당자여부(특허부서 총담/주담)
     * @return
     */
    public boolean isManager(){
        if(isUserAuth("EMF/MNG") ){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 시스템 시스템 담당자
     * @return
     */
    public boolean isCmmAdmin(){
        if(isUserAuth("CMM_SYS") ){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 시스템 담당자
     * @return
     */
    public boolean isEmfAdmin(){
        if(isUserAuth("EMF/SYS") ){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 게시판 관리자
     * @return
     */
    public boolean isCmmBbs(){
        if(isUserAuth("CMM/BBS") ){
            return true;
        }else{
            return false;
        }
    }

    public String sessionId;

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String session_id) {
        this.sessionId = session_id;
    }

}
