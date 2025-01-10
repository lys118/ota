<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ota.model.dao.Category_auctionDAO" %>
<%@ page import="ota.model.dto.Category_auctionDTO" %>
<%@ page import="ota.model.dto.AuctionDTO" %>
<%@ page import="ota.model.dto.BiddingDTO" %>
<%@ page import="ota.model.dao.BiddingDAO" %>
<%@ page import="ota.model.dto.AuctionImgDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTA 경매 메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/auction/css/auctionMain.css" />
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <%
    
    Map<String, Object> mainServiceMap = (Map)request.getAttribute("mainServiceMap");
    
    List<Category_auctionDTO> allCategoryDTOList = (List<Category_auctionDTO>)mainServiceMap.get("allCategoryDTOList");
    Map<Integer, AuctionDTO> allAuctionDTOMap = (Map<Integer, AuctionDTO>)mainServiceMap.get("allAuctionDTOMap");
    Map<Integer, Integer> highestBidMap = (Map<Integer, Integer>)mainServiceMap.get("highestBidMap");
    Map<Integer, AuctionImgDTO> auctionImgMap = (Map<Integer, AuctionImgDTO>)mainServiceMap.get("auctionImgMap");
    Integer selectedCategoryId = (Integer)mainServiceMap.get("selectedCategoryId");
    String searchField = (String)mainServiceMap.get("searchField");
    String searchWord = (String)mainServiceMap.get("searchWord");
    
    int categoryWidth = allCategoryDTOList.size();
    %>
    <section id="auction_container">
        <h1 id="auction_header">OTA 경매 물품 목록</h1>
        <form id="auction_search_form" method="get" action="${pageContext.request.contextPath}/auction/search">
            <select class="form-select" name="searchField">
                <option value="title" <%= "title".equals(searchField) ? "selected" : "" %>>제목</option>
                <option value="content" <%= "content".equals(searchField) ? "selected" : "" %>>내용</option>
                <option value="userName" <%= "userName".equals(searchField) ? "selected" : "" %>>닉네임</option>
            </select>
            <input type="text" maxlength="10" class="form-control" name="searchWord" value="<%= searchWord != null ? searchWord : "" %>"/>
            <button type="submit" class="btn btn-secondary">검색하기</button>
        </form>
        
        <div class="category-banner">
            <div class="wrap">
                <ul>
                    <li style="width: <%=100/(categoryWidth+1)%>%;">
                        <a href="${pageContext.request.contextPath}/auction" 
                           <%= selectedCategoryId == null ? "class='selected'" : "" %>>전체</a>
                    </li>
                    <% for(Category_auctionDTO categoryDTO : allCategoryDTOList){ %>
                        <li style="width: <%=100/(categoryWidth+1)%>%;">
                            <a href="${pageContext.request.contextPath}/auction/category?category_id=<%=categoryDTO.getCategory_auction_id()%>"
                               <%= selectedCategoryId != null && selectedCategoryId == categoryDTO.getCategory_auction_id() ? "class='selected'" : "" %>>
                                <%=categoryDTO.getCategory_auction_name()%>
                            </a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
        <div class="thumnail-list">
            <div class="wrap">
                <% if(allAuctionDTOMap.isEmpty()) { %>
                    <% if (searchWord != null && !searchWord.isEmpty()) { %>
                        <p>"<%=searchWord%>"에 대한 검색 결과가 없습니다.</p>
                    <% } else { %>
                        <p>등록된 경매 물품이 없습니다.</p>
                    <% } %>
                <% } else { %>
                    <ul class="thumnail">
                    <% for(int key : allAuctionDTOMap.keySet()){ 
                
                        AuctionImgDTO imgDTO = auctionImgMap.get(key);
                        String fileDirectory = imgDTO.getAuction_imgs_webdir();
						String webDirectory = fileDirectory.substring(fileDirectory.lastIndexOf("webapp")+6);
                        String imgSrc = (imgDTO != null) ? 
                            imgDTO.getAuction_imgs_webdir() + "/" + imgDTO.getAuction_imgs_new_name() :
                            "/views/auction/imgs/default.jpg";
                        Integer highestBid = highestBidMap.get(key);
                        
                    %>
                        <li>
                            <div class="thumnail-box">
                                <div class="img-box">
                                    <a href="/auction/detail?auction_id=<%=key%>">
                                        <img width="120px" height="60px" alt="경매 이미지" src="<%=webDirectory%>/<%=imgDTO.getAuction_imgs_new_name()%>">
                                    </a>
                                </div>
                                <div class="subject-box">
                                    <p class="subject">
                                        <a href="/auction/detail?auction_id=<%=key%>"><%=allAuctionDTOMap.get(key).getAuction_title()%></a>
                                    </p>
                                    <p class="highest-bid">최고 입찰가: <%= highestBid != null ? highestBid : "입찰 없음" %></p>
                                </div>
                            </div>
                        </li>
                    <% } %>
                    </ul>
                <% } %>
            </div>
        </div>
        <% if(loginUserDTO != null){ %>     
        <div class="post m-5 " style="display: flex; justify-content: flex-end;">
            <form action="${pageContext.request.contextPath}/auction/post" method="get">
                <button type="submit" class="btn btn-secondary">위탁 등록</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </form>
        </div>
        <% } %>      
    </section>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>