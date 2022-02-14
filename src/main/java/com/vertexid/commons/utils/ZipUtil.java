package com.vertexid.commons.utils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class ZipUtil {

	public ZipUtil(){}

	private static final int BUFFER_SIZE = 1024 * 2;
	protected static Logger logger = LoggerFactory.getLogger(ZipUtil.class);
	/**
	 * 파일 압축
	 * @param baseFile 파일 오브젝 생성후 Param 호출
	 * @param basefilePath 기본 파일 디렉토리
	 */
	public void archive(File baseFile, String basefilePath) {

		// 입출력 파일
		File zipfile = new File(baseFile.getParent(), baseFile.getName() + ".zip");
		ZipOutputStream zos = null;

		try {
		    // 출력장소 OutputStream을 생성
		    zos = new ZipOutputStream(new FileOutputStream(zipfile));
		    archive(zos, baseFile, basefilePath);
		} catch (FileNotFoundException e) {
			System.out.println("Connection Exception occurred");
		} finally {
			try {
				zos.close();
			} catch (IOException e) {
			}
	   }
	}


	  /**
     * 압축
     * @param sourceFile
     * @param sourcePath
     * @param zos
     * @throws Exception
     */
    public void zipEntry(File sourceFile, String sourcePath, ZipOutputStream zos) throws Exception {
        // sourceFile 이 디렉토리인 경우 하위 파일 리스트 가져와 재귀호출
        if (sourceFile.isDirectory()) {
            if (sourceFile.getName().equalsIgnoreCase(".metadata")) { // .metadata 디렉토리 return
                return;
            }
            File[] fileArray = sourceFile.listFiles(); // sourceFile 의 하위 파일 리스트
            for (int i = 0; i < fileArray.length; i++) {
                zipEntry(fileArray[i], sourcePath, zos); // 재귀 호출
            }
        } else { // sourcehFile 이 디렉토리가 아닌 경우
            BufferedInputStream bis = null;
            try {
                String sFilePath = sourceFile.getPath();
                String zipEntryName = sFilePath.substring(sourcePath.length() + 1, sFilePath.length());

                bis = new BufferedInputStream(new FileInputStream(sourceFile));
                ZipEntry zentry = new ZipEntry(zipEntryName);
                zentry.setTime(sourceFile.lastModified());
                zos.putNextEntry(zentry);

                byte[] buffer = new byte[BUFFER_SIZE];
                int cnt = 0;
                while ((cnt = bis.read(buffer, 0, BUFFER_SIZE)) != -1) {
                    zos.write(buffer, 0, cnt);
                }
                zos.closeEntry();
            } finally {
                if (bis != null) {
                    bis.close();
                }
            }
        }
    }

    /**
     * 압축해제
     * @param zipFile
     * @param outPath
     * @return 압축해제 파일리스트
     * @throws Exception
     */
    public List<File> UnZip(File zipFile , String outPath) throws Exception {

    	// Zip File
    	return UnZip(new FileInputStream(zipFile) , outPath);
    }


    /**
     * 압축해제
     * @param fileInputStream
     * @param outPath
     * @return 압축해제 파일리스트
     * @throws Exception
     */
    public List<File> UnZip(FileInputStream fileInputStream , String outPath) throws Exception {

    	// unZipFile list
    	List<File> fileList = new ArrayList<File>();

    	// UnZip Folder Check
    	File outFolder = new File(outPath);
    	if (!outFolder.exists()) {
    		outFolder.mkdir();
    	}

    	ZipInputStream zis = null;

    	try {
	    	zis = new ZipInputStream(fileInputStream, Charset.forName("CP949"));

	    	ZipEntry zipEntry = null;
	    	String zipEntryName = "";

	    	while ( ( zipEntry = zis.getNextEntry()) != null ){
	    		zipEntryName = zipEntry.getName();

	    		if ( zipEntry.isDirectory()) {
	    			zipEntryName = zipEntryName.substring(0, zipEntryName.length() - 1);
	                File folder = new File(outPath + File.separator + zipEntryName);
	                folder.mkdirs();
	    		}
	    		else
	    		{
	    			File file = new File(outPath + File.separator + zipEntryName);
	    			file.getParentFile().mkdirs();

	                FileOutputStream out = new FileOutputStream(file);
	                int len;
	                byte[] buffer = new byte[BUFFER_SIZE];
	                while ((len = zis.read(buffer)) != -1) {
	                    out.write(buffer, 0, len);
	                }
	                out.close();

	                fileList.add(file);
	    		}
	    	}
    	} catch (IOException e) {
    		fileList = null;
    		System.out.println("Connection Exception occurred");
    	}
    	finally
    	{
    		if ( zis != null ) zis.close();
    	}

    	return fileList;
    }

    public boolean deleteFolder(File targetFolder){

        File[] childFile = targetFolder.listFiles();
        boolean confirm = false;
        int size = childFile.length;

        if (size > 0) {

            for (int i = 0; i < size; i++) {

                if (childFile[i].isFile()) {

                    confirm = childFile[i].delete();

                    logger.debug(childFile[i]+":"+confirm + " 삭제");

                } else {

                    deleteFolder(childFile[i]);

                }

            }

        }



        targetFolder.delete();

        logger.debug(targetFolder + " 폴더삭제됨삭제");
        logger.debug(targetFolder+":"+confirm + " 삭제");

        return (!targetFolder.exists());


   }//deleteFolder


	 /**
	   * 파일을 ZOS 출력
	   * @param zos zip 파일 출력 스트림
	   * @param file 입력 파일
	   * @param basefilePath 기본 파일 디렉토리
	   * @return
	  */
	private void archive(ZipOutputStream zos, File file, String basefilePath) {

		// 파일이 디렉토리일 경우
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			for (File objFile : files) {
				archive(zos, objFile, basefilePath);
			}
		} else {
			BufferedInputStream fis = null;
			try {
				// 입력 스트림 생성
				fis = new BufferedInputStream(new FileInputStream(file));

			    // Entry 이름 취득
			    String entryName = file.getAbsolutePath().replace(basefilePath.replace("/", "\\"), "").substring(1);
			    logger.debug("###entryName = " + entryName + "\n");
			    logger.debug("###basefilePath = " + basefilePath + "\n");

			    // 출력 장소  Entry 설정
			     zos.putNextEntry(new ZipEntry(entryName));

			    // 파일 입출력 시작
			    int ava = 0;
			    while ((ava = fis.available()) > 0) {
			    	byte[] bs = new byte[ava];
			    	fis.read(bs);
			    	zos.write(bs);
			    }

			    // 파일 출력 Entry Close
			    zos.closeEntry();
			} catch (FileNotFoundException e) {
				System.out.println("Connection Exception occurred");
			} catch (IOException e) {
				System.out.println("Connection Exception occurred");
			} finally {
				try {
					fis.close();
				} catch (IOException e) {
					System.out.println("Connection Exception occurred");
				}
			}
		}
	}


}
