package ota.controller;

import jakarta.mail.Message;
import jakarta.mail.Multipart;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.internet.MimeMessage.RecipientType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ota.error.CustomException;
import ota.error.type.ContactUsError;
import ota.model.dto.ContactUsDto;
import ota.model.dto.ContactUsImgDto;
import ota.service.ContactUsService;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.UUID;

import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.core.FileUploadException;
import org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload;

/**
 * Servlet implementation class ContactUsController
 */
@WebServlet(urlPatterns = {"/contactUs/writeForm","/contactUs/upload","/admin/contactUs/adminList"
		,"/admin/contactUs/adminViewAndWrite","/admin/contactUs/adminResponse"})
public class ContactUsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ContactUsService contactUsService = new ContactUsService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
		
		if ("/writeForm".equals(lastURI)) {
			String result = request.getParameter("result");
			if(result != null && result != "") {
				request.setAttribute("result",result);
			}
			request.getRequestDispatcher("/views/contactUs/contactUsWrite.jsp").forward(request, response);
		} else if ("/adminList".equals(lastURI)) {
			adminList(request);
			request.getRequestDispatcher("/views/admin/contactUs/contactUsAdminList.jsp").forward(request, response);
		} else if ("/adminViewAndWrite".equals(lastURI)) {
			adminList(request);
			adminViewAndWrite(request);
			request.getRequestDispatcher("/views/admin/contactUs/contactUsAdminViewAndWrite.jsp").forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String requestURI = request.getRequestURI();
		String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
		
		if("/upload".equals(lastURI)) {
			upLoad(request);
			response.sendRedirect("/contactUs/writeForm?result=success");
		}else if("/adminResponse".equals(lastURI)) {
			adminResponse(request);
			response.sendRedirect("/admin/contactUs/adminList?result=success");
		}
	}
	
	private void upLoad(HttpServletRequest request) { //submit 멀티파트로 전송받으면 getParameter에 정보가 없고
		//file객체에 전부 담겨 있다. 그래서 아래와 같이 작성
		ContactUsDto contactUsDto = new ContactUsDto();
		List<ContactUsImgDto> cuImglist = new ArrayList<>();
		Map<String,String> paramMap = new HashMap<String,String>();//file에담긴거 여기다가 담을때 필요

		LocalDate localDate = LocalDate.now(); // 날짜 생성
		int year = localDate.getYear();
		int month = localDate.getMonthValue();
		int day = localDate.getDayOfMonth();
		
		String uploadDirectory = request.getSession().getServletContext()
				.getRealPath("/views/contactUs/imgs/"+year+"/"+month+"/"+day); //경로생성
		//기본은 이클립스 가상경로로 잡힌다. meta~/plug~~
		//서버탭에서 serve modules without publishing을 체크해주면
		//가상경로가아닌 실제경로로 잡아준다.
		
		File folder = new File(uploadDirectory);
		if(!folder.exists()) { //폴더가 없으면 
			folder.mkdirs(); //생성
		}
		
		DiskFileItemFactory factory = DiskFileItemFactory.builder().get(); //commons.io로 업로드할때 필요
		JakartaServletFileUpload upload = new JakartaServletFileUpload (factory);

		try {
			List<FileItem> fileItems = upload.parseRequest(request);//요청온 파일정보를 리스트에 저장
			if(!fileItems.isEmpty()) { //비어있지 않으면
				for(FileItem file : fileItems) {
					//paramMap.put(file.getFieldName(), file.getString()); //name, value를 담아준다.
					//getString으로 바로 담으면 한글이깨져버린다..
					paramMap.put(file.getFieldName(), new String(file.getString().getBytes("8859_1"),"UTF-8"));
					if("imgs".equals(file.getFieldName())) {//input파일 name이 imgs면
						if(file.getName() != null && file.getName() !="") {//(이미지가 없어도 이름 하나는 들어옴. 이미지없을경우 대비)
							ContactUsImgDto contactUsImgDto = new ContactUsImgDto(); //이미지객체 생성후
							String imgOriginName = file.getName();//getName은 파일이름 뽑아낼때씀 string과 다름.
							String imgNewName = UUID.randomUUID().toString()
									+imgOriginName.substring(imgOriginName.lastIndexOf("."));//uuid+확장자명으로 새로운이름생성
							file.write(Path.of(uploadDirectory, imgNewName)); //경로에 새로운이름으로 저장
							//이미지 서버에 자동반영(새로고침안해도되게)-> window - preference -general-workspace
							//에서 맨위 reflash using native~ polling 체크
							contactUsImgDto.setContactUsImgOriginName(imgOriginName);
							contactUsImgDto.setContactUsImgNewName(imgNewName);
							contactUsImgDto.setWebDirectory(uploadDirectory);
							cuImglist.add(contactUsImgDto);
						}
					}
				}
			}
		}catch (FileUploadException e) {
				e.printStackTrace();
				throw new CustomException(ContactUsError.CONTACTUS_IMG_UPLOAD_EXCEPTION);
		}catch (Exception e) {
				e.printStackTrace();
				throw new CustomException(ContactUsError.CONTACTUS_IMG_UPLOAD_EXCEPTION);
		}
		// map에 넣은걸 꺼내서 객체에 넣어준다.
		contactUsDto.setContactUsUserType(paramMap.get("userType"));
		contactUsDto.setContactUsUserId(paramMap.get("userId"));
		contactUsDto.setContactUsUserName(paramMap.get("userName"));
		contactUsDto.setContactUsUserEmail(paramMap.get("userEmail"));
		contactUsDto.setContactUsType(paramMap.get("contactUsType"));
		contactUsDto.setContactUsTitle(paramMap.get("contactUsTitle"));
		contactUsDto.setContactUsContent(paramMap.get("contactUsContent"));
		contactUsDto.setContactUsImgList(cuImglist);//이미지도 넣어준다.
		
		contactUsService.writeContactUs(contactUsDto);
	}
	
	private void adminList(HttpServletRequest request) {
		String result = request.getParameter("result");//답변 완료시 결과보여주기위한값
		int currentPage = Integer.parseInt(Optional.ofNullable(request.getParameter("currentPage"))
				.orElse("1"));
		String selectComplete = Optional.ofNullable(request.getParameter("selectComplete")).orElse("allComplete");
		
		Map<String,Object> contactUsMap =  contactUsService.adminList(currentPage,selectComplete);
		request.setAttribute("result", result);
		request.setAttribute("contactUsMap", contactUsMap);
	}
	
	private void adminViewAndWrite(HttpServletRequest request) {
		int contactUsId = Integer.parseInt(request.getParameter("contactUsId"));
		
		ContactUsDto contactUsDto = contactUsService.adminViewAndWrite(contactUsId);
		request.setAttribute("contactUsDto", contactUsDto);
	}
	
	private void adminResponse(HttpServletRequest request) {
		int contactUsId = Integer.parseInt(request.getParameter("contactUsId"));
		String responseText = request.getParameter("responseText");
		String contactUsUserEmail = request.getParameter("contactUsUserEmail");
		String contactUsTitle = request.getParameter("contactUsTitle");
		String contactUsContent = request.getParameter("contactUsContent");
		
		sendEmail(contactUsUserEmail, contactUsTitle, contactUsContent, responseText);
		contactUsService.adminResponse(contactUsId,responseText);
	}
	
	private boolean sendEmail(String contactUsUserEmail, String contactUsTitle, 
			String contactUsContent, String responseText) {
		String userEmail = contactUsUserEmail;
		String adminName = "OTA관리자";
		String adminEmail = "hyunho0720@gmail.com";
		String amdinEmailPassword = "qmpokyjwrnnalmjp";
		String title = "OTA 1:1문의 답변입니다.";
		
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
			Session session = Session.getDefaultInstance(prop);
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(adminEmail,adminName));
			message.addRecipient(RecipientType.TO, new InternetAddress(userEmail));
			message.setSubject(title);

			Multipart mParts = new MimeMultipart();
			MimeBodyPart mTextPart = new MimeBodyPart();
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("문의 제목 : " +contactUsTitle+"<br/>");
			sb.append("문의 내용 : " +contactUsContent+"<br/>");
			sb.append("=================================================<br/>");
			sb.append("답변 : " + responseText);

			String mailContent = sb.toString();
			
			mTextPart.setText(mailContent,"UTF-8","html");
			mParts.addBodyPart(mTextPart);
			message.setContent(mParts);


			Transport transport =session.getTransport("smtp");
			transport.connect(adminEmail,amdinEmailPassword);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();

		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomException(ContactUsError.CONTACTUS_RESPONSE_SEND_EMAIL_EXCEPTION);
		}
		
		return true;
	}
}






