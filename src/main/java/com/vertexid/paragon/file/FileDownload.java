package com.vertexid.paragon.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownload extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {


		File file = (File)model.get("downloadFile");
        System.out.println("DownloadView --> file.getPath() : " + file.getPath());
        System.out.println("DownloadView --> file.getName() : " + file.getName());

        response.setContentType(getContentType());
        response.setContentLength((int)file.length());

        //String userAgent = request.getHeader("User-Agent");

        //boolean ie = userAgent.indexOf("MSIE") > -1;

        String fileName = null;

        //if(ie){
        //브라우저 정보에 따라 utf-8변경
        if(request.getHeader("User-Agent").indexOf("MSIE") > -1){

            fileName = URLEncoder.encode(file.getName(), "UTF-8").replaceAll("\\+", "%20").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(").replaceAll("\\%29", ")")
					.replaceAll("\\%7E", "~");
            System.out.println("IE --> fileName : " + fileName);
        } else {

            fileName = URLEncoder.encode(file.getName(),"UTF-8");
            System.out.println("IE else --> fileName : " + fileName);
        }// end if;
//        fileName = file.getName();
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;

        //파일 카피 후 마무리
        try {
            fis = new FileInputStream(file);

            FileCopyUtils.copy(fis, out);
        } catch(Exception e){
            e.printStackTrace();
        }finally{
            if(fis != null){
                try{
                    fis.close();
                }catch(Exception e){}
            }
        }// try end;
        out.flush();
	}

}
