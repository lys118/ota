package ota.model.dto;

public class BiddingDTO {
	private int bidding_id;
	private int bidding_bid;
	private java.util.Date bidding_biddate;
	private String user_user_id;
	private int auction_auction_id;
	
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
	public java.util.Date getBidding_biddate() {
		return bidding_biddate;
	}
	public void setBidding_biddate(java.util.Date bidding_biddate) {
		this.bidding_biddate = bidding_biddate;
	}
	public String getUser_user_id() {
		return user_user_id;
	}
	public void setUser_user_id(String user_user_id) {
		this.user_user_id = user_user_id;
	}
	public int getAuction_auction_id() {
		return auction_auction_id;
	}
	public void setAuction_auction_id(int auction_auction_id) {
		this.auction_auction_id = auction_auction_id;
	}
}
