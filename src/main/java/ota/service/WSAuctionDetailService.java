package ota.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import ota.model.dao.BiddingDAO;
import ota.model.dto.BiddingDTO;

import java.io.IOException;
import java.text.SimpleDateFormat;



@ServerEndpoint("/wsAuctionDetail")
public class WSAuctionDetailService {
	private static Map<Session,Integer> clients = new HashMap<>();
	
	@OnOpen
	public void onOpen(Session session) {
		System.out.println("클라이언트가 연결되었습니다.");
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {
		// JSON 파싱
	    JSONParser parser = new JSONParser();
	    try {
	        JSONObject bidRequest = (JSONObject) parser.parse(message);
	        int wsInit = Integer.parseInt(Optional.ofNullable((String)bidRequest
	        		.get("wsInit")).orElse("0"));
	       
	        int auctionId = Integer.parseInt((String) bidRequest.get("auctionId"));
	        
	        if(wsInit == 1){//초기화과정이면(session,auctionId 입력)
	        	clients.put(session, auctionId);
	        	System.out.println("웹소켓 세션 초기화 완료");
	        	return;
	        }
	        
	        int bid = Integer.parseInt((String) bidRequest.get("bid"));
	        String userId = (String) bidRequest.get("userId");

	        BiddingDTO biddingDTO = new BiddingDTO();
	        biddingDTO.setBidding_bid(bid);
	        biddingDTO.setUser_user_id(userId);
	        biddingDTO.setAuction_auction_id(auctionId);

	        BiddingDAO biddingDAO = new BiddingDAO();
	        int result = biddingDAO.insertBid(biddingDTO);

	        // 클라이언트에 응답 전송
	        JSONObject response = new JSONObject();
	        response.put("success", result > 0);

	        
	        // 리스폰스에 담아서 주면 원래 있던 애들이 다 사라지는듯?
	        // 그리고 auctionDetail.jsp 에서 받을때 아예 biddingDTOList를 10개 채우게 빈 값으로 주든가 해야댈듯
	        if (result > 0) {
	            // 입찰 성공 시 입찰 목록을 가져와서 클라이언트에 전송
	            List<BiddingDTO> biddingList = biddingDAO.selectListBidding(auctionId);
	            response.put("loginUserId",userId);//로그인유저 체크용
	            response.put("biddingList", convertBiddingListToJSON(biddingList));
	        }
	        
	        for (Session key : clients.keySet()) {
	        	if(clients.get(key).equals(auctionId)) {//순회한 value랑 가져온 옥션아이디가 같으면 보내줌
	        		key.getBasicRemote().sendText(response.toJSONString());
	        	}
	        }

	    } catch (ParseException | IOException e) {
	        e.printStackTrace();
	    }
		
		
//		// if message > 현재 최고 입찰가
//		System.out.println("[클라이언트 메세지] " + message);
//		String serverMessage = "echo " + message;
//		System.out.println("서버가 보내는 메세지 : " + serverMessage);
//		
//		// 모든 클라이언트에게 메시지 전송
//        for (Session client : clients) {
//            if (client != session && client.isOpen()) {
//                client.getAsyncRemote().sendText(message);
//            }
//        }
//		
////		return serverMessage;
	}
	
	// 입찰 목록을 JSON 배열로 변환하는 메서드
	private JSONArray convertBiddingListToJSON(List<BiddingDTO> biddingList) {
	    JSONArray jsonArray = new JSONArray();
	    for (BiddingDTO bidding : biddingList) {
	        JSONObject jsonObject = new JSONObject();
	        jsonObject.put("userId", bidding.getUser_user_id());
	        jsonObject.put("bid", bidding.getBidding_bid());
			String bidDate = new SimpleDateFormat("yyyy-MM-dd HH시mm분ss초")
					.format(bidding.getBidding_biddate());
	        jsonObject.put("bidDate", bidDate);
	        jsonArray.add(jsonObject);
	    }
	    return jsonArray;
	}
	
	@OnClose
	public void onClose(Session session) {
        clients.remove(session);
		System.out.println("클라이언트와 연결이 끊어졌습니다...");
	}
	
	@OnError
	public void onError(Throwable error) {
		error.printStackTrace();
	}
}
