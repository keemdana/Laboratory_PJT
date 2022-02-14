package de.vogella.sap.jco.connection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;


public class CommonProperties {

    private static final Logger log = LoggerFactory.getLogger(CommonProperties.class);

    /**
     * the instance
     */
    private static CommonProperties instance = new CommonProperties();

    /**
     * 설정파일 이름
     */
    private static final String PROPERTIES_PATH = "/de/vogella/sap/jco/conf/sap.properties";

    /**
     * properties를 저장할 Properties 클래스
     */
    private static Properties prop;

    private CommonProperties() {
        log.info(
                "................................ CommonProperties constructed!");
    }

    /**
     * 초기화. .properties 파일을 읽어들인다.
     */
    private static void init() {

        InputStream is = null;

        try {
            if (instance == null) {
                instance = new CommonProperties();
            }

            if (prop == null) {

                // 기본 Properties 로드
                prop = new Properties();
                is = CommonProperties.class
                        .getResourceAsStream(PROPERTIES_PATH);
                prop.load(is);

            }
        } catch (Exception e) {
            instance = null;
            prop = null;
            e.printStackTrace();
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    log.error(e.getMessage());
                }
            }
        }
    }

    /**
     * @return the instance
     */
    public static CommonProperties getInstance() {
        init();
        return instance;
    }

    /**
     * 요청한 property를 리턴한다.
     *
     * @param property property name
     * @return String property value
     */
    public static String load(String property) {
        String res = null;

        if (prop == null) {
            init();
        }

        res = prop.getProperty(property);

        if (res != null) {
            res = res.trim();
        }

        return res;
    }

}
