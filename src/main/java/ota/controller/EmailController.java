package ota.controller;



import jakarta.mail.Message;

import jakarta.mail.Multipart;

import jakarta.mail.Session;

import jakarta.mail.Transport;

import jakarta.mail.internet.InternetAddress;

import jakarta.mail.internet.MimeBodyPart;

import jakarta.mail.internet.MimeMessage;

import jakarta.mail.internet.MimeMessage.RecipientType;

import jakarta.mail.internet.MimeMultipart;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.util.Properties;



/**

 * Servlet implementation class EmailContorller

 */

@WebServlet("/email")

public class EmailController extends HttpServlet {

	private static final long serialVersionUID = 1L;

       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userEmail = request.getParameter("user_email");
		

		String adminName = "OTA관리자";

		String adminEmail = "hyunho0720@gmail.com";

		String amdinEmailPassword = "qmpokyjwrnnalmjp";

		String title = "인증 제목";

		Properties prop = new Properties();
		prop.put("mail.transport.protocol", "smtp");
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "587"); //465, 587
		prop.put("mail.smtp.auth", "true");

		// 추가 옵션
		prop.put("mail.smtp.quitwait", "false");
		prop.put("mail.smtp.socketFactory.port", "587");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.fallback", "true");
		prop.put("mail.smtp.starttls.enable", "true");

		

		try {

			// 메일 세션 생성

			Session session = Session.getDefaultInstance(prop);

			
			Message message = new MimeMessage(session);

			message.setFrom(new InternetAddress(adminEmail,adminName));

			message.addRecipient(RecipientType.TO, new InternetAddress(userEmail));

			message.setSubject(title);

			

			Multipart mParts = new MimeMultipart();
			MimeBodyPart mTextPart = new MimeBodyPart();
			
			
			String ran = "";
				for(int i=0 ; i< 6 ; i++) {
				
				int sel1 = (int)(Math.random() * 3); // 0:숫자 / 1,2:영어
				
				if(sel1 == 0) {
					
					int num = (int)(Math.random() * 10); // 0~9
					ran += num;
					
				}else {
					
					char ch = (char)(Math.random() * 26 + 65); // A~Z
					
					int sel2 = (int)(Math.random() * 2); // 0:소문자 / 1:대문자
					
					if(sel2 == 0) {
						ch = (char)(ch + ('a' - 'A')); // 대문자로 변경
					}
					
					ran += ch;
				}
				
			}
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("<h3>[OTA] 회원 가입 인증 번호입니다.</h3>\n");
			sb.append("<h3>인증 번호 : <span style='color:red'>"+ ran +"</span></h3>\n");	

			String mailContent = sb.toString();
			
			mTextPart.setText(mailContent,"UTF-8","html");
			mParts.addBodyPart(mTextPart);
			message.setContent(mParts);

			

			Transport transport =session.getTransport("smtp");

			transport.connect(adminEmail,amdinEmailPassword);

			transport.sendMessage(message, message.getAllRecipients());

			transport.close();
			
			response.getWriter().print(ran);

		} catch (Exception e) {

			e.printStackTrace();

		}
		

	}



	/**

	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)

	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// TODO Auto-generated method stub

		doGet(request, response);

	}



}