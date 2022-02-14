/*
 * @(#)CKEditorImageSvc.java     2021-08-17(017) 오전 8:06
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
package com.vertexid.paragon.file;

import com.vertexid.commons.utils.FileUtil;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.spring.utils.BaseProperties;
import com.vertexid.viself.base.BaseSvc;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.joda.time.DateTime;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

/**
 * <b>Description</b>
 * <pre>
 *     CKEditor 용 이미지 서비스
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Service
@Transactional
public class CKEditorImageSvc extends BaseSvc {
    public static final String IMAGE_FOLDER = "EDITOR-IMG";
    public static final String IMAGE_URL = "/editor/viewImg";

    @Resource
    FileSvc fileSvc;

    public Map<String, Object> upload(HttpServletRequest req) {
        Map<String, Object> rtnMap = new HashMap<>();

        String uid = StringUtil.getRandomUUID();
        DateTime dateTime = new DateTime();
        String nowMonth = dateTime.toString("yyyyMM");

        boolean isMultipart = ServletFileUpload.isMultipartContent(req);
        if (!isMultipart) {
            log.error("이미지 파일 업로드가 아닙니다.");
            throw new RuntimeException("이미지 파일 업로드가 아닙니다.");
        }

        OutputStream outputStream = null;
        PrintWriter printWriter = null;

        try {
            String savePath =
                    BaseProperties.get("attach.saveRootPath") + File.separator +
                            IMAGE_FOLDER + File.separator + nowMonth;
            String tempPath = BaseProperties.get("attach.saveTempPath");

            log.info("savePath...." + savePath);
            log.info("tempPath...." + tempPath);

            FileUtil.makeDir(savePath);
            FileUtil.makeDir(tempPath);

            FileItemFactory factory = new DiskFileItemFactory();
            File folder = new File(tempPath);
            ((DiskFileItemFactory) factory).setRepository(folder);

            List<?> items = null;
            int itemCount = 0;
            List<Object> fileinfosFilter = new ArrayList<>();

            ServletFileUpload upload = new ServletFileUpload(factory);
            items = upload.parseRequest(req);
            Iterator<?> itr = items.iterator();
            String fileName;
            String ckUploadImgFile;
            String imgUrl;
            byte[] bytes = null;
            while (itr.hasNext()) {

                boolean bool = false;

                FileItem item = (FileItem) itr.next();
                fileName = item.getName();
                bytes = item.get();

                // 확장자 검사
                fileSvc.validateIsAllowFileExt(fileName);

                ckUploadImgFile =
                        savePath + File.separator + uid + "_" + fileName;
                log.info("ckUploadImgFile...." + ckUploadImgFile);
                item.write(new File(ckUploadImgFile));

                imgUrl = IMAGE_URL + "?uid=" + uid + "&fileName=" + fileName +
                        "&nowMonth=" + nowMonth;

                rtnMap.put("fileName", fileName);
                rtnMap.put("url", imgUrl);

                itemCount++;
                break;
            }// end of while

            log.info("itmCnt.................."+ itemCount);

        } catch (Exception e) {
            log.error(e.getMessage());
            throw new RuntimeException(e);
        } finally {
            try {
                if (outputStream != null) {
                    outputStream.close();
                }
                if (printWriter != null) {
                    printWriter.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
                throw new RuntimeException(e);
            }
        }

        return rtnMap;
    }

    public void viewImage(String nowMonth, String uid, String fileName,
            HttpServletResponse res) {
        String savePath =
                BaseProperties.get("attach.saveRootPath") + File.separator +
                        IMAGE_FOLDER + File.separator + nowMonth;
        String ckUploadImgFile =
                savePath + File.separator + uid + "_" + fileName;

        File imgFile = new File(ckUploadImgFile);

        if (!imgFile.isFile()) {

            // TODO 없는 경우 빈 이미지 파일 대체

            String msg = "파일이 존재하지 않습니다.";
            log.error(msg);
            throw new RuntimeException(msg);
        }

        byte[] buf = new byte[1024];
        int readByte;
        int length;
        byte[] imgBuf = null;

        FileInputStream fileInputStream = null;
        ByteArrayOutputStream byteArrayOutputStream = null;
        ServletOutputStream servletOutputStream = null;

        try {
            fileInputStream = new FileInputStream(imgFile);
            byteArrayOutputStream = new ByteArrayOutputStream();
            servletOutputStream = res.getOutputStream();

            while ((readByte = fileInputStream.read(buf)) != -1) {
                byteArrayOutputStream.write(buf, 0, readByte);
            }// end of while

            imgBuf = byteArrayOutputStream.toByteArray();
            length = imgBuf.length;
            servletOutputStream.write(imgBuf, 0, length);
            servletOutputStream.flush();

        } catch (Exception e) {
            log.error(e.getMessage());
            throw new RuntimeException(e);
        } finally {
            try {
                byteArrayOutputStream.close();
                fileInputStream.close();
                servletOutputStream.close();
            } catch (Exception e) {
                log.error(e.getMessage());
                throw new RuntimeException(e);
            }
        }
    }
}
