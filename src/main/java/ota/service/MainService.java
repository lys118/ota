package ota.service;

import java.util.List;

import ota.model.dao.MainDao;
import ota.model.dto.AuctionDTO;
import ota.model.dto.NoticeDto;

public class MainService {
	MainDao mainDao = new MainDao();
	public List<NoticeDto> noticeList() {
		return mainDao.noticeList();
	}
	public List<AuctionDTO> highPriceAuctionList() {
		return mainDao.highPriceAuctionList();
	}
	public List<AuctionDTO> popularAuctionList() {
		return mainDao.popularAuctionList();
	}
	public AuctionDTO highPriceAuction() {
		return mainDao.highPriceAuction();
	}
	public int getHighPrice(int auctionId) {
		return mainDao.getHighPrice(auctionId);
	}
	
}
