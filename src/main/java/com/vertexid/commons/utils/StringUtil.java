package com.vertexid.commons.utils;

import java.io.File;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Clob;
import java.sql.NClob;
import java.text.MessageFormat;
import java.text.Normalizer;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vertexid.viself.base.SystemPropertiesVO;

public class StringUtil extends StringUtils {

    /**
     * logger
     */
    protected static Logger logger = LoggerFactory.getLogger(StringUtil.class);

    /**
     * the instance
     */
    private static StringUtil instance;

    private final static int ZEROPAD = 1; /* pad with zero */
    private final static int SIGN = 2; /* unsigned/signed long */
    private final static int PLUS = 4; /* show plus */
    private final static int SPACE = 8; /* space if plus */
    private final static int LEFT = 16; /* left justified */
    private final static int SPECIAL = 32; /* 0x */
    private final static int LARGE = 64; /* use 'ABCDEF' instead of 'abcdef' */

//    private static String os = null;
//    private static boolean isUnix = true;

    // 거부할 특수문자
    private final static ArrayList<String> REJC_LTR_LST = new ArrayList<String>();
    // 허용할 HTML Character Number
    private final static HashMap<String,String> ALWN_SP_LTR_MAP = new HashMap<String,String>();
    /**
     * <p>
     * {@code StringUtil} instances should NOT be constructed in standard
     * programming. Instead, the class should be used as
     * {@code StringUtil.get(" foo ");}.
     * </p>
     *
     * <p>
     * This constructor is public to permit tools that require a JavaBean
     * instance to operate.
     * </p>
     */
    private StringUtil() {
        super();
        logger.debug("==========>>>>>>>>>> StringUtil constructed!");
    }

    /**
     * @return the instance
     */
    public static StringUtil getInstance() {
        if (instance == null) {
            instance = new StringUtil();
        }

        return instance;
    }


    /**
     * 문자열에서 시간 추출 ex)'변론기일(장소 : 시간 15:10)' = > 15:10을 문자열로 리턴
     * @param o
     * @return
     */
    public static String getStringInTime(String o){
        String timeStr = "";
        String tmpDate = "2016-01-01 ";
        String arrIdx[] = getStrIndex(o, ":");
        if(arrIdx != null && arrIdx.length > 0){
            for(int i=0; i< arrIdx.length; i++){
                logger.debug("arrIdx"+arrIdx[i]);
                if(StringUtil.isNotBlank(arrIdx[i])) {
                    int idx = Integer.parseInt(arrIdx[i]);
                    int startIdx = idx-2;
                    int endIdx = idx+3;
                    if(startIdx > 0 && (endIdx-1) < o.length()){
                        String tmpTime = o.substring(startIdx, endIdx);
                        if(DateUtil.isValid(tmpDate+tmpTime, "yyyy-MM-dd HH:mm")){
                            timeStr = tmpTime;
                            break;
                        }
                    }
                }
            }

        }

        return timeStr;
    }


    /**
     *
     * @param o
     * @param c
     * @return
     */
    public static String[] getStrIndex(String o, String c){
        String indexStr = "";
        int index = o.indexOf(c);
        int cnt = 0;
        while(index > -1){
            if(cnt > 0){indexStr += ",";}
            indexStr += index+"";
            int startIdx = (index+c.length())+1;
            if(startIdx < o.length()){
                index = o.indexOf(c, startIdx);
                cnt++;
            }else{
                index = -1;
            }
        }

        if("".equals(indexStr)) {
            return null;
        }else {
            return indexStr.split(",");
        }
    }


    /**
     * 문자열에서 시간 추출 ex)'변론기일(장소 : 시간 15:10)' = > 15:10을 문자열로 리턴
     * @param o
     * @return
     */
    public static String getStringInJangSo(String o){
        String timeStr = "";
        if(StringUtil.isNotBlank(o)) {
            logger.debug("getStringInJangSo:"+o);
            String start[] = getStrIndex(o, "(");
            String end[] = getStrIndex(o, ")");
            if((start != null && start.length > 0)
                    && (end != null && end.length > 0)){
                timeStr = o.substring(Integer.parseInt(start[0])+1, Integer.parseInt(end[0]));

            }
        }

        return timeStr;
    }




    /**
     * 설정 언어에 마추어 값 반환
     * @param code
     * @param siteLocale
     * @return
     */
    public static String getLang(String code, String siteLocale){
        //-- 인적 오류 서포트

//        String key = StringUtils.replace(code, " ", "");
//        key = StringUtils.upperCase(key);
//        key = StringUtils.replace(key, ",", ".");
//        if(StringUtils.isBlank(siteLocale)){
//            siteLocale = CommonProperties.getSystemDefaultLocale();
//        }
//        ParamMap sysLang = (ParamMap) SysStaticDataController.sysLang.get(key);
//
//        if(sysLang != null && !sysLang.isEmpty()){
//            String rtnStr = sysLang.getString(siteLocale);
//            return StringUtils.isBlank(rtnStr)?(code+":"+siteLocale):rtnStr;
//        }else{
//            if(StringUtil.isNotBlank(code)
//                    && (code.toUpperCase().startsWith("C.")
//                            ||code.toUpperCase().startsWith("L.")
//                            ||code.toUpperCase().startsWith("M.")
//                            ||code.toUpperCase().startsWith("D.")
//                            ||code.toUpperCase().startsWith("B.")
//                            ||code.toUpperCase().startsWith("R.")
//                            )
//                    ) {
//                SysStaticDataController.sysNoLang.add(code);
//                return "NG:"+code;
//            }else {
//                return code;
//            }
//        }

        /*
        if(sysLang != null && !sysLang.isEmpty()){
            String rtnStr = sysLang.getString(siteLocale);
            return StringUtils.isBlank(rtnStr)?("not yet:"+code+":"+siteLocale):rtnStr;
        }else{
            return "NG:"+code;
        }
        */
        return null;
    }

    /**
     * 명시된 문자열이 NULL일 경우 ""(blank) 문자열로 변환한다. 그렇지 않을 경우에는 원본 문자열을 그대로 리턴한다.
     *
     * @param str
     *            변환할 문자열
     * @return 변환된 문자열
     */
    public static String convertNull(String str) {
        return (str == null ? "" : str);
    }


    /**
     * 명시된 문자열이 NULL일 경우 NULL 로 리턴한다. 그렇지 않을 경우에는 원본 문자열을 그대로 리턴한다.
     * @param obj
     * @return
     */
    public static String convertNulltoNull(Object obj) {
        if(obj == null || "".equals(obj.toString())){
            return null;
        }else{
            return obj.toString();
        }
    }

    /**
     * 명시된 문자열이 NULL일 경우 ""(blank) 문자열로 변환한다. 그렇지 않을 경우에는 원본 문자열을 그대로 리턴한다.
     *
     * @param obj
     *            변환할 문자열
     * @return 변환된 문자열
     */
    public static String convertNull(Object obj) {
        return (obj == null ? "" : obj.toString());
    }

    /**
     * 윕스 링크로 변환
     * @param obj
     * @return
     */
    public static String convertWipsLink(Object obj, Object wkey) {
        return convertWipsLink(obj, wkey, "kr");
    }

    /**
     * 윕스 링크로 변환
     * @param obj
     * @return
     */
    public static String convertWipsLink(Object obj, Object wkey, String chulweongug_cod) {


        if("".equals(convertNull(wkey))){
            return (obj == null ? "" : obj.toString());
        }else{
            String str = "";

            if (obj == null){
                return null;
            }else{
                str = "<a href='javascript:void(0)' onClick=\"airCommon.openWips('"+wkey.toString()+"','" + chulweongug_cod.toLowerCase() + "')\" style=\"color:red;font-weight:bold;text-decoration:underline\" title=\"클릭시 원문보기가 가능합니다.\"/>"+obj.toString()+"</a>";

                return str;
            }
        }
    }

    /**
     * 원본 문자셋(src)을 가진 문자열을 대상 문자셋(tar)으로 변환한다.
     *
     * @param str
     *            원본 문자열
     * @param srcCharsetName
     *            원본 문자셋 ex> ISO-8859-1
     * @param tarCharsetName
     *            대상 문자셋 ex> UTF-8
     * @return 변환된 문자열
     */
    public static String convertCharset(String str, String srcCharsetName, String tarCharsetName) {
        String result = null;

        if (str == null)
            return null;

        try {
            result = new String(str.getBytes(srcCharsetName), tarCharsetName);
        } catch (UnsupportedEncodingException e) {
            result = new String(str);
        }

        return result;
    }

    /**
     * 입력값이 NULL OR EMPTY 일 경우 기본값으로 대체
     *
     * @param sIn
     *            입력값
     * @param sDefault
     *            기본값
     * @return
     */
    public static String convertNullDefault(String sIn, String sDefault) {
        if (sIn == null || "".equals(sIn)) {
            sIn = sDefault;
        }

        return sIn;
    }

    /**
     * 입력값이 NULL OR EMPTY 일 경우 기본값으로 대체
     *
     * @param sIn
     *            입력값
     * @param sDefault
     *            기본값
     * @return
     */
    public static String convertNullDefault(Object sIn, Object sDefault) {
        if (sIn == null || "".equals(sIn)) {
            if (sDefault != null) {
                sIn = sDefault;
            } else {
                sIn = new String();
            }
        }

        return sIn.toString();
    }

    /**
     * 대상 문자열을 지정된 형식의 문자열로 변환
     *
     * @param forObj
     *            대상 문자열
     * @param forType
     *            변환형식 [ VIEW:화면출력용, INPUT:폼값출력용, JAVASCRIPT:자바스크립트입력값출력용,
     *            EDITOR:HTML에디터입출력용, XML:XML출력용 ]
     * @return 변환된 문자열
     */
    public static String convertFor(Object forObj, String forType) {
        String forStr = (forObj == null ? "" : forObj.toString());
        forType = (forType == null ? "" : forType.toString());

        forType = forType.toUpperCase();
        if ("VIEW".equals(forType)) {
            forStr = StringUtils.replace(forStr, "&", "&amp;");
            forStr = StringUtils.replace(forStr, "#", "&#35;");
            forStr = StringUtils.replace(forStr, "\"", "&#34;");
            forStr = StringUtils.replace(forStr, "\\$", "&#36;");
            forStr = StringUtils.replace(forStr, "%", "&#37;");
            forStr = StringUtils.replace(forStr, "'", "&#39;");
            // forStr = forStr.replaceAll("(", "&#40;");
            // forStr = forStr.replaceAll(")", "&#41;");
            // forStr = forStr.replaceAll("*", "&#42;");
            // forStr = forStr.replaceAll("+", "&#43;");
            // forStr = forStr.replaceAll(",", "&#44;");
            // forStr = forStr.replaceAll("-", "&#45;");
            // forStr = forStr.replaceAll(".", "&#46;");
            // forStr = forStr.replaceAll("/", "&#47;");
            // forStr = forStr.replaceAll(":", "&#58;");
            //forStr = forStr.replaceAll("<", "&#60;");
            // forStr = forStr.replaceAll("=", "&#61;");
            //forStr = forStr.replaceAll(">", "&#62;");
            forStr = StringUtils.replace(forStr, "\\?", "&#63;");
            forStr = StringUtils.replace(forStr, "@", "&#64;");
            // forStr = forStr.replaceAll("[", "&#91;");
//            forStr = forStr.replaceAll("\\", "&#92;");
            // forStr = forStr.replaceAll("]", "&#93;");
            // forStr = forStr.replaceAll("^", "&#94;");
            // forStr = forStr.replaceAll("_", "&#95;");
            // forStr = forStr.replaceAll("`", "&#96;");
            // forStr = forStr.replaceAll("{", "&#123;");
            // forStr = forStr.replaceAll("|", "&#124;");
            // forStr = forStr.replaceAll("}", "&#125;");
            // forStr = forStr.replaceAll("~", "&#126;");

            forStr = StringUtils.replace(forStr, "\t", "&nbsp;&nbsp;&nbsp;");
//            forStr = forStr.replaceAll("  ", "&nbsp;&nbsp;");
//            forStr = forStr.replaceAll(" ", "&nbsp;");
            forStr = StringUtils.replace(forStr, "\r\n", "<br>");
            forStr = StringUtils.replace(forStr, "\n", "<br>");
//            forStr = StringUtil.replaceAll(forStr, "\\n", "<br />");
        } else if ("INPUT".equals(forType)) {
            forStr = StringUtils.replace(forStr, "&", "&amp;");
            forStr = StringUtils.replace(forStr, "#", "&#35;");
            forStr = StringUtils.replace(forStr, "\"", "&#34;");
            forStr = StringUtils.replace(forStr, "$", "&#36;");
            forStr = StringUtils.replace(forStr, "%", "&#37;");
            forStr = StringUtils.replace(forStr, "'", "&#39;");
            forStr = StringUtils.replace(forStr, "<", "&#60;");
            forStr = StringUtils.replace(forStr, ">", "&#62;");

        } else if ("JAVASCRIPT".equals(forType)) {
            forStr = StringUtils.replace(forStr, "\\", "\\\\");
            forStr = StringUtils.replace(forStr, "\"", "\\&#34;");
            forStr = StringUtils.replace(forStr, "'", "\\&#39;");
            forStr = StringUtils.replace(forStr, "\r", "\\r");
            forStr = StringUtils.replace(forStr, "\n", "\\n");
            forStr = StringUtils.replace(forStr, "\t", "\\t");
            forStr = StringUtils.replace(forStr, "\f", "\\f");
            // forStr = forStr.replaceAll("\b", "\\b");

        } else if ("EDITOR".equals(forType)) {
            String[] escape_strings = null;

            // -- 불필요한 태그 치환
            escape_strings = new String[] { "applet", "body", "embed", "html", "iframe", "input", "link", "meta", "object", "script", "select", "style", "textarea", "title" };
            for (int i = 0; i < escape_strings.length; i++) {
                forStr = StringUtils.replace(forStr,"<(?i)" + escape_strings[i], "&#60;" + escape_strings[i]);
                forStr = StringUtils.replace(forStr,"</(?i)" + escape_strings[i] + ">", "&#60;&#47;" + escape_strings[i] + "&#62;");
            }

            // -- 불필요한 속성 치환
            escape_strings = new String[] { "onabort", "onactivate", "onbegin", "onblur", "onbounce", "onchange", "onclick", "oncontextmenu", "ondbclick", "ondeactivate",
                    "ondocumentready", "ondrag", "ondragdrop", "ondragend", "ondrop", "onend", "onerror", "onerrorupdate", "onfinish", "onfocus", "onfocusin", "onfocusout",
                    "onhelp", "onhide", "onkeydown", "onkeypress", "onkeyup", "onload", "onmousedown", "onmouseenter", "onmouseleave", "onmousemove", "onmouseout", "onmouseover",
                    "onmouseup", "onmousewheel", "onmove", "onmoveend", "onmovestart", "onpaste", "onpause", "onreadystatechange", "onreset", "onresize", "onresizeend",
                    "onresizestart", "onscroll", "onselect", "onselectionchange", "onselectstart", "onstart", "onstop", "onsubmit", "ontimeerror", "onunload" };
            for (int i = 0; i < escape_strings.length; i++) {
                forStr = StringUtils.replace(forStr,"(?i)" + escape_strings[i] + "(\\s)*=", escape_strings[i] + "&#61;");
            }

            // -- style expression escape
            forStr = StringUtils.replace(forStr,"(?i):(\\s)*expression(\\s)*\\(", ":<!--// Illegal Expression! //-->expression<!--// Illegal Expression! //-->(");

            // Dext Editor
            forStr = StringUtils.replace(forStr,"'", "&#39;");

        } else if ("XML".equals(forType)) {
            forStr = StringEscapeUtils.escapeXml10(forStr);

        } else if ("JSON".equals(forType)) {
            forStr = StringUtils.replace(forStr, "\\", "\\\\");
            forStr = StringUtils.replace(forStr, "\"", "\\\"");
            forStr = StringUtils.replace(forStr, "/", "\\/");
            forStr = StringUtils.replace(forStr, "\b", "\\b");
            forStr = StringUtils.replace(forStr, "\f", "\\f");
            forStr = StringUtils.replace(forStr, "\n", "\\n");
            forStr = StringUtils.replace(forStr, "\r", "\\r");
            forStr = StringUtils.replace(forStr, "\t", "\\t");

        } else {
            forStr = "잘못된 인자값 입니다 : ForType => " + forType;
        }

        return forStr;
    }

    /**
     * 대상 문자열을 HTML 에디터 출력용 문자열로 변환
     *
     * @param forObj
     * @return
     * @throws Exception
     */
    public static String convertForEditor(Object forObj) {
        return convertFor(forObj, "EDITOR");
    }

    /**
     * 대상 문자열을 폼값 출력용 문자열로 변환
     *
     * @param forObj
     * @return
     * @throws Exception
     */
    public static String convertForInput(Object forObj) {
        return convertFor(forObj, "INPUT");
    }

    /**
     * 대상 문자열을 자바스크립트 출력용 문자열로 변환
     *
     * @param forObj
     * @return
     * @throws Exception
     */
    public static String convertForJavascript(Object forObj) {
        return convertFor(forObj, "JAVASCRIPT");
    }

    /**
     * 대상 문자열을 화면출력용 문자열로 변환
     *
     * @param forObj
     * @return
     * @throws Exception
     */
    public static String convertForView(Object forObj) {
        return convertFor(forObj, "VIEW");
    }

    /**
     * 대상 문자열을 XML 출력용 문자열로 변환
     *
     * @param forObj
     * @return
     * @throws Exception
     */
    public static String convertForXml(Object forObj) {
        return convertFor(forObj, "XML");
    }

    /**
     * 대상 문자열을 JSON 출력용 문자열로 변환 (※ XSS필터링 포함)
     * @param forObj
     * @return
     * @throws Exception
     */
    public static String convertForJson(Object forObj) {
        String res = (forObj == null ? "" : forObj.toString());

//        res = convertFor(res, "EDITOR");    //XSS필터링
        res = convertFor(res, "JSON");

        return res;
    }

    /**
     * 대상 문자열을 JSON 출력용 문자열로 변환 (※ XSS필터링 안함)
     * @param forObj
     * @return
     * @throws Exception
     */
    public static String convertForJsonOnly(Object forObj) {
        return convertFor(forObj, "JSON");
    }

    /**
     * 태그 제거
     * @param orgStr
     * @return
     */
    public static String removeTag(String orgStr){
        //return orgStr.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
        return orgStr.replaceAll("\\<[^\\>]*\\>", "");
    }

    /**
     * 한글을 포함한 글자수를 리턴한다.
     *
     * @param str
     *            원본 문자열
     * @return 글자수
     */
    public static int byteLength(String str) {
        int result = 0;
        if (str == null)
            return result;
        byte bStr[] = str.getBytes();
        return bStr.length;
    }

    /**
     * 문자열에서 명시된 문자가 연속하여 두번이상 나타나면 이를 하나로 만들어준다.
     * <p>
     * <li>removeDuplicatedChar("abbc", 'b') => "abc"
     * <li>removeDuplicatedChar("/request//test.html", '/') =>
     * "/request/test.html"
     *
     * @param str
     *            원본 문자열
     * @param c
     *            중복을 제거할 문자
     */
    public static String removeDuplicatedChar(String str, char c) {
        int i = 0;
        String t = "" + c + c;
        if (str == null)
            return str;
        while ((i = str.indexOf(t)) >= 0) {
            str = str.substring(0, i) + str.substring(i + 1);
        }

        return str;
    }

    /**
     * 이 method가 수행하는 작업은 먼저 path에서 "/./" 문자를 제거하고 "/../"를 찾아서 상위 디렉토리에 해당하는
     * 경로만큼 path에서 문자열을 제거한다.<br>
     * 이를 이용하여 상대경로 path가 제거된 경로명을 얻을 수 있다.
     *
     * @param path
     *            - A path to be canonized.
     */
    public static String canonizePath(String path) {
        return canonizePath(path, File.separatorChar);
    }

    /**
     * 이 method가 수행하는 작업은 먼저 path에서 "/./" 문자를 제거하고 "/../"를 찾아서 상위 디렉토리에 해당하는
     * 경로만큼 path에서 문자열을 제거한다.<br>
     * 이를 이용하여 상대경로 path가 제거된 경로명을 얻을 수 있다.
     *
     * @param path
     *            - A path to be canonized.
     * @param separator
     *            - A path separator character
     */
    public static String canonizePath(String path, char separator) {
        int i = 0;
        char sep = separator;
        String self = sep + "." + sep;
        String parent = sep + ".." + sep;
        if (path == null)
            return null;
        int idx = path.length();
        while ((i = path.indexOf(self)) >= 0)
            path = path.substring(0, i) + path.substring(i + 2);
        while ((i = path.indexOf(parent)) >= 0)
            if ((idx = path.lastIndexOf(sep, i - 1)) >= 0)
                path = path.substring(0, idx) + path.substring(i + 3);
            else
                path = path.substring(i + 3);

        if (path.endsWith(sep + ".")) {
            path = path.substring(0, path.length() - 1);
        } else if (path.endsWith(sep + "..")) {
            path = path.substring(0, path.length() - 3);
            path = path.substring(0, path.lastIndexOf("/") + 1);
        }

        return path;
    }

    /**
     * 주어진 문자열이 Wild Expression ('*'나 '?') 문자를 포함하고 있는지 확인한다.
     *
     * @param str
     *            문자열
     * @return Wild Expression을 포함하고 있을 경우 true, 그렇지 않으면 false.
     */
    public static boolean isWildExp(String str) {
        if (str == null)
            return false;
        if (str.indexOf('*') >= 0)
            return true;
        if (str.indexOf('?') >= 0)
            return true;
        return false;
    }

    /**
     * 문자열이 지정한 wild express에 합당한지 확인한다. 이 때 대소문자를 구별하지 않는다.
     *
     * @param source
     *            비교하고자 하는 문자열
     * @param expression
     *            '*', '?'를 이용한 wild expression
     * @return 비교가 성공하면 0을 반환, 그 외의 경우 양 혹은 음의 정수를 반환
     */
    public static int compareWildExpIgnoreCase(String source, String expression) {
        int ret = 0;
        int x = 0, y = 0;

        if (source == null || expression == null)
            return -1;

        char[] exp = expression.toCharArray();
        char[] str = source.toCharArray();

        for (; y < exp.length; ++y, ++x) {
            if ((x >= str.length) && (exp[y] != '*'))
                return -1;

            if (exp[y] == '*') {
                while (++y < exp.length && exp[y] == '*')
                    continue;

                // logger.debug("x = "+x+", y = "+y);
                if (y >= exp.length)
                    return 0;

                while (x < str.length) {
                    if ((ret = compareWildExpIgnoreCase(new String(str, x++, str.length - x + 1), new String(exp, y, exp.length - y))) != 1)
                        return ret;
                }

                return -1;
            } else if ((exp[y] != '?') && (Character.toLowerCase(str[x]) != Character.toLowerCase(exp[y])))
                return 1;
        }

        if (x < str.length)
            return 1;

        return 0;
    }

    /**
     * 문자열이 지정한 wild express에 합당한지 확인한다. 이 때 대소문자를 구별한다.
     *
     * @param source
     *            비교하고자 하는 문자열
     * @param expression
     *            '*', '?'를 이용한 wild expression
     * @return 비교가 성공하면 0을 반환, 그 외의 경우 양 혹은 음의 정수를 반환
     */
    public static int compareWildExp(String source, String expression) {
        int ret = 0;
        int x = 0, y = 0;

        if (source == null || expression == null)
            return -1;

        char[] exp = expression.toCharArray();
        char[] str = source.toCharArray();

        for (; y < exp.length; ++y, ++x) {
            if ((x >= str.length) && (exp[y] != '*'))
                return -1;

            if (exp[y] == '*') {
                while (++y < exp.length && exp[y] == '*')
                    continue;

                if (y >= exp.length)
                    return 0;

                while (x < str.length) {
                    if ((ret = compareWildExp(new String(str, x++, str.length - x + 1), new String(exp, y, exp.length - y))) != 1)
                        return ret;
                }

                return -1;
            } else if ((exp[y] != '?') && (str[x] != exp[y]))
                return 1;
        }

        if (x < str.length)
            return 1;

        return 0;
    }

    /**
     * 파일 사이즈 단위(K, M, G)를 포함하는 문자열 형식의 파일 사이즈 표기를 byte 단위의 파일 사이즈로 리턴한다.
     * <p>
     * e.g) 1024, 1K, 10M, 0.5G
     *
     * @param strLimit
     *            포함하는 파일 사이즈 문자열
     * @return byte 단위의 파일 사이즈
     */
    public static int parseFileSize(String strLimit) throws ParseException {
        int limit = 0;

        try {
            String str = strLimit.toUpperCase();
            if (str.endsWith("K"))
                limit = Integer.parseInt(str.substring(0, str.length() - 1)) * 1024;
            else if (str.endsWith("M"))
                limit = Integer.parseInt(str.substring(0, str.length() - 1)) * 1024 * 1024;
            else if (str.endsWith("G"))
                limit = Integer.parseInt(str.substring(0, str.length() - 1)) * 1024 * 1024 * 1024;
            else
                limit = Integer.parseInt(str);
        } catch (Exception e) {
            if (e instanceof ParseException)
                throw (ParseException) e;
            else
                throw new ParseException("Invalid file size format", 0);
        }

        return limit;
    }

    /**
     * 실제파일 사이즈를 단위기호를 호함하는 문자열 형식의 파일 사이즈 표기로 변환한다. 이때 명시된 사이즈에 해당하는 가장 큰 표기
     * 단위를 사용한다. 예를 들어 1024 -> 1K.
     *
     * @param size
     *            byte단위의 파일 사이즈
     * @return 단위를 호함하는 문자열 형식의 파일 사이즈 표기
     */
    public static String formatFileSize(int size) {
        int K = 1024;
        int M = 1024 * 1024;
        int G = 1024 * 1024 * 1024;

        if (size < K) {
            return Integer.toString(size) + "B";
        } else if (size < M) {
            double r = ((double) size / (double) K);
            return MessageFormat.format("{0,number,.#K}", new Object[] { new Double(r) });
        } else if (size < G) {
            double r = ((double) size / (double) M);
            return MessageFormat.format("{0,number,.#M}", new Object[] { new Double(r) });
        } else // if (size >= G)
        {
            double r = ((double) size / (double) G);
            return MessageFormat.format("{0,number,.#G}", new Object[] { new Double(r) });
        }
    }

    /**
     * 줄이 시작되는 위치에 명시된 prefix를 추가한다.
     *
     * @param source
     *            원본 문자열
     * @param prefix
     *            Prefix
     * @return Prefix가 추가된 문자열
     */
    public static String appendPrefix(String source, String prefix) {
        String returnValue = "";
        StringTokenizer stk = new StringTokenizer(source, "\n");

        while (stk.hasMoreTokens())
            returnValue += prefix + stk.nextToken();

        return returnValue;
    }

    /**
     * 줄이 끝나는 위치에 명시된 suffix를 추가한다.
     *
     * @param source
     *            원본 문자열
     * @param suffix
     *            Suffix
     * @return Suffix가 추가된 문자열
     */
    public static String appendSuffix(String source, String suffix) {
        String ls_return = "";
        StringTokenizer stk = new StringTokenizer(source, "\n");

        while (stk.hasMoreTokens())
            ls_return += stk.nextToken() + suffix;

        return ls_return;
    }

    /**
     * C style 출력 기능을 제공한다.
     *
     * @param fmt
     *            출력 포멧
     * @param arg1
     *            파라미터
     * @return 포멧팅된 문자열
     */
    public static String sprintf(String fmt, String arg1) {
        return vprintf(fmt, new String[] { arg1 });
    }

    /**
     * C style 출력 기능을 제공한다.
     *
     * @param fmt
     *            출력 포멧
     * @param arg1
     *            파라미터1
     * @param arg2
     *            파라미터2
     * @return 포멧팅된 문자열
     */
    public static String sprintf(String fmt, String arg1, String arg2) {
        return vprintf(fmt, new String[] { arg1, arg2 });
    }

    /**
     * C style 출력 기능을 제공한다.
     *
     * @param fmt
     *            출력 포멧
     * @param arg1
     *            파라미터1
     * @param arg2
     *            파라미터2
     * @param arg3
     *            파라미터3
     * @return 포멧팅된 문자열
     */
    public static String sprintf(String fmt, String arg1, String arg2, String arg3) {
        return vprintf(fmt, new String[] { arg1, arg2, arg3 });
    }

    /**
     * C style 출력 기능을 제공한다.
     *
     * @param fmt
     *            출력 포멧
     * @param args
     *            파라미터 리스트
     * @return 포멧팅된 문자열
     */
    public static String sprintf(String fmt, String[] args) {
        return vprintf(fmt, args);
    }

    private static String vprintf(String fmt, String[] args) {
        StringBuffer sb = new StringBuffer();
        int argsIdx = 0;
        char c;
        int flags;
        int field_width;
        int precision;
        int base;
        long num;

        for (int i = 0; i < fmt.length(); i++) {
            c = fmt.charAt(i);

            if (c != '%') {
                sb.append(c);
                continue;
            }
            /* process flags */
            flags = 0;

            boolean repeat = true;
            while (repeat) {
                c = fmt.charAt(++i); /* this also skip first % */
                switch (c) {
                case '-':
                    flags |= LEFT;
                    break;
                case '+':
                    flags |= PLUS;
                    break;
                case ' ':
                    flags |= SPACE;
                    break;
                case '#':
                    flags |= SPECIAL;
                    break;
                case '0':
                    flags |= ZEROPAD;
                    break;
                default:
                    repeat = false;
                    break;
                }
            }

            /* get field width */
            field_width = -1;
            if (Character.isDigit(c)) {
                field_width = 0;
                do {
                    field_width = field_width * 10 + (c - '0');
                    c = fmt.charAt(++i);
                } while (Character.isDigit(c));
            } else if (c == '*') {
                c = fmt.charAt(++i);
                /* it's the next argument */
                field_width = Integer.parseInt(args[argsIdx++]);
                if (field_width < 0) {
                    field_width = -field_width;
                    flags |= LEFT;
                }
            }

            /* get the precision */
            precision = -1;
            if (c == '.') {
                c = fmt.charAt(++i);
                if (Character.isDigit(c)) {
                    precision = 0;
                    do {
                        precision = precision * 10 + (c - '0');
                        c = fmt.charAt(++i);
                    } while (Character.isDigit(c));
                } else if (c == '*') {
                    c = fmt.charAt(++i);
                    /* it's the next argument */
                    precision = Integer.parseInt(args[argsIdx++]);
                }
                if (precision < 0)
                    precision = 0;
            }

            /* get the conversion qualifier */
            /*
             * NOT SUPPORT IN **JAVA** qualifier = -1; if( c == 'h' || c == 'l'
             * || c == 'L') { qualifier = c; c = fmt.charAt(++i); }
             */

            /* default base */
            base = 10;
            switch (c) {
            case 'c':
                if ((flags & LEFT) == 0)
                    while (--field_width > 0)
                        sb.append(' ');

                sb.append(args[argsIdx++]);
                while (--field_width > 0)
                    sb.append(' ');
                continue;

            case 's':
                String str = args[argsIdx++];
                if (str == null)
                    str = "<null>";

                int len = str.length();

                if ((flags & LEFT) != 0)
                    while (len < field_width--)
                        sb.append(' ');
                sb.append(str);
                while (len < field_width--)
                    sb.append(' ');
                continue;

                /*
                 * NOT SUPPORT IN **JAVA** case 'p': if( field_width == -1) {
                 * field_width = 2*sizeof(void *); flags |= ZEROPAD; }
                 * print_number((unsigned long) va_arg(args, void *), 16,
                 * field_width, precision, flags); continue;
                 */
            case 'o':
                base = 8;
                break;

            /* integer number format */
            case 'X':
                flags |= LARGE;
            case 'x':
                base = 16;
                break;

            case 'd':
            case 'i':
                flags |= SIGN;
            case 'u':
                break;
            default:
                if (c != '%')
                    sb.append('%');
                /*
                 * if (c != EOF) sb.append(c); else --i;
                 */
                continue;
            }

            num = Long.parseLong(args[argsIdx++]);
            sb.append(vprintf_number(num, base, field_width, precision, flags));
        }

        return sb.toString();
    }

    private static String vprintf_number(long num, int base, int size, int precision, int type) {
        StringBuffer sb = new StringBuffer();

        char[] digits = "0123456789abcdefghijklmnopqrstuvwxyz".toCharArray();
        char tmp[] = new char[66];
        char c;
        char sign;
        int i;

        if ((type & LARGE) != 0)
            digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();

        if ((type & LEFT) != 0)
            type &= ~ZEROPAD;

        if (base < 2 || base > 36)
            return "";

        c = ((type & ZEROPAD) != 0) ? '0' : ' ';
        sign = 0;

        if ((type & SIGN) != 0) {
            if (num < 0) {
                sign = '-';
                num = -num;
                size--;
            } else if ((type & PLUS) != 0) {
                sign = '+';
                size--;
            } else if ((type & SPACE) != 0) {
                sign = ' ';
                size--;
            }
        }

        if ((type & SPECIAL) != 0) {
            if (base == 16)
                size -= 2;
            else if (base == 8)
                size--;
        }

        i = 0;

        if (num == 0) {
            tmp[i++] = '0';
        } else {
            while (num != 0) {
                double d = num % base;
                tmp[i++] = digits[(int) d];
                num = num / base;
            }
        }

        if (i > precision)
            precision = i;

        size -= precision;

        if ((type & (ZEROPAD + LEFT)) == 0)
            while (size-- > 0)
                sb.append(' ');
        if (sign != 0)
            sb.append(sign);

        if ((type & SPECIAL) != 0) {
            if (base == 8) {
                sb.append('0');
            } else if (base == 16) {
                sb.append('0');
                sb.append(digits[33]);
            }
        }

        if ((type & LEFT) == 0)
            while (size-- > 0)
                sb.append(c);
        while (i < precision--)
            sb.append('0');
        while (i-- > 0)
            sb.append(tmp[i]);
        while (size-- > 0)
            sb.append(' ');

        return sb.toString();
    }

    /**
     * 문자열의 길이가 제한된 길이보다 길 경우 자르고 말줄임표 삽입
     *
     * @param str
     *            문자열
     * @param len
     *            길이
     * @param apos
     *            말줄임표
     * @return
     */
    public static String getTrunc(String str, int len, String apos) {
        String res = "";

        if (str != null) {
            if (str.length() > len) {
                res = str.substring(0, len);
                if (apos != null && !"".equals(apos)) {
                    res += apos;
                }
            } else {
                res = str;
            }
        }

        return res;
    }

    /**
     * 문자열의 길이가 제한된 길이보다 길 경우 자르고 말줄임표 삽입
     *
     * @param str
     * @param len
     * @return
     */
    public static String getTrunc(String str, int len) {
        return getTrunc(str, len, "...");
    }

    /**
     * String을 byte단위로 잘라서 return author okjsp.pe.kr author
     * http://www.javasun.net modify kykime
     *
     * @param srcStr
     *            원본 문장
     * @param lenLimit
     *            자를 단위
     * @param addStr
     *            덧붙이는 문자
     * @return 변경된 문장
     */
    public static String getByteSubString(String srcStr, int lenLimit, String addStr) {
        if (srcStr == null)
            return "";

        String str = srcStr;
        StringBuffer sb = new StringBuffer();
        int subLen = 0;
        for (int i = 0; (i < str.length() && subLen < lenLimit); i++) {
            if (Character.getType(str.charAt(i)) == Character.OTHER_LETTER) { // 2byte
                                                                                // 문자
                                                                                // (한글,
                                                                                // 한문,...)Character.OTHER_LETTER
                                                                                // =
                                                                                // 5
                subLen += 2;
            } else {
                subLen++; // 영어소문자 (Character.LOWERCASE_LETTER = 2),
                            // space(Character.SPACE_SEPARATOR = 12), 특수
                            // 문자(Character.OTHER_PUNCTUATION = 24)
            }
            sb.append(str.charAt(i));
        }

        byte[] byteStr = srcStr.getBytes();

        if (byteStr.length > lenLimit) {
            sb.append(addStr);
        }
        return sb.toString();
    }

    /**
     * Map 내용을 쿼리스트링으로 변환
     *
     * @param map
     * @param charSet
     *            쿼리스트링 인코딩 문자셋 ex> EUC-KR, UTF-8
     * @return 쿼리스트링
     * @throws UnsupportedEncodingException
     */
    public static String parseMapToQueryString(Map<String, Object> map, String charSet) throws UnsupportedEncodingException {
        String res = "";

        if (map != null) {
            Iterator<String> iter = map.keySet().iterator();
            while (iter.hasNext()) {
                String key = String.valueOf(iter.next());

                if (res != "")
                    res += "&";

                res += key + "=" + URLEncoder.encode(defaultIfEmpty(String.valueOf(map.get(key)), ""), charSet);
            }
        }

        return res;
    }

    /**
     * 빈 문자 포함, 구분자를 기준으로 대상 문자열 Split
     *
     * @param str
     *            대상 문자열
     * @param separator
     *            구분자
     * @return
     */
    public static String[] split(String str, String separator) {
        return splitByWholeSeparatorPreserveAllTokens(str, separator);
    }

    /**
     * 자바스크립트 escape() 메소드와 동일한 작업 수행
     *
     * @param src
     * @return
     */
    public static String escape(String src) {
        int i;
        char j;
        StringBuffer tmp = new StringBuffer();

        tmp.ensureCapacity(src.length() * 6);
        for (i = 0; i < src.length(); i++) {
            j = src.charAt(i);

            if (Character.isDigit(j) || Character.isLowerCase(j) || Character.isUpperCase(j))
                tmp.append(j);
            else if (j < 256) {
                tmp.append("%");
                if (j < 16)
                    tmp.append("0");
                tmp.append(Integer.toString(j, 16));
            } else {
                tmp.append("%u");
                tmp.append(Integer.toString(j, 16));
            }
        }

        return tmp.toString();
    }

    /**
     * 자바스크립트 unescape() 메소드와 동일한 작업 수행
     *
     * @param inp
     * @return
     */
    public static String unescape(String inp) {
        String rtnStr = "";

        if (inp != null && inp != "") {
            char[] arrInp = inp.toCharArray();
            int i;
            for (i = 0; i < arrInp.length; i++) {
                if (arrInp[i] == '%') {
                    String hex;
                    if (arrInp[i + 1] == 'u') { // 유니코드.
                        hex = inp.substring(i + 2, i + 6);
                        i += 5;
                    } else { // ascii
                        hex = inp.substring(i + 1, i + 3);
                        i += 2;
                    }
                    try {
                        rtnStr += new String(Character.toChars(Integer.parseInt(hex, 16)));
                    } catch (NumberFormatException e) {
                        rtnStr += "%";
                        i -= (hex.length() > 2 ? 5 : 2);
                    }
                } else {
                    rtnStr += arrInp[i];
                }
            }
        }

        return rtnStr;
    }

    /**
     * Decodes the passed UTF-8 String using an algorithm that's compatible with
     * JavaScript's <code>decodeURIComponent</code> function. Returns
     * <code>null</code> if the String is <code>null</code>.
     *
     * @param s
     *            The UTF-8 encoded String to be decoded
     * @return the decoded String
     */
    public static String decodeURIComponent(String s) {
        if (s == null) {
            return null;
        }

        String result = null;

        try {
            result = URLDecoder.decode(s, "UTF-8");
        }

        // This exception should never occur.
        catch (UnsupportedEncodingException e) {
            result = s;
        }

        return result;
    }

    /**
     * Encodes the passed String as UTF-8 using an algorithm that's compatible
     * with JavaScript's <code>encodeURIComponent</code> function. Returns
     * <code>null</code> if the String is <code>null</code>.
     *
     * @param s
     *            The String to be encoded
     * @return the encoded String
     */
    public static String encodeURIComponent(String s) {
        String result = null;

        try {
            result = URLEncoder.encode(s, "UTF-8").replaceAll("\\+", "%20").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(").replaceAll("\\%29", ")")
                                .replaceAll("\\%7E", "~");
        }

        // This exception should never occur.
        catch (UnsupportedEncodingException e) {
            result = s;
        }

        return result;
    }

    /**
     * 코드정보 문자열에서 비교 값과 일치하는 그룹의 대상 값을 반환
     *
     * @param srcValue
     *            비교 값
     * @param codestr
     *            코드정보 문자열
     * @param srcIndex
     *            비교 값 인덱스 [기본값:0]
     * @param tarIndex
     *            대상 값 인덱스 [기본값:1]
     * @param separ1
     *            값 구분자 [기본값:|]
     * @param separ2
     *            그룹 구분자 [기본값:^]
     * @param separ3
     *            비교값 구분자 [기본값:,]
     * @returns {String}
     */
    public static String getCodestrValue(String srcValue, String codestr, int srcIndex, int tarIndex, String separ1, String separ2, String separ3) {
        String v_res = "";

        // -- 구분자 기본값 셋팅!
        separ1 = ((separ1 == null || separ1 == "") ? "|" : separ1);
        separ2 = ((separ2 == null || separ2 == "") ? "^" : separ2);
        separ3 = ((separ3 == null || separ3 == "") ? "," : separ3);

        // -- 인덱스 기본값 셋팅!
        srcIndex = (srcIndex < 0 ? 0 : srcIndex);
        tarIndex = (tarIndex < 0 ? 1 : tarIndex);

        String[] a_val = splitByWholeSeparatorPreserveAllTokens(srcValue, separ3);
        String[] a_codestr = splitByWholeSeparatorPreserveAllTokens(codestr, separ2);
        if(StringUtil.isNotBlank(srcValue)){
            for (int i = 0; i < a_val.length; i++) {
                for (int j = 0; j < a_codestr.length; j++) {
                    String[] a_temp = splitByWholeSeparatorPreserveAllTokens(a_codestr[j], separ1);

                    if (a_temp[srcIndex].equals(a_val[i].trim())) {
                        if (!"".equals(v_res))
                            v_res += separ3; // 비교값이 1개 이상일 경우 반환값에 구분자 삽입
                        v_res += a_temp[tarIndex];
                    }
                }
            }
        }
        return v_res;
    }

    /**
     * 코드정보 문자열에서 비교 값과 일치하는 그룹의 대상 값을 반환
     *
     * @param srcValue
     *            비교 값
     * @param codestr
     *            코드정보 문자열
     * @param separ1
     *            값 구분자
     * @param separ2
     *            그룹 구분자
     * @param separ3
     *            비교값 구분자
     * @return
     */
    public static String getCodestrValue(String srcValue, String codestr, String separ1, String separ2, String separ3) {
        return getCodestrValue(srcValue, codestr, -1, -1, separ1, separ2, separ3);
    }

    /**
     * 코드정보 문자열에서 비교 값과 일치하는 그룹의 대상 값을 반환
     *
     * @param srcValue
     *            비교 값
     * @param codestr
     *            코드정보 문자열
     * @param srcIndex
     *            비교 값 인덱스
     * @param tarIndex
     *            대상 값 인덱스
     * @return
     */
    public static String getCodestrValue(String srcValue, String codestr, int srcIndex, int tarIndex) {
        return getCodestrValue(srcValue, codestr, srcIndex, tarIndex, null, null, null);
    }

    /**
     * 코드정보 문자열에서 비교 값과 일치하는 그룹의 대상 값을 반환
     *
     * @param srcValue
     *            비교 값
     * @param codestr
     *            코드정보 문자열
     * @return
     */
    public static String getCodestrValue(String srcValue, String codestr) {
        return getCodestrValue(srcValue, codestr, -1, -1, null, null, null);
    }

    /**
     * 문자열 배열로부터 구분자로 구분한 단일 문자열 생성
     *
     * @param arr
     *            문자열 배열
     * @param separ
     *            구분자
     * @return
     */
    public static String getCodestrFromArray(String[] arr, String separ) {
        String res = "";

        if (arr != null) {
            for (int i = 0; i < arr.length; i++) {
                if (i > 0)
                    res += separ;

                res += arr[i];
            }
        }

        return res;
    }

    /**
     * ParamMap 로부터 코드정보 문자열 생성
     *
     * @param sr
     *            ParamMap
     * @param fieldNames
     *            필드명 (※ 원하는 순서대로 쉼표[,]를 사용하여 입력 ex> VALUE,TEXT,TITLE)
     * @param defaultCodestr
     *            기본 코드정보 문자열
     * @param separ1
     *            값 구분자 [기본값:|]
     * @param separ2
     *            그룹 구분자 [기본값:^]
     * @return
     */
    public static String getCodestrFromParamMap(String siteLocale, List<Map> sr, String fieldNames, String defaultCodestr, String separ1, String separ2) {
        StringBuffer res = new StringBuffer();

        // 1) 구분자 기본값 셋팅!
        separ1 = ((separ1 == null || "".equals(separ1)) ? "|" : separ1);
        separ2 = ((separ2 == null || "".equals(separ2)) ? "^" : separ2);

        // 2) 기본 코드정보 문자열 셋팅!
        if (defaultCodestr != null && !"".equals(defaultCodestr)) {
            res.append(defaultCodestr);
        }

        // 3) ParamMap 로부터 코드정보 문자열 생성!
        if (sr != null && sr.size() > 0) {
            String[] fields = splitByWholeSeparatorPreserveAllTokens(fieldNames, ",");

            for (int i = 0; i < sr.size(); i++) {
                // -- 그룹 구분자 삽입
                if (i > 0 || (i == 0 && !"".equals(res.toString())))
                    res.append(separ2);

                for (int j = 0; j < fields.length; j++) {
                    // -- 값 구분자 삽입
                    if (j > 0)
                        res.append(separ1);

                    //2019.07.05
                    // code_id와 lang_code 두가지 경우 중 code_id로 들어온 fields 명은 getLang 메서드를 타지 않고
                    // res에 append 되도록 하는 로직
                    ParamMap rowMap = (ParamMap)sr.get(i);

                    String txt = rowMap.getString(fields[j]);

                    if(fields[j].indexOf("LANG_CD") > -1) {
                        txt = getLang(txt, siteLocale);
                    }
                    res.append(txt);

                }
            }
        }

        if (new SystemPropertiesVO().isNotProd()){
            logger.debug("##### CodeStr is:"+ res.toString());
        }
        return res.toString();
    }

    /**
     * ParamMap 로부터 코드정보 문자열 생성
     *
     * @param sr
     *            ParamMap
     * @param fieldNames
     *            필드명 (※ 원하는 순서대로 쉼표[,]를 사용하여 입력 ex> VALUE,TEXT,TITLE)
     * @param defaultCodestr
     *            기본 코드정보 문자열
     * @param separ1
     *            값 구분자 [기본값:|]
     * @param separ2
     *            그룹 구분자 [기본값:^]
     * @return
     */
    public static String getCodestrFromLists(List<Object> sr, String fieldNames, String defaultCodestr, String separ1, String separ2) {
        StringBuffer res = new StringBuffer();

        // 1) 구분자 기본값 셋팅!
        separ1 = ((separ1 == null || "".equals(separ1)) ? "|" : separ1);
        separ2 = ((separ2 == null || "".equals(separ2)) ? "^" : separ2);

        // 2) 기본 코드정보 문자열 셋팅!
        if (defaultCodestr != null && !"".equals(defaultCodestr)) {
            res.append(defaultCodestr);
        }

        // 3) ParamMap 로부터 코드정보 문자열 생성!
        if(sr != null && sr.size() > 0){
            String[] fields = splitByWholeSeparatorPreserveAllTokens(fieldNames, ",");

            for (int i = 0; i < sr.size(); i++) {
                ParamMap rowMap = (ParamMap)sr.get(i);
                // -- 그룹 구분자 삽입
                if (i > 0 || (i == 0 && !"".equals(res.toString())))
                    res.append(separ2);

                for (int j = 0; j < fields.length; j++) {
                    // -- 값 구분자 삽입
                    if (j > 0)
                        res.append(separ1);

                    // logger.debug("##### field:'"+ fields[j].trim()
                    // +"', string:'"+ sr.getString(i, fields[j].trim()) +"'");
                    res.append(rowMap.getString(fields[j].toUpperCase().trim()));
                }
            }
        }

        return res.toString();
    }

    /**
     * ParamMap 로부터 코드정보 문자열 생성
     *
     * @param sr
     *            ParamMap
     * @param fieldNames
     *            필드명 (※ 원하는 순서대로 쉼표[,]를 사용하여 입력 ex> VALUE,TEXT,TITLE)
     * @param defaultCodestr
     *            기본 코드정보 문자열
     * @return
     */
    public static String getCodestrFromParamMap(String siteLocale, List<Map> sr, String fieldNames, String defaultCodestr) {
        return getCodestrFromParamMap(siteLocale, sr, fieldNames, defaultCodestr, null, null);
    }

    public static String getCdStrFromRs(String siteLocale, List<Map> sr, String fieldNames, String defaultCodestr) {
        return getCodestrFromParamMap(siteLocale, sr, fieldNames, defaultCodestr, null, null);
    }
    public static String getCodestrFromLists(List<Object> sr, String fieldNames, String defaultCodestr) {
        return getCodestrFromLists(sr, fieldNames, defaultCodestr, null, null);
    }

    /**
     * request 파라메터를 get 방식의 쿼리스트링으로 변환
     *
     * @param request
     *            HttpServletRequest
     * @param paramNames
     *            대상 파라메터명 (※ 여러 개일 경우 쉼표[,]를 사용하여 입력 ex> param1,param2)
     * @return
     */
    public static String getRequestQueryString(HttpServletRequest request, String paramNames) {
        StringBuffer res = new StringBuffer();

        // -- 1) 지정된 파라메터명이 없으면 전체 파라메터명을 기본 값으로 셋팅!
        if (paramNames == null || "".equals(paramNames)) {
            Enumeration<String> paramNameEnum = request.getParameterNames();
            while (paramNameEnum.hasMoreElements()) {
                if (!"".equals(paramNames))
                    paramNames += ",";

                paramNames += paramNameEnum.nextElement();
            }
        }

        // -- 2) 쿼리스트링 생성!
        if (paramNames != null && !"".equals(paramNames)) {
            String[] paramNameArr = splitByWholeSeparatorPreserveAllTokens(paramNames, ",");
            if (paramNameArr != null && paramNameArr.length > 0) {
                for (int i = 0; i < paramNameArr.length; i++) {
                    String key = paramNameArr[i].trim();
                    String[] paramValueArray = request.getParameterValues(key);

                    if (paramValueArray != null && paramValueArray.length > 0) {
                        for (int j = 0; j < paramValueArray.length; j++) {
                            if (!"".equals(res.toString()))
                                res.append("&");

                            res.append(key + "=" + encodeUrl(paramValueArray[j], "UTF-8"));
                        }
                    }
                }
            }
        }

        return res.toString();
    }

    /**
     * request 파라메터를 get 방식의 쿼리스트링으로 변환
     *
     * @param request
     *            HttpServletRequest
     * @param paramNames
     *            ArrayList 대상 파라메터명
     * @return
     */
    public static String getRequestQueryString(HttpServletRequest request, List<String> paramNames) {
        StringBuffer res = new StringBuffer();

        // -- 1) 지정된 파라메터명이 없으면 전체 파라메터명을 기본 값으로 셋팅!

        if(paramNames == null || paramNames.size() == 0){
            paramNames = new ArrayList<String>();

            Enumeration<String> paramNameEnum = request.getParameterNames();
            while (paramNameEnum.hasMoreElements()) {
                paramNames.add(paramNameEnum.nextElement());
            }

        }

        // -- 2) 쿼리스트링 생성!
        if (paramNames.size() > 0) {
            for (int i = 0; i < paramNames.size(); i++) {

                String key = paramNames.get(i).trim();
                String[] paramValueArray = request.getParameterValues(key);

                if (paramValueArray != null && paramValueArray.length > 0) {
                    for (int j = 0; j < paramValueArray.length; j++) {
                        if (!"".equals(res.toString()))
                            res.append("&");

                        res.append(key + "=" + encodeUrl(paramValueArray[j], "UTF-8"));
                    }
                }
            }
        }

        return res.toString();
    }


    /**
     * request 파라메터를 get 방식의 쿼리스트링으로 변환
     * @param request
     * @param fieldNameSet 대상파라메터 명 Set
     * @since 카카오 프로젝트
     * @return
     */
    public static String getRequestQueryString(HttpServletRequest request, Set<String> fieldNameSet) {
        StringBuffer res = new StringBuffer();

        Set<String> paramSet = fieldNameSet;

        // -- 1) 지정된 파라메터명이 없으면 전체 파라메터명을 기본 값으로 셋팅!
        if (fieldNameSet == null ||
                fieldNameSet.size() == 0) {

            Enumeration<String> paramNameEnum = request.getParameterNames();
            paramSet = new HashSet<String>();

            while (paramNameEnum.hasMoreElements()) {

                paramSet.add(paramNameEnum.nextElement());

            }// end of while

        }

        // -- 2) 쿼리스트링 생성!
        if (paramSet != null &&
                paramSet.size() > 0) {

            Object[] paramNameArr = paramSet.toArray();

            if (paramNameArr != null && paramNameArr.length > 0) {
                for (int i = 0; i < paramNameArr.length; i++) {
                    String key = paramNameArr[i].toString().trim();
                    String[] paramValueArray = request.getParameterValues(key);

                    if (paramValueArray != null && paramValueArray.length > 0) {
                        for (int j = 0; j < paramValueArray.length; j++) {
                            if (!"".equals(res.toString()))
                                res.append("&");

                            res.append(key + "=" + encodeUrl(paramValueArray[j], "UTF-8"));
                        } // end of for j
                    }
                }// end of for i
            }
        }

        return res.toString();
    }



    /**
     * request 파라메터를 get 방식의 쿼리스트링으로 변환
     *
     * @param request
     * @return
     */
    public static String getRequestQueryString(HttpServletRequest request) {
        return getRequestQueryString(request, new HashSet<String>());
    }

    /**
     * 쿼리스트링을 Map으로 변환
     *
     * @param s
     * @return
     */
    public static Map<String, Object> parseUrlQueryString(String s) {
        if (s == null || "".equals(s))
            return new HashMap<String, Object>(0);

        // In map1 we use strings and ArrayLists to collect the parameter
        // values.
        Map<String, Object> map1 = new HashMap<String, Object>();
        int p = 0;
        while (p < s.length()) {
            int p0 = p;
            while (p < s.length() && s.charAt(p) != '=' && s.charAt(p) != '&')
                p++;
            String name = decodeUrl(s.substring(p0, p));

            if (p < s.length() && s.charAt(p) == '=')
                p++;
            p0 = p;
            while (p < s.length() && s.charAt(p) != '&')
                p++;
            String value = decodeUrl(s.substring(p0, p));

            if (p < s.length() && s.charAt(p) == '&')
                p++;
            Object x = map1.get(name);
            if (x == null) {
                // The first value of each name is added directly as a string to
                // the map.
                map1.put(name, value);
            } else if (x instanceof String) {
                // For multiple values, we use an ArrayList.
                ArrayList<String> a = new ArrayList<String>();
                a.add((String) x);
                a.add(value);
                map1.put(name, a);
            } else {
                @SuppressWarnings("unchecked")
                ArrayList<String> a = (ArrayList<String>) x;
                a.add(value);
            }
        }

        // Copy map1 to map2. Map2 uses string arrays to store the parameter
        // values.
        Map<String, Object> map2 = new HashMap<String, Object>(map1.size());
        for (Map.Entry<String, Object> e : map1.entrySet()) {
            String name = e.getKey();
            Object x = e.getValue();
            String[] v;
            if (x instanceof String) {
                map2.put(name, x.toString());
            } else {
                @SuppressWarnings("unchecked")
                ArrayList<String> a = (ArrayList<String>) x;
                v = new String[a.size()];
                v = a.toArray(v);

                map2.put(name, v);
            }
        }

        return map2;
    }

    /**
     * URL 을 시스템 주어진 캐릭터셋으로 디코딩
     *
     * @param s
     * @param charSet
     * @return
     */
    public static String decodeUrl(String s, String charSet) {
        try {
            return URLDecoder.decode(s, charSet);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Error in decodeUrl.", e);
        }
    }

    /**
     * URL 을 시스템 기본 캐릭터셋으로 디코딩
     *
     * @param s
     * @return
     */
    public static String decodeUrl(String s) {
        return decodeUrl(s, "UTF-8");
    }

    /**
     * URL 을 시스템 주어진 캐릭터셋으로 인코딩
     *
     * @param s
     * @param charSet
     * @return
     */
    public static String encodeUrl(String s, String charSet) {
        try {
            return URLEncoder.encode(s, charSet);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Error in encodeUrl.", e);
        }
    }


    /**
     * UUID 생성
     *
     * @return
     */
    public static String getRandomUUID() {

        return  String.valueOf(UUID.randomUUID()).replace("-", "").toUpperCase();
    }

    /**
     * date time 이 앞에 붙어 있는 UUID 생성
     * yyyyMMddHHmmssSSSS(18)+UUID(32) = DateTimeUUID(50)
     * @return DateTimeUUID(50)
     */
    public static String getDateTimeUUID() {
        DateTime dateTime = new DateTime();
        String today = dateTime.toString("yyyyMMddHHmmssSSSS").substring(0,18);
        return today + StringUtil.getRandomUUID();
    }

    /**
     * 금액 콤마 표시
     *
     * @param obj
     *            대상 값
     * @param maxPoint
     *            소수점 이하 자릿수 제한값 [-1:무제한, 0:허용안함]
     * @return
     */
    public static String getFormatCurrency(Object obj, Integer maxPoint) {
        String res = "";

        String noMark = ""; // 양수/음수 기호
        String str1 = "";
        String str2 = "";

        if (obj == null) {
            res = "";

        } else {
            res = obj.toString().trim();
        }

        // 양수/음수 기호 셋팅!
        if (!"".equals(res) && ("+".equals(res.substring(0, 1)) || "-".equals(res.substring(0, 1)))) {
            noMark = res.substring(0, 1);
        }

        res = res.replaceAll("[^0-9.]", ""); // 숫자, 소수점을 제외한 문자 제거

        int idxDot = res.indexOf('.');
        if (idxDot == -1) {
            str1 = res;
        } else {
            str1 = res.substring(0, idxDot);

            if (maxPoint == -1) {
                // 소수점 이하 자릿수 무제한
                str2 = "." + res.substring(idxDot).replaceAll("[^0-9]", "");
            } else if (maxPoint > 0) {
                // 소수점 이하 자릿수 제한
                String appendZero = "";
                for(int i=0; i<maxPoint; i++){
                    appendZero += "0";
                }

                res += appendZero;
                str2 = "." + res.substring(idxDot, idxDot + maxPoint + 1).replaceAll("[^0-9]", "");
            }

            //소수점 끝에자리가 0인 경우 제거(소수점 전체가 다 0이면 .까지 제거)
            str2 = str2.replaceAll("^\\.0+$|0+$", "");
        }

        String ReN = "(-?[0-9]+)([0-9]{3})";
        Pattern pattern = Pattern.compile(ReN);
        while (pattern.matcher(str1).find()) {
            str1 = str1.replaceAll(ReN, "$1,$2");
        }

        res = noMark + str1 + str2;

        return res;
    }

    /**
     * 금액 콤마 표시(값이 0일경우 출력 안하는 버전)
     *
     * @param obj
     *            대상 값
     * @param maxPoint
     *            소수점 이하 자릿수 제한값 [-1:무제한, 0:허용안함]
     * @return
     */
    public static String getFormatCurrencyZeroNoOutput(Object obj, Integer maxPoint) {
        String res = getFormatCurrency(obj,maxPoint);
        if(!"".equals(res)){
            if(Double.parseDouble(StringUtil.replace(res, ",", "")) == 0){
                res = "";
            }
        }

        return res;
    }

    /**
     * Locale에 해당하는 문자를 스크립트용으로 리턴함
     *
     * @param str
     *            언어:값 형태의 원문
     * @param siteLocale
     *            리턴을 원하는 언어
     * @return
     */
    public static String getScriptMessage(String str, String siteLocale) {
        return getLocalLang(str, siteLocale, "");
    }

    /**
     * Locale에 해당하는 문자를 스크립트용으로 리턴함
     *
     * @param str
     *            언어:값 형태의 원문
     * @param siteLocale
     *            리턴을 원하는 언어
     * @param label
     *            [LABEL]위치에 들어가 라벨값
     * @return
     */
    public static String getScriptMessage(String str, String siteLocale, String label) {

        return getLocalLang(str, siteLocale, label);
    }

    /**
     * Locale에 해당하는 문자를 리턴함
     *
     * @param str
     *            언어:값 형태의 원문
     * @param siteLocale
     *            리턴을 원하는 언어
     * @return
     */
    public static String getLocaleWord(String str, String siteLocale) {
        return StringUtil.convertForView(getLocalLang(str, siteLocale, ""));
    }

    /**
     * Locale에 해당하는 문자를 리턴함
     *
     * @param str
     *            언어:값 형태의 원문
     * @param siteLocale
     *            리턴을 원하는 언어
     * @param label
     *            [LABEL]위치에 들어가 라벨값
     * @return
     */
    public static String getLocaleWord(String str, String siteLocale, String label) {

        return StringUtil.convertForView(getLocalLang(str, siteLocale, label));
    }

    /**
     * -----------------------------------------------------------------------
     * @Description    request로 LocaleMessage 반환 : 영문화 일괄 처리용.
     * @author    (주)엠프론티어 신현삼
     * @since    2016. 6. 14.
     * @version    1.0
     *
     *------------------------------------------------------------------------
     * History
     *------------------------------------------------------------------------
     * 2016. 6. 14.      신현삼       최초생성
     */
    public static String getLocaleMessage(String str, String siteLocale) {
        return StringUtil.convertForView(getLocalLang(str, siteLocale, ""));
    }



    /**
     * Locale에 해당하는 메세지를 리턴함
     *
     * @param str
     *            언어:값 형태의 원문
     * @param siteLocale
     *            리턴을 원하는 언어
     * @param label
     *            [LABEL]위치에 들어가 라벨값
     * @return
     */
    public static String getLocaleMessage(String str, String siteLocale, String label) {
        return StringUtil.convertForView(getLocalLang(str, siteLocale, label));
    }

    public static String getLocalLang(String str, String siteLocale, String label) {

        String[] split_str = StringUtil.split(str, "|");
        String rtnValue = "";
        boolean find_yn = false;

        if ("".equals(siteLocale)) {
            siteLocale = "KO";
        }
        if(split_str != null && split_str.length > 0) {
            for (int i = 0; i < split_str.length; i++) {
                if (split_str[i].indexOf(siteLocale + "=") != -1) {
                    rtnValue = replace(split_str[i], siteLocale + "=", "");

                    find_yn = true;
                }
            }
        }


        if (!"HASH".equals(siteLocale) && find_yn == false) {
            if(split_str != null && split_str.length > 0) {
                for (int i = 0; i < split_str.length; i++) {
                    if (split_str[i].indexOf("KO=") != -1) {
                        rtnValue = split_str[i].replaceAll("KO=", "");

                    }
                }
            }
        }

        rtnValue = getLang(str, siteLocale);

        if (!"".equals(label)) {


            if(label.length() > 2 && ".".equals(label.substring(1, 2))) {
//            if(StringUtils.indexOf(label, ".") > -1){
                label = getLang(label, siteLocale);
            }


            rtnValue = rtnValue.replace("[LABEL]", label);


            if("KO".equals(siteLocale)){
                rtnValue = StringUtil.replace(rtnValue, "을(를)", getKorWordByJongSung(label, "을", "를", "을(를)"));
                rtnValue = StringUtil.replace(rtnValue, "이(가)", getKorWordByJongSung(label, "이", "가", "이(가)"));
                rtnValue = StringUtil.replace(rtnValue, "은(는)", getKorWordByJongSung(label, "은", "는", "은(는)"));
            }

        }

        return rtnValue;
    }

    /**
     * 리스트 라벨에서 사용
     * @param str
     * @param locale
     * @return
     */
    public static String getListAttr(String str, String locale) {
        String[] split_str = StringUtil.split(str, "|");
        String attr_str = locale;
        String rtnValue = "";
        boolean find_yn = false;

        if("KO".equals(locale)||"EN".equals(locale)||"JP".equals(locale)||"CN".equals(locale)){

            for (int i = 0; i < split_str.length; i++) {
                if (split_str[i].indexOf(locale + "=") != -1) {
                    rtnValue = replace(split_str[i], locale + "=", "");

                    find_yn = true;
                }
            }

//            rtnValue = getLang(rtnValue, locale);
        }else{

            for (int i = 0; i < split_str.length; i++) {
                if (split_str[i].indexOf(locale + "=") != -1) {
                    rtnValue = replace(split_str[i], locale + "=", "");

                    find_yn = true;
                }
            }

            /*
            if (!"HASH".equals(locale) && find_yn == false) {
                for (int i = 0; i < split_str.length; i++) {
                    if (split_str[i].indexOf("KO=") != -1) {
                        rtnValue = split_str[i].replaceAll("KO=", "");

                    }
                }
            }
            */
        }

        if (new SystemPropertiesVO().isNotProd()){
//            logger.debug("rtnVal:"+rtnValue+"locale:"+locale);
        }


        return rtnValue;
    }

    /**
     * getWordHeadInitialToUpper
     * @param word
     * @return
     */
    public static String getWordHeadInitialToUpper(String word) {
        String rtnValue = "";

        if (!"".equals(word)) {
            rtnValue = word.substring(0, 1).toUpperCase() + word.substring(1, word.length()).toLowerCase();
        }
        return rtnValue;

    }

    /**
     * getRepeatStringWithSeparator
     * @param str
     * @param separator
     * @param count
     * @return
     */
    public static String getRepeatStringWithSeparator(String str, String separator, int count) {
        String rtnValue = "";

        if (count > 0) {
            for (int i = 0; i < count; i++) {
                if (i == (count - 1)) {
                    rtnValue += str;
                } else {
                    rtnValue += str + separator;
                }

            }
        }

        return rtnValue;
    }


    /**
     * NFC 정규화 문자열 반환 ex) "ㅇㅏㄴㄴㅕㅇ" => "안녕"
     * @param obj
     * @return
     */
    public static String getNormalizeToNFC(Object obj) {
        String res = "";

        if (obj != null) {
            res = Normalizer.normalize(obj.toString(), Normalizer.Form.NFC);
        }

        return res;
    }

    public static String getLPAD(String str, int len, String append){
        String rtn = str;
        if (str.length() < len){
            for (int i = (len - str.length()); i > 0; i--){
                rtn = append + rtn;
            }
        }else{
            rtn = str.substring(0, len);
        }
        return rtn;
    }

    public static boolean isRegistNo(String resistsNo){
        boolean rtnBool = false;
        if(resistsNo.trim().length() == 13){
            rtnBool = true;
        }
        if(rtnBool && !isNumeric(resistsNo)){
            rtnBool = false;
        }

        return rtnBool;
    }


    /**
     * IN 절 SQL 문의 파라메터를 String형식으로 치환해준다.
     * @param arrParam
     * @return
     */
    public static String getArrSqlparamString(String[] arrParam){
        StringBuffer query = new StringBuffer();

        if(arrParam != null){
            for(int i=0; i< arrParam.length; i++){
                if(i > 0){
                    query.append(",");
                }
                query.append("'"+ arrParam[i]+"'");
            }
        }
        return query.toString();
    }

    /**
     * @Desc        콘솔 로그 출력용 : suffix에 탭문자열을 붙인다.
     * @param val
     * @return
     * @author    신현삼
     * @since    2015. 10. 23.
     * @history
     * 2015. 10. 23.    신현삼        RequestFilter에서 이동
     */
    public static String addTabSuffix(String val) {
        StringBuilder sb = new StringBuilder();
        sb.append(val);
        /*int tcnt = cnt - val.replaceAll("-", "").length() / 4;
        for (int inx=0; inx<tcnt;inx++) val += "\t";*/
        while(sb.toString().length() < 25) {
            sb.append(" ");
        }
        return sb.toString();
    }

    /**
     * @Desc        콘솔 로그 출력용 : name            = value 형태로 문자열을 만들어준다.
     * @param name
     * @param value
     * @return
     * @author    신현삼
     * @since    2015. 10. 21.
     * @history
     * 2015. 10. 21.    신현삼        RequestFilter에서 이동
     */
    public static String buildLogLine(String name, String value) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n");
        //if (log.isDebugEnabled()) log.debug(tabCnt);
        sb.append(addTabSuffix(name)).append(" = ").append(value);
        //sb.append("\n------------------------------------------------------------------------------------------------------------------------------");
        return sb.toString();
    }

    /**
     * @Desc        거부할 특수문자 목록 리턴 : RequestFilter에서 사용
     * @return
     * @author    신현삼
     * @since    2015. 10. ??.
     * @history
     * 2015. 10. ??.    신현삼        최초생성
     */
    public static ArrayList<String> getRejcLtrLst() {
        ArrayList<String> rtnLst = new ArrayList<String>();
        if (REJC_LTR_LST != null) {
            rtnLst.addAll(REJC_LTR_LST);
        }
        return rtnLst;
    }


    /**
     * @Desc        HTML특수문자를 제거 : RequestFilter에서 사용
     * @param val
     * @return
     * @author    신현삼
     * @since    2015. 10. ??.
     * @history
     * 2015. 10. ??.    신현삼        최초생성
     */
    public static String removeAlwnSpLtr(String val) {
        String rtn = val;
        if (StringUtil.isNotEmpty(val)) {
            for (java.util.Map.Entry<String, String> entry : ALWN_SP_LTR_MAP.entrySet()) {
                String ltr = entry.getKey();
                rtn = rtn.replaceAll(ltr, "");
            }
        }
        return rtn;
    }


    /**
     * Oracle CLOB to String
     *
     * @param clob
     * @return
     */
    public static String getClobToString(Clob clob) {
        Reader reader = null;
        StringBuffer out = new StringBuffer();

        try {
            // oracle.sql.CLOB clob = (oracle.sql.CLOB) rs.getObject(column);
            // oracle.sql.CLOB clob = (oracle.sql.CLOB) resMap.get(arg0)
            // .getObject(column);
            // weblogic.jdbc.common.OracleClobImpl clob =
            // (weblogic.jdbc.common.OracleClobImpl) rs.getObject(columnIndex) ;

            reader = clob.getCharacterStream();

            char[] buff = new char[1024];

            int nchars = 0;
            while ((nchars = reader.read(buff)) > 0)
                out.append(""+(char) nchars);

        } catch (Exception e) {
            System.out.println("Connection Exception occurred");
        }

        return out.toString();
    }

    public static String getNClobToString(NClob nclob) {
        Reader reader = null;
        StringBuffer out = new StringBuffer();

        try {
            // oracle.sql.CLOB clob = (oracle.sql.CLOB) rs.getObject(column);
            // oracle.sql.CLOB clob = (oracle.sql.CLOB) resMap.get(arg0)
            // .getObject(column);
            // weblogic.jdbc.common.OracleClobImpl clob =
            // (weblogic.jdbc.common.OracleClobImpl) rs.getObject(columnIndex) ;

            reader = nclob.getCharacterStream();

            char[] buff = new char[1024];

            int nchars = 0;
            while ((nchars = reader.read(buff)) > 0)
                out.append(buff, 0, nchars);

        } catch (Exception e) {
            System.out.println("Connection Exception occurred");
        }

        return out.toString();
    }


    /**
     * String을 camel표기법으로 변환
     * @param underScore
     * @return
     */
    public static String convert2CamelCase(String underScore) {



        // '_' 가 나타나지 않으면 이미 camel case 로 가정함.

        // 단 첫째문자가 대문자이면 camel case 변환 (전체를 소문자로) 처리가

        // 필요하다고 가정함. --> 아래 로직을 수행하면 바뀜

        if (underScore.indexOf('_') < 0

            && Character.isLowerCase(underScore.charAt(0))) {

            return underScore;

        }

        StringBuilder result = new StringBuilder();

        boolean nextUpper = false;

        int len = underScore.length();



        for (int i = 0; i < len; i++) {

            char currentChar = underScore.charAt(i);

            if (currentChar == '_') {

                nextUpper = true;

            } else {

                if (nextUpper) {

                    result.append(Character.toUpperCase(currentChar));

                    nextUpper = false;

                } else {

                    result.append(Character.toLowerCase(currentChar));

                }

            }

        }

        return result.toString();

    }


    /**
     * 한글의 종성에 따라서 은/는, 이/가, 을/를 선택 하여 반환한다.
     * @param word
     * @param fistVal
     * @param secondVal
     * @return
     */
    public static String getKorWordByJongSung(String word, String fistVal, String secondVal, String defaultStr){
        char lastWord = word.charAt(word.length() -1);

        //-- 한글 제일 처음과 끝의 법위밖일 경우는 오류
        if(lastWord < 0xAC00 || lastWord > 0xD7A3){
            return defaultStr;
        }

        String selectVal = (lastWord - 0xAC00) %28 > 0 ? fistVal: secondVal;

        return selectVal;

    }

    /**
     * enCode
     * @param sParam
     * @return
     */
    public static String enCode(String sParam)
    {
        StringBuffer sb  = new StringBuffer();

        if(sParam == null) {
            sb.append("");
        } else {
            if(sParam.length()>0) {
                for(int iIndex=0; iIndex<sParam.length(); iIndex++) {
                    String sLength = ""+((int)sParam.charAt(iIndex));
                    sb.append(sLength.length());
                    sb.append(((int)sParam.charAt(iIndex)));
                }
            }
        }

        return sb.toString();
    }


    /**
     * deCode
     * @param sParam
     * @return
     */
    public static String deCode(String sParam)
    {
        sParam = convertNull(sParam);
        StringBuffer sb  = new StringBuffer();
        int iPos = 0;
        boolean bFlg = true;

        if(StringUtil.isNotBlank(sParam)) {
            if(sParam.length()>1)
            {
                while(bFlg) {
                    String sLength = sParam.substring(iPos, ++iPos);
                    int iLength = 0;

                    try {
                        iLength = Integer.parseInt(sLength);
                    } catch(Exception e) {
                        iLength   = 0;
                    }

                    String sCode = "";

                    if((iPos+iLength)>sParam.length()) {
                        sCode = sParam.substring(iPos);
                    } else {
                        sCode = sParam.substring(iPos,(iPos+iLength));
                    }

                    iPos += iLength;

                    sb.append(((char) Integer.parseInt(sCode)));

                    if(iPos >= sParam.length()) {
                        bFlg = false;
                    }
                }
            }
        } else {
            sParam = "";
        }

        return sb.toString();
    }


}
