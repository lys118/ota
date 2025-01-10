package ota.model.dto;

import java.sql.Date;

public class MyBidInfoDTO {
	private int auction_id;
	private String auction_title;
	private String auction_content;
	private String auction_img;
	private java.sql.Date auction_postdate;
	private int auction_startingbid;
	private java.sql.Date auction_startingdate;
	private java.sql.Date auction_enddate;
	private int auction_view;
	private String auction_winner;
	private String user_user_id;
	private int bidding_id;
	private int bidding_bid;
	private java.sql.Date bidding_biddate;
	
	public MyBidInfoDTO() {
	}

	public MyBidInfoDTO(int auction_id, String auction_title, String auction_content, String auction_img,
			Date auction_postdate, int auction_startingbid, Date auction_startingdate, Date auction_enddate,
			int auction_view, String auction_winner, String user_user_id, int bidding_id, int bidding_bid,
			Date bidding_biddate) {
		this.auction_id = auction_id;
		this.auction_title = auction_title;
		this.auction_content = auction_content;
		this.auction_img = auction_img;
		this.auction_postdate = auction_postdate;
		this.auction_startingbid = auction_startingbid;
		this.auction_startingdate = auction_startingdate;
		this.auction_enddate = auction_enddate;
		this.auction_view = auction_view;
		this.auction_winner = auction_winner;
		this.user_user_id = user_user_id;
		this.bidding_id = bidding_id;
		this.bidding_bid = bidding_bid;
		this.bidding_biddate = bidding_biddate;
	}

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

	public java.sql.Date getAuction_postdate() {
		return auction_postdate;
	}

	public void setAuction_postdate(java.sql.Date auction_postdate) {
		this.auction_postdate = auction_postdate;
	}

	public int getAuction_startingbid() {
		return auction_startingbid;
	}

	public void setAuction_startingbid(int auction_startingbid) {
		this.auction_startingbid = auction_startingbid;
	}

	public java.sql.Date getAuction_startingdate() {
		return auction_startingdate;
	}

	public void setAuction_startingdate(java.sql.Date auction_startingdate) {
		this.auction_startingdate = auction_startingdate;
	}

	public java.sql.Date getAuction_enddate() {
		return auction_enddate;
	}

	public void setAuction_enddate(java.sql.Date auction_enddate) {
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

	public int getBidding_id() {
		return bidding_id;
	}

	public void setBidding_id(int bidding_id) {
		this.bidding_id = bidding_id;
	}

	public int getBidding_bid() {
		return bidding_bid;
	}

	public void setBidding_bid(int bidding_bid) {
		this.bidding_bid = bidding_bid;
	}

	public java.sql.Date getBidding_biddate() {
		return bidding_biddate;
	}

	public void setBidding_biddate(java.sql.Date bidding_biddate) {
		this.bidding_biddate = bidding_biddate;
	}
	
	
	
	
}
