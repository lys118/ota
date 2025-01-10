package ota.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ota.model.dao.UserDAO;
import ota.model.dto.LoginUserDTO;
import ota.model.dto.UserDTO;
import ota.service.UserService;

import java.awt.geom.CubicCurve2D;
import java.io.IOException;
import java.util.ArrayList;

import com.mysql.cj.Session;

/**
 * Servlet implementation class UserController
 */
@WebServlet(urlPatterns = {"/login","/loginprocess","/agreement","/join","/joinprocess","/checkid"
		,"/logout","/findid","/findidprocess","/findpw","/changepw","/changepwprocess","/delete"
		,"/mypage","/updateinfo","/userlist"})
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
		
		if ("/login".equals(lastURI)) {
			request.getRequestDispatcher("/views/login/login.jsp").forward(request, response);
		}else if ("/loginprocess".equals(lastURI)) {
			String user_id = request.getParameter("user_id");
			String user_password = request.getParameter("user_password");
			LoginUserDTO loginUserDTO = userService.login(user_id,user_password);
			
			if(loginUserDTO != null) {
				request.getSession(true).setAttribute("loginUser", loginUserDTO);
				request.getSession().setMaxInactiveInterval(60*60*24);
				response.sendRedirect("/welcome");
			}else {
				request.setAttribute("result", "실패");
				request.getRequestDispatcher("/views/login/login.jsp").forward(request, response);
			}
		}else if("/agreement".equals(lastURI)) {
			request.getRequestDispatcher("/views/login/agreement.jsp").forward(request, response);
		}else if ("/join".equals(lastURI)) {
			request.getRequestDispatcher("/views/login/join.jsp").forward(request, response);
		}else if("/joinprocess".equals(lastURI)) {
			String user_id = request.getParameter("user_id");
			String user_password = request.getParameter("user_password");
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			String user_phone = request.getParameter("user_phone");
			String user_postcode = request.getParameter("user_postcode");
			String user_address = request.getParameter("user_address");
			String user_detail_address = request.getParameter("user_detail_address");
			
			UserDTO dto = new UserDTO();
			dto.setUserID(user_id);
			dto.setUserPassword(user_password);
			dto.setUserName(user_name);
			dto.setUserEmail(user_email);
			dto.setUserPhone(user_phone);
			dto.setUserPostcode(user_postcode);
			dto.setUserAddress(user_address);
			dto.setUserDetailAddress(user_detail_address);
			
			boolean result = userService.join(dto);
			request.setAttribute("result", result);
			request.getRequestDispatcher("/views/login/joinresult.jsp").forward(request, response);
		} else if ("/checkid".equals(lastURI)) {
			String user_id = request.getParameter("user_id");
			boolean result = userService.checkid(user_id);
			response.getWriter().print(result);
		} else if ("/logout".equals(lastURI)) {
			request.getSession().invalidate();
			response.sendRedirect("/welcome");
		}  else if ("/findid".equals(lastURI)) {
			request.getRequestDispatcher("/views/login/findid.jsp").forward(request, response);
		} else if ("/findidprocess".equals(lastURI)) {
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			String user_id = userService.findid(user_name, user_email);
			request.setAttribute("user_id", user_id);
			request.getRequestDispatcher("/views/login/findidresult.jsp").forward(request, response);
		} else if ("/findpw".equals(lastURI)) {
			request.getRequestDispatcher("/views/login/findpw.jsp").forward(request, response);
		} else if ("/changepw".equals(lastURI)) {
			request.getRequestDispatcher("/views/login/changepw.jsp").forward(request, response);
		} else if ("/changepwprocess".equals(lastURI)) {
			String user_id = request.getParameter("user_id");
			String user_password = request.getParameter("user_password");
			boolean result = userService.changepw(user_id, user_password);
			request.setAttribute("result", result);
			request.getRequestDispatcher("/views/login/changepwresult.jsp").forward(request, response);
		} else if ("/delete".equals(lastURI)) {
			LoginUserDTO loginUserDTO = (LoginUserDTO)request.getSession().getAttribute("loginUser");
			String user_id = (String)loginUserDTO.getUserID();
			boolean result = userService.delete(user_id);
			request.setAttribute("result", result);
			request.getRequestDispatcher("/views/login/deleteresult.jsp").forward(request, response);
		} else if ("/mypage".equals(lastURI)) {
			LoginUserDTO loginUserDTO = (LoginUserDTO)request.getSession().getAttribute("loginUser");
			String user_id = (String)loginUserDTO.getUserID();
			UserDTO user = userService.getinfo(user_id);
			String ID = user.getUserID();
			String Password = user.getUserPassword();
			String Name = user.getUserName();
			String Email = user.getUserEmail();
			String Phone = user.getUserPhone();
			String Postcode = user.getUserPostcode();
			String Address = user.getUserAddress();
			String DetailAddress = user.getUserDetailAddress();
			
			request.setAttribute("ID", ID);
			request.setAttribute("Password", Password);
			request.setAttribute("Name", Name);
			request.setAttribute("Email", Email);
			request.setAttribute("Phone", Phone);
			request.setAttribute("Postcode", Postcode);
			request.setAttribute("Address", Address);
			request.setAttribute("DetailAddress", DetailAddress);
			request.getRequestDispatcher("/views/login/mypage.jsp").forward(request, response);
			
		} else if ("/updateinfo".equals(lastURI)) {
			String user_id = request.getParameter("user_id");
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			String user_phone = request.getParameter("user_phone");
			String user_postcode = request.getParameter("user_postcode");
			String user_address = request.getParameter("user_address");
			String user_detail_address = request.getParameter("user_detail_address");
			
			boolean result = userService.updateinfo(user_id, user_name, user_email, user_phone, user_postcode,
					user_address, user_detail_address);
			
			request.setAttribute("result", result);
			request.getRequestDispatcher("/views/login/updateinforesult.jsp").forward(request, response);
			
		} else if ("/userlist".equals(lastURI)) {
			int cnt = userService.getusercount();
			int pageSize = 10;
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null) {
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			ArrayList<UserDTO> list = userService.userlist(startRow,pageSize);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("cnt", cnt);
			request.setAttribute("list", list);
			request.getRequestDispatcher("/views/admin/user/userlist.jsp").forward(request, response);			
		}
			
	}

}
