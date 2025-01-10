package ota.model.dto;

import java.util.List;
import java.sql.Timestamp;

public class AuctionDTO {
	private int auction_id;
	private String auction_title;
	private String auction_content;
	private String auction_img;
	private Timestamp auction_postdate;
	private int auction_startingbid;
	private Timestamp auction_startingdate;
	private Timestamp auction_enddate;
	private int auction_view;
	private String auction_winner;
	private String user_user_id;
	private List<AuctionImgDTO> auctionImgDTOList;

	
	public int getAuction_id() {
		return auction_id;
	}
	public void setAuction_id(int auction_id) {
		this.auction_id = auction_id;
	}
	public String getAuction_title() {
		return auction_title;
	}
	public void setAuction_title(String auction_title) {
		this.auction_title = auction_title;
	}
	public String getAuction_content() {
		return auction_content;
	}
	public void setAuction_content(String auction_content) {
		this.auction_content = auction_content;
	}
	public String getAuction_img() {
		return auction_img;
	}
	public void setAuction_img(String auction_img) {
		this.auction_img = auction_img;
	}
	public Timestamp getAuction_postdate() {
		return auction_postdate;
	}
	public void setAuction_postdate(Timestamp auction_postdate) {
		this.auction_postdate = auction_postdate;
	}
	public int getAuction_startingbid() {
		return auction_startingbid;
	}
	public void setAuction_startingbid(int auction_startingbid) {
		this.auction_startingbid = auction_startingbid;
	}
	public Timestamp getAuction_startingdate() {
		return auction_startingdate;
	}
	public void setAuction_startingdate(Timestamp auction_startingdate) {
		this.auction_startingdate = auction_startingdate;
	}
	public Timestamp getAuction_enddate() {
		return auction_enddate;
	}
	public void setAuction_enddate(Timestamp auction_enddate) {
		this.auction_enddate = auction_enddate;
	}
	public int getAuction_view() {
		return auction_view;
	}
	public void setAuction_view(int auction_view) {
		this.auction_view = auction_view;
	}
	public String getAuction_winner() {
		return auction_winner;
	}
	public void setAuction_winner(String auction_winner) {
		this.auction_winner = auction_winner;
	}
	public String getUser_user_id() {
		return user_user_id;
	}
	public void setUser_user_id(String user_user_id) {
		this.user_user_id = user_user_id;
	}
	public List<AuctionImgDTO> getAuctionImgDTOList() {
		return auctionImgDTOList;
	}
	public void setAuctionImgDTOList(List<AuctionImgDTO> auctionImgDTOList) {
		this.auctionImgDTOList = auctionImgDTOList;
	}
}
