/*
 * @(#)BaseProperties.java     2020-12-29(029) 오전 8:35
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
package com.vertexid.spring.utils;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

/**
 * <b>Description</b>
 * <pre>
 *     기본 프로퍼티 유틸
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class BaseProperties {

    private static Logger log = LoggerFactory.getLogger(BaseProperties.class);

    private static Properties properties;
    private static ResourceLoader resourceLoader = new DefaultResourceLoader();
    public static final String PROPERTIES_CLASS_PATH = "classpath:properties.xml";

    public static String get(final String key){

        initProperties();

        return properties.getProperty(key);
    }

    public static String get(final String key, final String defaultVal){

        initProperties();

        return properties.getProperty(key, defaultVal);
    }

    public static List<String> getList(final String key){

        String data = StringUtils.replace(get(key), " ", "");
        return Arrays.asList(StringUtils.split(data, "\n"));
    }

    public static void reload(){
        if(null == properties){
            properties = new Properties();
        }else{
            properties.clear();
        }

        loadProperties();
    }

    private static void loadProperties() {
        Resource resource = resourceLoader.getResource(PROPERTIES_CLASS_PATH);
        try {
            properties.loadFromXML(resource.getInputStream());
        } catch (IOException e) {
            log.error(e.getMessage());
            throw new RuntimeException(e.getMessage());
        }
    }

    private static void initProperties() {
        if(null == properties){
            properties = new Properties();
            loadProperties();
        }
    }
}
