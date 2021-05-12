package com.mem.model;

import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {

	public String sendPassword(String mb_email) {
		String to = mb_email;
		String subject = "---新密碼寄送通知---";
		SendEmail se = new SendEmail();
		String randomPwd = se.getStringRandom(8);
		String url = "http://localhost:8081/CEA103G3_Project/front-end/mem/MemLogin.jsp";
		String messageText = ("您的新密碼為: " + randomPwd + "，請點選連結馬上登入您的帳號  <a href=\"" + url + "\">Click Here</a>");
		
//		 \"  ->印出雙引號
//		System.out.println(messageText);

		
		try {
			// 設定使用SSL連線至 Gmail smtp Server
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");

			// ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
			// ●須將myGmail的【安全性>>安全性較低的應用程式存取權】打開
			final String myGmail = "ixlogic.wu@gmail.com";
			final String myGmail_password = "CCC45678CCC";
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(myGmail, myGmail_password);
				}
			});

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myGmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

			// 設定信中的主旨
			message.setSubject(subject);
			// 設定信中的內容
			message.setText(messageText);
			 message.setContent(messageText, "text/html;charset=UTF-8");
			

			Transport.send(message);
			System.out.println("傳送成功!");
		} catch (MessagingException e) {
			System.out.println("傳送失敗!");
			e.printStackTrace();
		}
		return randomPwd;
	}

	
	
	// 設定傳送郵件:至收信人的Email信箱,Email主旨,Email內容
	public void sendMail (String mb_email) {
		String to = mb_email;
		String subject = "---帳號啟用通知---";
		
		String url = "http://localhost:8081/CEA103G3_Project/mem/accountactivate.do?key1=" + to;
		String messageText = ("請點選連結啟動您的帳號  <a href=\"" + url + "\">Click Here</a>");
		// \"  ->印出雙引號
//		System.out.println(messageText);
		
		try {
			// 設定使用SSL連線至 Gmail smtp Server
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");

			// ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
			// ●須將myGmail的【安全性>>安全性較低的應用程式存取權】打開
			final String myGmail = "ixlogic.wu@gmail.com";
			final String myGmail_password = "CCC45678CCC";
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(myGmail, myGmail_password);
				}
			});

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myGmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

			// 設定信中的主旨
			message.setSubject(subject);
			// 設定信中的內容
			message.setText(messageText);
//			message.setContent(messageText, "utf-8", "text/html");
			 message.setContent(messageText, "text/html;charset=UTF-8");
			

			Transport.send(message);
			System.out.println("傳送成功!");
		} catch (MessagingException e) {
			System.out.println("傳送失敗!");
			e.printStackTrace();
		}
	}
	
	
	// 隨機產生包含大小寫英文字母&數字的亂數 (可指定產生幾碼)
		public String getStringRandom(int length) {
        
        String val = "";
        Random random = new Random();
        
        //參數length，表示生成幾位隨機數
        for(int i = 0; i < length; i++) {
            
            String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
            //輸出字母還是數字
            if( "char".equalsIgnoreCase(charOrNum) ) {
                //輸出是大寫字母還是小寫字母
                int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
                val += (char)(random.nextInt(26) + temp);
            } else if( "num".equalsIgnoreCase(charOrNum) ) {
                val += String.valueOf(random.nextInt(10));
            }
        }
        return val;
    }
}
