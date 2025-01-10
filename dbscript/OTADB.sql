drop table if exists contactus_imgs;
drop table if exists contactus;
drop table if exists notice_imgs;
drop table if exists notice;
drop table if exists auction_has_category_auction;
drop table if exists bidding;
drop table if exists category_auction;
drop table if exists auction_imgs;
drop table if exists auction;
drop table if exists user;


create table user(
	user_id varchar(20),
	user_password varchar(20),
	user_name varchar(20),
	user_email varchar(20),
	user_phone varchar(20),
	user_postcode varchar(20),
	user_address varchar(20),
	user_detail_address varchar(20),
	user_join_date datetime,
    primary key (user_id)
);

insert into user value ('admin','1234','관리자','admin@admin.com','010-1234-5678','우편번호','주소','상세주소',sysdate());
insert into user value ('user1','1234','유저1','admin@admin.com','010-1234-5678','우편번호','주소','상세주소',sysdate());
insert into user value ('user2','1234','유저2','admin@admin.com','010-1234-5678','우편번호','주소','상세주소',sysdate());

drop procedure if exists user_insert; 
DELIMITER $$
CREATE PROCEDURE user_insert()
BEGIN
	DECLARE i INT DEFAULT 1; 
    	WHILE (i <= 350) 
        DO 
		insert into user value (concat('users',i),'1234','유저1','admin@admin.com','010-1234-5678','우편번호','주소','상세주소',sysdate());
        SET i = i + 1;
	END WHILE; 
END $$
DELIMITER ;
call user_insert();


create table notice (
	notice_id int AUTO_INCREMENT,
    notice_title varchar(200) not null,
	notice_content text,
    notice_post_date timestamp,
    notice_visit_count int not null,
    notice_importance_type varchar(10) not null,
    notice_user_id varchar(20),
    constraint NOTICE_PK primary key (notice_id),
    foreign key ( notice_user_id) references user(user_id) on delete cascade
);

create table notice_imgs(
	notice_img_id int AUTO_INCREMENT,
    notice_img_origin_name varchar(100) not null,
    notice_img_new_name varchar(100) not null,
    notice_img_webdirectory varchar(100) not null,
    notice_id int,
    constraint NOTICE_IMGS_PK primary key (notice_img_id),
    foreign key (notice_id) references notice(notice_id) on delete cascade
);


create table contactus (
	contactus_id int AUTO_INCREMENT,
    contactus_user_type varchar(20) not null,
    contactus_user_id varchar(20),
    contactus_user_name varchar(20) not null,
    contactus_user_email varchar(20) not null,
    contactus_type varchar(30) not null,
    contactus_title varchar(100) not null,
	contactus_content text,
    contactus_post_date timestamp,
    contactus_admin_response text,
    contactus_response_status boolean,
    constraint CONTACTUS_PK primary key (contactus_id)
);

create table contactus_imgs(
    contactus_img_origin_name varchar(100) not null,
    contactus_img_new_name varchar(100) not null,
    contactus_img_webdirectory varchar(100) not null,
	contactus_id int,
    constraint CONTACTUS_IMGS_PK primary key (contactus_img_new_name),
    foreign key (contactus_id) references contactus(contactus_id) on delete cascade
);

insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adafbb', 'fabfabfb', '2024-09-25', 0,'일반', 'admin');   
 
insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adafbb', 'fabfabfb', now(), 0,'일반', 'admin');   

insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adafbb', 'fabfabfb', now(), 0,'중요', 'admin');       

insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adb', 'fabfb', now(), 0,'필독', 'admin'); 
    
insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adafbb', 'fabfabfb', now(), 0,'중요', 'admin');
 
insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adafbb', 'fabfabfb', now(), 0,'일반', 'admin');    

insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adafbb', 'fabfabfb', now(), 0,'중요', 'admin');

insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('adafbb', 'fabfabfb', now(), 0,'일반', 'admin');
    
insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('a%dafbb', 'fabfabfb', now(), 0,'일반', 'admin');    

insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
	notice_importance_type,notice_user_id) value ('123', '', now(), 0,'', 'admin');

drop procedure if exists notice_insert; 

DELIMITER $$
CREATE PROCEDURE notice_insert()
BEGIN
	DECLARE i INT DEFAULT 1; 
    	WHILE (i <= 350) 
        DO 
		insert into notice (notice_title, notice_content, notice_post_date, notice_visit_count,
		notice_importance_type,notice_user_id) value (concat('adafbb',i), concat('adabafbb',i), now(), 0,'일반', 'admin'); 
        SET i = i + 1;
	END WHILE; 
END $$
DELIMITER ;
call notice_insert();

drop procedure if exists contactus_insert; 
DELIMITER $$
CREATE PROCEDURE contactus_insert()
BEGIN
	DECLARE i INT DEFAULT 1; 
    	WHILE (i <= 350) 
        DO 
		insert into contactus (contactus_user_type,contactus_user_id,contactus_user_name,contactus_user_email
		,contactus_type,contactus_title,contactus_content,contactus_post_date, contactus_admin_response,contactus_response_status)
		value('비회원',null,'홍길동','afb@arg.com','회원 정보',concat('제목',i),concat('내용',i),now(),"",false);
        SET i = i + 1;
	END WHILE; 
END $$
DELIMITER ;
call contactus_insert();

drop procedure if exists contactus_insert2; 
DELIMITER $$
CREATE PROCEDURE contactus_insert2()
BEGIN
	DECLARE i INT DEFAULT 1; 
    	WHILE (i <= 350) 
        DO 
		insert into contactus (contactus_user_type,contactus_user_id,contactus_user_name,contactus_user_email
		,contactus_type,contactus_title,contactus_content,contactus_post_date, contactus_admin_response,contactus_response_status)
		value('비회원',null,'홍길동','afb@arg.com','회원 정보',concat('제목',i),concat('내용',i),now(),"",true);
        SET i = i + 1;
	END WHILE; 
END $$
DELIMITER ;
call contactus_insert2();

-- AUTO_INCREMENT
CREATE TABLE `auction` (
  `auction_id` int NOT NULL AUTO_INCREMENT,
  `auction_title` varchar(20) NOT NULL,
  `auction_content` varchar(300) NOT NULL,
  `auction_img` varchar(100) NOT NULL,
  `auction_postdate` datetime NOT NULL,
  `auction_startingbid` int NOT NULL,
  `auction_startingdate` datetime NOT NULL,
  `auction_enddate` datetime NOT NULL,
  `auction_view` int unsigned NOT NULL,
  `auction_winner` varchar(6) DEFAULT NULL,
  `user_user_id` varchar(20) NOT NULL,
  PRIMARY KEY (`auction_id`),
  KEY `fk_auction_user_idx` (`user_user_id`),
  CONSTRAINT `fk_auction_user` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `category_auction` (
  `category_auction_id` int NOT NULL,
  `category_auction_name` varchar(10) NOT NULL,
  PRIMARY KEY (`category_auction_id`),
  UNIQUE KEY `category_auction_name_UNIQUE` (`category_auction_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `bidding` (
  `bidding_id` int NOT NULL AUTO_INCREMENT,
  `bidding_bid` int NOT NULL,
  `bidding_biddate` datetime NOT NULL,
  `user_user_id` varchar(20) NOT NULL,
  `auction_auction_id` int NOT NULL,
  PRIMARY KEY (`bidding_id`),
  KEY `fk_bidding_user1_idx` (`user_user_id`),
  KEY `fk_bidding_auction1_idx` (`auction_auction_id`),
  CONSTRAINT `fk_bidding_auction1` FOREIGN KEY (`auction_auction_id`) REFERENCES `auction` (`auction_id`) on delete cascade,
  CONSTRAINT `fk_bidding_user1` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `auction_has_category_auction` (
  `auction_auction_id` int NOT NULL,
  `category_auction_category_auction_id` int NOT NULL,
  PRIMARY KEY (`auction_auction_id`,`category_auction_category_auction_id`),
  KEY `fk_auction_has_category_auction_category_auction1_idx` (`category_auction_category_auction_id`),
  KEY `fk_auction_has_category_auction_auction1_idx` (`auction_auction_id`),
  CONSTRAINT `fk_auction_has_category_auction_auction1` FOREIGN KEY (`auction_auction_id`) REFERENCES `auction` (`auction_id`) on delete cascade,
  CONSTRAINT `fk_auction_has_category_auction_category_auction1` FOREIGN KEY (`category_auction_category_auction_id`) REFERENCES `category_auction` (`category_auction_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 추가됨
CREATE TABLE `auction_imgs` (
  `auction_imgs_id` int NOT NULL AUTO_INCREMENT,
  `auction_imgs_origin_name` varchar(100) NOT NULL,
  `auction_imgs_new_name` varchar(100) NOT NULL,
  `auction_imgs_webdir` varchar(100) NOT NULL,
  `auction_auction_id` int NOT NULL,
  PRIMARY KEY (`auction_imgs_id`),
  KEY `fk_auction_imgs_auction_idx` (`auction_auction_id`),
  CONSTRAINT `fk_auction_imgs_auction` FOREIGN KEY (`auction_auction_id`) REFERENCES `ota`.`auction` (`auction_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('1', '애플워치 사세요', '삼성 갤럭시 콜라보 리미티드 브라질 에디션 제품으로, 일본의 샤오미 매장에서만 구매 가능합니다. 한정수량 70억대 뿐이라 희소성이 높습니다. 50유로로 현장 구매한 제품을 시작가 무려 5000만원에 싸게 올립니다. 고민은 후회를 부를 뿐, 행동하는 자가 삶을 변화시킵니다. 입찰하세요!', 'img.png', '2024-09-30 00:00:00', '1000', '2024-09-30 00:00:00', '2025-09-30 00:00:00', '20', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('2', '샤오미 배터리', '폭발 전적 6회 있지만, 서비스센터에서 수리받았습니다. 8일째 쓰는데 스파크가 좀 튀는것 빼고는 문제 없습니다.', 'img.png', '2024-10-02 00:00:00', '1500', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '40', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('3', '지샥 시계', '지샤기입니다', 'img.png', '2024-10-02 00:00:00', '12', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '10', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('4', '로지텍 마우스', '휠 튐 있음', 'img.png', '2024-10-02 00:00:00', '159', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '20', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('5', '게르마늄 팔찌', '일론머스크가 개발했습니다.', 'img.png', '2024-10-02 00:00:00', '159159', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '50', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('6', '음이온 선풍기', '피톤치드 추출물 0.0000181% 함유', 'img.png', '2024-10-02 00:00:00', '6700', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '70', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('7', '성경책', '저는 알라신만 믿기때문에 내놓습니다.', 'img.png', '2024-10-02 00:00:00', '8', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '50', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('8', '마인크래프트 1.5.9 크랙', '드롭박스 덧링 참고', 'img.png', '2024-10-02 00:00:00', '0', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('9', '웹개발 해드립니다', '프론트는 JSP, 백엔드는 C#으로 작업합니다. 만관부', 'img.png', '2024-10-02 00:00:00', '78', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '15', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('10', '금반지', '1.5돈짜리 ', 'img.png', '2024-10-02 00:00:00', '560', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '25', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('11', '뉴발란스 조던', '테무에서 2만원 주고 산거예요.', 'img.png', '2024-10-02 00:00:00', '560560560', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '30', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('12', '한라산 풍경화', '전유나 화백님께서 작업하셨습니다.', 'img.png', '2024-10-02 00:00:00', '90000', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '15', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('13', '실비김치', '저희 시부모님께서 캐롤라이나 리퍼 고추로 담갔어요.', 'img.png', '2024-10-02 00:00:00', '60', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '22', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('14', '5억 메소', '메이플 본섭 메소 아닙니다. 메랜 메소입니다.', 'img.png', '2024-10-02 00:00:00', '8000', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '1', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('15', '코스프레 가발', '요네 가발입니다.', 'img.png', '2024-10-02 00:00:00', '800', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('16', '악어가죽 코트', '이탈리아 장인이 소가죽으로 만들었습니다.', 'img.png', '2024-10-02 00:00:00', '37000', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('17', '뉴진스 앨범', '뉴진스 데뷔엘범입니다. 하니 싸인 있어요.', 'img.png', '2024-10-02 00:00:00', '412333', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('18', '샤넬 립스틱', '2023년 홀리데이 컬렉션. 현재 중고시세 6000만원이에요.', 'img.png', '2024-10-02 00:00:00', '200000', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('19', '아이리버 mp3', '초딩때 쓰던건데 팜니다요', 'img.png', '2024-10-02 00:00:00', '16', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('20', '나전칠기 장롱', '할머니꺼 팝니다.', 'img.png', '2024-10-02 00:00:00', '31', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('21', '펜텔 스매쉬 한정판', '가장 인기 많은 모델입니다. 한국 정발 예정 없는 일본 내수용 샤프입니다. 그립감이 예술', 'img.png', '2024-10-02 00:00:00', '5600', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('22', '수제 쿠키', '니코틴, 타르 함유', 'img.png', '2024-10-02 00:00:00', '28000', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');
INSERT INTO auction (auction_id, auction_title, auction_content, auction_img, auction_postdate, auction_startingbid, auction_startingdate, auction_enddate, auction_view, auction_winner, user_user_id) VALUES ('23', '독일제 클라리넷', '사진찍으려고 포장 깠어요ㅎ 미사용 새제품 맞으니까 안심하세용ㅎㅎ', 'img.png', '2024-10-02 00:00:00', '170000', '2024-10-02 00:00:00', '2025-10-02 00:00:00', '0', 'admin', 'admin');

INSERT INTO category_auction (category_auction_id, category_auction_name) VALUES(1,'표창');
INSERT INTO category_auction (category_auction_id, category_auction_name) VALUES(2,'전자기기');
INSERT INTO category_auction (category_auction_id, category_auction_name) VALUES(3,'소프트웨어');
INSERT INTO category_auction (category_auction_id, category_auction_name) VALUES(4,'하드웨어');
INSERT INTO category_auction (category_auction_id, category_auction_name) VALUES(5,'악세서리');

INSERT INTO auction_has_category_auction (auction_auction_id, category_auction_category_auction_id) VALUES(1,1);
INSERT INTO auction_has_category_auction (auction_auction_id, category_auction_category_auction_id) VALUES(1,2);
INSERT INTO auction_has_category_auction (auction_auction_id, category_auction_category_auction_id) VALUES(1,3);
INSERT INTO auction_has_category_auction (auction_auction_id, category_auction_category_auction_id) VALUES(1,4);

insert into bidding (bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('30000',now(),'user1',1);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('50000',now(),'user1',1);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('100000',now(),'user1',1);
insert into bidding (bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('30000',now(),'user1',2);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('40000',now(),'user1',2);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('120000',now(),'user2',1);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('150000',now(),'user1',1);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('200000',now(),'user1',4);
insert into bidding (bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('300000',now(),'user1',5);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('400000',now(),'user1',6);
insert into bidding (bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('100000',now(),'user1',7);
insert into bidding (bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('70000',now(),'user2',2);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('480000',now(),'user1',6);
insert into bidding ( bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('520000',now(),'user1',6);
insert into bidding (bidding_bid, bidding_biddate, user_user_id, auction_auction_id) 
value('760000',now(),'user1',6);

 insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "smart-watch-821559_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 1);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "power-bank-925569_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 2);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "old-6880626_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 3);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "gaming-mouse-6159550_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 4);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "diamond-1817291_640.png", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 5);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "fan-6521496_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 6);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "book-6957870_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 7);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "minecraft-1816996_640.png", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 8);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "design-1210160_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 9);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "wedding-ring-2666265_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 10);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "kicks-2213619_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 11);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "mount-halla-4822598_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 12);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "kimchi-7259268_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 13);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "money-2298511_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 14);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "wig-1048539_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 15);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "leather-2098495_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 16);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "film-2499924_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 17);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "makeup-6698881_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 18);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "iriver-1062987_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 19);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "armoire-575821_640.png", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 20);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "glass-83592_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 21);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "valentines-day-3984154_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 22);
insert into auction_imgs (auction_imgs_origin_name, auction_imgs_new_name, auction_imgs_webdir, auction_auction_id ) values("default.jpg", "instrument-4118588_640.jpg", "E:\\TJ\\semi-project\\OTA-real-workspace\\OTA\\src\\main\\webapp\\views\\auction\\imgs", 23);

 