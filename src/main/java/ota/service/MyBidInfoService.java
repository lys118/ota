package ota.service;

import java.util.List;

import ota.model.dao.MyBidInfoDAO;
import ota.model.dto.MyBidInfoDTO;

public class MyBidInfoService {
	private MyBidInfoDAO myBidInfoDAO = new MyBidInfoDAO();
	
	public List<MyBidInfoDTO> getMyBidInfo(String userId) {
		return myBidInfoDAO.getMyBidInfo(userId);
	}

}
