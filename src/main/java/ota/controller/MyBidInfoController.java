package ota.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ota.model.dto.MyBidInfoDTO;
import ota.service.MyBidInfoService;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class TestController
 */
@WebServlet("/user/bidInfo")
public class MyBidInfoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MyBidInfoService myBidInfoService = new MyBidInfoService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		//List<MyBidInfoDTO> myBidInfoDTO = myBidInfoService.getMyBidInfo(userId);
		request.getRequestDispatcher("/views/test/myBidInfo.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
