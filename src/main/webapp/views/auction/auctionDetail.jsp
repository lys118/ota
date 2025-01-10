<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="ota.model.dto.UserDTO"%>
<%@ page import="ota.model.dto.Category_auctionDTO"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ota.model.dto.AuctionDTO" %>
<%@ page import="ota.model.dto.AuctionImgDTO" %>
<%@ page import="ota.model.dto.BiddingDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTA 경매 물품 상세 보기</title>
</head>
<style>
#detail_container{
	margin: 0 auto;
	width: 80%;
}

.detail-information{
	display: flex;
	justify-content: space-around;
}
.detail-mainBox{
	margin: 0 auto;
	width: 60%;
}
.detail-content{
	width: 80%;
}

.detail-infoBox{
	margin: 0 auto;
	width: 40%;
}
.image-box{
	width: 90%;
	height: 40%;
}
.image-box img {
	max-width: 100%;
	max-height: 100%;
}
</style>
<body>
	<%@include file="../common/header.jsp" %>
	<%
		String searchField = "";
		String searchWord = "";

		Map<String, Object> detailServiceMap = (Map)request.getAttribute("detailServiceMap");
		AuctionDTO auctionDTO = (AuctionDTO)detailServiceMap.get("auctionDTO");
		List<BiddingDTO> biddingDTOList = (List<BiddingDTO>)detailServiceMap.get("biddingDTOList");
		List<String> categoryNameList = (List<String>)detailServiceMap.get("categoryNameList");
		
		List<AuctionImgDTO> auctionImgDTOs = auctionDTO.getAuctionImgDTOList();
		AuctionImgDTO auctionImgDTO = auctionImgDTOs.get(0);
        String fileDirectory = auctionImgDTO.getAuction_imgs_webdir();
		String webDirectory = fileDirectory.substring(fileDirectory.lastIndexOf("webapp")+6);
        String imgSrc = webDirectory + "/" + auctionImgDTO.getAuction_imgs_new_name();
        
        String maxBid = "0원";
        if(!biddingDTOList.isEmpty()){
        	maxBid = String.format("%,d", biddingDTOList.get(0).getBidding_bid())+"원";
        }
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	%>
	
	<section id="detail_container">
		<div class="detail-information m-3">
			<div class="detail-mainBox">
				<h1><strong><i><%=auctionDTO.getAuction_title()%></i></strong></h1>
				<h3 style="display: inline-block;"><strong>현재 입찰가 : </strong></h3>
				<h4 id ="mainBid" style="display: inline-block;"><%= maxBid %></h4>
				<br/>
				<br/>
				<div class="image-box">
					<img alt="사진티비"
					src="<%=imgSrc%>"/>
				</div>
				<div class="detail-content mt-5">
				<h2>제품 설명</h2>
				<p><%=auctionDTO.getAuction_content()%></p>
				</div>
			</div>	
			<div class="detail-infoBox">
				<h2 class="text-center">제품 정보</h2>
				<br/>
				<table class="table table-bordered">
						<tbody class="text-center">
							<tr>
								<th>위탁자</th>
								<td><%=auctionDTO.getUser_user_id()%></td>
							</tr>
							<tr>
								<th>위탁일</th>
								<td><%= auctionDTO.getAuction_postdate() != null ? sdf.format(auctionDTO.getAuction_postdate()) : "정보 없음" %></td>
							</tr>
							<tr>
								<th>경매 시작</th>
								<td><%= auctionDTO.getAuction_startingdate() != null ? sdf.format(auctionDTO.getAuction_startingdate()) : "정보 없음" %></td>
							</tr>
							<tr>
								<th>경매 종료</th>
								<td><%= auctionDTO.getAuction_enddate() != null ? sdf.format(auctionDTO.getAuction_enddate()) : "정보 없음" %></td>
							</tr>
							<tr>
								<th>시작가</th>
								<%
								String startBid = String.format("%,d", auctionDTO.getAuction_startingbid());
								%>
								<td><%= startBid %></td>
							</tr>
							<tr>
								<th>카테고리</th>
								<td>
<%
									for(String category : categoryNameList){
%>
										"<%=category%>" 
<%
									}
%>
								</td>
							</tr>
<%
%>
						</tbody>
					</table>
					<br/>
					<h2 class="text-center">입찰 내역</h2>
					<br/>
					<table class="table table-bordered">
						<thead class="text-center">
							<tr>
								<th width="20%">입찰자</th>
								<th width="30%">입찰 금액</th>
								<th width="50%">입찰 날짜(시간)</th>
							</tr>
						</thead>
					<tbody id="bidInfo-tbody" class="text-center">
<%
						for(BiddingDTO biddingDTO : biddingDTOList){
							String bidMoney = String.format("%,d", biddingDTO.getBidding_bid()); //천단위 콤마설정
							String bidDate = new SimpleDateFormat("yyyy-MM-dd HH시mm분ss초")
									.format(biddingDTO.getBidding_biddate()); //날짜 설정
%>							
							<tr>
								<td><%=biddingDTO.getUser_user_id() %></td>
								<td><%= bidMoney %>원</td>
								<td><%= bidDate %></td>
							</tr>
<%
						}
%>
					</tbody>
					</table>
<%
					if(loginUserDTO != null){
%>					
					<div style="display:flex; justify-content:flex-end; width: 100%;">
						<input id="bid" onkeyup="bidInputSetting(this);" type="text" 
						value=0 maxlength="15" style="text-align: right;">&nbsp;원&nbsp;
						<input onclick="sendBid()" value="입찰" type="button">
					</div>
					<%
					}
					%>
				</div>
			</div>
	</section>

<script type="text/javascript">
	let webSocket;
	let loginUserId = "";
	<%
		if(loginUserDTO != null){
	%>	
		loginUserId = "<%=loginUserDTO.getUserID()%>"; 
	<%
		}
	%>
	window.onload = function() {

		webSocket = new WebSocket("ws://localhost:8080/wsAuctionDetail");

		webSocket.onopen = function(event) {
			console.log("웹소켓 연결됨");
			webSokectInit();
		};

		webSocket.onerror = function(event) {
			console.error("웹소켓 에러 발생:", event);
		};

		webSocket.onclose = function(event) {
			console.log("웹소켓 연결이 끊어졌습니다.");
		};

		webSocket.onmessage = function(event) {
			const data = JSON.parse(event.data);
			if (data.success) {
				if(loginUserId==data.loginUserId){
					alert("입찰이 성공적으로 이루어졌습니다.");	
				}
				updateBiddingTable(data.biddingList); // 입찰 목록 업데이트
			} else {
				alert("입찰에 실패했습니다. 다시 시도해 주세요.");
			}
		};
	};
	
	function webSokectInit(){
		const auctionId = "<%= auctionDTO.getAuction_id() %>";
		const data = {
			wsInit : "1",
			auctionId: String(auctionId)	
		};
		webSocket.send(JSON.stringify(data));
	}

	function sendBid() {
		const bidAmount = document.getElementById("bid").value.replace(/,/gi,"");
		const auctionId = "<%= auctionDTO.getAuction_id() %>"; // 경매 ID
		const userId = loginUserId; // 사용자 ID
		if (bidAmount == "" || bidAmount == 0) {
			alert("입찰 금액을 입력하세요.");
			return;
		}

		const data = {
			bid: String(bidAmount),
			auctionId: String(auctionId),
			userId: userId
		};

		webSocket.send(JSON.stringify(data)); // WebSocket을 통해 데이터 전송
		document.getElementById("bid").value = ""; // 입력란 초기화
	}

	function updateBiddingTable(biddingList) {
		const mainBid = document.getElementById("mainBid");
		const biddingTableBody = document.getElementById("bidInfo-tbody");
		biddingTableBody.textContent = ""; // 기존 내용 제거
		
		let maxBid = "0원";
		if(biddingList.length !=0){
			maxBid = (biddingList[0].bid).toLocaleString('ko-KR')+"원";
		}
		let trtdTag ="";
		for (let i = 0; i < biddingList.length; i++) {
			const bidding = biddingList[i];
			trtdTag += '<tr><td>'+bidding.userId+'</td>'
						+'<td>'+(bidding.bid).toLocaleString('ko-KR')+'원</td>'
					 +'<td>'+bidding.bidDate+'</td></tr>';	
			}
		biddingTableBody.innerHTML=trtdTag;
		mainBid.innerText=maxBid;
	}
	
	function bidInputSetting(tag){
		let value = tag.value;
		  value = Number(value.replaceAll(',', ''));
		  if(isNaN(value)) {
			tag.value = 0;
		  }else {
		    const formatValue = value.toLocaleString('ko-KR');
		    tag.value = formatValue;
		  }
	}
</script>
<%@include file="../common/footer.jsp" %>
</body>
</html>