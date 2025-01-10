package ota.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ota.common.DBConnection;
import ota.error.CustomException;
import ota.error.type.NoticeError;
import ota.model.dto.AuctionDTO;
import ota.model.dto.AuctionImgDTO;
import ota.model.dto.NoticeDto;

import static ota.common.DBConnection.*;
public class MainDao {

	public List<NoticeDto> noticeList() {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<NoticeDto> noticeList = new ArrayList<NoticeDto>();
		String query = "select notice_id, notice_title "
				+ " from notice "
				+ " order by notice_id desc "
				+ " limit 5";
		try {
			pstmt =conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				NoticeDto noticeDto = new NoticeDto();
				noticeDto.setNoticeId(rset.getInt(1));
				noticeDto.setNoticeTitle(rset.getString(2));
				
				noticeList.add(noticeDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}

		return noticeList;
	}

	public List<AuctionDTO> highPriceAuctionList() {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<AuctionDTO> highPriceAuctionList = new ArrayList<AuctionDTO>();
		String query = "select auction_id, auction_title, datediff(now(),auction_enddate) as enddatediff,"
				+ " max(bidding_bid), auction_enddate, auction_view"
				+ " from bidding"
				+ " left join auction on bidding.auction_auction_id=auction.auction_id"
				+ " group by auction_id"
				+ " having enddatediff <= 0"
				+ " order by max(bidding_bid) desc"
				+ " limit 5";
		try {
			pstmt =conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				AuctionDTO auctionDTO = new AuctionDTO();
				
				auctionDTO.setAuction_id(rset.getInt(1));
				auctionDTO.setAuction_title(rset.getString(2));
				auctionDTO.setAuction_startingbid(rset.getInt(4));//최고입찰가인데 담을곳 없어서 사용...
				auctionDTO.setAuction_enddate(rset.getTimestamp(5));
				auctionDTO.setAuction_view(rset.getInt(6));
				
				highPriceAuctionList.add(auctionDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}

		return highPriceAuctionList;
	}

	public List<AuctionDTO> popularAuctionList() {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<AuctionDTO> popularAuctionList = new ArrayList<AuctionDTO>();
		String query = "select auction_id,auction_title,auction_view, datediff(now(),auction_enddate) as enddatediff,"
				+ " auction_startingbid, max(bidding_bid), auction_enddate"
				+ " from auction"
				+ " left join bidding on auction.auction_id=bidding.auction_auction_id"
				+ " group by auction_id"
				+ " having enddatediff <= 0"
				+ " order by auction_view desc"
				+ " limit 5";
		try {
			pstmt =conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				AuctionDTO auctionDTO = new AuctionDTO();
				
				auctionDTO.setAuction_id(rset.getInt(1));
				auctionDTO.setAuction_title(rset.getString(2));
				auctionDTO.setAuction_view(rset.getInt(3));
				if(rset.getInt(6) == 0) {//입찰된 가격이 없으면..
					auctionDTO.setAuction_startingbid(rset.getInt(5));//시작입찰가로 담는다
				}else {
					auctionDTO.setAuction_startingbid(rset.getInt(6));//최고 입찰가로 담는다
				}
				auctionDTO.setAuction_enddate(rset.getTimestamp(7));
				
				popularAuctionList.add(auctionDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}

		return popularAuctionList;
	}

	public AuctionDTO highPriceAuction() {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		AuctionDTO highPriceAuction = new AuctionDTO();
		String query = "select auction_id, auction_title, datediff(now(),auction_enddate) as enddatediff,"
				+ " max(bidding_bid),auction_content, auction_enddate, auction_view"
				+ " from bidding"
				+ " left join auction on bidding.auction_auction_id=auction.auction_id"
				+ " group by auction_id"
				+ " having enddatediff <= 0"
				+ " order by max(bidding_bid) desc"
				+ " limit 1";
		
		String query2 = "select auction_imgs_new_name, auction_imgs_webdir from auction_imgs"
				+ " where auction_auction_id = ?";
		try {
			pstmt =conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			int auction_id = 0;
			if (rset.next()) {
				auction_id = rset.getInt(1);
				highPriceAuction.setAuction_id(rset.getInt(1));
				highPriceAuction.setAuction_title(rset.getString(2));
				highPriceAuction.setAuction_startingbid(rset.getInt(4));
				highPriceAuction.setAuction_content(rset.getString(5));
				highPriceAuction.setAuction_enddate(rset.getTimestamp(6));
				highPriceAuction.setAuction_view(rset.getInt(7));
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
				highPriceAuction.setAuctionImgDTOList(auctionImgDTOs);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}

		return highPriceAuction;
	}

	public int getHighPrice(int auctionId) {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		String query = "select max(bidding_bid)"
				+ " from bidding"
				+ " where auction_auction_id=?";
		try {
			pstmt =conn.prepareStatement(query);
			pstmt.setInt(1, auctionId);
			rset = pstmt.executeQuery();
			
			if (rset.next()) {
				result = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}

		return result;
	}

}
