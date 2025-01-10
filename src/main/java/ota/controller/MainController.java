package ota.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ota.model.dto.AuctionDTO;
import ota.model.dto.NoticeDto;
import ota.service.MainService;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class MainController
 */
@WebServlet(urlPatterns = {"/welcome","/welcome/auctionBid"})
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MainService mainService = new MainService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String requestURI = request.getRequestURI();
		String lastURI = requestURI.substring(requestURI.lastIndexOf("/"));
		if("/".equals(lastURI)) {
			getMainInfo(request);
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else if("/welcome".equals(lastURI)) {
			getMainInfo(request);
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else if("/auctionBid".equals(lastURI)) {
			int auctionId = Integer.parseInt(request.getParameter("auctionId"));
			int result = mainService.getHighPrice(auctionId);
			response.getWriter().print(result);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private void getMainInfo(HttpServletRequest request) {
		List<NoticeDto> noticeList = mainService.noticeList();
		List<AuctionDTO> highPriceAuctionList = mainService.highPriceAuctionList();
		List<AuctionDTO> popularAuctionList = mainService.popularAuctionList();
		AuctionDTO highPriceAuction = mainService.highPriceAuction();
	
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("highPriceAuctionList", highPriceAuctionList);
		request.setAttribute("popularAuctionList", popularAuctionList);
		request.setAttribute("highPriceAuction", highPriceAuction);
	}

}
