package ota.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

//import com.mysql.cj.xdevapi.Statement;

import ota.model.dto.AuctionDTO;
import ota.model.dto.AuctionImgDTO;

import static ota.common.DBConnection.*;

// DAO에는 create read update delete 기능이 포함되어야 한다!
// CRUD를 구현하자!
public class AuctionDAO{
	
	// 경매 물품 총 합계
	public int selectCountAuction(Map<String, Object> map) {
		int auctionCount = 0;
		String query = "SELECT count(*) FROM auction";
		
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			// 결과가 count(*) 한 줄 일테니까 next()를 한 번 해주는건가?
			rset.next();
			
			auctionCount = rset.getInt(1);
			
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return auctionCount;
	}
	
	// 경매 물품 검색할 때 쓰일 예정
	// map의 { KEY:searchField, VALUE:searchWord } 중 KEY의 필드를 대상으로 VALUE값을 갖는 레코드 검색.
	public List<AuctionDTO> selectListAuction(Map<String, Object> map) {
		List<AuctionDTO> auctionDTOList = new Vector<AuctionDTO>();
		String query = "SELECT * FROM auction";
		
		if(!map.isEmpty() && map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		query += " ORDER BY auction_id DESC ";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				AuctionDTO dto = new AuctionDTO();
				
				dto.setAuction_id(rset.getInt("auction_id"));
				dto.setAuction_title(rset.getString("auction_title"));
				dto.setAuction_content(rset.getString("auction_content"));
				dto.setAuction_img(rset.getString("auction_img"));
				dto.setAuction_postdate(rset.getTimestamp("auction_postdate"));
				dto.setAuction_startingbid(rset.getInt("auction_startingbid"));
				dto.setAuction_startingdate(rset.getTimestamp("auction_startingdate"));
				dto.setAuction_enddate(rset.getTimestamp("acution_enddate"));
				dto.setAuction_view(rset.getInt("auction_view"));
				dto.setAuction_winner(rset.getString("auction_winner"));
				dto.setUser_user_id(rset.getString("user_user_id"));
				
				auctionDTOList.add(dto);
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
		return auctionDTOList;
	}
	
	public List<AuctionDTO> selectListAuction() {
		List<AuctionDTO> auctionDTOList = new Vector<AuctionDTO>();
		String query = "SELECT * FROM auction";
		
		query += " ORDER BY auction_id DESC ";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				AuctionDTO dto = new AuctionDTO();
				
				dto.setAuction_id(rset.getInt("auction_id"));
				dto.setAuction_title(rset.getString("auction_title"));
				dto.setAuction_content(rset.getString("auction_content"));
				dto.setAuction_img(rset.getString("auction_img"));
				dto.setAuction_postdate(rset.getTimestamp("auction_postdate"));
				dto.setAuction_startingbid(rset.getInt("auction_startingbid"));
				dto.setAuction_startingdate(rset.getTimestamp("auction_startingdate"));
				dto.setAuction_enddate(rset.getTimestamp("auction_enddate"));
				dto.setAuction_view(rset.getInt("auction_view"));
				dto.setAuction_winner(rset.getString("auction_winner"));
				dto.setUser_user_id(rset.getString("user_user_id"));
				
				auctionDTOList.add(dto);
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
		return auctionDTOList;
	}
	
	public int insertAuction(AuctionDTO auctionDTO) {
        String query = "INSERT INTO auction (auction_title, auction_content, auction_startingbid, auction_startingdate, auction_enddate, user_user_id, auction_img, auction_postdate, auction_view) VALUES (?, ?, ?, ?, ?, ?, 'img.png', now(), 1)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int auctionId = -1;
        
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, auctionDTO.getAuction_title());
            pstmt.setString(2, auctionDTO.getAuction_content());
            pstmt.setInt(3, auctionDTO.getAuction_startingbid());
            pstmt.setTimestamp(4, auctionDTO.getAuction_startingdate());
            pstmt.setTimestamp(5, auctionDTO.getAuction_enddate());
            
            String userId = auctionDTO.getUser_user_id();
            if (userId == null || userId.trim().isEmpty()) {
                throw new SQLException("User ID cannot be null or empty");
            }
            pstmt.setString(6, userId);
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    auctionId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        
        return auctionId;
    }

    public void insertAuctionImage(AuctionImgDTO imgDTO) {
        String query = "INSERT INTO auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id) VALUES (?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, imgDTO.getAuction_imgs_origin_name());
            pstmt.setString(2, imgDTO.getAuction_imgs_new_name());
            pstmt.setString(3, imgDTO.getAuction_imgs_webdir());
            pstmt.setInt(4, imgDTO.getAuction_auction_id());
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
            close(conn);
        }
    }
	
	// 경매 물품 등록할 때 쓰일 예정
//	public int insertAuction(AuctionDTO dto) {
//		int result = 0;
//		String query = "INSERT INTO auction ("
//				+ " auction_id,"
//				+ " auction_title,"
//				+ " auction_content,"
//				+ " auction_img,"
//				+ " auction_postdate,"
//				+ " auction_startingbid,"
//				+ " auction_startingdate,"
//				+ " auction_enddate,"
//				+ " auction_view,"
//				+ " auction_winner,"
//				+ " user_user_id)"
//				+ " VALUES("
//				+ "seq_auction_auction_id.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?";
//		
//		Connection conn = getConnection();
//		PreparedStatement pstmt = null;
//		
//		try {
//			pstmt = conn.prepareStatement(query);
//			pstmt.setString(1, dto.getAuction_title());
//			pstmt.setString(2, dto.getAuction_content());
//			pstmt.setString(3, dto.getAuction_img());
//			pstmt.setTimestamp(4, dto.getAuction_postdate());
//			pstmt.setInt(5, dto.getAuction_startingbid());
//			pstmt.setTimestamp(6, dto.getAuction_startingdate());
//			pstmt.setTimestamp(7, dto.getAuction_enddate());
//			pstmt.setInt(8, dto.getAuction_view());
//			pstmt.setString(9, dto.getAuction_winner());
//			pstmt.setString(10, dto.getUser_user_id());
//			
//			result = pstmt.executeUpdate();
//		}
//		catch (SQLException e) {
//			e.printStackTrace();
//		}
//		finally {
//			close(pstmt);
//			close(conn);
//		}
//		return result;
//	}
	
	// 등록된 경매 물품 삭제할 때 쓰일 예정
	public int deleteAuction(int acution_id) {
		int result = 0;
		String query = "DELETE FROM auction WHERE auction_id = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, acution_id);
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
	
	// 나중에 상황봐서 수정 필요..
	public int updateAuction(AuctionDTO dto) {
		int result = 0;
		String query = "UPDATE auction SET"
				+ " auction_id = ?,"
				+ " auction_title = ?,"
				+ " auction_content = ?,"
				+ " auction_img = ?,"
				+ " auction_postdate = ?,"
				+ " auction_startingbid = ?,"
				+ " auction_startingdate = ?,"
				+ " auction_enddate = ?,"
				+ " auction_view = ?,"
				+ " auction_winner = ?"
				+ " user_user_id = ?"
				+ " WHERE acution_id = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			
			// update대상 field의 type이 date, int, String 중 하나인데...
			// 특정 지어야 할 상황이 왔다...
			// 해결법: DB를 뜯어고치자, if문을 쓰자, DTO를 받자
			pstmt.setInt(1, dto.getAuction_id());
			pstmt.setString(2, dto.getAuction_title());
			pstmt.setString(3, dto.getAuction_content());
			pstmt.setString(4, dto.getAuction_img());
			pstmt.setTimestamp(5, dto.getAuction_postdate());
			pstmt.setInt(6, dto.getAuction_startingbid());
			pstmt.setTimestamp(7, dto.getAuction_startingdate());
			pstmt.setTimestamp(8, dto.getAuction_enddate());
			pstmt.setInt(9, dto.getAuction_view());
			pstmt.setString(10, dto.getAuction_winner());
			pstmt.setString(11, dto.getUser_user_id());
			pstmt.setInt(12, dto.getAuction_id());
			
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
	
	public List<Integer> selectAllAuction_idList() {
		List<Integer> auction_idList = new Vector<Integer>();
		String query = "SELECT auction_id FROM auction";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				auction_idList.add(rset.getInt(1));
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
		return auction_idList;
	}
	
	public String selectTitleOfAuction_id(int auction_id) {
		String title = "";
		String query = "SELECT auction_title FROM auction"
				+ " WHERE auction_id = " + auction_id;
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			rset.next();
			title = rset.getString("auction_title");
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return title;
	}
	
	public AuctionDTO selectAuctionDTO(int auction_id) {
		AuctionDTO auctionDTO = new AuctionDTO();
		String query = "SELECT * FROM auction WHERE auction_id = " + auction_id;
		
		String query2 = "select auction_imgs_new_name, auction_imgs_webdir from auction_imgs where auction_auction_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				auctionDTO.setAuction_id(auction_id);
				auctionDTO.setAuction_title(rset.getString("auction_title"));
				auctionDTO.setAuction_content(rset.getString("auction_content"));
				auctionDTO.setAuction_img(rset.getString("auction_img"));
				auctionDTO.setAuction_postdate(rset.getTimestamp("auction_postdate"));
				auctionDTO.setAuction_startingbid(rset.getInt("auction_startingbid"));
				auctionDTO.setAuction_startingdate(rset.getTimestamp("auction_startingdate"));
				auctionDTO.setAuction_enddate(rset.getTimestamp("auction_enddate"));
				auctionDTO.setAuction_view(rset.getInt("auction_view"));
				auctionDTO.setAuction_winner(rset.getString("auction_winner"));
				auctionDTO.setUser_user_id(rset.getString("user_user_id"));
			}
			pstmt.clearParameters();
			pstmt = conn.prepareStatement(query2);
			pstmt.setInt(1, auction_id);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				AuctionImgDTO auctionImgDTO = new AuctionImgDTO();
				auctionImgDTO.setAuction_imgs_new_name(rset.getString(1));
				auctionImgDTO.setAuction_imgs_webdir(rset.getString(2));
				
				List<AuctionImgDTO> auctionImgDTOs = new ArrayList<>();
				auctionImgDTOs.add(auctionImgDTO);
				auctionDTO.setAuctionImgDTOList(auctionImgDTOs);
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
		return auctionDTO;
	}
	
	public Map<Integer, AuctionDTO> selectAllAuctionDTOMap() {
		Map<Integer, AuctionDTO> allAuctionDTOMap = new HashMap<Integer, AuctionDTO>();
		String query = "SELECT * FROM auction";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				AuctionDTO auctionDTO = new AuctionDTO();
				
				auctionDTO.setAuction_id(rset.getInt("auction_id"));
				auctionDTO.setAuction_title(rset.getString("auction_title"));
				auctionDTO.setAuction_content(rset.getString("auction_content"));
				auctionDTO.setAuction_img(rset.getString("auction_img"));
				auctionDTO.setAuction_postdate(rset.getTimestamp("auction_postdate"));
				auctionDTO.setAuction_startingbid(rset.getInt("auction_startingbid"));
				auctionDTO.setAuction_startingdate(rset.getTimestamp("auction_startingdate"));
				auctionDTO.setAuction_enddate(rset.getTimestamp("auction_enddate"));
				auctionDTO.setAuction_view(rset.getInt("auction_view"));
				auctionDTO.setAuction_winner(rset.getString("auction_winner"));
				auctionDTO.setUser_user_id(rset.getString("user_user_id"));
				
				allAuctionDTOMap.put(rset.getInt("auction_id"), auctionDTO);
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
		return allAuctionDTOMap;
	}
	
	public Map<Integer, AuctionDTO> selectAuctionDTOMapByCategory(int categoryId) {
        Map<Integer, AuctionDTO> filteredAuctionDTOMap = new HashMap<>();
        String query = "SELECT a.* FROM auction a " +
                       "JOIN auction_has_category_auction ahca ON a.auction_id = ahca.auction_auction_id " +
                       "WHERE ahca.category_auction_category_auction_id = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                AuctionDTO auctionDTO = new AuctionDTO();
                auctionDTO.setAuction_id(rs.getInt("auction_id"));
                auctionDTO.setAuction_title(rs.getString("auction_title"));
                auctionDTO.setAuction_content(rs.getString("auction_content"));
                auctionDTO.setAuction_img(rs.getString("auction_img"));
                auctionDTO.setAuction_postdate(rs.getTimestamp("auction_postdate"));
                auctionDTO.setAuction_startingbid(rs.getInt("auction_startingbid"));
                auctionDTO.setAuction_startingdate(rs.getTimestamp("auction_startingdate"));
                auctionDTO.setAuction_enddate(rs.getTimestamp("auction_enddate"));
                auctionDTO.setAuction_view(rs.getInt("auction_view"));
                auctionDTO.setAuction_winner(rs.getString("auction_winner"));
                auctionDTO.setUser_user_id(rs.getString("user_user_id"));
                
                filteredAuctionDTOMap.put(auctionDTO.getAuction_id(), auctionDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        
        return filteredAuctionDTOMap;
    }
	
	public Map<Integer, AuctionImgDTO> selectAllAuctionImgMap() {
        Map<Integer, AuctionImgDTO> auctionImgMap = new HashMap<>();
        String query = "SELECT * FROM auction_imgs";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                AuctionImgDTO imgDTO = new AuctionImgDTO();
                imgDTO.setAuction_imgs_id(rs.getInt("auction_imgs_id"));
                imgDTO.setAuction_imgs_origin_name(rs.getString("auction_imgs_origin_name"));
                imgDTO.setAuction_imgs_new_name(rs.getString("auction_imgs_new_name"));
                imgDTO.setAuction_imgs_webdir(rs.getString("auction_imgs_webdir"));
                imgDTO.setAuction_auction_id(rs.getInt("auction_auction_id"));
                
                auctionImgMap.put(imgDTO.getAuction_auction_id(), imgDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return auctionImgMap;
    }
	
	public Map<Integer, AuctionImgDTO> selectAuctionImgMapByCategory(int categoryId) {
        Map<Integer, AuctionImgDTO> auctionImgMap = new HashMap<>();
        String query = "SELECT ai.* FROM auction_imgs ai " +
                       "JOIN auction_has_category_auction ahca ON ai.auction_auction_id = ahca.auction_auction_id " +
                       "WHERE ahca.category_auction_category_auction_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, categoryId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    AuctionImgDTO imgDTO = new AuctionImgDTO();
                    imgDTO.setAuction_imgs_id(rs.getInt("auction_imgs_id"));
                    imgDTO.setAuction_imgs_origin_name(rs.getString("auction_imgs_origin_name"));
                    imgDTO.setAuction_imgs_new_name(rs.getString("auction_imgs_new_name"));
                    imgDTO.setAuction_imgs_webdir(rs.getString("auction_imgs_webdir"));
                    imgDTO.setAuction_auction_id(rs.getInt("auction_auction_id"));
                    
                    auctionImgMap.put(imgDTO.getAuction_auction_id(), imgDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return auctionImgMap;
    }
	
	public Map<Integer, AuctionDTO> searchAuctions(String searchField, String searchWord) {
        Map<Integer, AuctionDTO> searchedAuctionDTOMap = new HashMap<>();
        String query = "SELECT * FROM auction WHERE ";
        
        if ("title".equals(searchField)) {
            query += "auction_title LIKE ?";
        } else if ("content".equals(searchField)) {
            query += "auction_content LIKE ?";
        } else if ("userName".equals(searchField)) {
            query += "user_user_id LIKE ?";
        } else {
            // 기본적으로 제목으로 검색
            query += "auction_title LIKE ?";
        }
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, "%" + searchWord + "%");
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    AuctionDTO auctionDTO = new AuctionDTO();
                    // ResultSet에서 AuctionDTO 객체로 데이터 매핑
                    auctionDTO.setAuction_id(rs.getInt("auction_id"));
                    auctionDTO.setAuction_title(rs.getString("auction_title"));
                    // 다른 필드들도 설정...
                    
                    searchedAuctionDTOMap.put(auctionDTO.getAuction_id(), auctionDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return searchedAuctionDTOMap;
    }
	
	public Map<Integer, AuctionImgDTO> selectAuctionImgMapByIds(List<Integer> auctionIds) {
        Map<Integer, AuctionImgDTO> auctionImgMap = new HashMap<>();
        if (auctionIds.isEmpty()) {
            return auctionImgMap;
        }

        String placeholders = String.join(",", Collections.nCopies(auctionIds.size(), "?"));
        String query = "SELECT * FROM auction_imgs WHERE auction_auction_id IN (" + placeholders + ")";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            for (int i = 0; i < auctionIds.size(); i++) {
                pstmt.setInt(i + 1, auctionIds.get(i));
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    AuctionImgDTO imgDTO = new AuctionImgDTO();
                    imgDTO.setAuction_imgs_id(rs.getInt("auction_imgs_id"));
                    imgDTO.setAuction_imgs_origin_name(rs.getString("auction_imgs_origin_name"));
                    imgDTO.setAuction_imgs_new_name(rs.getString("auction_imgs_new_name"));
                    imgDTO.setAuction_imgs_webdir(rs.getString("auction_imgs_webdir"));
                    imgDTO.setAuction_auction_id(rs.getInt("auction_auction_id"));
                    
                    auctionImgMap.put(imgDTO.getAuction_auction_id(), imgDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return auctionImgMap;
    }
}
