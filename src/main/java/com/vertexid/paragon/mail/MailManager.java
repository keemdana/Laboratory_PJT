/*
 * @(#)MailManager.java     2021-09-10(010) 오전 10:24
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
package com.vertexid.paragon.mail;

import com.vertexid.spring.utils.BaseProperties;
import com.vertexid.spring.utils.CmmProperties;
import com.vertexid.viself.base.BaseSvc;
import org.springframework.stereotype.Component;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

/**
 * <b>Description</b>
 * <pre>
 *     REVIEW spring mailSender 교체 검토
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Component
public class MailManager extends BaseSvc {
    Properties props = new Properties();
    MimeMessage message;
    Multipart multipart;
    Session session;
    Authenticator auth ;

    String m_smtp_charSet		= BaseProperties.get("cmm.lang.charSet");
    String m_smtp_useYn			= BaseProperties.get("mail.useYn");
    String m_smtp_host 			= BaseProperties.get("mail.smtp.host");
    String m_smtp_port			= BaseProperties.get("mail.smtp.port");
    String m_smtp_user 			= BaseProperties.get("mail.smtp.user");
    String m_smtp_password 		= BaseProperties.get("mail.smtp.password");
    String m_smtp_startTlsYn 	= BaseProperties.get("mail.smtp.tlsYn");
    String m_smtp_enableSslYn	= BaseProperties.get("mail.smtp.sslYn");
    String m_smtp_debugYn 		= BaseProperties.get("mail.smtp.debugYn");

    /**
     * 메일 관리자 객체 생성
     *
     * @throws Exception
     */
    public MailManager() throws Exception {
        setProperties();
    }

    /**
     * 메일 관리자 객체 생성
     * @param host 호스트 주소
     * @param port 포트번호
     * @param user 계정 아이디
     * @param password 계정 패스워드
     * @param useYn SMTP 실제사용여부 [Y:사용함, N:사용안함(테스트)]
     * @param charSet 캐릭터셋
     * @param startTlsYn
     * @param enableSslYn
     * @param debugYn
     * @throws MessagingException
     */
    public MailManager(String host, String port, String user, String password, String useYn, String charSet, String startTlsYn, String enableSslYn, String debugYn) throws Exception {
        m_smtp_host 		= host;
        m_smtp_port 		= port;
        m_smtp_user 		= user;
        m_smtp_password 	= password;
        m_smtp_useYn 		= ("N".equals(useYn) ? "N" : "Y");
        m_smtp_charSet		= (charSet != null && !"".equals(charSet) ? charSet : "UTF-8");
        m_smtp_startTlsYn	= ("Y".equals(startTlsYn) ? "Y" : "N");
        m_smtp_enableSslYn	= ("Y".equals(enableSslYn) ? "Y" : "N");
        m_smtp_debugYn		= ("Y".equals(debugYn) ? "Y" : "N");

        setProperties();
    }

    /**
     * SMTP SERVER 설정 및 기본 할당
     * @throws MessagingException
     */
    public void setProperties() throws Exception {
        props.put("mail.smtp.host", m_smtp_host);
        props.put("mail.smtp.port", m_smtp_port);

        if ("Y".equals(m_smtp_startTlsYn)) {
            props.put("mail.smtp.starttls.enable", "true");
        }

        if ("Y".equals(m_smtp_enableSslYn)) {
            props.put("mail.smtp.EnableSSL.enable", "true");
        }

        /* Sending smtp server Authentication */
        if (m_smtp_user != null && !"".equals(m_smtp_user)) {
            props.put("mail.smtp.auth", "true");
            auth = new MailAuthentication(m_smtp_user, m_smtp_password);
        } else {
            props.put("mail.smtp.auth", "false");
            auth = null;
        }

		/*session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(m_smtp_user, m_smtp_password);
            }
        });*/
        session = Session.getInstance(props, auth);
        session.setDebug("Y".equals(m_smtp_debugYn));

        message = new MimeMessage(session);
        message.setHeader("Content-Type", "text/html;charset="+ m_smtp_charSet);

        multipart = new MimeMultipart();
    }

    /**
     * 발신자 추가
     *
     * @param address
     * @param name
     * @throws UnsupportedEncodingException
     * @throws MessagingException
     */
    public void setFrom(String address, String name) throws UnsupportedEncodingException, MessagingException {
        log.debug("[setFrom()] address is "+ address);
        log.debug("[setFrom()] name is "+ name);

        InternetAddress addrFrom = new InternetAddress(address, name, m_smtp_charSet);
        message.setFrom(addrFrom);
    }

    /**
     * 발신자 추가
     * @param address 발신자 메일주소 문자열 ex) "이름" &lt;id@domain.com&gt;
     * @throws Exception
     */
    public void setFrom(String address) throws Exception
    {
        InternetAddress[] addrs = InternetAddress.parse(address);
        if (addrs.length != 0) {
            this.setFrom(addrs[0].getAddress(), addrs[0].getPersonal());
        }
    }


    /**
     * 수신자 추가
     * @param address
     * @param name
     * @throws AddressException
     * @throws MessagingException
     * @throws UnsupportedEncodingException
     */
    public void addTo(String address, String name) throws AddressException, MessagingException, UnsupportedEncodingException {
        log.debug("[addTo()] address is "+ address);
        log.debug("[addTo()] name is "+ name);

        message.addRecipient(Message.RecipientType.TO, new InternetAddress(address, name, m_smtp_charSet));
    }

    /**
     * 수신자들 추가
     * @param addresses 수신자 메일주소 문자열 ex) "이름01" &lt;id01@domain.com&gt;, "이름02" &lt;id02@domain.com&gt;
     * @throws MessagingException
     */
    public void addTos(String addresses) throws Exception {
        //message.addRecipients(Message.RecipientType.TO, addresses); //이 방법을 쓰면 한글 이름이 깨진다..

        InternetAddress[] addrs = InternetAddress.parse(addresses);
        for (InternetAddress addr : addrs) {
            this.addTo(addr.getAddress(), addr.getPersonal());
        }
    }


    /**
     * 참조자 추가
     * @param address
     * @param name
     * @throws MessagingException
     * @throws UnsupportedEncodingException
     */
    public void addCc(String address, String name) throws MessagingException, UnsupportedEncodingException {
        log.debug("[addCc()] address is "+ address);
        log.debug("[addCc()] name is "+ name);

        message.addRecipient(Message.RecipientType.CC, new InternetAddress(address, name, m_smtp_charSet));
    }

    /**
     * 참조자들 추가
     * @param addresses 참조자 메일주소 문자열 ex) "이름01" &lt;id01@domain.com&gt;, "이름02" &lt;id02@domain.com&gt;
     * @throws MessagingException
     */
    public void addCcs(String addresses) throws Exception {
        if (addresses != null && !"".equals(addresses)) {
            InternetAddress[] addrs = InternetAddress.parse(addresses);
            for (InternetAddress addr : addrs) {
                this.addCc(addr.getAddress(), addr.getPersonal());
            }
        }
    }

    /**
     * 비밀참조자 추가
     *
     * @param address
     * @param name
     * @throws AddressException
     * @throws MessagingException
     * @throws UnsupportedEncodingException
     */
    public void addBcc(String address, String name) throws AddressException, MessagingException, UnsupportedEncodingException {
        message.addRecipient(Message.RecipientType.BCC, new InternetAddress(address, name, m_smtp_charSet));
    }

    /**
     * 비밀참조자들 추가
     * @param addresses 비밀참조자 메일주소 문자열 ex) "이름01" &lt;id01@domain.com&gt;, "이름02" &lt;id02@domain.com&gt;
     * @throws MessagingException
     */
    public void addBccs(String addresses) throws Exception {
        if (addresses != null && !"".equals(addresses)) {
            InternetAddress[] addrs = InternetAddress.parse(addresses);
            for (InternetAddress addr : addrs) {
                this.addBcc(addr.getAddress(), addr.getPersonal());
            }
        }
    }


    /**
     * 제목
     * @param subject
     * @throws MessagingException
     */
    public void setSubject(String subject) throws UnsupportedEncodingException, MessagingException {
        log.debug("subject is "+ subject);

        message.setSubject(subject, m_smtp_charSet);
    }

    /**
     * 본문
     *
     * @param txt
     * @throws MessagingException
     */
    public void setBody(String txt) throws MessagingException {
        setBody(txt, true);
    }

    public void setBody(String txt, boolean isHtml) throws MessagingException {
        log.debug("body is "+ txt);

        BodyPart messageBodyPart = new MimeBodyPart();
        if(isHtml) {
            messageBodyPart.setContent(txt, "text/html; charset=\""+ m_smtp_charSet +"\"");
        } else {
            messageBodyPart.setContent(txt, "text/plain; charset=\""+ m_smtp_charSet +"\"");
        }
        multipart.addBodyPart(messageBodyPart);
    }

    /**
     * 첨부파일 추가
     * @param absoluteFile
     * @param fileName
     * @throws MessagingException
     * @throws UnsupportedEncodingException
     */
    public void addAttachFile(String absoluteFile, String fileName)
            throws MessagingException, UnsupportedEncodingException
    {
        BodyPart fileBodyPart = new MimeBodyPart();

        DataSource source = new FileDataSource(absoluteFile);
        if (fileName == null || "".equals(fileName)) fileName = source.getName();

        fileBodyPart.setDataHandler(new DataHandler(source));
        //fileBodyPart.setFileName(new String(fileName.getBytes(m_smtp_charSet), "8859_1"));
        fileBodyPart.setFileName(MimeUtility.encodeText(fileName, m_smtp_charSet, "Q"));

        multipart.addBodyPart(fileBodyPart);
    }

    /**
     * 첨부파일 추가
     * @param absoluteFile
     * @throws MessagingException
     */
    public void addAttachFile(String absoluteFile)
            throws MessagingException, UnsupportedEncodingException
    {
        this.addAttachFile(absoluteFile, null);
    }

    /**
     * 메일 보내기
     * @throws MessagingException
     */
    public void send() throws MessagingException {
        if ( ( "Y".equals(m_smtp_useYn)) ) {

            //-- 아이디 비번 사용시
//			message.setContent(multipart);
//			Transport transport = session.getTransport("smtp");
//			transport.connect(m_smtp_host, m_smtp_user, m_smtp_password);
//			transport.sendMessage(message, message.getAllRecipients() );
//			transport.close();


            //-- 아이디 비번 미사용시
            message.setContent(multipart);
            Transport transport = null;
            try {
                transport = session.getTransport("smtp");
                transport.connect();
                transport.sendMessage(message, message.getAllRecipients());
            }catch (Exception e){
                String msg = e.getMessage();
                log.error(msg);
                throw new MessagingException(msg);
            }finally {
                if(transport != null){
                    transport.close();
                }

                log.info("close trasport");
            }
        } else {
            if (CmmProperties.isNotProd()){
                //DEBUG
                log.debug("[DEBUG] MailManager.send() --------------------");
                log.debug(" - Subject:"+ message.getSubject());
                log.debug(" - From:");
                Address[] froms = message.getFrom();
                for (Address from : froms) {
                    log.debug("    * " + from.toString());
                }
                log.debug(" - Recipients:");
                Address[] recipients = message.getAllRecipients();
                for (Address recipient : recipients) {
                    log.debug("    * [" + recipient.getType() + "] " +
                            recipient);
                }
//				log.debug(" - Contents:");

//				try {
//					log.debug("    * [ CONTENTS ] "+ message.getContent().toString());
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
            }
        }
    }

    public void setLguDrmVal() {
        try {
            message.addHeader("X-Uplus-Mail-Class", "2");
        } catch (MessagingException e) {
            e.printStackTrace();
        } //메일을 발송하면서, DRM을 해제하도록 요청하는 Header

    }

    private static class MailAuthentication extends Authenticator {
        PasswordAuthentication pa;

        public MailAuthentication(String id , String pw) {
            pa = new PasswordAuthentication(id,pw);
        }

        public PasswordAuthentication getPasswordAuthenticaion() {
            return pa;
        }
    }
}
