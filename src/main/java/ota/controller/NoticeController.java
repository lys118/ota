package ota.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ota.error.CustomException;
import ota.error.type.NoticeError;
import ota.model.dto.NoticeDto;
import ota.model.dto.NoticeImgDto;
import ota.service.NoticeService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.core.FileUploadException;
import org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.time.LocalDate;

/**
 * Servlet implementation class NoticeController
 */
@WebServlet(urlPatterns = {"/notice", "/notice/view","/notice/adminList"
		,"/notice/delete","/notice/adminView","/notice/writeForm"
		,"/notice/write","/notice/imgUpload","/notice/imgDelete"
		,"/notice/updateForm","/notice/update"})
public class NoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private NoticeService noticeService = new NoticeService();
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String requestURI = request.getRequestURI();
		String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
		
		if ("/notice".equals(lastURI)) {
			noticeList(request).getRequestDispatcher("/views/notice/noticeList.jsp")
							.forward(request, response);
		} else if ("/view".equals(lastURI)) {
			noticeView(request).getRequestDispatcher("/views/notice/noticeView.jsp")
							.forward(request, response);
		} else if ("/adminList".equals(lastURI)) {
			noticeList(request).getRequestDispatcher("/views/admin/notice/noticeAdminList.jsp")
							.forward(request, response);
		} else if ("/adminView".equals(lastURI)) {
			noticeView(request).getRequestDispatcher("/views/admin/notice/noticeAdminView.jsp")
							.forward(request, response);
		} else if ("/delete".equals(lastURI)) {
			noticeDelete(request);
			response.sendRedirect("/notice/adminList");
		} else if ("/writeForm".equals(lastURI)) {
			request.getRequestDispatcher("/views/admin/notice/noticeAdminWrite.jsp").forward(request, response);
		} else if ("/updateForm".equals(lastURI)) {
			noticeUpdateForm(request).getRequestDispatcher("/views/admin/notice/noticeAdminUpdate.jsp")
							.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String requestURI = request.getRequestURI();
		String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
		
		if("/write".equals(lastURI)) {
			noticeWrite(request);
			response.sendRedirect("/notice/adminList");
		}else if("/imgUpload".equals(lastURI)) {
			noticeImgUpload(request,response);
		}else if("/imgDelete".equals(lastURI)) {
			noticeImgDelete(request,response);
		}else if("/update".equals(lastURI)) {
			noticeUpdate(request);
			response.sendRedirect("/notice/adminList");
		}
	}

	private HttpServletRequest noticeList(HttpServletRequest request) {
		int currentPage = Integer.parseInt(Optional.ofNullable(request.getParameter("currentPage"))
				.orElse("1")); //페이징 처리를 위한 현재페이지
		String searchField = Optional.ofNullable(request.getParameter("searchField")).orElse("");
		String searchWord = Optional.ofNullable(request.getParameter("searchWord")).orElse("");
		
		Map<String,String> searchMap = new HashMap<String, String>();
		searchMap.put("searchField", searchField);
		searchMap.put("searchWord", searchWord);
		Map<String,Object> noticeMap = noticeService.noticeList(currentPage,searchMap);
		
		request.setAttribute("noticeMap", noticeMap);
		return request;
	}
	
	private HttpServletRequest noticeView(HttpServletRequest request) {
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		NoticeDto noticeDto = noticeService.getNoticeView(noticeId);
		noticeList(request);
		request.setAttribute("noticeDto", noticeDto);
		return request;
	}
	
	private void noticeDelete(HttpServletRequest request) {
		int[] deleteIArr =null;
		if(request.getParameter("deleteOneCheck") != null) { //하나만 삭제시
			deleteIArr = new int[1];
			deleteIArr[0] = Integer.parseInt(request.getParameter("deleteOneCheck"));
		}else { //한번에 여러개 삭제시
			String[] deleteSArr = request.getParameterValues("deleteManyCheck");
			deleteIArr = Arrays.stream(deleteSArr)
							.mapToInt(Integer::parseInt)
							.toArray();
		}
		List<NoticeImgDto> noticeImgList= noticeService.noticeDelete(deleteIArr);//db에서 삭제후 서버에서 이미지삭제
		
		if(!noticeImgList.isEmpty()) {
			for(int i = 0; i<noticeImgList.size(); i++) {
				String uploadDirectory = request.getSession().getServletContext()
						.getRealPath(noticeImgList.get(i).getWebDirectory() + "/" + noticeImgList.get(i).getNoticeImgNewName());
				File file = new File(uploadDirectory);
				if (file.exists())
					file.delete();
			}
		}
	}
	
	private void noticeImgUpload(HttpServletRequest request, HttpServletResponse response) {
		LocalDate localDate = LocalDate.now();
		int year = localDate.getYear();
		int month = localDate.getMonthValue();
		int day = localDate.getDayOfMonth();
		
		String uploadDirectory = request.getSession().getServletContext()
				.getRealPath("/views/admin/notice/imgs/"+year+"/"+month+"/"+day);
		//기본은 이클립스 가상경로로 잡힌다. meta~/plug~~
		//서버탭에서 serve modules without publishing을 체크해주면
		//가상경로가아닌 실제경로로 잡아준다.
		
		File folder = new File(uploadDirectory);
		if(!folder.exists()) { //폴더가 없으면 
			folder.mkdirs(); //생성
		}
		
		 DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
		 JakartaServletFileUpload upload = new JakartaServletFileUpload (factory);
		 String filename = "";
		 String newFileName = "";
		 try {
			List<FileItem> fileItems = upload.parseRequest(request);
			//list로 바꿧지만 request로는 하나씩만보냄.
			if(!fileItems.isEmpty()) {
				FileItem file = fileItems.get(0); 
				filename = file.getName(); //원래 파일이름인데 이름중복시 덮어쓰기됨..
				newFileName = UUID.randomUUID().toString()
						+filename.substring(filename.lastIndexOf("."));//uuid+확장자명으로 새로운이름생성
				file.write(Path.of(uploadDirectory, newFileName));//경로에 파일 저장
				}
			//uploadDirectory 경로는
			//D:\dev\devcode\eclipse\eclipse-workspace\OTA\src\main\webapp\views\admin\notice\imgs\2024\9\30
			//근데 summernote에서 로컬경로로 접근이 불가능하므로
			//img추가방식으로 함 그래서 view/admin...으로 뽑으면됨
			String webDirectory = uploadDirectory.substring(uploadDirectory.lastIndexOf("webapp")+6);
			Map<String, String> jsonMap = new HashMap<String, String>();
			jsonMap.put("webDirectory",webDirectory);
			jsonMap.put("fileName",filename);
			jsonMap.put("newFileName",newFileName);
			 
			JSONObject jsonObject = new JSONObject(jsonMap);
			response.setContentType("application/json");
		    response.getWriter().print(jsonObject.toJSONString());
		} catch (FileUploadException e) {
			e.printStackTrace();
			throw new CustomException(NoticeError.NOTICE_IMG_UPLOAD_EXCEPTION);
		} catch (IOException e) {
			e.printStackTrace();
			throw new CustomException(NoticeError.NOTICE_IMG_UPLOAD_EXCEPTION);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomException(NoticeError.NOTICE_IMG_UPLOAD_EXCEPTION);
		}		 
	}
	
	private void noticeImgDelete(HttpServletRequest request, HttpServletResponse response) {
		String jsonObjString = ""; // json으로 받은 data를 string에 입력
		try {
			BufferedReader br = request.getReader();
			while (br.ready()) {
				jsonObjString += br.readLine();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		JSONParser jsonParser = new JSONParser(); //json으로 바꿔서 출력
		String noticeId ="";
		String webDirectory = "";
		String fileName = "";
		String newFileName = "";
		try {
			Object obj = jsonParser.parse(jsonObjString);
			JSONObject jsonObject = (JSONObject) obj;
			noticeId = (String)jsonObject.get("noticeId");
			webDirectory = jsonObject.get("webDirectory").toString();
			fileName = jsonObject.get("fileName").toString();
			newFileName = jsonObject.get("newFileName").toString();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if(noticeId != null && noticeId != "") {//업데이트시 noticeid가 있다면 db에서도 조회 후 있으면 삭제.
			NoticeImgDto noticeImgDto = new NoticeImgDto();
			noticeImgDto.setNoticeId(Integer.parseInt(noticeId));
			noticeImgDto.setNoticeImgNewName(newFileName);
			
			noticeService.deleteImg(noticeImgDto);
		}
		//서버에는 무조건 있으므로 서버에서삭제.
		String uploadDirectory = request.getSession().getServletContext()
				.getRealPath(webDirectory + "/" + newFileName);
		File file = new File(uploadDirectory);
		
		if (file.exists())
			 file.delete();
	}
	
	private NoticeDto setNoticeWriteAndUpdate(HttpServletRequest request) {
		int noticeId = Integer.parseInt(Optional.ofNullable(request.getParameter("noticeId"))
				.orElse("0"));
		String noticeTitle = request.getParameter("noticeTitle");
		String noticeImportanceType = request.getParameter("noticeImportType");
		String noticeContent = request.getParameter("noticeContent");
		List<NoticeImgDto> noticeImgList = new ArrayList<>();
		
		String[] webDirectory = request.getParameterValues("webDirectory");
		String[] fileName = request.getParameterValues("fileName");
		String[] newFileName = request.getParameterValues("newFileName");
		
		if(webDirectory != null) {
			for (int i = 0; i < webDirectory.length; i++) {
				NoticeImgDto noticeImgDto = new NoticeImgDto();
				noticeImgDto.setWebDirectory(webDirectory[i]);
				noticeImgDto.setNoticeImgNewName(newFileName[i]);
				noticeImgDto.setNoticeImgOriginName(fileName[i]);
			
				noticeImgList.add(noticeImgDto);
			}
		}
		
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setNoticeId(noticeId);
		noticeDto.setNoticeTitle(noticeTitle);
		noticeDto.setNoticeImportanceType(noticeImportanceType);
		noticeDto.setNoticeContent(noticeContent);
		noticeDto.setNoticeImgList(noticeImgList);
		
		return noticeDto;
	}
	
	private void noticeWrite(HttpServletRequest request) {
		noticeService.noticeWrite(setNoticeWriteAndUpdate(request));
	}
	
	private HttpServletRequest noticeUpdateForm(HttpServletRequest request) {
		Map<String,Object> noticeMap = noticeService
				.noticeUpdateForm(Integer.parseInt(request.getParameter("noticeId")));
		
		request.setAttribute("noticeMap", noticeMap);
		return request;
	}
	
	private void noticeUpdate(HttpServletRequest request) {
		noticeService.noticeUpdate(setNoticeWriteAndUpdate(request));
	}
}
