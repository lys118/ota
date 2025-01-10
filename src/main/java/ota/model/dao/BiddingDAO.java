package ota.model.dao;

import static ota.common.DBConnection.close;
import static ota.common.DBConnection.getConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import ota.model.dto.BiddingDTO;

public class BiddingDAO {
	
	
	public List<BiddingDTO> selectListBidding(Map<String, String> map) {
		List<BiddingDTO> biddingDTOList = new Vector<BiddingDTO>();
		String query = "SELECT * FROM bidding";
		
		if(map != null && map.get("searchField") != null) {
			query += " WHERE " + map.get("searchField") + "=" + map.get("searchWord"); 
		}
		query += " ORDER BY bidding_id";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				BiddingDTO dto = new BiddingDTO();
				dto.setBidding_id(rset.getInt("bidding_id"));
				dto.setBidding_bid(rset.getInt("bidding_bid"));
				dto.setBidding_biddate(rset.getDate("bidding_biddate"));
				dto.setUser_user_id(rset.getString("user_user_id"));
				dto.setAuction_auction_id(rset.getInt("auction_auction_id"));
				
				biddingDTOList.add(dto);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	
		}
		finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return biddingDTOList;
	}
	
//	public List<BiddingDTO> selectListBidding(int auction_id) {
//		List<BiddingDTO> biddingDTOList = new Vector<BiddingDTO>();
//		String query = "SELECT * FROM bidding WHERE auction_auction_id = " + auction_id + " ORDER BY bidding_id LIMIT 10";
//		
//		Connection conn = getConnection();
//		PreparedStatement pstmt = null;
//		ResultSet rset = null;
//		
//		try {
//			pstmt = conn.prepareStatement(query);
//			rset = pstmt.executeQuery();
//			
//			while(rset.next()){
//				BiddingDTO dto = new BiddingDTO();
//				dto.setBidding_id(rset.getInt("bidding_id"));
//				dto.setBidding_bid(rset.getInt("bidding_bid"));
//				dto.setBidding_biddate(rset.getDate("bidding_biddate"));
//				dto.setUser_user_id(rset.getString("user_user_id"));
//				dto.setAuction_auction_id(rset.getInt("auction_auction_id"));
//				
//				biddingDTOList.add(dto);
//			}
//		}
//		catch (SQLException e) {
//			e.printStackTrace();	
//		}
//		finally {
//			close(rset);
//			close(pstmt);
//			close(conn);
//		}
//		return biddingDTOList;
//	}
	
	public List<BiddingDTO> selectListBidding(int auctionId) {
	    List<BiddingDTO> biddingDTOList = new ArrayList<>();
	    String query = "SELECT * FROM bidding WHERE auction_auction_id = ? ORDER BY bidding_bid DESC LIMIT 10";

	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        pstmt.setInt(1, auctionId);
	        ResultSet rset = pstmt.executeQuery();
	        
	        while (rset.next()) {
	            BiddingDTO dto = new BiddingDTO();
	            dto.setBidding_id(rset.getInt("bidding_id"));
	            dto.setBidding_bid(rset.getInt("bidding_bid"));
	            dto.setBidding_biddate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
	            		.parse(rset.getString("bidding_biddate")));
	            dto.setUser_user_id(rset.getString("user_user_id"));
	            dto.setAuction_auction_id(rset.getInt("auction_auction_id"));
	            biddingDTOList.add(dto);
	        }
	    }catch (ParseException e) {
	    	e.printStackTrace();
	    }catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return biddingDTOList;
	}
	
	public Map<Integer, Integer> selectHighestBid(List<Integer> auction_idList) {
		Map<Integer, Integer> highestBidMap = new HashMap<Integer, Integer>();
		String baseQuery = "SELECT MAX(bidding_bid) FROM bidding";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		try {
			for(int auction_id : auction_idList) {
				String query = baseQuery + " WHERE auction_auction_id = " + auction_id;
				pstmt = conn.prepareStatement(query);
				rset = pstmt.executeQuery();
				rset.next();
				highestBidMap.put(auction_id, rset.getInt(1));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	
		}
		finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return highestBidMap;
	}
	
	// auctionDetail.jsp에서 입찰 버튼을 눌렀을 때, user_id, bid, bidding_date가 INSERT돼야댐
	public int insertBid(BiddingDTO dto) {
		int result = 0;
		String query = "INSERT INTO bidding ("
//				+ " bidding_id,"
				+ " bidding_bid,"
				+ " bidding_biddate,"
				+ " user_user_id,"
				+ " auction_auction_id)"
				+ " VALUES("
				+ " ?, now(), ?, ?)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, dto.getBidding_bid());
			pstmt.setString(2, dto.getUser_user_id());
			pstmt.setInt(3, dto.getAuction_auction_id());
			
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();	
		}
		finally {
			close(pstmt);
			close(conn);
		}
		return result;
	}
}
