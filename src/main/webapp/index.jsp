<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="ota.model.dto.NoticeDto"%>
<%@ page import="ota.model.dto.AuctionDTO"%>
<%@ page import="ota.model.dto.AuctionImgDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script defer src="/views/common/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
*{
	font-family: sans-serif;
}

#ota-main {
	margin: 0;
	padding: 0;
	/* 	background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.8)),
		url("views/common/img/hammer-7286346_1920.png");
	background-repeat: no-repeat;
	background-size: 100% 100%; */
	
}

#main-content-section {
	margin: 0 auto;
	width: 80%;
	display: flex;
	justify-content: space-between;
}

#mcs-box1 {
	width: 60%;
}

#mcs-box2 {
	width: 40%;
}

#mcs-box1-auction {
	width: 85%;
	height: 100%;
	position: relative;
}

#msc-img-box {
	margin: 0 auto;
	width: 85%;
	height: 50%;
}

#msc-img-box img{
	margin: auto;
    display: block;
	max-width: 100%;
	max-height: 100%;
}

#mcs-box2-auction div:first-child {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.anl-noview {
	display: none;
}

#mcs-box2-newNotice div:first-child {
	display: flex;
	justify-content: space-between;
}
#faq-section {
	margin: 0 auto;
	width: 60%;
}
#faq-section h2 {
	text-align: center;
}

#question-section h2 {
	text-align: center;
}
</style>
</head>
<body>
	<%
	List<NoticeDto> noticeList = (List<NoticeDto>) request.getAttribute("noticeList");
	List<AuctionDTO> highPriceAuctionList = (List<AuctionDTO>) request.getAttribute("highPriceAuctionList");
	List<AuctionDTO> popularAuctionList = (List<AuctionDTO>) request.getAttribute("popularAuctionList");
	AuctionDTO highPriceAuction = (AuctionDTO)request.getAttribute("highPriceAuction");
	
	List<AuctionImgDTO> auctionImgDTOs = highPriceAuction.getAuctionImgDTOList();
	AuctionImgDTO auctionImgDTO = auctionImgDTOs.get(0);
    String fileDirectory = auctionImgDTO.getAuction_imgs_webdir();
	String webDirectory = fileDirectory.substring(fileDirectory.lastIndexOf("webapp")+6);
    String imgSrc = webDirectory + "/" + auctionImgDTO.getAuction_imgs_new_name();
	
	String hpaBid = String.format("%,d", highPriceAuction.getAuction_startingbid());
	%>
	<%@include file="./views/common/header.jsp"%>
	<main id='ota-main'>
	<div class="bg-light">
	<br/>
		<section id="main-content-section" class="p-3">
			<div id='mcs-box1'>
				<div id="mcs-box1-auction" 
					class="mcs-box1-item p-2 rounded-2 bg-secondary bg-opacity-10">
					<p style="position:absolute; right: 2%; top: 3%;">
						<a class="link-secondary p-2" href='/auction/detail?auction_id=<%=highPriceAuction.getAuction_id()%>'>바로가기</a>
					</p>
					<h2 class="m-3 text-center text-black"><strong><i>최고가 경매 진행중!!</i></strong></h2>
					<div id="msc-img-box">
						<img alt="이미지"	src="<%=imgSrc%>">
					</div>
					<p class="m-3 fs-4 text-center text-secondary fst-italic">물품명 : <%=highPriceAuction.getAuction_title() %></p>
					<p class="m-3 fs-5 text-center text-secondary fst-italic">
						물품 설명 : <%=highPriceAuction.getAuction_content() %>
					</p>
					<p id="highPriceP"class="m-3 fs-4 text-center text-secondary fst-italic">
						현재 입찰가 : <%=hpaBid %>원
					</p>
					<p id="hpaDDay" class="m-3 fs-5 text-center text-secondary fst-italic" ></p>
				</div>
			</div>
			<div id='mcs-box2'>
				<div id="mcs-box2-auction"
					class="mcs-box2-item p-2 rounded-2 bg-secondary bg-opacity-10">
					<div>
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="auction-nav nav-link active"
								href="javascript:auctionNavToggle();">최고가 경매</a></li>
							<li class="nav-item"><a class="auction-nav nav-link"
								href="javascript:auctionNavToggle();">인기 경매</a></li>
						</ul>
						<a class="link-secondary p-2" href='/auction'>더보기</a>
					</div>
					<div class="autcion-nav-list p-2 pb-0">
						<%
						if (highPriceAuctionList.isEmpty()) {
						%>
						<p class="text-secondary">경매물품이 없습니다.</p>
						<%
						} else {
							int pId = 0;
							for (AuctionDTO auctionDTO : highPriceAuctionList) {
								String bidMoney = String.format("%,d", auctionDTO.getAuction_startingbid());
								String auTitle = "";
							if (auctionDTO.getAuction_title().length() > 20) {
								auTitle = auctionDTO.getAuction_title().substring(0, 20) + "...";
							} else {
								auTitle = auctionDTO.getAuction_title();
							}
						%>
						<p class="m-0" style="display: inline-block; width: 70%">
							<a class="link-secondary link-underline-opacity-0"
								href="/auction/detail?auction_id=<%=auctionDTO.getAuction_id()%>">&#10061;
								<%=auTitle%> - <%= bidMoney %>원</a>
						</p>
						<p class="m-0 text-secondary" style="display: inline-block;">조회수 : <%=auctionDTO.getAuction_view() %></p>
						<p id="hpaDDay<%=pId%>" style="color: red; font-size: 14px" > </p>
						<%
							pId++;
							}
						}
						%>
					</div>
					<div class="autcion-nav-list p-2 pb-0 anl-noview">
						<%
						if (popularAuctionList.isEmpty()) {
						%>
						<p class="text-secondary">경매물품이 없습니다.</p>
						<%
						} else {
							int pId = 0;
							for (AuctionDTO auctionDTO : popularAuctionList) {
								String bidMoney = String.format("%,d", auctionDTO.getAuction_startingbid());
								String auTitle = "";
							if (auctionDTO.getAuction_title().length() > 20) {
								auTitle = auctionDTO.getAuction_title().substring(0, 20) + "...";
							} else {
								auTitle = auctionDTO.getAuction_title();
							}
						%>
						<p class="m-0" style="display: inline-block; width: 70%">
							<a class="link-secondary link-underline-opacity-0"
								href="/auction/detail?auction_id=<%=auctionDTO.getAuction_id()%>">&#10061;
								<%=auTitle%> - <%= bidMoney %>원</a>
						</p>
						<p class="m-0 text-secondary" style="display: inline-block;">조회수 : <%=auctionDTO.getAuction_view() %></p>
						<p id="paDDay<%=pId%>" style="color: red; font-size: 14px" > </p>
						<%
							pId++;
							}
						}
						%>
					</div>
				</div>
				<br />
				<div id="mcs-box2-newNotice"
					class="mcs-box2-item p-3 pb-1 rounded-2 bg-secondary bg-opacity-10">
					<div>
						<p>최근 공지</p>
						<a class="link-secondary" href='/notice'>더보기</a>
					</div>
					<div>
						<%
						if (noticeList.isEmpty()) {
						%>
						<p class="text-secondary">최근 공지사항이 없습니다.</p>
						<%
						} else {
						for (NoticeDto noticeDto : noticeList) {
							String noTitle = "";
							if (noticeDto.getNoticeTitle().length() > 20) {
								noTitle = noticeDto.getNoticeTitle().substring(0, 20) + "...";
							} else {
								noTitle = noticeDto.getNoticeTitle();
							}
						%>
						<p>
							<a class="link-secondary link-underline-opacity-0"
								href="/notice/view?noticeId=<%=noticeDto.getNoticeId()%>">-
								<%=noTitle%></a>
						</p>
						<%
						}
						}
						%>
					</div>
				</div>
			</div>
		</section>
		</div>
		<br/>
		<br/>
		<section id="faq-section">
			<h2><strong>자주 묻는 질문</strong></h2><br/>
			<div class="accordion accordion-flush" id="accordionFlushExample">
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-headingOne">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#flush-collapseOne"
							aria-expanded="false" aria-controls="flush-collapseOne">
							결제 어떻게 해야하나요?</button>
					</h2>
					<div id="flush-collapseOne" class="accordion-collapse collapse"
						aria-labelledby="flush-headingOne">
						<div class="accordion-body">
							추후 추가될 예정입니다^^
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-headingTwo">
						<button class="accordion-button collapsed btn-primary" type="button"
							data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo"
							aria-expanded="false" aria-controls="flush-collapseTwo">
							사기당하면 어캐요</button>
					</h2>
					<div id="flush-collapseTwo" class="accordion-collapse collapse"
						aria-labelledby="flush-headingTwo">
						<div class="accordion-body">
							지켜드리겠습니다^^
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-headingThree">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#flush-collapseThree"
							aria-expanded="false" aria-controls="flush-collapseThree">
							검색하는 법을 모르겠어요</button>
					</h2>
					<div id="flush-collapseThree" class="accordion-collapse collapse"
						aria-labelledby="flush-headingThree">
						<div class="accordion-body">
							상단 입력창에 검색어를 입력하세요
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-headingfour">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#flush-collapsefour"
							aria-expanded="false" aria-controls="flush-collapsefour">
							경매 등록은 어떻게 하나요</button>
					</h2>
					<div id="flush-collapsefour" class="accordion-collapse collapse"
						aria-labelledby="flush-headingfour">
						<div class="accordion-body">
							로그인 후 이용 가능합니다
						</div>
					</div>
				</div>
			</div>
		</section>
		<br/>
		<br/>
		<div class="bg-light">
		<section id="question-section" class="p-5">
			<h2><strong>1:1 문의하기</strong></h2>
			<br/>
			<p class="fs-4 text-center">
				<a class="link-secondary link-underline-opacity-50"
					href="/contactUs/writeForm"><i>contact us</i></a>
			</p>
		</section>
		</div>
	</main>
	<%@include file="./views/common/footer.jsp"%>
<script type="text/javascript">
function auctionNavToggle(){
	const navItems = document.getElementsByClassName("auction-nav");
	const listItems = document.getElementsByClassName("autcion-nav-list");
	for (var i = 0; i < 2; i++) {
		navItems[i].classList.toggle("active");
		listItems[i].classList.toggle("anl-noview");
	}
}

const hpaDDays = []; //가격높은경매
const paDDays = []; //인기경매
const hpaPTags = []; //가격 높은경매 p태그
const paPTags = []; //인기 경매 p태그
window.onload = function() {
	//가격높은 경매 배열만들기
	<%
		int hpaSize = highPriceAuctionList.size();
		for(int i=0; i<hpaSize; i++){
	%>
		hpaDDays.push('<%=highPriceAuctionList.get(i).getAuction_enddate()%>');
		hpaPTags.push(document.getElementById("hpaDDay<%=i%>"));		
	<%
		}
	%>
	
	//인기 많은 경매 배열만들기
	<%
		int paSize = popularAuctionList.size();
		for(int i=0; i<paSize; i++){
	%>
		paDDays.push('<%=popularAuctionList.get(i).getAuction_enddate()%>');
		paPTags.push(document.getElementById("paDDay<%=i%>"));
	<%
		}
	%>
	setDDay();
}

function setDDay() {
	for(let i=0; i<hpaDDays.length; i++){
		setDiff(hpaDDays[i],hpaPTags[i]);
	}
	
	for(let i=0; i<paDDays.length; i++){
		setDiff(paDDays[i],paPTags[i]);
	}
	
	const hpaDDayPTag = document.getElementById("hpaDDay");
	const hpaDDay = "<%=highPriceAuction.getAuction_enddate()%>";
	setDiff(hpaDDay,hpaDDayPTag);
}

function setDiff(date,pTag){
	const endDate = new Date(date);
	const todayTime = new Date();
	
	const diff = endDate - todayTime;

	const diffDay = Math.floor(diff / (1000*60*60*24));
	const diffHour = String(Math.floor((diff / (1000*60*60)) % 24)).padStart(2,"0");
	const diffMin = String(Math.floor((diff / (1000*60)) % 60)).padStart(2,"0");
 	const diffSec = String(Math.floor(diff / 1000 % 60)).padStart(2,"0");
 	pTag.innerText = '마감 시간 : '+diffDay+'일 '+diffHour+'시 '+diffMin+'분 '+diffSec+'초' 
}

setInterval(setDDay, 1000);


const auctionId = "<%=highPriceAuction.getAuction_id()%>"
const highPriceP = document.getElementById("highPriceP");


setInterval(() => {
	fetch("/welcome/auctionBid?auctionId="+auctionId)
	.then((response) => response.json())
	.then((data) => 
		highPriceP.innerText="현재 입찰가 : "+data.toLocaleString('ko-KR')+"원") 
	.catch((error) => console.error(error));
}, 2000);

</script>	
</body>
</html>
















