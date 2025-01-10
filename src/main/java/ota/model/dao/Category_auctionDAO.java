package ota.model.dao;

import static ota.common.DBConnection.close;
import static ota.common.DBConnection.getConnection;
import ota.model.dto.Category_auctionDTO;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

public class Category_auctionDAO {
	
	public int getCategoryListCount() {
		int categoryCount = 0;
		String query = "SELECT COUNT(*) FROM category_auction";
		
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			rset.next();
			
			categoryCount = rset.getInt(1);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return categoryCount;
	}
	
	public List<Category_auctionDTO> categoryList() {
		String query = "SELECT * FROM category_auction ORDER BY category_auction_id";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		List<Category_auctionDTO> categoryList = new Vector<Category_auctionDTO>();
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Category_auctionDTO dto = new Category_auctionDTO();
				dto.setCategory_auction_id(rset.getInt("category_auction_id"));
				dto.setCategory_auction_name(rset.getString("category_auction_name"));
				categoryList.add(dto);
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
		return categoryList;
	}
	
	public List<String> categoryNameList(int auction_id) {
		String query = "SELECT category_auction_name"
				+ " FROM category_auction"
				+ " WHERE category_auction_id IN ("
				+ " SELECT category_auction_category_auction_id"
				+ " FROM auction_has_category_auction"
				+ " WHERE " + auction_id + " = auction_auction_id)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		List<String> categoryNameList = new Vector<String>();
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				categoryNameList.add(rset.getString("category_auction_name"));
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
		return categoryNameList;
	}
	
	public void insertAuctionCategory(int auctionId, int categoryId) {
        String query = "INSERT INTO auction_has_category_auction (auction_auction_id, category_auction_category_auction_id) VALUES (?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, auctionId);
            pstmt.setInt(2, categoryId);
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
            close(conn);
        }
    }
}
