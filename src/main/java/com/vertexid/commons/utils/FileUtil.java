package com.vertexid.commons.utils;

import com.vertexid.spring.utils.CmmProperties;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class FileUtil {

    protected static Logger logger = LoggerFactory.getLogger(FileUtil.class);

    /**
     * 기본 파일 인코딩
     */
    private static final String defaultFileEncoding = "UTF-8";


//    public static void main(String args[]) {
//        String filename = "[가]{나}(다)<라>\\/:*?\"<>|*abc\\/:*?\"<>|*123";
//
//        logger.debug("escapeFilename is '"+ escapeFilename(filename) + "'");
//    }


    /**
     * image url and base 64 encodes the image.
     * @param url ex) http://www.example.com/sample.jpg
     * @param fileExt ex) jpg
     * @param charsetName ex) UTF-8
     * @return
     */
    public static String getBase64ImageStringFromUrl(String url, String fileExt, String charsetName) {
        String res;

        try {
            InputStream input = getInputStreamByURL(url);
            BufferedImage im = ImageIO.read(input);
            ByteArrayOutputStream output = new ByteArrayOutputStream();
            ImageIO.write(im, fileExt, output);
            output.flush();
            byte[] bim = Base64.encodeBase64(output.toByteArray());
            res = new String(bim, charsetName);
            res = "data:image/"+ fileExt +";base64,"+ res;
            output.close();
        } catch (Exception e) {
            System.out.println("Connection Exception occurred");
            res = "";
        }

        return res;
    }


    /**
     * 디렉토리 생성
     * @param dir
     */
    public static void makeDir(String dir)
    {
        File fi = new File(dir);
        if (!fi.exists()) {
            fi.mkdirs();
        }
    }

    /**
     * 파일복사
     * @param inFile 은 원본파일명-풀패스,
              outFile은 복사되서 생성될 파일명풀패스
     * @return 성공하면 true, 아니면  false
     */
    public static boolean copy(String inFile, String outFile) {
        boolean ret = false;
        FileInputStream fin = null;
        FileOutputStream fout = null;

        try{
            fin = new FileInputStream(inFile);
            fout = new FileOutputStream(outFile);
            byte[] buffer = new byte[1024];
            while(true){
                int bytesRead = fin.read(buffer);
                if(bytesRead== -1){
                    break;
                }
                fout.write(buffer, 0, bytesRead);
            }
            ret = true;
        }catch(Exception e){
            logger.error(e.getMessage());
        }finally{
            try{
                if(fin != null){
                    fin.close();
                    fin = null;
                }
            }catch(Exception e){
                logger.error(e.getMessage());
            }
            try{
                if(fout != null){
                    fout.close();
                    fout = null;
                }
            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }

        return ret;
    }


    /**
     * 텍스트 파일 복사
     * @param inFile
     * @param inFileEncoding
     * @param outFile
     * @param outFileEncoding
     * @return
     */
    public static boolean copyTextFile(String inFile, String inFileEncoding, String outFile, String outFileEncoding)
    {
        boolean ret = false;

        BufferedReader bin = null;
        BufferedWriter bout = null;

        try{
            bin = new BufferedReader(new InputStreamReader(new FileInputStream(inFile), inFileEncoding));
            bout = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), outFileEncoding));

            String line = null;
            while ((line = bin.readLine()) != null){
                bout.write(line, 0, line.length());
                bout.newLine();
            }

            ret = true;
        }catch(Exception e){
            System.out.println("Connection Exception occurred");
        }finally{
            try{
                if(bin != null){ bin.close(); bin = null; }
            }catch(Exception e){
                System.out.println("Connection Exception occurred");
            }

            try{
                if(bout != null){ bout.close(); bout = null; }
            }catch(Exception e){
                System.out.println("Connection Exception occurred");
            }
        }

        return ret;
    }


    /**
     * 텍스트 파일 복사
     * @param inFile
     * @param outFile
     * @return
     */
    public static boolean copyTextFile(String inFile, String outFile) {
        return copyTextFile(inFile, defaultFileEncoding, outFile, defaultFileEncoding);
    }


    /**
     * 파일이동, 파일 이름을 바꿔주는 용도로도 사용가능
     * @param inFile 은 원본파일명-풀패스
     * @return 성공하면 true, 아니면  false
     */
    public static boolean move(String inFile, String outFile) {
        try{
            File file = new File(inFile);
            return file.renameTo(new File(outFile));
        }catch(Exception e){
            System.out.println("Connection Exception occurred");
            return false;
        }
    }


    /**
     * 파일삭제
     * @param filePath 은 원본파일명-풀패스
     * @return 성공하면 true, 아니면  false
     */
    public static boolean delete(String filePath) {
        try{
            File file = new File(filePath);
            return file.delete();
        }catch(Exception e){
            System.out.println("Connection Exception occurred");
            return false;
        }
    }


   /**
    * 파일내용을 String으로 반환(Text File에 적용)
    * @param filePath 읽을 파일의 절대경로+ 파일명
    * @param fileEncoding 읽을 파일의 fileEncoding
    * @return 파일내용
    */
    public static String getContent(String filePath, String fileEncoding){
        final int cap = 512;    //한번에 읽어들일 바이트 크기

        StringBuffer res = new StringBuffer(cap);

        File f = null;
        FileInputStream fis = null;
        byte buff[] = new byte[cap];

        int len;

        try {
            f         = new File(filePath);
            fis     = new FileInputStream(f);

            if ("".equals(fileEncoding)) {
                while ((len = fis.read(buff, 0, cap)) != -1) {
                    res.append(new String(buff, 0, len));
                }
            } else {
                while ((len = fis.read(buff, 0, cap)) != -1) {
                    res.append(new String(buff, 0, len, fileEncoding));
                }
            }

            fis.close();

        } catch (IOException ioe) {
            res.setLength(0);

            if(fis != null){
                try{
                    fis.close();
                    fis = null;
                }catch(Exception e){
                    System.out.println("Connection Exception occurred");
                }
            }

            System.out.println("Connection Exception occurred");
        }

        return res.toString();
    }

    /**
    * 파일내용을 String으로 반환(Text File에 적용)
    * @param filePath 읽을 파일의 절대경로+ 파일명
    * @return 파일내용
    */
    public static String getContent(String filePath){

        return getContent(filePath, defaultFileEncoding);
    }


    /**
     * parameter로 전달받은 문자열을 파일로 저장
     * @param fileName - 파일의 절대경로 + 파일명 모두, String content-저장할 문자열
     */
     public static boolean writeFile(String fileName, String content) {
        return writeFile(fileName, content, defaultFileEncoding);
     }


     /**
     * 텍스트 파일 복사
     * @param fileName
     * @param content
     * @param fileEncoding
     * @return
     */
    public static boolean writeFile(String fileName, String content, String fileEncoding)
    {
        boolean ret = false;

        BufferedReader bin = null;
        BufferedWriter bout = null;

        try{
            File outFile = new File(fileName);

            bin = new BufferedReader(new StringReader(content));
            bout = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), fileEncoding));

            String line = null;
            while ((line = bin.readLine()) != null){
                bout.write(line, 0, line.length());
                bout.newLine();
            }

            ret = true;
        }catch(Exception e){
            System.out.println("Connection Exception occurred");
        }finally{
            try{
                if(bin != null){ bin.close(); bin = null; }
            }catch(Exception e){
                System.out.println("Connection Exception occurred");
            }

            try{
                if(bout != null){ bout.close(); bout = null; }
            }catch(Exception e){
                System.out.println("Connection Exception occurred");
            }
        }

        return ret;
    }


    /**
     * parameter로 전달받은 문자열을 파일로 저장하는 메쏘드
     * @param fileName - 파일의 절대경로 + 파일명 모두, String content-저장할 문자열
     */
     public static boolean writeFileByBuffRead(String fileName, String content) {

        boolean ret = false;
        FileOutputStream saver = null;

        try{
            byte[] buffer = content.getBytes();
            saver = new FileOutputStream(fileName);
            saver.write(buffer);
            saver.close();
            ret = true;
        }catch(Exception ioe){
            System.out.println("Connection Exception occurred");
        }finally{
            if(saver!= null){
                try{
                    saver.close();
                    saver = null;
                }catch(Exception e){
                    System.out.println("Connection Exception occurred");
                }
            }
        }
        return ret;
     }

     /**
      * 주어진 URL에 해당하는 문서를 읽어 InputStream 형태로 반환
      * @param url
      * @return InputStream (※ 에러 발생시 null 값 리턴)
      */
     public static InputStream getInputStreamByURL(String url)
     {
        InputStream res = null;

        try {
            activateTrustManager(url);

            URL urlobj = new URL(url);
            //URLConnection conn = urlobj.openConnection();
            //res = conn.getInputStream();
            res = urlobj.openStream();
        } catch (Exception e) {
            e.printStackTrace();
            res = null;
        }

        return res;
     }

     /**
      *
      * @param url
      * @throws KeyManagementException
      * @throws NoSuchAlgorithmException
      */
     private static void activateTrustManager(String url) throws KeyManagementException, NoSuchAlgorithmException {
         boolean isHttps = (!"https".equals(url.substring(0, 5).toLowerCase()) ? false : true);

         if (isHttps) {
             // Create a new trust manager that trust all certificates
             TrustManager[] trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                        return new java.security.cert.X509Certificate[]{};
                    }
                    public void checkClientTrusted(
                        java.security.cert.X509Certificate[] certs, String authType) {
                    }
                    public void checkServerTrusted(
                        java.security.cert.X509Certificate[] certs, String authType) {
                    }
                }
             };

             // Activate the new trust manager
             SSLContext sc = SSLContext.getInstance("SSL");
             sc.init(null, trustAllCerts, new java.security.SecureRandom());
             HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
         }
     }

     /**
      * POST 요청 결과를 읽어 InputStream 형태로 반환
      * @param url ex) http://www.example.com
      * @param postDataQueryString ex) a=1&b=2&c=3
      * @return
      */
     public static InputStream getInputStreamByPostRequest(String url, String postDataQueryString) {
         InputStream res = null;

         try {
             activateTrustManager(url);

             URL urlobj = new URL(url);
             HttpURLConnection conn = (HttpURLConnection)urlobj.openConnection();
             conn.setDoOutput(true);
             conn.setRequestMethod("POST");
             conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
             conn.setRequestProperty("Content-Length", String.valueOf(postDataQueryString.length()));
             OutputStream os = conn.getOutputStream();
             os.write(postDataQueryString.getBytes());
             os.close();

             res = conn.getInputStream();
         } catch (Exception e) {
             System.out.println("Connection Exception occurred");
             res = null;
         }

         return res;
     }

     /**
      * InputStream 을 문자열로 변환하여 반환
      * @param is
      * @return 문자열 (※ 에러 발생시 null 값 리턴)
      */
     public static String getInputStreamString(InputStream is) {
         String res = null;

         try {
             if (is != null) {
                 InputStreamReader isr = new InputStreamReader(is);
                 BufferedReader br = new BufferedReader(isr);
                 String line = "";
                 StringBuffer sb = new StringBuffer(512);
                 while ((line = br.readLine()) != null) {
                     sb.append(line +"\n");
                 }
                 res = sb.toString();
             }
         } catch (Exception e) {
             System.out.println("Connection Exception occurred");
             res = null;
         }

         return res;
     }

     /**
      * 리소스 파일 객체를 반환한다.
      * @param resourceFileName 파일이름
      * @return 파일
      */
     private static File getResourceFile(String resourceFileName) {
        ClassLoader loader = Thread.currentThread().getContextClassLoader();

        return new File(loader.getResource(resourceFileName).getFile());
     }

     /**
      * 파일 확장자 반환
      * @param filename
      * @return
      */
     public static String getFileExt(String filename) {
         String res = "";

         if (filename != null && !"".equals(filename)) {
             filename = filename.trim();

             int idx = filename.lastIndexOf(".");
             if (idx != -1) {
                 res = filename.substring(idx+1);
             }
         }

         return res;
     }
     /**
      * 확장자포함한 파일명
      * @param filename
      * @return
      */
     public static String getFileName(String filename) {
         String res = "";

         if (filename != null && !"".equals(filename)) {
             filename = filename.trim();

             int idx = filename.lastIndexOf(File.separator);
             if (idx != -1) {
                 res = filename.substring(idx+1, (filename.lastIndexOf(".")));
             }
         }

         return res;
     }

     public static String getBase64String(InputStream in) {
         String res = "";

         return res;
     }

     /**
      * 특수문자 이스케이프 파일명 반환
      * @param filename
      * @return
      */
     public static String escapeFilename(String filename) {
         String res = "";

         if (filename != null && !"".equals(filename)) {
             res = filename.replaceAll("[\\\\/:*?\"<>|]", "");
         }

         return res;
     }

     /**
      * 첨부파일 다운로드 파일명 반환
      * @param request
      * @param filename
      * @param charsetName
      * @return
      */
     public static String getAttachmentFilename(HttpServletRequest request, String filename, String charsetName) {
         String res = "";

         if (filename != null && !"".equals(filename)) {
             String user_agent = request.getHeader("USER-AGENT").toLowerCase();

             if (user_agent.contains("trident")) {
                 // IE일 경우 파일명 인코딩 처리
                 res = StringUtil.encodeURIComponent(filename);
             } else {
                 try {
                     res = java.net.URLEncoder.encode(filename,"UTF-8"); // <-- Chrome
                     //res = new String(filename.getBytes(charsetName), "8859_1");  <-- safari
                 } catch (UnsupportedEncodingException e) {
                     System.out.println("Connection Exception occurred");
                     res = filename;
                 }
             }
         }

         return res;
     }

     /**
      *파일 내용 단어 찾기(하위 폴더 포함)
      * @param dir
      * @param ext
      * @param searchWord
      * @return
      */
     public static boolean isContainsWord(String dir, String ext, String searchWord) {

        String content = "";

        File path = new File(dir);
        File[] listOfFiles = path.listFiles();
         if (listOfFiles != null) {
             for (File file : listOfFiles) {

                 try {
                     if(file.isDirectory()) {
                         if(isContainsWord(file.getAbsolutePath(), ext, searchWord)) {
                             return true;
                         }
                     } else if(file.getName().endsWith("."+ ext)) {
                         content = FileUtils.readFileToString(file, "UTF-8");
                         //if(file.getName().endsWith("mng_pati_list.jsp")) {
                         //    logger.debug(content);
                         //}
                         if (content.contains(searchWord)) {
                             //logger.debug("Found in: " + file.getAbsolutePath());
                             return true;
                         } else {
                             //logger.debug("Not found in: " + file.getAbsolutePath());
                         }
                     }
                 } catch (IOException e) {
                 }
             }
         }

         return false;
    }



     @SuppressWarnings({"unchecked", "rawtypes"})
     public static ParamMap zipDownload(List<Object> list)throws IOException{

         ParamMap rtnMap =  new ParamMap();

        //-------------------------------------- INIT
        //현재시간 가져오기
        SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
        Date currentTime = new Date ( );
        String dTime = formatter.format ( currentTime );

        //기본저장경로
        String defaultSavePath = CmmProperties.getSaveRootPath();

        //저장소 폴더 생성
        String copyDir = defaultSavePath + "/temp_copy";
        FileUtil.makeDir(copyDir);

        //압축파일이 저장될 경로폴더
        String copyAchiveDir = defaultSavePath + "/achive_download";
        FileUtil.makeDir(copyAchiveDir);

        //압축파일명은 해당일자시분초.zip으로 생성한다
        String zipFileName = copyAchiveDir + "/" + dTime + ".zip";


        //-------------------------------------- FILE LIST 설정
        if(list  !=  null && list.size() > 0){
            for (int i = 0; i < list.size(); i++) {
                ParamMap rowMap = (ParamMap)list.get(i);

                String tCode     = rowMap.getString("TYPE_CODE");     //파일 분류폴더
                String sName = rowMap.getString("FILE_SAVENAME");    //실제 저장된 파일명
                String fName     = rowMap.getString("FILE_NAME");       //보여지는 파일명
                String ext = fName.substring(fName.lastIndexOf("."),fName.length());//확장자

                //출원번호+시퀀스.확장자로 카피
                String realFilePath  = defaultSavePath + "/" + tCode + "/" + sName;
                String copyFilePath  = copyDir + "/" + fName + "_" + (i+1) + ext;
                FileUtil.copy(realFilePath, copyFilePath);
            }


        }else{
            throw new IOException("FILE NOT FOUND");
        }

        //저장한 임시저장 폴더에서 파일을 가져와 ZIP파일을 만든다.
        File dirFile = new File(copyDir);
        File []fileList = dirFile.listFiles();
        byte[] buf = new byte[1024];
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));

        //파일 압축시작
         if (fileList != null) {
             for(File tempFile : fileList) {
                 if(tempFile.isFile()) {

                 String tempPath    = tempFile.getParent();
                 String tempFileName = tempFile.getName();
                 String fullPath = tempPath + "/" + tempFileName;

                 FileInputStream in = new FileInputStream(fullPath);

                 //압축 항목추가
                 out.putNextEntry(new ZipEntry(tempFileName));

                 //바이트 전송
                 int len;
                 while((len = in.read(buf)) > 0){
                     out.write(buf,0,len);
                 }

                 out.closeEntry();
                 in.close();

               }//END OF IF
             }//END OF FOR tempFile
         }

         //압축파일 작성
        out.close();

        //저장되 있는 임시저장 폴대 내부의 파일들을 삭제한다.
        //FileUtil.delete(copyDir);
        ZipUtil zu = new ZipUtil();
        zu.deleteFolder(dirFile);


        rtnMap.put("TYPE_CODE", "achive_download");
        rtnMap.put("FILE_NAME", dTime + ".zip");
        rtnMap.put("FILE_SAVENAME", dTime + ".zip");

        return rtnMap;

     }

}