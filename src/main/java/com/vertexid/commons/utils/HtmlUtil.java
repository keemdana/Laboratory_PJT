package com.vertexid.commons.utils;

import com.vertexid.viself.base.SystemPropertiesVO;
import de.vogella.sap.jco.connection.CommonProperties;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Calendar;

public class HtmlUtil {
    /**
     * logger
     */
    protected Logger logger = LoggerFactory.getLogger(this.getClass());
    /**
     * the instance
     */
    private static HtmlUtil instance;

    /**
     * <p>{@code HtmlUtil} instances should NOT be constructed in
     * standard programming. Instead, the class should be used as
     * {@code HtmlUtil.get(" foo ");}.</p>
     *
     * <p>This constructor is public to permit tools that require a JavaBean
     * instance to operate.</p>
     */
    private HtmlUtil() {
    }

    /**
     * @return the instance
     */
    public static HtmlUtil getInstance() {
        if (instance == null) {
            instance = new HtmlUtil();
        }

        return instance;
    }

    /**
     * 라디오 출력 도우미 메소드
     * @param IsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param FormName 폼 이름
     * @param CodeStr 폼 구성용 코드정보 문자열        ex> {값1}[Separ1]{텍스트1}[Separ1]{툴팁1}[Separ2]{값2}[Separ1]{텍스트2}[Separ1]{툴팁2} ...
     * @param InitData 초기값
     * @param FormEtc 폼 스타일, 이벤트 등
     * @param LabelEtc 레이블 스타일, 이벤트 등
     * @param Separ1 폼 구성용 코드정보 문자열 value-text 구분자 [기본값 :|]
     * @param Separ2 폼 구성용 코드정보 문자열 value-text 그룹 구분자 [기본값 :^]
     * @return HTML 문자열
     */
    public static String getInputRadio(boolean IsInput, String FormName, String CodeStr, String InitData, String FormEtc, String LabelEtc, String Separ1, String Separ2, int dipCnt)
    {
        StringBuffer res = new StringBuffer();


        //2016.07.22 김형종 :: 라디오 박스를 세로로 출력해야하는 특정 폼을 위해 추가함.
        String addBr = "";
        if(FormName == "ips_pati_ex012_simsa_yn"){//심사청구 여부 폼
            addBr = "<br/>";
        }

        String a_code[], a_temp[];
        String v_title         = "";
        String v_checked     = "";
        String v_disabled     = "";

        // 입력 뷰가 아닐 경우 읽기전용으로 출력
        if (!IsInput)
        {
            FormName += "__ReadOnly";
        }

        if(IsInput == false){
            FormName += StringUtil.getRandomUUID();
        }

        // 구분자 기본값 셋팅
        if (StringUtils.isEmpty(Separ1)) Separ1 = "|";
        if (StringUtils.isEmpty(Separ2)) Separ2 = "^";

        a_code = StringUtils.splitByWholeSeparatorPreserveAllTokens(CodeStr, Separ2);
        if (a_code != null)
        {
            for (int i = 0; i < a_code.length; i++) {
                a_temp = StringUtils.splitByWholeSeparatorPreserveAllTokens(a_code[i], Separ1);

                //-- 툴팁 처리
                if (a_temp.length > 2) {
                    v_title = " title=\""+ StringEscapeUtils.escapeHtml4(a_temp[2]) +"\"";
                } else {
                    v_title = " title=\""+ StringEscapeUtils.escapeHtml4(a_temp[1]) +"\"";
                }

                //-- 선택항목 처리
                v_checked = "";
                if (a_temp[0].equals(InitData)) {
                    v_checked = " checked";
                    v_disabled = "";
                } else {
                    if (!IsInput) v_disabled = " disabled";
                }

                if (i != 0){

                    res.append( "\n" );
                    //2016.07.22 김형종
                    res.append(addBr);

                }

                res.append( "<input type=\"radio\" name=\""+ FormName +"\" id=\""+ FormName + i +"\" value=\""+ StringEscapeUtils.escapeHtml4(a_temp[0]) +"\" style=\"cursor:pointer;\" "+ v_title + v_checked + v_disabled +" "+ FormEtc +" />" );
                res.append( "<label for=\""+ FormName + i +"\""+ v_title +" style=\"cursor:pointer;\" "+ LabelEtc +">"+ a_temp[1] +"</label>" );
                if( dipCnt > 0 && (i+1)%dipCnt == 0){
                    res.append( "<br/>");
                }
            }
        }

        return res.toString();
    }

    /**
     * 라디오 출력 도우미 메소드
     * @param IsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param FormName 폼 이름
     * @param CodeStr 폼 구성용 코드정보 문자열        ex> {값1}[Separ1]{텍스트1}[Separ1]{툴팁1}[Separ2]{값2}[Separ1]{텍스트2}[Separ1]{툴팁2} ...
     * @param InitData 초기값
     * @param FormEtc 폼 스타일, 이벤트 등
     * @param LabelEtc 레이블 스타일, 이벤트 등
     * @param Separ1 폼 구성용 코드정보 문자열 value-text 구분자 [기본값 :|]
     * @param Separ2 폼 구성용 코드정보 문자열 value-text 그룹 구분자 [기본값 :^]
     * @return HTML 문자열
     */
    public static String getInputRadio(boolean IsInput, String FormName, String CodeStr, String InitData, String FormEtc, String LabelEtc)
    {
        return getInputRadio(IsInput, FormName, CodeStr, InitData, FormEtc, LabelEtc, "", "", 0);
    }
    /**
     * 라디오 출력 도우미 메소드
     * @param IsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param FormName 폼 이름
     * @param CodeStr 폼 구성용 코드정보 문자열        ex> {값1}[Separ1]{텍스트1}[Separ1]{툴팁1}[Separ2]{값2}[Separ1]{텍스트2}[Separ1]{툴팁2} ...
     * @param InitData 초기값
     * @param FormEtc 폼 스타일, 이벤트 등
     * @param LabelEtc 레이블 스타일, 이벤트 등
     * @param Separ1 폼 구성용 코드정보 문자열 value-text 구분자 [기본값 :|]
     * @param Separ2 폼 구성용 코드정보 문자열 value-text 그룹 구분자 [기본값 :^]
     * @return HTML 문자열
     */
    public static String getInputRadioBr(boolean IsInput, String FormName, String CodeStr, String InitData, String FormEtc, String LabelEtc, int dipCnt)
    {
        return getInputRadio(IsInput, FormName, CodeStr, InitData, FormEtc, LabelEtc, "", "", dipCnt);
    }


    /**
     * 체크박스 출력 도우미 메소드
     * @param IsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param FormName 폼 이름
     * @param CodeStr 폼 구성용 코드정보 문자열        ex> {값1}[Separ1]{텍스트1}[Separ1]{툴팁1}[Separ2]{값2}[Separ1]{텍스트2}[Separ1]{툴팁2} ...
     * @param InitData 초기값 (※ 여러 개일 경우 구분자[Separ3] 사용)
     * @param FormEtc 폼 스타일, 이벤트 등
     * @param LabelEtc 레이블 스타일, 이벤트 등
     * @param Separ1 폼 구성용 코드정보 문자열 value-text 구분자 [기본값 :|]
     * @param Separ2 폼 구성용 코드정보 문자열 value-text 그룹 구분자 [기본값 :^]
     * @param Separ3 초기값 구분자 [기본값:,]
     * @return HTML 문자열
     */
    public static String getInputCheckbox(boolean IsInput, String FormName, String CodeStr, String InitData, String FormEtc, String LabelEtc, String Separ1, String Separ2, String Separ3) {
        StringBuffer res = new StringBuffer();

        String a_code[], a_init[], a_temp[];
        String v_title         = "";
        String v_checked     = "";
        String v_disabled     = "";


        // 입력 뷰가 아닐 경우 읽기전용으로 출력
        if (!IsInput)
        {
            FormName += "__ReadOnly";
        }

        if(IsInput == false){
            FormName += StringUtil.getRandomUUID();
        }

        // 구분자 기본값 셋팅
        if (StringUtils.isEmpty(Separ1)) Separ1 = "|";
        if (StringUtils.isEmpty(Separ2)) Separ2 = "^";
        if (StringUtils.isEmpty(Separ3)) Separ3 = ",";

        a_code = StringUtils.splitByWholeSeparatorPreserveAllTokens(CodeStr, Separ2);
        a_init = StringUtils.splitByWholeSeparatorPreserveAllTokens(InitData, Separ3);

        if (a_code != null)
        {
            for (int i = 0; i < a_code.length; i++) {
                a_temp = StringUtils.splitByWholeSeparatorPreserveAllTokens(a_code[i], Separ1);

                //-- 툴팁 처리
                if (a_temp.length > 2) {
                    v_title = " title=\""+ StringEscapeUtils.escapeHtml4(a_temp[2]) +"\"";
                } else {
                    v_title = " title=\""+ StringEscapeUtils.escapeHtml4(a_temp[1]) +"\"";
                }

                //-- 선택항목 처리
                v_checked = "";
                if (a_init != null)
                {
                    for (int j = 0; j < a_init.length; j++) {
                        if (a_temp[0].equals(a_init[j].trim())) {
                            if (!IsInput) { //-- 편집모드가 아닌 경우에만 클릭시에도 선택  플리지 않토록 처리
                                v_checked = "onClick='this.checked=!this.checked;'";
                            }
                            v_checked += " checked";
                            v_disabled = "";

                            break;
                        } else {
                            if (!IsInput) v_disabled = " disabled";
                        }
                    }
                }

                if (i != 0) res.append( "\n" );

                res.append( "<input type=\"checkbox\" name=\""+ FormName +"\" id=\""+ FormName + i +"\" value=\""+ StringEscapeUtils.escapeHtml4(a_temp[0]) +"\" style=\"cursor:pointer;\" "+ v_title + v_checked + v_disabled +" "+ FormEtc +" />" );
                res.append( "<label for=\""+ FormName + i +"\""+ v_title +" style=\"cursor:pointer;\" "+ LabelEtc +">"+ a_temp[1] +"</label>" );
            }
        }

        return res.toString();
    }
    /**
     *
     * @param IsInput
     * @param FormName
     * @param CodeStr
     * @param InitData
     * @param FormEtc
     * @param LabelEtc
     * @param Separ1
     * @param Separ2
     * @param Separ3
     * @return
     */
    public static String getInputCheckboxBr(boolean IsInput, String FormName, String CodeStr, String InitData, String FormEtc, String LabelEtc, String Separ1, String Separ2, String Separ3, int dipCnt) {
        StringBuffer res = new StringBuffer();

        String a_code[], a_init[], a_temp[];
        String v_title         = "";
        String v_checked     = "";
        String v_disabled     = "";


        // 입력 뷰가 아닐 경우 읽기전용으로 출력
        if (!IsInput)
        {
            FormName += "__ReadOnly";
        }

        if(IsInput == false){
            FormName += StringUtil.getRandomUUID();
        }

        // 구분자 기본값 셋팅
        if (StringUtils.isEmpty(Separ1)) Separ1 = "|";
        if (StringUtils.isEmpty(Separ2)) Separ2 = "^";
        if (StringUtils.isEmpty(Separ3)) Separ3 = ",";

        a_code = StringUtils.splitByWholeSeparatorPreserveAllTokens(CodeStr, Separ2);
        a_init = StringUtils.splitByWholeSeparatorPreserveAllTokens(InitData, Separ3);

        if (a_code != null)
        {
            res.append( "<table >");
            res.append( "    <tr>");
            for (int i = 0; i < a_code.length; i++) {
                res.append( "    <td>");
                a_temp = StringUtils.splitByWholeSeparatorPreserveAllTokens(a_code[i], Separ1);

                //-- 툴팁 처리
                if (a_temp.length > 2) {
                    v_title = " title=\""+ StringEscapeUtils.escapeHtml4(a_temp[2]) +"\"";
                } else {
                    v_title = " title=\""+ StringEscapeUtils.escapeHtml4(a_temp[1]) +"\"";
                }

                //-- 선택항목 처리
                v_checked = "";
                if (a_init != null)
                {
                    for (int j = 0; j < a_init.length; j++) {
                        if (a_temp[0].equals(a_init[j].trim())) {
                            if (!IsInput) { //-- 편집모드가 아닌 경우에만 클릭시에도 선택  플리지 않토록 처리
                                v_checked = "onClick='this.checked=!this.checked;'";
                            }
                            v_checked += " checked";
                            v_disabled = "";

                            break;
                        } else {
                            if (!IsInput) v_disabled = " disabled";
                        }
                    }
                }

                if (i != 0) res.append( "\n" );

                res.append( "<input type=\"checkbox\" name=\""+ FormName +"\" id=\""+ FormName + i +"\" value=\""+ StringEscapeUtils.escapeHtml4(a_temp[0]) +"\" style=\"cursor:pointer;\" "+ v_title + v_checked + v_disabled +" "+ FormEtc +" />" );
                res.append( "<label for=\""+ FormName + i +"\""+ v_title +" style=\"cursor:pointer;\" "+ LabelEtc +">"+ a_temp[1] +"</label>" );
                res.append( "    </td>");
                if( (i+1)%dipCnt == 0){
                    res.append( "</tr>");
                    res.append( "<tr>");
                }
            }
            res.append( "</tr>");
            res.append( "</table>");
        }

        return res.toString();
    }

    /**
     * 체크박스 출력 도우미 메소드
     * @param IsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param FormName 폼 이름
     * @param CodeStr 폼 구성용 코드정보 문자열        ex> {값1}[Separ1]{텍스트1}[Separ1]{툴팁1}[Separ2]{값2}[Separ1]{텍스트2}[Separ1]{툴팁2} ...
     * @param InitData 초기값 (※ 여러 개일 경우 구분자[Separ3] 사용)
     * @param FormEtc 폼 스타일, 이벤트 등
     * @param LabelEtc 레이블 스타일, 이벤트 등
     * @return HTML 문자열
     */
    public static String getInputCheckbox(boolean IsInput, String FormName, String CodeStr, String InitData, String FormEtc, String LabelEtc)
    {
        return getInputCheckbox(IsInput, FormName, CodeStr, InitData, FormEtc, LabelEtc, "", "", "");
    }
    /**
     * 체크박스 출력 도우미 메소드(줄바꿈)
     * @param IsInput
     * @param FormName
     * @param CodeStr
     * @param InitData
     * @param FormEtc
     * @param LabelEtc
     * @return
     */
    public static String getInputCheckboxBr(boolean IsInput, String FormName, String CodeStr, String InitData, String FormEtc, String LabelEtc, int dipCnt)
    {
        return getInputCheckboxBr(IsInput, FormName, CodeStr, InitData, FormEtc, LabelEtc, "", "", "",dipCnt);
    }


    /**
     * 셀렉트  컨트롤 출력 도우미 메소드
     * @param bIsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param sCtrlName 컨트롤 이름
     * @param sCtrlId 컨트롤 아이디
     * @param sCodeStr 컨트롤 구성용 코드정보 문자열 ex> {value1}[sSepar1]{text1}[sSepar2]{value2}[sSepar1]{text2} ...
     * @param sInitData 초기값 (※ 여러 개일 경우 구분자[sSepar3] 사용)
     * @param sCtrlEtc 컨트롤 스타일, 이벤트 등
     * @param sSepar1 컨트롤 구성용 코드정보 문자열 value-text 구분자 [기본값 :|]
     * @param sSepar2 컨트롤 구성용 코드정보 문자열 value-text 그룹 구분자 [기본값 :^]
     * @param sSepar3 초기값 구분자 [기본값:,]
     * @return HTML 문자열
     * 2016.07.14    신현삼    : 영문화 공통처리를 위해 첫번째 param으로 HttpServletRequest 추가.
     */
    public static String getSelect(boolean bIsInput, String sCtrlName, String sCtrlId, String sCodeStr, String sInitData, String sCtrlEtc, String sSepar1, String sSepar2, String sSepar3)
    {
        StringBuffer res = new StringBuffer();

        String sCodeDataArr[], sInitValArr[], sTempDataArr[];
        String sSelected = "";
        String sDisabled = "";

        // 입력 뷰가 아닐 경우 읽기전용으로 출력
        if (!bIsInput)
        {
            sCtrlName += "__ReadOnly";
        }

        // 구분자 기본값 셋팅
        if (StringUtils.isEmpty(sSepar1)) sSepar1 = "|";
        if (StringUtils.isEmpty(sSepar2)) sSepar2 = "^";
        if (StringUtils.isEmpty(sSepar3)) sSepar3 = ",";

        sCodeDataArr = StringUtils.splitByWholeSeparatorPreserveAllTokens(sCodeStr, sSepar2);
        sInitValArr = StringUtils.splitByWholeSeparatorPreserveAllTokens(sInitData, sSepar3);

        if (bIsInput) {
            if (sCodeDataArr != null)
            {
                res.append( "<select name=\"" + sCtrlName + "\" id=\"" + sCtrlId + "\" " + sCtrlEtc + sDisabled + " >\n" );

                for (int i = 0; i < sCodeDataArr.length; i++) {
                    sTempDataArr = StringUtils.splitByWholeSeparatorPreserveAllTokens(sCodeDataArr[i], sSepar1);
                    sSelected = "";

                    if (sInitValArr != null)
                    {
                        for (int j = 0; j < sInitValArr.length; j++) {
                            if (sTempDataArr[0].equals(sInitValArr[j].trim())) {
                                sSelected = " selected";
                                break;
                            }
                        }
                    }


                    /*
                     * 여기서부터 2016.07.14 추가
                     */
                    res.append( "<option value=\""+ sTempDataArr[0] +"\" "+ (sTempDataArr.length > 2 ? "title=\""+ sTempDataArr[2].replace("\"", "&quot;") +"\" " : "") + sSelected +">"+ sTempDataArr[1] + "</option>\n" );
                    /*
                    String vTxt = sTempDataArr[1];
                    if (!"KO".equals(locale.toUpperCase())
                            //&& !label.startsWith(""L."")) {
                            && !vTxt.contains("T_SYS_GROUP")
                            && !vTxt.contains("T_SYS_CODE")
                            && vTxt.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {

                        String sTxt = vTxt.replaceAll("-", "");
                        try {
                            Field lfld =Label.getInstance().getClass().getField(sTxt);
                            String nTxt = lfld.get(sTxt).toString();
                            nTxt = StringUtil.getLocaleWord(nTxt, locale);
                            vTxt = vTxt.replaceAll(sTxt, nTxt);
                        } catch (SecurityException e) {
                            log.error("Label Field 접근 불가 : " + vTxt);
                            vTxt += "(Label미존재:" + vTxt + ")";
                        } catch (NoSuchFieldException e) {
                            log.error("Label Field 찾을 수 없음 : " + vTxt);
                            vTxt += "(Label미존재:" + vTxt + ")";
                        } catch (IllegalArgumentException e) {
                            log.error("Label 항목 찾을 수 없음 : " + vTxt);
                            vTxt += "(Label미존재:" + vTxt + ")";
                        } catch (IllegalAccessException e) {
                            log.error("Label 항목 접근 불가 : " + vTxt);
                            vTxt += "(Label미존재:" + vTxt + ")";
                        }
                    }
                    res.append( "<option value=\""+ sTempDataArr[0] +"\" "+ (sTempDataArr.length > 2 ? "title=\""+ sTempDataArr[2].replace("\"", "&quot;") +"\" " : "") + sSelected +">"+ vTxt + "</option>\n" );
                    */
                }
            }
            res.append( "</select>" );
        } else {
            if (sCodeDataArr != null)
            {
                for (int i = 0; i < sCodeDataArr.length; i++) {
                    sTempDataArr = StringUtils.splitByWholeSeparatorPreserveAllTokens(sCodeDataArr[i], sSepar1);
                    if (sInitValArr != null)
                    {
                        for (int j = 0; j < sInitValArr.length; j++) {
                            if (sTempDataArr[0].equals(sInitValArr[j].trim())) {
                                sSelected = sTempDataArr[1]; //선택된 Title 추출
                                break;
                            }
                        }
                    }
                }
                res.append(sSelected);
            }
        }
        return res.toString();
    }

    /**
     * 셀렉트 컨트롤 출력 도우미 메소드
     * @param bIsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param sCtrlName 컨트롤 이름
     * @param sCtrlId 컨트롤 아이디
     * @param sCodeStr 컨트롤 구성용 코드정보 문자열 ex> {value1}|{text1}^{value2}|{text2} ...
     * @param sInitData 초기값 (※ 여러 개일 경우 구분자[,] 사용)
     * @param sCtrlEtc 컨트롤 스타일, 이벤트 등
     * @return HTML 문자열
     * 2016.07.14    신현삼    영문화 관련 request 추가
     */
    public static String getSelect(boolean bIsInput, String sCtrlName, String sCtrlId, String sCodeStr, String sInitData, String sCtrlEtc)
    {
        return getSelect(bIsInput, sCtrlName, sCtrlId, sCodeStr, sInitData, sCtrlEtc, "|", "^", ",");
    }


    /**
     * 날짜입력 컨트롤 출력 도우미 메소드
     * @param bIsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param fromName 컨트롤 이름
     * @param fromId 컨트롤 아이디
     * @param fromData 초기값
     * @param fromEtc 컨트롤 스타일, 이벤트 등
     * @return HTML 문자열
     */
    public static String getDualCalendar(boolean bIsInput, String fromName, String fromId, String fromData, String fromEtc , String toName, String toId, String toData, String toEtc)
    {
        StringBuffer res = new StringBuffer();

        if ( bIsInput )
        {

            //-- 입력 뷰 일 경우,
            res.append( "<input type=\"text\" name=\""+ fromName +"\" id=\""+ fromId +"\" value=\""+ fromData +"\" class=\"date\" onfocus=\"this.select()\" onblur=\"airCommon.validateDateObject(this);\" "+ fromEtc +" />" );
            res.append( "\r\n<i  class=\"fas fa-calendar-alt\" style=\"cursor:pointer\" onclick=\"javascript:$( '#"+fromId+"' ).datepicker('show');\"></i> ~ " );
            res.append( "<input type=\"text\" name=\""+ toName +"\" id=\""+ toId +"\" value=\""+ toData +"\" class=\"date\" onfocus=\"this.select()\" onblur=\"airCommon.validateDateObject(this);\" "+ toEtc +" />" );
            res.append( "\r\n<i  class=\"fas fa-calendar-alt\" style=\"cursor:pointer\" onclick=\"javascript:$( '#"+toId+"' ).datepicker('show');\"></i>" );
            res.append( "<script>airCommon.openDualCalendar('"+ fromId +"','"+ toId +"');</script>" );

        } else {
            //-- 출력 뷰 일 경우,
            res.append( fromData );
        }

        return res.toString();
    }

    /**
     * 날짜입력 컨트롤 출력 도우미 메소드
     * @param bIsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param sCtrlName 컨트롤 이름
     * @param sCtrlId 컨트롤 아이디
     * @param sInitData 초기값
     * @param sCtrlEtc 컨트롤 스타일, 이벤트 등
     * @return HTML 문자열
     */
    public static String getInputCalendar(boolean bIsInput, String sCtrlName, String sCtrlId, String sInitData, String sCtrlEtc)
    {
        StringBuffer res = new StringBuffer();

        if ( bIsInput )
        {
            //-- 입력 뷰 일 경우,
            res.append( "<input type=\"text\" name=\""+ sCtrlName +"\" id=\""+ sCtrlId +"\" value=\""+ sInitData +"\" class=\"date\" onfocus=\"this.select()\" onblur=\"airCommon.validateDateObject(this);\" "+ sCtrlEtc +" />" );
            res.append( "\r\n<i  class=\"fas fa-calendar-alt\" style=\"cursor:pointer\" onclick=\"javascript:airCommon.openInputCalendar('"+ sCtrlId +"');\"></i>" );
//            res.append( "\r\n<input type=\"button\" value=\" \" onclick=\"javascript:airCommon.openInputCalendar('"+ sCtrlId +"');\" class=\"btn_calendar\" />" );

        } else {
            //-- 출력 뷰 일 경우,
            res.append( sInitData );
        }

        return res.toString();
    }

    /**
     * 날짜입력 컨트롤 출력 도우미 메소드
     * @param bIsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param sCtrlName 컨트롤 이름
     * @param sCtrlId 컨트롤 아이디
     * @param sInitData 초기값
     * @param sCtrlEtc 컨트롤 스타일, 이벤트 등
     * @param callBackFnc 날짜 선택시 호출할 함수
     * @return HTML 문자열
     */
    public static String getCallBackFnCalendar(boolean bIsInput, String sCtrlName, String sCtrlId, String sInitData, String sCtrlEtc, String callBackFnc)
    {
        StringBuffer res = new StringBuffer();

        if ( bIsInput )
        {
            //-- 입력 뷰 일 경우,
            res.append( "<input type=\"text\" name=\""+ sCtrlName +"\" id=\""+ sCtrlId +"\" value=\""+ sInitData +"\" class=\"date\" onfocus=\"this.select()\" onblur=\"airCommon.validateDateObject(this);"+callBackFnc+"(this.value)\" "+ sCtrlEtc +" />" );
            res.append( "\r\n<input type=\"button\" value=\" \" id=\""+ sCtrlId +"_btn\"  onclick=\"javascript:airCommon.openCallBackCalendar('"+ sCtrlId +"',"+callBackFnc+");\" class=\"btn_calendar\" />" );

        } else {
            //-- 출력 뷰 일 경우,
            res.append( sInitData );
        }

        return res.toString();
    }

    /**
     * HTML 에디터 컨트롤 출력 도우미 메소드
     *
     * @param request
     * @param bIsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param sCtrlName 컨트롤 이름
     * @param sCtrlId 컨트롤 아이디
     * @param sInitData 초기값
     * @param sCtrlEtc 컨트롤 스타일, 이벤트 등
     * @param sWidth 컨트롤 넓이
     * @param sHeight 컨트롤 높이
     * @param sToolbarSet 에디터 툴바셋 이름 ex> Default
     * @return
     */
    public static String getHtmlEditor(HttpServletRequest request,boolean bIsInput, String sCtrlName, String sCtrlId, String sInitData, String sCtrlEtc, String sWidth, String sHeight, String sToolbarSet)
    {
        String editorType = StringUtil.convertNull(CommonProperties.load("system.editor"));

        StringBuffer res = new StringBuffer();
        //-- 기본값 셋팅
        if (sWidth == null || "".equals(sWidth)) sWidth = "100%";
        if (sHeight == null || "".equals(sHeight)) sHeight = "150px";
        if (sToolbarSet == null || "".equals(sToolbarSet)) sToolbarSet = "Default";

//        SysLoginModel loginUser =     (SysLoginModel) SessionUtils.getLoginVO();
        String siteLocale = "KO";//loginUser.getSiteLocale(); TODO

        if("NAMO".equals(editorType.toUpperCase())){

            /*
             * 나모 Cross Editor 사용
             */
            if ( bIsInput ){
                //나모 CrossEditor 적용 소스
                res.append( "<textarea id=\""+ sCtrlName +"\" name=\""+ sCtrlName +"\" Style=\"width:"+ sWidth +"; height:"+ sHeight +";\" "+ sCtrlEtc +">"+sInitData+"</textarea>\n" );
                res.append( "<div id=\"div_"+sCtrlName+"\">\n" );
                res.append( "<script type=\"text/javascript\" language=\"javascript\">\n" );
                res.append( "    var CrossEditor"+ sCtrlName +" = new NamoSE('"+ sCtrlName +"');\n" );
                res.append( "    CrossEditor"+ sCtrlName +".params.Width = \"100%\";\n" );
//                res.append( "    CrossEditor"+ sCtrlName +".params.Height = \""+ sHeight +"\";\n" );
                res.append( "    CrossEditor"+ sCtrlName +".params.UserLang = \"auto\";\n" );
                res.append( "    CrossEditor"+ sCtrlName +".params.FullScreen = false;\n" );
                res.append( "    CrossEditor"+ sCtrlName +".params.SetFocus  =  false;\n" );
//                res.append( "    CrossEditor"+ sCtrlName +".params.ParentEditor = document.getElementById('div_'+"+sCtrlName+");\n" );
                res.append( "    CrossEditor"+ sCtrlName +".EditorStart();\n" );

//                CrossEditor.params.ParentEditor = document.getElementById("editor1");

                //중복함수 생성으로 header.default.jsp로 이동함


                //상수로 선언된 배열 CrossEditor에 push 시킴(최종적으로 갯수만치 꺼내다 씀)
                res.append( "    CrossEditor.push(CrossEditor"+ sCtrlName +");\n" );
                res.append( "</script>\n" );
                res.append( "</div>\n" );
            } else {
                res.append( "<div style=\"width:"+ sWidth +";height:"+ sHeight +";\" "+ sCtrlEtc +">"+ sInitData +"</div>" );
            }
        }else if("X_FREE".equals(editorType.toUpperCase())){

            /*
             *  X free Editor 사용
             */
            if ( bIsInput ){

                String systemUrl = StringUtil.convertNull(String.valueOf(request.getRequestURL()));//-- TODO 이건슨 나중에 할것인가?


                //나모 CrossEditor 적용 소스
                res.append( "<textarea style='display:none;' name=\""+ sCtrlName +"\" Style=\"width:"+ sWidth +"; height:"+ sHeight +";\" "+ sCtrlEtc +">"+sInitData+"</textarea>\n" );

                res.append( "\n <div id='"+ sCtrlName +"'> </div>                     ");
                res.append( "\n <script type=\"text/javascript\">              ");
                res.append( "\n var XfreeEditor"+ sCtrlName +" = new XFE({                          ");
                res.append( "\n        basePath : '"+systemUrl+"/common/_lib/x_free', ");
                res.append( "\n        width : '100%',                      ");
                res.append( "\n        height : '"+ sHeight +"'                      ");
                res.append( "\n });                                          ");
                res.append( "\n XfreeEditor"+ sCtrlName +".render('"+ sCtrlName +"');         ");
                res.append( "\n XfreeEditor"+ sCtrlName +".setBodyValue($('textarea[name=\""+ sCtrlName +"\"').eq(0).val());         ");
//                res.append( "\n XfreeEditor"+ sCtrlName +".setBodyValue('"+ sInitData +"');         ");
                res.append( "\n    XfreeEditor.push(XfreeEditor"+ sCtrlName +");" );
                res.append( "\n </script>                                    ");

            } else {
                res.append( "<div style=\"width:"+ sWidth +";height:"+ sHeight +";\" "+ sCtrlEtc +">"+ sInitData +"</div>" );
            }

        }else{
            /*
             * 기본 CK Editor 사용
             */
            if ( bIsInput )
            {
//                res.append( "<textarea readonly='readonly' name=\""+ sCtrlName +"\" id=\""+ sCtrlId +"\" style=\"width:"+ sWidth +";height:"+ sHeight +";\" "+ sCtrlEtc +" class=\"ckeditor\">"+ sInitData +"</textarea>\n" );
                // class=ckeditor 는 4.16.2 에서 editor-element-conflict 에러를 발생 시킵니다.
                res.append( "<textarea name=\""+ sCtrlName +"\" id=\""+ sCtrlId +"\" style=\"width:"+ sWidth +";height:"+ sHeight +";\" "+ sCtrlEtc +">"+ sInitData +"</textarea>\n" );
                res.append( "<script type=\"text/javascript\">\n" );
                res.append( "  CKEDITOR.replace('"+ sCtrlName +"', {width:'").append(sWidth).append("',height:'").append(sHeight).append("',language:'"+siteLocale.toLowerCase()+"'});\n" );
                res.append( "</script>\n" );
            } else {
                res.append( "<div style=\"width:"+ sWidth +";height:"+ sHeight +";\" "+ sCtrlEtc +">"+ sInitData +"</div>" );
            }

        }
        return res.toString();

    }

    /**
     * HTML 에디터 컨트롤 출력 도우미 메소드
     * @param bIsInput 입력 뷰 여부 [true:입력 뷰, false:출력 뷰(읽기전용)]
     * @param sCtrlName 컨트롤 이름
     * @param sCtrlId 컨트롤 아이디
     * @param sInitData 초기값
     * @param sCtrlEtc 컨트롤 스타일, 이벤트 등
     * @return
     */
    public static String getHtmlEditor(HttpServletRequest request, boolean bIsInput, String sCtrlName, String sCtrlId, String sInitData, String sCtrlEtc) {
        return getHtmlEditor(request, bIsInput, sCtrlName, sCtrlId, sInitData, sCtrlEtc, "99%", null, null);
    }


    /**
     * 페이지 목록 출력 도우미 메소드
     * @param totalCount 전체 페이지 수
     * @param pageNo 현재 페이지 번호
     * @param rowSize 페이지당 행 수
     * @param callbackFunction 페이지 이동 함수([PAGE_NO]:페이지 번호로 치환할 부분, [ROW_SIZE]:페이지당 행 수로 치환할 부분) ex> goPage(document.form1, [PAGE_NO], [ROW_SIZE])
     * @param pageListSize 페이지당 페이지 목록 수
     * @return
     */
    public static String getPageList(Integer totalCount, Integer pageNo, Integer rowSize, String callbackFunction, Integer pageListSize)
    {
        StringBuffer res     = new StringBuffer();

        //-- 기본값 셋팅!
        if (pageNo <= 0) pageNo = 1;
        if (rowSize <= 0) rowSize = new SystemPropertiesVO().getPageRows();
        if (pageListSize <= 0) pageListSize = new SystemPropertiesVO().getPageSize();

        int lastPageNo     = 1;
        if (totalCount > 0) {
            lastPageNo     = totalCount / rowSize;

            if ((totalCount % rowSize) > 0) {
                lastPageNo++;
            }
        }

        int beginPageNo = (int)((pageNo-1)/pageListSize)*pageListSize+1;
        int endPageNo = 1;
        if (lastPageNo < beginPageNo + pageListSize) {
            endPageNo = lastPageNo;
        } else {
            endPageNo = beginPageNo+pageListSize-1;
        }

        int prevPageNo = 1;
        if (beginPageNo > 1) prevPageNo = beginPageNo - 1;
        int nextPageNo = lastPageNo;
        if (endPageNo < lastPageNo) nextPageNo = endPageNo + 1;


        res.append("<div class=\"pagelist\">");

        //-- 처음/이전 페이지 바로가기
        res.append("<a href=\"javascript:void(0);\" onclick=\""+ callbackFunction.replace("[PAGE_NO]", "'1'").replace("[ROW_SIZE]", rowSize.toString()) +"\" title=\"go to first page\"><span class=\"go_first\"></span></a>");
        res.append("<a href=\"javascript:void(0);\" onclick=\""+ callbackFunction.replace("[PAGE_NO]", "'"+prevPageNo+"'").replace("[ROW_SIZE]", rowSize.toString()) +"\" title=\"go to previous page\"><span class=\"go_prev\"></span></a>");

        //-- 페이지 바로가기
        for(int i=beginPageNo; i<=endPageNo; i++){
            if(i > beginPageNo){
                res.append("<span class=\"page_separ\">|</span>");
            }

            if(i==pageNo){
                res.append("<span class=\"page_no\">"+i+"</span>");
            } else {
                res.append("<a href=\"javascript:void(0);\" onclick=\""+ callbackFunction.replace("[PAGE_NO]", "'"+i+"'").replace("[ROW_SIZE]", rowSize.toString()) +"\">"+i+"</a>");
            }

        }

        //-- 다음/마지막  페이지 바로가기
        res.append("<a href=\"javascript:void(0);\" onclick=\""+ callbackFunction.replace("[PAGE_NO]", "'"+nextPageNo+"'").replace("[ROW_SIZE]", rowSize.toString()) +"\" title=\"go to next page\"><span class=\"go_next\"></span></a>");
        res.append("<a href=\"javascript:void(0);\" onclick=\""+ callbackFunction.replace("[PAGE_NO]", "'"+lastPageNo+"'").replace("[ROW_SIZE]", rowSize.toString()) +"\" title=\"go to last page\"><span class=\"go_last\"></span></a>");

        res.append("</div>");

        return res.toString();
    }

    /**
     * 페이지 목록 출력 도우미 메소드
     * @param totalCount 전체 페이지 수
     * @param rowSize 페이지당 행 수
     * @param callbackFunction 페이지 이동 함수([PAGE_NO]:페이지 번호로 치환할 부분, [ROW_SIZE]:페이지당 행 수로 치환할 부분) ex> goPage(document.form1, [PAGE_NO], [ROW_SIZE])
     * @return
     */
    public static String getPageList(Integer totalCount, Integer pageNo, Integer rowSize, String callbackFunction) {
        return getPageList(totalCount, pageNo, rowSize, callbackFunction, -1);
    }

    public static String getPageOrderByHeaderLink(HttpServletRequest request, String headerText, String headerField, String nowOrderByField, String nowOrderByMethod, String callbackFunction) {
        String siteLocale = (String) request.getAttribute("siteLocale");

        if (!"KO".equals(siteLocale.toUpperCase())) {

        }
        return getPageOrderByHeaderLink(headerText, headerField, nowOrderByField, nowOrderByMethod, callbackFunction);
    }

    /**
     * 페이지 정렬 헤더 링크 출력 도우미 메소드
     * @param headerText
     * @param headerField
     * @param nowOrderByField
     * @param nowOrderByMethod
     * @param callbackFunction
     * @return
     */
    public static String getPageOrderByHeaderLink(String headerText, String headerField, String nowOrderByField, String nowOrderByMethod, String callbackFunction)
    {
        StringBuffer res = new StringBuffer();

        String orderby_method = ( headerField.equals(nowOrderByField) && "ASC".equals(nowOrderByMethod) ? "DESC" : "ASC");

        callbackFunction = callbackFunction.replace("[PAGE_ORDERBY_FIELD]", headerField);
        callbackFunction = callbackFunction.replace("[PAGE_ORDERBY_METHOD]", orderby_method);

        if("Y".equals(CommonProperties.load("fnc.listSorting"))){
            res.append("<a href=\"javascript:void(0)\" onclick=\""+ callbackFunction +"\">");
            if ("".equals(nowOrderByField) || !headerField.equals(nowOrderByField))
            {
                //-- 정렬중인 필드가 없거나 아니면 헤더텍스트만 출력!
                res.append(headerText);
            }
            else
            {
                //-- 정렬중인 필드일 경우 표시
                if ("DESC".equals(nowOrderByMethod))
                {
                    res.append("<span style=\"font-size:0.9em\">"+ headerText +"<label title=\"내림차순 정렬 중 입니다.\">▼</label></span>");
                } else {
                    res.append("<span style=\"font-size:0.9em\">"+ headerText +"<label title=\"오름차순 정렬 중 입니다.\">▲</label></span>");
                }
            }
            res.append("</a>");
        } else {
            res.append(headerText);
        }

        return res.toString();
    }


    /**
     * 탭 메뉴 출력 도우미 메소드
     * @param sCtrlId 컨트롤 아이디
     * @param sCodeStr 컨트롤 구성용 코드정보 문자열 ex> {value1}|{text1}|{title1}^{value2}|{text2}|{title2} ...
     * @param sInitData 초기값
     * @param sTabClickFunction 탭 클릭 이벤트 처리 함수([VALUE]:값으로 치환할 부분, [TEXT]:텍스트로 치환할 부분, [TITLE]:타이틀로 치환할 부분, [INDEX]:탭 인덱스로 치환할 부분) ex> goTabPage(document.form1, [VALUE])
     * @param sTabSize 탭 크기
     * @param sMoreHtml more 부분에 들어갈 html
     * @parma sCssClassName 탭메뉴 CSS Class Name [기본값:menu_tab]
     * @param sSepar1 컨트롤 구성용 코드정보 문자열 value-text 구분자 [기본값 :|]
     * @param sSepar2 컨트롤 구성용 코드정보 문자열 value-text 그룹 구분자 [기본값 :^]
     * @return
     */
    public static String getTabMenu(String sCtrlId, String sCodeStr, String sInitData, String sTabClickFunction, String sTabSize, String sMoreHtml, String sCssClassName, String sSepar1, String sSepar2) {
        StringBuffer res = new StringBuffer();

        String[] sCodeDataArr, sTempDataArr;
        String sClassName, sValue, sText, sTitle, sFunction;

        // 기본값 셋팅
        sTabSize = (StringUtils.isEmpty(sTabSize) ? "" : " style=\"width:"+sTabSize+"px\"");
        if (StringUtils.isEmpty(sMoreHtml)) sMoreHtml = "";
        if (StringUtils.isEmpty(sSepar1)) sSepar1 = "|";
        if (StringUtils.isEmpty(sSepar2)) sSepar2 = "^";
        if (StringUtils.isEmpty(sCssClassName)) sCssClassName = "menu_tab";

        sCodeDataArr = StringUtils.splitByWholeSeparatorPreserveAllTokens(sCodeStr, sSepar2);
        if (sCodeDataArr != null)
        {
            res.append("\n <script type=\"text/javascript\"> ");
            res.append("\n function _"+ sCtrlId +"_changeTab(tabIdx) { ");
            res.append("\n  var menuTab = document.getElementById('"+ sCtrlId +"').getElementsByTagName('li'); ");
            res.append("\n  for (var i = 0; i < menuTab.length; i++) { ");
            res.append("\n   if (i != tabIdx) { ");
            res.append("\n       if (menuTab[i].className == 'on') menuTab[i].className = 'off';");
            res.append("\n     } ");
            res.append("\n  } ");
            res.append("\n  menuTab[tabIdx].className = 'on'; ");
            res.append("\n } ");
            res.append("\n </script> ");

            res.append("\n <div class=\""+ sCssClassName +"\"> ");
            res.append("\n  <ul id=\""+ sCtrlId +"\"> ");

            for (int i = 0; i < sCodeDataArr.length; i++) {
                sTempDataArr = StringUtils.splitByWholeSeparatorPreserveAllTokens(sCodeDataArr[i], sSepar1);

                sClassName = (sTempDataArr[0].equals(sInitData.trim()) ? "on" : "off");
                sValue = sTempDataArr[0].replace("\"", "&quot;");
                sText = sTempDataArr[1].replace("\"", "&quot;");
                sTitle = (sTempDataArr.length > 2 ? sTempDataArr[2] : sTempDataArr[1]).replace("\"", "&quot;");
                sFunction = sTabClickFunction;
                sFunction = sFunction.replaceAll("\\[VALUE\\]", sValue);
                sFunction = sFunction.replaceAll("\\[TEXT\\]", sText);
                sFunction = sFunction.replaceAll("\\[TITLE\\]", sTitle);
                sFunction = sFunction.replaceAll("\\[INDEX\\]", ""+i);

                res.append("\n   <li class=\""+ sClassName +"\" onclick=\"_"+ sCtrlId +"_changeTab("+ i +");"+ sFunction +"\" title=\""+ sTitle +"\"><span"+ sTabSize +">"+ sText +"</span></li> ");
            }

            if (!"".equals(sMoreHtml)) {
                res.append("\n   <li class=\"more\">"+ sMoreHtml +"</li>");
            }

            res.append("\n  </ul> ");
            res.append("\n </div> ");
        }

        return res.toString();
    }

    /**
     * 탭 메뉴 출력 도우미 메소드
     * @param sCtrlId 컨트롤 아이디
     * @param sCodeStr 컨트롤 구성용 코드정보 문자열 ex> {value1}|{text1}|{title1}^{value2}|{text2}|{title2} ...
     * @param sInitData 초기값
     * @param sTabClickFunction 탭 클릭 이벤트 처리 함수
     * @param sTabSize 탭 크기
     * @param sMoreHtml more 부분에 들어갈 html
     * @param sCssClassName 탭메뉴 CSS Class Name [기본값:menu_tab]
     * @return
     */
    public static String getTabMenu(String sCtrlId, String sCodeStr, String sInitData, String sTabClickFunction, String sTabSize, String sMoreHtml, String sCssClassName) {
        return getTabMenu(sCtrlId, sCodeStr, sInitData, sTabClickFunction, sTabSize, sMoreHtml, sCssClassName, null, null);
    }

    /**
     * 탭 메뉴 출력 도우미 메소드
     * @param sCtrlId 컨트롤 아이디
     * @param sCodeStr 컨트롤 구성용 코드정보 문자열 ex> {value1}|{text1}|{title1}^{value2}|{text2}|{title2} ...
     * @param sInitData 초기값
     * @param sTabClickFunction 탭 클릭 이벤트 처리 함수
     * @param sTabSize 탭 크기
     * @return
     */
    public static String getTabMenu(String sCtrlId, String sCodeStr, String sInitData, String sTabClickFunction, String sTabSize) {
        return getTabMenu(sCtrlId, sCodeStr, sInitData, sTabClickFunction, sTabSize, null, null, null, null);
    }

    /**
     * 탭 메뉴 출력 도우미 메소드
     * @param sCtrlId 컨트롤 아이디
     * @param sCodeStr 컨트롤 구성용 코드정보 문자열 ex> {value1}|{text1}|{title1}^{value2}|{text2}|{title2} ...
     * @param sInitData 초기값
     * @param sTabClickFunction 탭 클릭 이벤트 처리 함수
     * @return
     */
    public static String getTabMenu(String sCtrlId, String sCodeStr, String sInitData, String sTabClickFunction) {
        return getTabMenu(sCtrlId, sCodeStr, sInitData, sTabClickFunction, null, null, null, null, null);
    }


    /**
     * 구분자로 구분된 문자열을 ~외 N명 형태의 문자열로 변환
     * @param str 문자열
     * @param separ 구분자
     * @param format 변환 문자열 포맷 ex> [NAME] 외 [COUNT]명 => 홍길동 외 3명
     * @return
     */
    public static String getAndOthers(String str, String separ, String format)
    {
        StringBuffer res = new StringBuffer();

        if (res != null && !"".equals(res)) {
            String[] str_arr = str.split(separ);
            if (str_arr.length > 1) {
                res.append("<label title=\""+ str.replace(str_arr[0] + separ, "") +"\">");
                res.append(format.replace("[NAME]", str_arr[0]).replace("[COUNT]", ""+ (str_arr.length-1)));
                res.append("</label>");
            } else {
                res.append(str);
            }
        }

        return res.toString();
    }


    /**
     * BeanResultMap을 input:hidden Str 변환하여 반환
     * @param rowMap
     * @param addKeyNm key명 앞에 공통으로 추가할 문자
     * @param exceptKeyNm 히든으로 만들지 않을 키 명. 콤마(,)로 구분
     * @return
     */
    public static String getMapToInputHidden(ParamMap rowMap,String addKeyNm, String exceptKeyNm){
        StringBuffer res = new StringBuffer();


        String keys[] = (String[])rowMap.keySet().toArray();

        for (int i = 0; i < keys.length; i++) {
            String key = keys[i];
            if(StringUtils.isNotBlank(addKeyNm)){
                key = addKeyNm+key;
            }
            //HTML 문법이 있는 모든 내용을 일반 텍스트로 변환
            String val = Jsoup.parse(rowMap.getString(keys[i])).text();

            res.append("\n <input type=\"hidden\" name=\""+key+"\" value=\""+val+"\">");
        }


        return res.toString();
    }

    /**
     * 대림산업 - editor에 적용할 html
     * @param String path  경로
     * @return
     */
    public static String getDefContent(String path){

         //Form Path
        String formPath = "";

        try {
            InputStream inputStream =  HtmlUtil.class.getResourceAsStream("/html/"+path);  //this.getClass().getClassLoader().getResourceAsStream(strFile);
            BufferedReader in;
            in = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
            StringBuffer formPathTmp = new StringBuffer();
            String strTmp = "";

            while ((strTmp = in.readLine()) != null) {
                formPathTmp.append(strTmp);
            }
            in.close();
            formPath = formPathTmp.toString();

        } catch (Exception e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }


//        formPath = formPath.replace("/", File.separator);
        String strForm = "";

        try {

            if (!"".equals(formPath)) {

                FetchForm fetForm = null;
                fetForm = new FetchForm(formPath);

                StringBuffer sbTmp = new StringBuffer();

                sbTmp.append(fetForm.parseForm());

                strForm = sbTmp.toString();
            }

        } catch (Exception e) {
        }

        return strForm;
    }

    /**
     * getSelectbox
     * @param sType
     * @param iFrom
     * @param iTo
     * @param sSearchDate
     * @param sSelectedDate
     * @return
     */
    public static String getSelectboxCalendar(String sType, int iFrom, int iTo, String sSearchDate) {
        String sSelectBoxOptionHTML = "";
        Calendar cal = Calendar.getInstance();

        if("YEAR".equals(sType)) {
            if( 0>iFrom) {
                iFrom = cal.get(Calendar.YEAR);
            }
            if( 0>iTo) {
                iTo = cal.get(Calendar.YEAR);
            }

            String sSelected = "";

            for(int iIndex=iFrom; iIndex<=iTo; iIndex++) {
                sSelected = "";

                if(!"".equals(sSearchDate)) { //검색한 경우
                    if(Integer.parseInt(sSearchDate)==iIndex) {
                        sSelected = " selected";
                    }
                } else if(cal.get(Calendar.YEAR)==iIndex) { //검색 안한 경우, 현재 일자
                    sSelected = " selected";
                }

                sSelectBoxOptionHTML = sSelectBoxOptionHTML + "<option value='"+iIndex+"'"+sSelected+">"+iIndex+"</option>\n";
            }
        } else if("MONTH".equals(sType)) {
            if( 0>iFrom) {
                iFrom = cal.get(Calendar.MONTH);
            }
            if( 0>iTo) {
                iTo = cal.get(Calendar.MONTH)+1;
            }

            String sSelected = "";

            sSelectBoxOptionHTML = "<option value=''>전체</option>";

            for(int iIndex=iFrom; iIndex<=iTo; iIndex++) {
                sSelected = "";

                if(!"".equals(sSearchDate)) { //검색한 경우
                    if(Integer.parseInt(sSearchDate)==iIndex) {
                        sSelected = " selected";
                    }
//                } else if(cal.get(Calendar.MONTH)+1==iIndex) { //검색 안한 경우, 현재 일자
//                    sSelected = " selected";
                }

                sSelectBoxOptionHTML = sSelectBoxOptionHTML + "<option value='"+(String.valueOf(iIndex).length()==1 ? "0"+iIndex : iIndex)+"'"+sSelected+">"+(String.valueOf(iIndex).length()==1 ? "0"+iIndex : iIndex)+"</option>\n";
            }
        }

        return sSelectBoxOptionHTML;
    }
    /**
     * 비용현황 지급품의연월 전체추가
     * @param sType
     * @param iFrom
     * @param iTo
     * @param sSearchDate
     * @return
     */
    public static String getSelectboxCalendar2(String sType, int iFrom, int iTo, String sSearchDate) {
        String sSelectBoxOptionHTML = "";
        Calendar cal = Calendar.getInstance();

        if("YEAR".equals(sType)) {
            if( 0>iFrom) {
                iFrom = cal.get(Calendar.YEAR);
            }
            if( 0>iTo) {
                iTo = cal.get(Calendar.YEAR);
            }

            String sSelected = "";

            sSelectBoxOptionHTML = "<option value=''>전체</option>";

            for(int iIndex=iFrom; iIndex<=iTo; iIndex++) {
                sSelected = "";

                if(!"".equals(sSearchDate)) { //검색한 경우
                    if(Integer.parseInt(sSearchDate)==iIndex) {
                        sSelected = " selected";
                    }
//                } else if(cal.get(Calendar.YEAR)==iIndex) { //검색 안한 경우, 현재 일자
//                    sSelected = " selected";
                }

                sSelectBoxOptionHTML = sSelectBoxOptionHTML + "<option value='"+iIndex+"'"+sSelected+">"+iIndex+"</option>\n";
            }
        }
        return sSelectBoxOptionHTML;
    }


      // Google Code 의 html2image(GPL) 을 사용한 컨버터
      // 순수 HTML 만 기본 폰트로 Convert 됨
      // image, css 등 link 관련 부분은 변환되지 않음
//    public static String convertImg(String strHtml){
//        String fileInfo = "";
//
//        String IMAGE_FOLDER = "PREVIEW-IMG";
//        String savePath =
//                BaseProperties.get("attach.saveRootPath") + File.separator +
//                        IMAGE_FOLDER;
//        String fileName = StringUtil.getRandomUUID() + ".png";
//
//        String imgFilePath = savePath + File.separator + fileName;
//
//        ByteArrayOutputStream byteArrayOutputStream = null;
//        ByteArrayInputStream byteArrayInputStream = null;
//        FileInputStream fileInputStream = null;
//
//        try{
//            FileUtil.makeDir(savePath);
//
//
//            HtmlImageGenerator imageGenerator = new HtmlImageGenerator();
//            imageGenerator.loadHtml(strHtml);
//
//            imageGenerator.saveAsImage(imgFilePath);
//
//            fileInfo = imgFilePath;
//
//        }catch (Exception e){
//            throw new RuntimeException(e);
//        }
//
//
//        return fileInfo;
//    }
}