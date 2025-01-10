package ota.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import ota.model.dto.AuctionDTO;
import ota.model.dto.AuctionImgDTO;
import ota.model.dao.AuctionDAO;
import ota.model.dto.BiddingDTO;
import ota.model.dao.BiddingDAO;
import ota.model.dto.Category_auctionDTO;
import ota.model.dao.Category_auctionDAO;

public class AuctionService {
	private AuctionDAO auctionDAO = new AuctionDAO();
	private Category_auctionDAO category_auctionDAO = new Category_auctionDAO();
	
	public Map<String, Object> mainService() {
        BiddingDAO biddingDAO = new BiddingDAO();
        
        List<Category_auctionDTO> allCategoryDTOList = category_auctionDAO.categoryList();
        Map<Integer, AuctionDTO> allAuctionDTOMap = auctionDAO.selectAllAuctionDTOMap();
        Map<Integer, Integer> highestBidMap = biddingDAO.selectHighestBid(auctionDAO.selectAllAuction_idList());
        Map<Integer, AuctionImgDTO> auctionImgMap = auctionDAO.selectAllAuctionImgMap();
        
        Map<String, Object> mainServiceMap = new HashMap<>();
        mainServiceMap.put("allCategoryDTOList", allCategoryDTOList);
        mainServiceMap.put("allAuctionDTOMap", allAuctionDTOMap);
        mainServiceMap.put("highestBidMap", highestBidMap);
        mainServiceMap.put("auctionImgMap", auctionImgMap);
        
        return mainServiceMap;
    }
	
	public Map<String, Object> mainServiceByCategory(int categoryId) {
        BiddingDAO biddingDAO = new BiddingDAO();
        
        List<Category_auctionDTO> allCategoryDTOList = category_auctionDAO.categoryList();
        Map<Integer, AuctionDTO> filteredAuctionDTOMap = auctionDAO.selectAuctionDTOMapByCategory(categoryId);
        Map<Integer, Integer> highestBidMap = biddingDAO.selectHighestBid(new ArrayList<>(filteredAuctionDTOMap.keySet()));
        Map<Integer, AuctionImgDTO> auctionImgMap = auctionDAO.selectAuctionImgMapByCategory(categoryId);
        
        Map<String, Object> mainServiceMap = new HashMap<>();
        mainServiceMap.put("allCategoryDTOList", allCategoryDTOList);
        mainServiceMap.put("allAuctionDTOMap", filteredAuctionDTOMap);
        mainServiceMap.put("highestBidMap", highestBidMap);
        mainServiceMap.put("auctionImgMap", auctionImgMap);
        mainServiceMap.put("selectedCategoryId", categoryId);
        
        return mainServiceMap;
    }
	
	// List<String> categoryNameList 추가 필요
	// List<BiddingDTO> biddingDTOList는 "ORDER BY bidding_bid limit 10" 
	public Map<String, Object> detailService(int auction_id){
		BiddingDAO biddingDAO = new BiddingDAO();
		Category_auctionDAO categoryDAO = new Category_auctionDAO();
				
		List<BiddingDTO> biddingDTOList = biddingDAO.selectListBidding(auction_id);
		AuctionDTO auctionDTO = auctionDAO.selectAuctionDTO(auction_id);
		List<String> categoryNameList = categoryDAO.categoryNameList(auction_id);
		
		Map<String, Object> detailServiceMap = new HashMap<String, Object>();
		
		detailServiceMap.put("auctionDTO", auctionDTO);
		detailServiceMap.put("biddingDTOList", biddingDTOList);
		detailServiceMap.put("categoryNameList", categoryNameList);
		
		System.out.println(detailServiceMap);

		return detailServiceMap;
	}
	
//	public Map<String, Object> postService(AuctionDTO auctionDTO) {
//		Category_auctionDAO category_auctionDAO = new Category_auctionDAO();
//		List<Category_auctionDTO> allCategoryDTOList = category_auctionDAO.categoryList();
//		
//		Map<String, Object> postServiceMap = new HashMap<String, Object>();
//		postServiceMap.put("allCategoryDTOList", allCategoryDTOList);
//		
//		return postServiceMap;
//	}
	
	public void postService(AuctionDTO auctionDTO, List<Integer> categoryIds) {
        // 1. auction 테이블에 AuctionDTO 저장
        int auctionId = auctionDAO.insertAuction(auctionDTO);
        
        // 2. auction_has_category_auction 테이블에 카테고리 관계 저장
        for (Integer categoryId : categoryIds) {
            category_auctionDAO.insertAuctionCategory(auctionId, categoryId);
        }
        
        // 3. 이미지 정보 저장 (필요한 경우)
        if (auctionDTO.getAuctionImgDTOList() != null && !auctionDTO.getAuctionImgDTOList().isEmpty()) {
            for (AuctionImgDTO imgDTO : auctionDTO.getAuctionImgDTOList()) {
                imgDTO.setAuction_auction_id(auctionId);
                auctionDAO.insertAuctionImage(imgDTO);
            }
        }
    }
	
	public Map<String, Object> getPostServiceMap() {
        List<Category_auctionDTO> allCategoryDTOList = category_auctionDAO.categoryList();
        
        Map<String, Object> postServiceMap = new HashMap<>();
        postServiceMap.put("allCategoryDTOList", allCategoryDTOList);
        
        return postServiceMap;
    }
	
	public Map<String, Object> searchService(String searchField, String searchWord) {
        BiddingDAO biddingDAO = new BiddingDAO();
        
        List<Category_auctionDTO> allCategoryDTOList = category_auctionDAO.categoryList();
        Map<Integer, AuctionDTO> searchedAuctionDTOMap = auctionDAO.searchAuctions(searchField, searchWord);
        
        Map<Integer, Integer> highestBidMap = new HashMap<>();
        Map<Integer, AuctionImgDTO> auctionImgMap = new HashMap<>();
        
        if (!searchedAuctionDTOMap.isEmpty()) {
            highestBidMap = biddingDAO.selectHighestBid(new ArrayList<>(searchedAuctionDTOMap.keySet()));
            auctionImgMap = auctionDAO.selectAuctionImgMapByIds(new ArrayList<>(searchedAuctionDTOMap.keySet()));
        }
        
        Map<String, Object> mainServiceMap = new HashMap<>();
        mainServiceMap.put("allCategoryDTOList", allCategoryDTOList);
        mainServiceMap.put("allAuctionDTOMap", searchedAuctionDTOMap);
        mainServiceMap.put("highestBidMap", highestBidMap);
        mainServiceMap.put("auctionImgMap", auctionImgMap);
        mainServiceMap.put("searchField", searchField);
        mainServiceMap.put("searchWord", searchWord);
        
        return mainServiceMap;
    }
	

}
