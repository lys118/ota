package ota.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ota.error.CustomException;
import ota.error.type.AuctionError;
import ota.model.dto.AuctionDTO;
import ota.model.dto.AuctionImgDTO;
import ota.model.dto.LoginUserDTO;
import ota.service.AuctionService;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.core.FileUploadException;
import org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload;

/**
 * Servlet implementation class AuctionController
 */
@WebServlet(urlPatterns = {"/auction", "/auction/search", "/auction/detail", "/auction/post", "/auction/post/upload", "/auction/category"})
public class AuctionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private AuctionService auctionService = new AuctionService();
    @Override
    public void init() throws ServletException {
    	System.out.println("init() 실행됨!");
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI().toString();
		String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
		
		System.out.println(lastURI);
		
		if (lastURI.equals("/auction")) {
			request.setAttribute("mainServiceMap", auctionService.mainService());
			request.getRequestDispatcher("/views/auction/auctionMain.jsp").forward(request, response);
		}
		else if (lastURI.equals("/category")) {
			String categoryIdParam = request.getParameter("category_id");
            int categoryId = categoryIdParam != null ? Integer.parseInt(categoryIdParam) : 0;
            request.setAttribute("mainServiceMap", auctionService.mainServiceByCategory(categoryId));
            request.getRequestDispatcher("/views/auction/auctionMain.jsp").forward(request, response);
        }
		else if (lastURI.equals("/detail")) {
		    String auctionIdParam = request.getParameter("auction_id");
		    if (auctionIdParam == null) {
		        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing auction_id parameter");
		        return;
		    }
		    int auctionId = Integer.parseInt(auctionIdParam);
		    request.setAttribute("detailServiceMap", auctionService.detailService(auctionId));
		    request.getRequestDispatcher("/views/auction/auctionDetail.jsp").forward(request, response);
		}
		else if(lastURI.equals("/post")) {
			 Map<String, Object> postServiceMap = auctionService.getPostServiceMap();
	         request.setAttribute("postServiceMap", postServiceMap);
	         request.getRequestDispatcher("/views/auction/auctionPost.jsp").forward(request, response);
		}
		else if (lastURI.equals("/search")) {
            String searchField = request.getParameter("searchField");
            String searchWord = request.getParameter("searchWord");
            
            // 검색어가 null이거나 공백인 경우 메인 페이지로 리다이렉트
            if (searchWord == null || searchWord.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/auction");
                return;
            }
            
            request.setAttribute("mainServiceMap", auctionService.searchService(searchField, searchWord.trim()));
            request.getRequestDispatcher("/views/auction/auctionMain.jsp").forward(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
        String requestURI = request.getRequestURI();
        String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
        
        if(lastURI.equals("/upload")) {
        	Map<String,Object> uploadMap = upload(request);

            auctionService.postService((AuctionDTO)uploadMap.get("auctionDTO")
            		,(List<Integer>)uploadMap.get("categoryIds"));
            response.sendRedirect("/auction");
        } else {
            doGet(request, response);
        }
	}
	
	private Map<String,Object> upload(HttpServletRequest request) {
		AuctionDTO auctionDTO = new AuctionDTO();
		List<Integer> categoryIds = new ArrayList<Integer>();
        List<AuctionImgDTO> auctionImgDTOList = new ArrayList<>();
        Map<String,String> paramMap = new HashMap<String,String>();

        LocalDate localDate = LocalDate.now();
        String uploadDirectory = request.getSession().getServletContext()
                .getRealPath("/views/auction/imgs/" + localDate.getYear() + "/" + localDate.getMonthValue() + "/" + localDate.getDayOfMonth());
        
        Path uploadPath = Paths.get(uploadDirectory);
        try {
            Files.createDirectories(uploadPath);
        } catch (IOException e) {
            throw new CustomException(AuctionError.DIRECTORY_CREATION_FAILED);
        }

        DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
        JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);

        try {
            List<FileItem> fileItems = upload.parseRequest(request);
            if(!fileItems.isEmpty()) {
                for(FileItem item : fileItems) {
                    if(item.isFormField()) {
                        paramMap.put(item.getFieldName(), new String(item.getString().getBytes("8859_1"),"UTF-8"));
                        if("category".equals(item.getFieldName())){
                        	categoryIds.add(Integer.parseInt(item.getString()));
                        }
                    } else {
                        if("img".equals(item.getFieldName()) && item.getSize() > 0) {
                            AuctionImgDTO auctionImgDTO = new AuctionImgDTO();
                            String imgOriginName = item.getName();
                            String imgNewName = UUID.randomUUID().toString() + imgOriginName.substring(imgOriginName.lastIndexOf("."));
                            Path filePath = uploadPath.resolve(imgNewName);
                            
                            try {
                                item.write(filePath);  // 수정된 부분
                                System.out.println("File saved successfully: " + filePath);
                            } catch (Exception e) {
                                e.printStackTrace();
                                throw new CustomException(AuctionError.FILE_UPLOAD_FAILED);
                            }
                            auctionImgDTO.setAuction_imgs_origin_name(imgOriginName);
                            auctionImgDTO.setAuction_imgs_new_name(imgNewName);
                            auctionImgDTO.setAuction_imgs_webdir(uploadDirectory);
                            auctionImgDTOList.add(auctionImgDTO);
                        }
                    }
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
            throw new CustomException(AuctionError.FILE_UPLOAD_EXCEPTION);
        } catch (Exception e) {
            e.printStackTrace();
            throw new CustomException(AuctionError.UNKNOWN_ERROR);
        }

		auctionDTO.setAuction_title(paramMap.get("title"));
		auctionDTO.setAuction_content(paramMap.get("content"));
		auctionDTO.setAuction_startingbid(Integer.parseInt(paramMap.get("startingbid")));
		
		// 날짜 파싱 로직 수정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        try {
            LocalDateTime startDateTime = LocalDateTime.parse(paramMap.get("startdate"), formatter);
            LocalDateTime endDateTime = LocalDateTime.parse(paramMap.get("enddate"), formatter);
            
            auctionDTO.setAuction_startingdate(Timestamp.valueOf(startDateTime));
            auctionDTO.setAuction_enddate(Timestamp.valueOf(endDateTime));
        } catch (DateTimeParseException e) {
            // 날짜 파싱 실패 시 예외 처리
            throw new CustomException(AuctionError.INVALID_DATE_FORMAT);
        }
        
        String userId = paramMap.get("user_user_id");
        if (userId == null || userId.trim().isEmpty()) {
            throw new CustomException(AuctionError.USER_ID_MISSING);
        }
        auctionDTO.setUser_user_id(userId);
        auctionDTO.setAuctionImgDTOList(auctionImgDTOList);
        
        Map<String,Object> uploadMap = new HashMap<>();
        uploadMap.put("auctionDTO", auctionDTO);
        uploadMap.put("categoryIds", categoryIds);
        return uploadMap;
	}
	private List<Integer> getCategoryIds(HttpServletRequest request) {
        String[] categoryIds = request.getParameterValues("category");
        List<Integer> result = new ArrayList<>();
        if (categoryIds != null) {
            for (String id : categoryIds) {
                result.add(Integer.parseInt(id));
            }
        }
        return result;
    }
}
