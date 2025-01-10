package ota.service;

import java.util.List;
import ota.model.dao.Category_auctionDAO;
import ota.model.dto.Category_auctionDTO;

public class Category_auctionService {
	public List<Category_auctionDTO> getCategoryList(){
		Category_auctionDAO dao = new Category_auctionDAO();
		
		return dao.categoryList();
		
	}
	
	
}
