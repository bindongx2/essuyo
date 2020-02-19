/* 테이블 생성할 때 제약조건을 기입하는 방식입니다.
 * 생성할 때 값들이 적용되므로 테이블 생성에 있어 순서가 존재합니다. */

DROP DATABASE essuyo;
CREATE DATABASE essuyo;
USE essuyo;

/* 사용가능시설목록 */
CREATE TABLE facility (
	id INTEGER PRIMARY KEY auto_increment,	/* 번호 */
	name VARCHAR(255) NOT NULL				/* 이름 */
)DEFAULT CHARSET=utf8; 

/* 지역명목록 */
CREATE TABLE area_list (
	id INTEGER PRIMARY KEY auto_increment,	/* 번호 */
	name VARCHAR(255) NOT NULL				/* 이름 */
)DEFAULT CHARSET=utf8; 

/* 상품 */
CREATE TABLE product (
	id INTEGER PRIMARY KEY auto_increment,		/* 번호 */
	name VARCHAR(255) NOT NULL,					/* 이름 */
	sale_start_date DATE NOT NULL,				/* 판매시작일 */
	sale_end_date DATE NOT NULL,				/* 판매종료일 */
	discription VARCHAR(255) NOT NULL,			/* 설명 */
	price INTEGER NOT NULL						/* 가격 */
)DEFAULT CHARSET=utf8; 

/* 상품 재고 */
CREATE TABLE product_manager (
	id INTEGER PRIMARY KEY auto_increment,	/* 번호 */
	sale_date DATE NOT NULL,				/* 판매일 */
	count INTEGER NOT NULL,					/* 개수 */
	product_id INTEGER NOT NULL,			/* 상품번호 */
	
	FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE 
)DEFAULT CHARSET=utf8; 



/* 이미지파일정보 */
CREATE TABLE image_info (
	id INTEGER PRIMARY KEY auto_increment,	/* 번호 */
	save_path VARCHAR(255) NOT NULL, 		/* 저장위치 */
	type VARCHAR(255) NOT NULL,				/* 종류 */
	name VARCHAR(255) NOT NULL,				/* 이름 */
	cre_date DATE NOT NULL,					/* 생성날짜 */
	mod_date DATE							/* 수정_날짜 */
)DEFAULT CHARSET=utf8; 


/* 업체 목록 */
CREATE TABLE company (
	id INTEGER PRIMARY KEY auto_increment, /* 번호 */
	name VARCHAR(255) NOT NULL, /* 이름 */
	type VARCHAR(255) NOT NULL, /* 회사 종류*/
	discription VARCHAR(255), /* 설명 */
	score  DECIMAL(2,1), /* 점수 */
	address VARCHAR(255) NOT NULL, /* 주소 */
	number VARCHAR(255) NOT NULL, /* 전화번호 */
	homepage VARCHAR(255), /* 홈페이지 */
	state VARCHAR(255) NOT NULL, /* 영업상태 */
	time VARCHAR(255) NOT NULL, /* 영업시간 */
	area_list_id INTEGER , /* 지역명목록번호 */
	
	FOREIGN KEY (area_list_id) REFERENCES area_list(id)
)DEFAULT CHARSET=utf8; 


/* 사업 */
CREATE TABLE business (
	id INTEGER PRIMARY KEY auto_increment, /* 번호 */
	good INTEGER, /* 좋아요 */
	comment VARCHAR(255), /* 한마디 */
	company_id INTEGER, /* 상점번호 */
	
	FOREIGN KEY (company_id) REFERENCES company(id)
)DEFAULT CHARSET=utf8; 


/* 사용자 */
CREATE TABLE user (
	id INTEGER PRIMARY KEY auto_increment, /* 번호 */
	name VARCHAR(255) NOT NULL, /* 이름 */
	age INTEGER NOT NULL, /*나이*/
	gender VARCHAR(255) NOT NULL, /*성별*/
	email VARCHAR(255) UNIQUE NOT NULL, /* 이메일 */
	password VARCHAR(255) NOT NULL, /* 비밀번호 */
	fail_password INTEGER NOT NULL, /* 비밀번호실패 */
	cre_date DATE NOT NULL, /* 생성날짜 */
	last_date DATE, /* 마지막로그인날짜 */
    /*2019-05-31 추가 */
    juso varchar(255) NOT NULL, /*주소*/
    phone_no varchar(255) NOT NULL, /*핸드폰 번호*/
	business_id INTEGER, /* 사업번호 */
	image_info_id INTEGER,
	
	FOREIGN KEY (business_id) REFERENCES business(id) ON DELETE CASCADE,
	FOREIGN KEY (image_info_id) REFERENCES image_info(id) ON DELETE CASCADE
)DEFAULT CHARSET=utf8; 

/* 덧글 */
CREATE TABLE comment (
	id INTEGER PRIMARY KEY auto_increment, /* 번호 */
	title VARCHAR(255) NOT NULL, /* 제목 */
	content  VARCHAR(255), /* 내용 */
	helpful INTEGER default 0, /* 도움점수 */
	score INTEGER NOT NULL, /* 점수 */
	mod_date DATE, /* 수정날짜 */
	reg_date timestamp not null default now(), /* 등록날짜 */
	user_id INTEGER NOT NULL,/* 사용자번호 */
	company_id INTEGER NOT NULL,/* 회사번호 */
	
	CONSTRAINT chk_score CHECK (score > 0 AND score <=5),
	FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
	FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE
)DEFAULT CHARSET=utf8; 

/* 메시지 */
CREATE TABLE message (
	megNum INTEGER PRIMARY KEY auto_increment, /* 번호 */
	title VARCHAR(255) NOT  NULL, /* 제목 */	
	content TEXT, /* 내용 */
	send_date timestamp not null default now(), /* 보낸날짜 */	
	read_check INTEGER , /* 읽음확인 */
	user_id VARCHAR(255) NOT NULL, /* 발송자 사용자번호 */
    receiver_id VARCHAR(255) NOT NULL, /* 수신자 사용자번호 */	
	
    FOREIGN KEY (user_id) REFERENCES user(email) ON DELETE CASCADE,
	FOREIGN KEY (receiver_id) REFERENCES user(email) ON DELETE CASCADE
)DEFAULT CHARSET=utf8; 

/* 공지사항 */
CREATE TABLE notice (
	noticeNum INTEGER PRIMARY KEY auto_increment, /* 번호 */
	title VARCHAR(255) NOT  NULL, /* 제목 */	
	content TEXT, /* 내용 */
	reg_date timestamp not null default now(), /* 등록날짜 */	
	user_id VARCHAR(255) NOT NULL, /* 작성자 사용자번호 */	
	
   FOREIGN KEY (user_id) REFERENCES user(email) ON DELETE CASCADE
)DEFAULT CHARSET=utf8; 

/* 상품관리 */
CREATE TABLE product_admin (
	id INTEGER PRIMARY KEY auto_increment, /*상품 관리 번호*/
	company_id INTEGER, /* 사업종류번호 */
	product_id INTEGER,
	
	FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);

/* 사용가능시설 */
CREATE TABLE facility_admin (
	company_id INTEGER , /* 회사번호 */
	facility_id INTEGER,  /* 사용가능시설목록번호 */
	
	FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
	FOREIGN KEY (facility_id) REFERENCES facility(id) ON DELETE CASCADE
);


/* 회사이미지관리 */
CREATE TABLE company_image_admin (
	id INTEGER PRIMARY KEY auto_increment, /*회사이미지관리 번호*/
	company_id INTEGER, /* 회사번호 */
	image_info_id INTEGER, /* 이미지정보번호 */
	
	FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
	FOREIGN KEY (image_info_id) REFERENCES image_info(id) ON DELETE CASCADE
)DEFAULT CHARSET=utf8;

/* 상품이미지관리 */
CREATE TABLE product_image_admin (
	id INTEGER PRIMARY KEY auto_increment, /*상품 관리 번호*/
	product_id INTEGER, /* 상품 번호 */
	image_info_id INTEGER, /* 이미지 관리 번호 */
	
	FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
	FOREIGN KEY (image_info_id) REFERENCES image_info(id) ON DELETE CASCADE
)DEFAULT CHARSET=utf8; 

/* 예약 */
CREATE TABLE reservation (
	id INTEGER PRIMARY KEY  auto_increment, /* 번호 */
	state VARCHAR(255) NOT NULL, /* 상태 */
	product_type VARCHAR(255) NOT NULL,
	total_price INTEGER NOT NULL, /* 총가격 */
	res_date DATE NOT NULL, /* 예약한날짜 */
	product_count INTEGER NOT NULL, /* 상품 개수 */
	reg_date DATE NOT NULL, /* 등록날짜 */
	company_id INTEGER , /* 회사_번호 */
	product_id INTEGER , /* 상품_번호 */
	user_id INTEGER ,  /* 사용자_번호 */
	
	FOREIGN KEY (company_id) REFERENCES company(id),
	FOREIGN KEY (product_id) REFERENCES product(id),
	FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
)DEFAULT CHARSET=utf8; 

/* QnA */
CREATE TABLE qna (
	id INTEGER PRIMARY KEY auto_increment, /* 번호 */
    title VARCHAR(255) NOT NULL, /* 제목 */
    content text, /* 내용 */
    reg_date timestamp not null default now(), /* 등록날짜 */	
    user_id VARCHAR(255) NOT NULL, /* 사용자_번호*/    
    view_count INTEGER default 0 , /* 조회수 */
    
    FOREIGN KEY (user_id) REFERENCES user(email)
)DEFAULT CHARSET=utf8;



/*********************************************************************************/
/************************************ 데이터 입력 ************************************/
/*********************************************************************************/

/* 지역명목록 */
INSERT INTO area_list (name)  VALUES("서울");
INSERT INTO area_list (name)  VALUES("부산");
INSERT INTO area_list (name)  VALUES("광주");
INSERT INTO area_list (name)  VALUES("강원도");

INSERT INTO facility(name)  VALUES("주차공간");
INSERT INTO facility(name)  VALUES("와이파이/인터넷");
INSERT INTO facility(name)  VALUES("금연구역");
INSERT INTO facility(name)  VALUES("신용카드");

/* 이미지 */
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_1.png","image/png","Hotel_seoul_1.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_2.png","image/png","Hotel_seoul_2.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_3.png","image/png","Hotel_seoul_3.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_4.png","image/png","Hotel_seoul_4.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_5.png","image/png","Hotel_seoul_5.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_6.png","image/png","Hotel_seoul_6.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_7.png","image/png","Hotel_seoul_7.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_8.png","image/png","Hotel_seoul_8.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_9.png","image/png","Hotel_seoul_9.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_10.png","image/png","Hotel_seoul_10.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_11.png","image/png","Hotel_seoul_11.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_seoul_12.png","image/png","Hotel_seoul_12.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_busan_1.png","image/png","Hotel_busan_1.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_gangwon_1.png","image/png","Hotel_gangwon_1.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/hotel/Hotel_gwangju_1.png","image/png","Hotel_gwangju_1.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt1.jpg","image/jpg","restraunt1.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt2.jpg","image/jpg","restraunt2.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt3.jpg","image/jpg","restraunt3.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt4.jpg","image/jpg","restraunt4.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt5.jpg","image/jpg","restraunt5.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt6.jpg","image/jpg","restraunt6.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt7.jpg","image/jpg","restraunt7.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt8.jpg","image/jpg","restraunt8.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt9.jpg","image/jpg","restraunt9.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt10.jpg","image/jpg","restraunt10.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt11.jpg","image/jpg","restraunt11.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt12.jpg","image/jpg","restraunt12.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt13.jpg","image/jpg","restraunt13.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt14.jpg","image/jpg","restraunt14.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/restraunt/restraunt15.jpg","image/jpg","restraunt15.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/31.jpg","image/jpg","31.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/32.jpg","image/jpg","32.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/33.jpg","image/jpg","33.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/34.jpg","image/jpg","34.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/35.jpg","image/jpg","35.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/36.jpg","image/jpg","36.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/37.jpg","image/jpg","37.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/38.jpg","image/jpg","38.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/39.jpg","image/jpg","39.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/40.jpg","image/jpg","40.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/41.jpg","image/jpg","41.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/42.jpg","image/jpg","42.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/43.jpg","image/jpg","43.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/44.jpg","image/jpg","44.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/museum/45.jpg","image/jpg","45.jpg", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car01.png","image/png","car01.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car02.png","image/png","car02.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car03.png","image/png","car03.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car04.png","image/png","car04.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car05.png","image/png","car05.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car06.png","image/png","car06.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car07.png","image/png","car07.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car08.png","image/png","car08.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car09.png","image/png","car09.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car10.png","image/png","car10.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car11.png","image/png","car11.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car12.png","image/png","car12.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car13.png","image/png","car13.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car14.png","image/png","car14.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/rentcar/car15.png","image/png","car15.png", now());
INSERT INTO image_info (save_path, type ,name, cre_date ) VALUES("/resources/images/default-user.png","image/png","default-user.png", now());


INSERT INTO company(name, type, score, discription, address, number, homepage, state, time, area_list_id ) 
VALUES("롯데 호텔", "숙박", 4.5,"쇼핑몰과 연결되는 2개의 호텔 건물","중구 을지로 30","02-771-1000", "www.lottehotel.com", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("롯데시티호텔", "숙박", 5.0,"서울특별시청 근처에 위치한 4성급 호텔" , "서울특별시 중구 장교동 74", "02-6112-1000", "www.lottehotel.com", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("호텔 베뉴지", "숙박", 3.5, "서울의 종로에 위치한 3.5성급 호텔","서울특별시 종로구 청계천로 117",  "02-2223-6500", "www.hotelvenueg.com", "영업중", "ALL TIME" ,1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("르와지르 호텔 서울", "숙박", 4.0, "숭례문 근처에 위치한 3.5성급 호텔", "서울특별시 중구 충무로1가 24-1", "02-6936-6000", "www.loisir-md.com", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("L7 명동 바이 롯데","숙박", 1.8, "명동에 위치한 4성급 호텔","서울특별시 중구 퇴계로 137", "02-3480-0166", "www.lottehotel.com", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("호텔 피제이","숙박", 3.7,"서울의 인기 관광 명소로 무료 셔틀을 운행하고 대중교통도 편리하게 이용 가능", "서울특별시 중구 마른내로 71 (주)오일관광풍전호텔",  "02-2266-2151", "www.hotelpj.co.kr/", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("이그제큐티브 타워","숙박", 2.5, "도시 전망을 자랑합니다", " 서울 중구 을지로 30",  "02-759-7311", "www.lottehotel.com", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("이비스 앰배서더","숙박", 4.4, "객실은 넓은 창문을 갖추고 있어 서울시를 조망해 보시기에 좋습니다","서울특별시 중구 남대문로 78",  "02-6361-8888", "ibis.ambatel.com ", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("호텔 스카이파크 센트럴","숙박", 1.9, "서울 지하철 2호선 을지로1가역에서 250m 거리", "서울특별시 중구 명동9길 16 명동 센트럴빌딩",  "02-752-0022", "www.skyparkhotel.com", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("솔라리아 니시테츠 호텔","숙박", 3.2, "눈스퀘어에서 200m", "서울특별시 중구 명동8길 27 엠 플라자", "02-773-1555", "www.nnr-h.com/", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("세종 호텔","숙박", 5.0, "남산 건너편에 위치한 4성급 호텔", "서울특별시 중구 퇴계로 145 세종호텔",  "02-773-6000", "www.sejong.co.kr/", "영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("ENA 스위트 호텔","숙박", 4.4, "일품요리 조식","서울특별시 중구 세종대로11길 36",  "02-6020-7000", "www.enahotel.co.kr","영업중", "ALL TIME", 1);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("라마다 앙코르","숙박", 4.7, "부산의 해운대에 위치한 4성급 호텔", "부산광역시 해운대구 구남로 9", "051-610-3000", "www.ramadaencorehaeundae.com/", "영업중", "ALL TIME", 2);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("세인트존스 호텔","숙박", 5.0,"신나는 해변의 호텔 사우나 이용 가능","강원도 강릉시 창해로 307",  "033-660-9000", "stjohns.co.kr", "영업중", "ALL TIME", 3);
INSERT INTO company(name, type, score, discription,  address, number, homepage, state, time, area_list_id ) 
VALUES("라마다 플라자","숙박", 0.8,  "4성급 호텔, 2 개의 레스토랑 및 2 개의 스파 욕조 이용 가능","광주광역시 서구 상무자유로 149 라마다프라자호텔", "062-717-7000", "www.ramadagwangju.com", "영업중", "ALL TIME", 4);
	
/* 카테고리(레스토랑) */
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("해운대 식당", "식당", 4.2 , "부산 해운대 근처", "부산광역시 해운대구 해운대해변로 52","010-6291-2938",
"restrauntOne.com","영업중","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("센텀 식당", "식당", 3.1 , "부산 해운대 근처", "부산광역시 해운대구 센텀남대로 76","02-803-1405",
"restrauntTwo.com","영업중","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("광안해변 식당", "식당", 3.6 , "부산 해운대 근처", "부산광역시 수영구 광안해변로 386","010-3048-1246",
"restrauntThree.co.kr","영업종료","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("우동로 식당", "식당", 1.8 , "부산 해운대 근처", "부산광역시 해운대구 우동1로85번길 25","010-3009-1833",
"restrauntFour.co.kr","영업종료","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("수영 식당", "식당", 2.6 , "부산 해운대 근처", "부산광역시 수영구 수영동 432-1","010-7090-1092",
"restrauntFive.com","영업중","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("구남로 식당", "식당", 4.8 , "부산 해운대 근처", "부산광역시 해운대구 구남로29번길 21","010-5097-1021",
"restrauntSix.com","영업중","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("천일사 식당", "식당", 1.5 , "부산 해운대 근처", "부산광역시 해운대구 우동 1104-1","010-6079-9065",
"restrauntSeven.co.kr","영업종료","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("광안 식당", "식당", 3.6 , "부산 해운대 근처", "부산광역시 수영구 광안동 140-18","010-9854-1457",
"restrauntEight.co.kr","영업종료","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("동백 식당", "식당", 4.9 , "돈만 있으면 쾌적한 곳1", "부산광역시 해운대구 동백로 116","010-5831-2947",
"restrauntNine.com","영업중","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("한화 식당", "식당", 4.1 , "부산 해운대 근처", "부산광역시 해운대구 마린시티3로 52 한화리조트","010-6421-1268",
"restrauntTen.com","영업중","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("이마트 식당", "식당", 1.4 , "부산 해운대 근처", "부산광역시 해운대구 좌동순환로 511 E-마트해운대점","010-3446-3312",
"restrauntEleven.co.kr","영업종료","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("좌동 식당", "식당", 3.1 , "부산 해운대 근처", "부산광역시 해운대구 좌동순환로99번길 7","010-2235-6684",
"restrauntTwelve.co.kr","영업종료","ALL TIME",2);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("이대 식당", "식당", 1.6 , "서울 이대역 근처", "서울특별시 서대문구 연세로2길 98","010-2241-7784",
"restrauntThirteen.co.kr","영업중","ALL TIME",1);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("광주 월드컵 식당", "식당", 3.7 , "광주 월드컵 경기장", "광주광역시 서구 금화로 240 월드컵경기장","010-2256-4451",
"www.restrauntFourteen.com","영업중","ALL TIME",3);
INSERT INTO company(name, type, score, discription, address,number, homepage, state, time, area_list_id)
VALUES("한림 식당", "식당", 4.2 , "강원도 한림대 변화가", "강원도 춘천시 한림대학길 1","010-6774-2231",
"restrauntfifteen.co.kr","영업중","ALL TIME",4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("국립광주 박물관", "문화", "광주광역시 대표 박물관", 4, "광주 북구 하서로 110", "062-570-7001", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("남도향토음식박물관", "문화", "남도음식 대표 박물관", 3.5, "광주 북구 설죽로 477", "062-570-7002", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("비움 박물관", "문화", "마음을 비웁니다", 2, "광주 동구 제봉로 143-1", "062-570-7003", "http://gwangju.museum.go.kr/", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("전남대학교 박물관", "문화", "전남대학교 대표 박물관", 1, "광주 북구 용봉로 77 전남대학교", "062-570-7004", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("국립광주 어린이박물관", "문화", "어린이를 위한 박물관", 5, "광주 북구 하서로 110", "062-570-7005", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("광주광역시립민속박물관", "문화", "광주의 민속 대표 박물관", 3, "광주 북구 서하로 48-25", "062-570-7006", "gwangju.museum.go.kr/", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("한국미용박물관", "문화", "한국의 미용을 알수있습니다.", 2, "광주 북구 용봉로 116", "062-570-7007", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("세계카메라영화박물관", "문화", "세계의 카메라로 찍은 영화", 3.5, "광주 동구 동계로 5", "062-570-7008", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("광주교육대학교 교육박물관", "문화", "광주교대 대표 박물관", 3, "광주 북구 필문대로 55 광주교육대학교", "062-570-7009", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("전남대학교 의학박물관", "문화", "의학대학 대표 박물관", 1.4, "광주 동구 백서로 160", "062-570-7010", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("조선대학교 장황남정보통신박물관", "문화", "조선대학교 대표 박물관", 4, "광주 동구 필문대로 309 조선대학교", "062-570-7011", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("518민주화운동기록관", "문화", "518민주화운동 대표 기록관", 3.2, "광주 동구 금남로 221", "062-570-7012", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 3);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("부산박물관", "문화", "부산광역시 대표 박물관", 3, "부산 남구 유엔평화로 63 부산광역시시립박물관", "051-610-7111", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 2);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("국립춘천박물관", "문화", "강원도의 대표 박물관", 4.5, "강원 춘천시 우석로 70 국립춘천박물관", "033-260-1500", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) 
VALUES("서울 역사박물관", "문화", "대한민국 대표 역시박물관", 4.7, "서울 종로구 새문안로 55", "02-123-1234", "gwangju.museum.go.kr", "영업중", "평일 10:00 ~ 18:00", 1);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("하나 렌트카", "차량대여", "강원도 제일의 렌트카", 2.7, "강원도 양양군 양양읍 관아길 13-32", "010-5656-2225", "www.rentCar1.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("두리 렌트카", "차량대여", "강원도 두번째 렌트카", 3.7, "강원도 양양군 양양읍 군청길 15", "010-5656-5675", "www.rentCar2.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("세니 렌트카", "차량대여", "강원도 셋째가는 렌트카", 4.9, "강원도 양양군 양양읍 월리 449-1", "010-5656-2323", "www.rentCar3.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("네시 렌트카", "차량대여", "강원도 넷째 렌트카", 1.2, "강원도 양양군 양양읍 동해대로 2996", "010-5656-3467", "www.rentCar4.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("다솜 렌트카", "차량대여", "강원도 다섯번째 렌트카", 2.5, "강원도 양양군 손양면 하왕도리 303", "010-5656-2233", "www.rentCar5.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("여솔 렌트카", "차량대여", "강원도 여섯번째 렌트카", 5.0, "강원도 양양군 손양면 손중로 177", "010-5656-8000", "www.rentCar6.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("칠리 렌트카", "차량대여", "강원도 일곱번째 렌트카", 3.5, "강원도 양양군 손양면 굴개길 72", "010-5656-8676", "www.rentCar7.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("팔도 렌트카", "차량대여", "강원도 여덜번째 렌트카", 4.2, "강원도 양양군 손양면 선사유적로 244", "010-5656-8123", "www.rentCar8.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("구구 렌트카", "차량대여", "강원도 아홉번째 렌트카", 4.5, "강원도 양양군 손양면 굴개길 1-12", "010-5656-8888", "www.rentCar9.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("열정 렌트카", "차량대여", "강원도 열번째 렌트카", 3.9, "강원도 양양군 양양읍 관아길 13-32", "010-5656-8232", "www.rentCar10.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("열하 렌트카", "차량대여", "강원도 열한번째 렌트카", 2.7, "강원도 양양군 손양면 선사유적로 359", "010-5656-8944", "www.rentCar11.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("열두 렌트카", "차량대여", "강원도 열두번째 렌트카", 4.8, "강원도 양양군 서면 떡마을길 85-10", "010-5656-8323", "www.rentCar12.com", "영업중", "09:00 ~ 18:00", 4);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("열세 렌트카", "차량대여", "서울 열세번째 렌트카", 2.3, "서울특별시 중구 동호로33길 24", "010-5656-7923", "www.rentCar13.com", "영업중", "09:00 ~ 18:00", 1);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("열네 렌트카", "차량대여", "부산 열네번째 렌트카", 1.7, "부산광역시 연제구 거제대로74번길 71", "010-5656-8323", "www.rentCar14.com", "영업중", "09:00 ~ 18:00", 2);
INSERT INTO company(name, type,  discription, score, address, number, homepage, state, time, area_list_id ) VALUES("열다 렌트카", "차량대여", "광주 열닷번째 렌트카", 1.1, "광주광역시 서구 월드컵4강로 223", "010-5656-4443", "www.rentCar15.com", "영업중", "09:00 ~ 18:00", 3);


INSERT INTO facility_admin(company_id, facility_id) VALUES(1,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(1,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(1,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(2,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(2,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(2,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(3,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(3,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(3,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(3,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(3,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(3,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(4,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(4,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(4,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(5,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(5,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(6,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(6,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(7,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(7,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(8,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(8,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(9,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(9,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(10,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(11,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(11,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(11,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(12,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(12,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(13,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(13,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(14,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(15,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(16,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(16,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(16,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(17,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(17,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(18,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(18,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(19,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(19,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(19,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(19,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(20,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(20,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(20,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(21,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(21,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(22,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(22,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(22,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(23,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(23,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(24,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(24,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(25,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(25,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(26,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(26,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(27,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(27,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(28,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(28,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(29,2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(29,3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(30,1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(30,4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(31, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(31, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(31, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(31, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(32, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(32, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(32, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(32, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(33, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(33, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(33, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(34, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(34, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(34, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(35, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(35, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(35, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(36, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(36, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(36, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(36, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(37, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(38, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(38, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(38, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(39, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(39, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(39, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(40, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(40, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(41, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(41, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(41, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(42, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(42, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(43, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(44, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(44, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(45, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(45, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(45, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(45, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(46, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(46, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(47, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(47, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(48, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(48, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(49, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(49, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(49, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(50, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(50, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(50, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(51, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(51, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(52, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(52, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(53, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(53, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(54, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(54, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(55, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(55, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(55, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(56, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(56, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(57, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(57, 2);
INSERT INTO facility_admin(company_id, facility_id) VALUES(57, 3);
INSERT INTO facility_admin(company_id, facility_id) VALUES(57, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(58, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(58, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(59, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(59, 4);
INSERT INTO facility_admin(company_id, facility_id) VALUES(60, 1);
INSERT INTO facility_admin(company_id, facility_id) VALUES(60, 4);





INSERT INTO business (good, comment, company_id) VALUES(50,"전망 좋은 호텔",1);
INSERT INTO business (good, comment, company_id) VALUES(110,"도심 야경이 보이는 호텔",2);
INSERT INTO business (good, comment, company_id) VALUES(48,"남산이 보이는 호텔",3);
INSERT INTO business (good, comment, company_id) VALUES(54,"서울 시내가 보이는 호텔",4);
INSERT INTO business (good, comment, company_id) VALUES(25,"전망 좋은 호텔",5);
INSERT INTO business (good, comment, company_id) VALUES(230,"전망 좋은 호텔",6);
INSERT INTO business (good, comment, company_id) VALUES(548,"전망 좋은 호텔",7);
INSERT INTO business (good, comment, company_id) VALUES(552,"전망 좋은 호텔",8);
INSERT INTO business (good, comment, company_id) VALUES(652,"전망 좋은 호텔",9);
INSERT INTO business (good, comment, company_id) VALUES(221,"전망 좋은 호텔",10);
INSERT INTO business (good, comment, company_id) VALUES(95,"전망 좋은 호텔",11);
INSERT INTO business (good, comment, company_id) VALUES(75,"전망 좋은 호텔",12);
INSERT INTO business (good, comment, company_id) VALUES(36,"전망 좋은 호텔",13);
INSERT INTO business (good, comment, company_id) VALUES(21,"전망 좋은 호텔",14);
INSERT INTO business (good, comment, company_id) VALUES(12,"전망 좋은 호텔",15);
INSERT INTO business (good, comment, company_id) VALUES(48,"해운대 식당입니다. 잘부탁드립니다.",16);
INSERT INTO business (good, comment, company_id) VALUES(553,"센텀 식당입니다. 잘부탁드립니다.",17);
INSERT INTO business (good, comment, company_id) VALUES(332,"광안해변 식당입니다. 잘부탁드립니다.",18);
INSERT INTO business (good, comment, company_id) VALUES(1,"우동로 식당입니다. 잘부탁드립니다.",19);
INSERT INTO business (good, comment, company_id) VALUES(80,"수영 식당입니다. 잘부탁드립니다.",20);
INSERT INTO business (good, comment, company_id) VALUES(999,"구남로 식당입니다. 잘부탁드립니다.",21);
INSERT INTO business (good, comment, company_id) VALUES(556,"천일사 식당입니다. 잘부탁드립니다.",22);
INSERT INTO business (good, comment, company_id) VALUES(332,"광안 식당입니다. 잘부탁드립니다.",23);
INSERT INTO business (good, comment, company_id) VALUES(551,"동백 식당입니다. 잘부탁드립니다.",24);
INSERT INTO business (good, comment, company_id) VALUES(223,"한화 식당입니다. 잘부탁드립니다.",25);
INSERT INTO business (good, comment, company_id) VALUES(467,"이마트 식당입니다. 잘부탁드립니다.",26);
INSERT INTO business (good, comment, company_id) VALUES(111,"좌동 식당입니다. 잘부탁드립니다.",27);
INSERT INTO business (good, comment, company_id) VALUES(56,"이대 식당입니다. 잘부탁드립니다.",28);
INSERT INTO business (good, comment, company_id) VALUES(75,"광주 월드컵 식당입니다. 잘부탁드립니다.",29);
INSERT INTO business (good, comment, company_id) VALUES(10,"한림 식당입니다. 잘부탁드립니다.",30);
INSERT INTO business (good, comment, company_id) VALUES(10, "광주를 알수 있어염", 31);
INSERT INTO business (good, comment, company_id) VALUES(8, "남도음식을 알수 있어염", 32);
INSERT INTO business (good, comment, company_id) VALUES(6, "마음을 비울수 있어염", 33);
INSERT INTO business (good, comment, company_id) VALUES(8, "전남대학교 알수 있어염", 34);
INSERT INTO business (good, comment, company_id) VALUES(10, "어린이들이 즐거워염", 35);
INSERT INTO business (good, comment, company_id) VALUES(12, "민속을 알수 있어염", 36);
INSERT INTO business (good, comment, company_id) VALUES(31, "미용을 알수 있어염", 37);
INSERT INTO business (good, comment, company_id) VALUES(33, "영화를 알수 있어염", 38);
INSERT INTO business (good, comment, company_id) VALUES(5, "교대를 알수 있어염", 39);
INSERT INTO business (good, comment, company_id) VALUES(4, "의대를 알수 있어염", 40);
INSERT INTO business (good, comment, company_id) VALUES(41, "조선대를 알수 있어염", 41);
INSERT INTO business (good, comment, company_id) VALUES(12, "518을 알수 있어염", 42);
INSERT INTO business (good, comment, company_id) VALUES(33, "부산을 알수 있어염", 43);
INSERT INTO business (good, comment, company_id) VALUES(50, "춘천을 알수 있어염", 44);
INSERT INTO business (good, comment, company_id) VALUES(152, "대한민국을 알수 있어염", 45);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 46);
INSERT INTO business (good, comment, company_id) VALUES(0, "안전점검 확실합니다!", 47);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다", 48);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 49);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 50);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 51);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 52);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 53);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 54);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 55);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 56);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 57);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 58);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 59);
INSERT INTO business (good, comment, company_id) VALUES(0, "싸게 해드립니다!", 60);


INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("김정환", 55, "남", "abc1@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 1, 1);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개2", 21, "여", "abc2@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 2, 2);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개3", 21, "여", "abc3@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 3, 3);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개4", 21, "남", "abc4@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 4, 4);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개5", 21, "여", "abc5@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 5, 5);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개6", 21, "남", "abc6@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 6, 6);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개7", 21, "남", "abc7@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 7, 7);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개8", 21, "남", "abc8@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 8, 8);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개9", 21, "여", "abc9@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 9, 9);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개10", 21, "여", "abc10@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 10, 10);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개11", 21, "여", "abc11@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 11, 11);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개12", 21, "남", "abc12@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 12, 12);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개13", 21, "여", "abc13@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 13, 13);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개14", 21, "남", "abc14@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 14, 14);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
	VALUES("아무개15", 21, "남", "abc15@gmail.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 15, 15);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동16", 20, "남", "hong@naver16.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 16, 16);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동17", 20, "남", "hong@naver17.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 17, 17);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동18", 20, "남", "hong@naver18.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 18, 18);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동19", 20, "남", "hong@naver19.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 19, 19);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동20", 20, "남", "hong@naver20.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 20, 20);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동21", 20, "남", "hong@naver21.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 21, 21);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동22", 20, "남", "hong@naver22.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 22, 22);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동23", 20, "남", "hong@naver23.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 23, 23);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동24", 20, "남", "hong@naver24.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 24, 24);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동25", 20, "남", "hong@naver25.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 25, 25);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동26", 20, "남", "hong@naver26.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 26, 26);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동27", 20, "남", "hong@naver27.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 27, 27);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동28", 20, "남", "hong@naver28.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 28, 28);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동29", 20, "남", "hong@naver29.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 29, 29);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("홍길동30", 20, "남", "hong@naver30.com", SHA2('1234',512), 0,"2018-10-01","서울특별시 금천구","010-4879-8545", 30, 30);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동01", 21, "남자", "museum01@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 31, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동02", 22, "남자", "museum02@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 32, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동03", 23, "남자", "museum03@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 33, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동04", 24, "남자", "museum04@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 34, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동05", 25, "남자", "museum05@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 35, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동06", 26, "남자", "museum06@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 36, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동07", 27, "남자", "museum07@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 37, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동08", 28, "남자", "museum08@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 38, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동09", 29, "남자", "museum09@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 39, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동10", 30, "남자", "museum10@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 40, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동11", 31, "남자", "museum11@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 41, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동12", 32, "남자", "museum12@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 42, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동13", 33, "남자", "museum13@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 43, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동14", 34, "남자", "museum14@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 44, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) 
VALUES("홍길동15", 35, "남자", "museum15@aaa.com", SHA2('1234',512), 0, "2018-10-10","서울특별시 금천구","010-4879-8545", 45, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("한대여", 24, "남", "car1@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 46, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("두대여", 34, "남", "car2@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 47, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("세대여", 52, "남", "car3@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 48, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("네대여", 55, "남", "car4@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 49, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("다대여", 43, "남", "car5@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 50, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("여대여", 37, "남", "car6@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 51, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("일대여", 39, "여", "car7@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 52, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("엳대여", 50, "남", "car8@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 53, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("아대여", 67, "남", "car9@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 54, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("열대여", 36, "여", "car10@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 55, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("옇대여", 40, "여", "car11@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 56, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("엽대여", 42, "남", "car12@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 57, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("엿대여", 44, "여", "car13@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 58, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("연대여", 50, "남", "car14@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 59, 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, business_id, image_info_id) VALUES("달대여", 63, "여", "car15@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 60, 1);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("한대여", 24, "남", "abcde61@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("두대여", 34, "여", "abcde62@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("세대여", 52, "남", "abcde63@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("네대여", 55, "여", "abcde64@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("다대여", 43, "남", "abcde65@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("여대여", 37, "여", "abcde66@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("일대여", 39, "남", "abcde67@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("엳대여", 50, "여", "abcde68@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("아대여", 67, "남", "abcde69@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("열대여", 36, "여", "abcde70@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);
INSERT INTO user(name, age, gender, email, password, fail_password, cre_date, juso, phone_no, image_info_id) VALUES("옇대여", 40, "남", "abcde71@rent.com", SHA2('1234',512), 0, NOW(),"서울특별시 금천구","010-4879-8545", 61);




INSERT INTO company_image_admin (company_id , image_info_id) VALUES(1,1);
INSERT INTO company_image_admin (company_id , image_info_id) VALUES(1,2);
INSERT INTO company_image_admin (company_id , image_info_id) VALUES(1,3);
INSERT INTO company_image_admin (company_id , image_info_id) VALUES(2,2);
INSERT INTO company_image_admin (company_id , image_info_id) VALUES(2,3);
INSERT INTO company_image_admin (company_id , image_info_id) VALUES(2,1);
INSERT INTO company_image_admin (company_id , image_info_id) VALUES(3,3);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(4,4);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(5,5);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(6,6);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(7,7);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(8,8);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(9,9);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(10,10);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(11,11);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(12,12);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(13,13);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(14,14);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(15,15);
INSERT INTO company_image_admin(company_id , image_info_id) values(16,16);
INSERT INTO company_image_admin(company_id , image_info_id) values(16,30);
INSERT INTO company_image_admin(company_id , image_info_id) values(16,29);
INSERT INTO company_image_admin(company_id , image_info_id) values(17,17);
INSERT INTO company_image_admin(company_id , image_info_id) values(18,18);
INSERT INTO company_image_admin(company_id , image_info_id) values(19,19);
INSERT INTO company_image_admin(company_id , image_info_id) values(20,20);
INSERT INTO company_image_admin(company_id , image_info_id) values(21,21);
INSERT INTO company_image_admin(company_id , image_info_id) values(22,22);
INSERT INTO company_image_admin(company_id , image_info_id) values(23,23);
INSERT INTO company_image_admin(company_id , image_info_id) values(23,16);
INSERT INTO company_image_admin(company_id , image_info_id) values(23,17);
INSERT INTO company_image_admin(company_id , image_info_id) values(24,24);
INSERT INTO company_image_admin(company_id , image_info_id) values(24,17);
INSERT INTO company_image_admin (company_id , image_info_id)values(24,18);
INSERT INTO company_image_admin(company_id , image_info_id) values(25,25);
INSERT INTO company_image_admin(company_id , image_info_id) values(25,18);
INSERT INTO company_image_admin(company_id , image_info_id) values(25,19);
INSERT INTO company_image_admin(company_id , image_info_id) values(26,26);
INSERT INTO company_image_admin(company_id , image_info_id) values(26,19);
INSERT INTO company_image_admin(company_id , image_info_id) values(26,20);
INSERT INTO company_image_admin(company_id , image_info_id) values(27,27);
INSERT INTO company_image_admin(company_id , image_info_id) values(27,21);
INSERT INTO company_image_admin(company_id , image_info_id) values(27,22);
INSERT INTO company_image_admin(company_id , image_info_id) values(28,28);
INSERT INTO company_image_admin(company_id , image_info_id) values(28,22);
INSERT INTO company_image_admin(company_id , image_info_id) values(28,23);
INSERT INTO company_image_admin(company_id , image_info_id) values(29,23);
INSERT INTO company_image_admin(company_id , image_info_id) values(29,24);
INSERT INTO company_image_admin(company_id , image_info_id) values(30,30);
INSERT INTO company_image_admin(company_id , image_info_id) values(30,24);
INSERT INTO company_image_admin(company_id , image_info_id) values(30,25);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(31, 31);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(31, 32);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(31, 33);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(32, 32);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(33, 33);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(34, 34);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(35, 35);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(36, 36);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(37, 37);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(38, 38);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(39, 39);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(40, 40);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(41, 41);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(42, 42);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(43, 43);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(44, 44);
INSERT INTO company_image_admin(company_id , image_info_id) VALUES(45, 45);
INSERT INTO company_image_admin(company_id , image_info_id) values(46 , 46);
INSERT INTO company_image_admin(company_id , image_info_id) values(46 , 47);
INSERT INTO company_image_admin(company_id , image_info_id) values(46 , 48);
INSERT INTO company_image_admin(company_id , image_info_id) values(47 , 47);
INSERT INTO company_image_admin(company_id , image_info_id) values(47 , 48);
INSERT INTO company_image_admin(company_id , image_info_id) values(47 , 49);
INSERT INTO company_image_admin(company_id , image_info_id) values(48 , 48);
INSERT INTO company_image_admin(company_id , image_info_id) values(48 , 49);
INSERT INTO company_image_admin(company_id , image_info_id) values(48 , 50);
INSERT INTO company_image_admin(company_id , image_info_id) values(49 , 49);
INSERT INTO company_image_admin(company_id , image_info_id) values(49 , 50);
INSERT INTO company_image_admin(company_id , image_info_id) values(49 , 51);
INSERT INTO company_image_admin(company_id , image_info_id) values(50 , 50);
INSERT INTO company_image_admin(company_id , image_info_id) values(50 , 51);
INSERT INTO company_image_admin(company_id , image_info_id) values(50 , 25);
INSERT INTO company_image_admin(company_id , image_info_id) values(51 , 51);
INSERT INTO company_image_admin(company_id , image_info_id) values(51 , 52);
INSERT INTO company_image_admin(company_id , image_info_id) values(51 , 53);
INSERT INTO company_image_admin(company_id , image_info_id) values(52 , 52);
INSERT INTO company_image_admin(company_id , image_info_id) values(52 , 53);
INSERT INTO company_image_admin(company_id , image_info_id) values(52 , 54);
INSERT INTO company_image_admin(company_id , image_info_id) values(53 , 53);
INSERT INTO company_image_admin(company_id , image_info_id) values(53 , 54);
INSERT INTO company_image_admin(company_id , image_info_id) values(53 , 55);
INSERT INTO company_image_admin(company_id , image_info_id) values(54 , 54);
INSERT INTO company_image_admin(company_id , image_info_id) values(54 , 55);
INSERT INTO company_image_admin(company_id , image_info_id) values(54 , 56);
INSERT INTO company_image_admin(company_id , image_info_id) values(55 , 55);
INSERT INTO company_image_admin(company_id , image_info_id) values(55 , 56);
INSERT INTO company_image_admin(company_id , image_info_id) values(55 , 57);
INSERT INTO company_image_admin(company_id , image_info_id) values(56 , 56);
INSERT INTO company_image_admin(company_id , image_info_id) values(56 , 57);
INSERT INTO company_image_admin(company_id , image_info_id) values(56 , 58);
INSERT INTO company_image_admin(company_id , image_info_id) values(57 , 57);
INSERT INTO company_image_admin(company_id , image_info_id) values(57 , 58);
INSERT INTO company_image_admin(company_id , image_info_id) values(57 , 59);
INSERT INTO company_image_admin(company_id , image_info_id) values(58 , 58);
INSERT INTO company_image_admin(company_id , image_info_id) values(58 , 59);
INSERT INTO company_image_admin(company_id , image_info_id) values(58 , 60);
INSERT INTO company_image_admin(company_id , image_info_id) values(59 , 59);
INSERT INTO company_image_admin(company_id , image_info_id) values(59 , 60);
INSERT INTO company_image_admin(company_id , image_info_id) values(59 , 46);
INSERT INTO company_image_admin(company_id , image_info_id) values(60 , 60);
INSERT INTO company_image_admin(company_id , image_info_id) values(60 , 46);
INSERT INTO company_image_admin(company_id , image_info_id) values(60 , 47);


INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 105000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 105000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 65000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 65000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 95000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 95000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 160000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 160000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 170000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 170000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 90000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 90000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 80000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 80000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 75000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 75000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 65000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 65000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 55000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 55000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 52000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 52000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 69000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 69000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 78000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 78000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 130000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 130000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 110000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("호텔 예약", "2018-10-17", "2018-10-23", "서울 최성급 호텔입니다.", 110000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 400000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 200000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 300000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 200000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 300000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 400000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 500000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 600000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 200000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 300000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 400000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 500000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("식당예약자리", "2018-10-17", "2018-10-23", "몇명인지 말씀해주세요", 800000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("르네전", "2018-10-17", "2019-10-23", "유명 예술가 르네의 작품 전시전", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("남도음식전", "2018-10-17", "2019-10-23", "맛남", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("미륵전", "2018-10-17", "2019-10-23", "마음을 비웁니다", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("전남전", "2018-10-17", "2019-10-23", "전라남도를 알려드립니다", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("어린이 놀이전", "2018-10-17", "2019-10-23", "어린이들을 놀게합시당", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("민속전", "2018-10-17", "2019-10-23", "민속놀이전", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("미용전", "2018-10-17", "2019-10-23", "한국의 모든 미용용품", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("카메라영화전", "2018-10-17", "2019-10-23", "세계의 명화", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("교육과제전", "2018-10-17", "2019-10-23", "선생님들 보세요", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("해부학전", "2018-10-17", "2019-10-23", "인체의 신비", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("조선전", "2018-10-17", "2019-10-23", "해양 선박", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("운동전", "2018-10-17", "2019-10-23", "518", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("해양전", "2018-10-17", "2019-10-23", "바다를 알자", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("소양강댐전", "2018-10-17", "2019-10-23", "강을 알자", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("대한제국전", "2018-10-17", "2019-10-23", "대한제국을 알아보자", 15000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카1", "2018-10-17", "2018-10-23", "튼튼합니다", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카2", "2018-10-17", "2018-10-23", "튼튼합니다", 120000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카3", "2018-10-17", "2018-10-23", "튼튼합니다", 103000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카4", "2018-10-17", "2018-10-23", "튼튼합니다", 120000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카5", "2018-10-17", "2018-10-23", "튼튼합니다", 190000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카6", "2018-10-17", "2018-10-23", "튼튼합니다", 200000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카7", "2018-10-17", "2018-10-23", "튼튼합니다", 250000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카8", "2018-10-17", "2018-10-23", "튼튼합니다", 330000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카9", "2018-10-17", "2018-10-23", "튼튼합니다", 70000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카10", "2018-10-17", "2018-10-23", "튼튼합니다", 170000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카11", "2018-10-17", "2018-10-23", "튼튼합니다", 220000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카12", "2018-10-17", "2018-10-23", "튼튼합니다", 330000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카14", "2018-10-17", "2018-10-23", "튼튼합니다", 880000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카13", "2018-10-17", "2018-10-23", "튼튼합니다", 120000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카15", "2018-10-17", "2018-10-23", "튼튼합니다", 110000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카16", "2018-10-17", "2018-10-23", "튼튼합니다", 320000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카17", "2018-10-17", "2018-10-23", "튼튼합니다", 150000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카18", "2018-10-17", "2018-10-23", "튼튼합니다", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카19", "2018-10-17", "2018-10-23", "튼튼합니다", 170000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카20", "2018-10-17", "2018-10-23", "튼튼합니다", 180000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카21", "2018-10-17", "2018-10-23", "튼튼합니다", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카22", "2018-10-17", "2018-10-23", "튼튼합니다", 120000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카23", "2018-10-17", "2018-10-23", "튼튼합니다", 104000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카24", "2018-10-17", "2018-10-23", "튼튼합니다", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카25", "2018-10-17", "2018-10-23", "튼튼합니다", 130000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카26", "2018-10-17", "2018-10-23", "튼튼합니다", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카27", "2018-10-17", "2018-10-23", "튼튼합니다", 120000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카28", "2018-10-17", "2018-10-23", "튼튼합니다", 100000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카29", "2018-10-17", "2018-10-23", "튼튼합니다", 120000);
INSERT INTO product(name, sale_start_date, sale_end_date, discription, price) VALUES("렌트카30", "2018-10-17", "2018-10-23", "튼튼합니다", 130000);


INSERT INTO product_admin(company_id,product_id) VALUES(1,1);
INSERT INTO product_admin(company_id,product_id) VALUES(1,2);
INSERT INTO product_admin(company_id,product_id) VALUES(2,3);
INSERT INTO product_admin(company_id,product_id) VALUES(2,4);
INSERT INTO product_admin(company_id,product_id) VALUES(3,5);
INSERT INTO product_admin(company_id,product_id) VALUES(3,6);
INSERT INTO product_admin(company_id,product_id) VALUES(4,7);
INSERT INTO product_admin(company_id,product_id) VALUES(4,8);
INSERT INTO product_admin(company_id,product_id) VALUES(5,9);
INSERT INTO product_admin(company_id,product_id) VALUES(5,10);
INSERT INTO product_admin(company_id,product_id) VALUES(6,11);
INSERT INTO product_admin(company_id,product_id) VALUES(6,12);
INSERT INTO product_admin(company_id,product_id) VALUES(7,13);
INSERT INTO product_admin(company_id,product_id) VALUES(7,14);
INSERT INTO product_admin(company_id,product_id) VALUES(8,15);
INSERT INTO product_admin(company_id,product_id) VALUES(8,16);
INSERT INTO product_admin(company_id,product_id) VALUES(9,17);
INSERT INTO product_admin(company_id,product_id) VALUES(9,18);
INSERT INTO product_admin(company_id,product_id) VALUES(10,19);
INSERT INTO product_admin(company_id,product_id) VALUES(10,20);
INSERT INTO product_admin(company_id,product_id) VALUES(11,21);
INSERT INTO product_admin(company_id,product_id) VALUES(11,22);
INSERT INTO product_admin(company_id,product_id) VALUES(12,23);
INSERT INTO product_admin(company_id,product_id) VALUES(12,24);
INSERT INTO product_admin(company_id,product_id) VALUES(13,25);
INSERT INTO product_admin(company_id,product_id) VALUES(13,26);
INSERT INTO product_admin(company_id,product_id) VALUES(14,27);
INSERT INTO product_admin(company_id,product_id) VALUES(14,28);
INSERT INTO product_admin(company_id,product_id) VALUES(15,29);
INSERT INTO product_admin(company_id,product_id) VALUES(15,30);
INSERT INTO product_admin(company_id,product_id) VALUES(16,31);
INSERT INTO product_admin(company_id,product_id) VALUES(17,32);
INSERT INTO product_admin(company_id,product_id) VALUES(18,33);
INSERT INTO product_admin(company_id,product_id) VALUES(19,34);
INSERT INTO product_admin(company_id,product_id) VALUES(20,35);
INSERT INTO product_admin(company_id,product_id) VALUES(21,36);
INSERT INTO product_admin(company_id,product_id) VALUES(22,37);
INSERT INTO product_admin(company_id,product_id) VALUES(23,38);
INSERT INTO product_admin(company_id,product_id) VALUES(24,39);
INSERT INTO product_admin(company_id,product_id) VALUES(25,40);
INSERT INTO product_admin(company_id,product_id) VALUES(26,41);
INSERT INTO product_admin(company_id,product_id) VALUES(27,42);
INSERT INTO product_admin(company_id,product_id) VALUES(28,43);
INSERT INTO product_admin(company_id,product_id) VALUES(29,44);
INSERT INTO product_admin(company_id,product_id) VALUES(30,45);
INSERT INTO product_admin(company_id,product_id) VALUES(31, 46);
INSERT INTO product_admin(company_id,product_id) VALUES(32, 47);
INSERT INTO product_admin(company_id,product_id) VALUES(33, 48);
INSERT INTO product_admin(company_id,product_id) VALUES(34, 49);
INSERT INTO product_admin(company_id,product_id) VALUES(35, 50);
INSERT INTO product_admin(company_id,product_id) VALUES(36, 51);
INSERT INTO product_admin(company_id,product_id) VALUES(37, 52);
INSERT INTO product_admin(company_id,product_id) VALUES(38, 53);
INSERT INTO product_admin(company_id,product_id) VALUES(39, 54);
INSERT INTO product_admin(company_id,product_id) VALUES(40, 55);
INSERT INTO product_admin(company_id,product_id) VALUES(41, 56);
INSERT INTO product_admin(company_id,product_id) VALUES(42, 57);
INSERT INTO product_admin(company_id,product_id) VALUES(43, 58);
INSERT INTO product_admin(company_id,product_id) VALUES(44, 59);
INSERT INTO product_admin(company_id,product_id) VALUES(45, 60);
INSERT INTO product_admin(company_id,product_id) VALUES(46, 61);
INSERT INTO product_admin(company_id,product_id) VALUES(46, 62);
INSERT INTO product_admin(company_id,product_id) VALUES(47, 63);
INSERT INTO product_admin(company_id,product_id) VALUES(47, 64);
INSERT INTO product_admin(company_id,product_id) VALUES(48, 65);
INSERT INTO product_admin(company_id,product_id) VALUES(48, 66);
INSERT INTO product_admin(company_id,product_id) VALUES(49, 67);
INSERT INTO product_admin(company_id,product_id) VALUES(49, 68);
INSERT INTO product_admin(company_id,product_id) VALUES(50, 69);
INSERT INTO product_admin(company_id,product_id) VALUES(50, 70);
INSERT INTO product_admin(company_id,product_id) VALUES(51, 71);
INSERT INTO product_admin(company_id,product_id) VALUES(51, 72);
INSERT INTO product_admin(company_id,product_id) VALUES(52, 73);
INSERT INTO product_admin(company_id,product_id) VALUES(52, 74);
INSERT INTO product_admin(company_id,product_id) VALUES(53, 75);
INSERT INTO product_admin(company_id,product_id) VALUES(53, 76);
INSERT INTO product_admin(company_id,product_id) VALUES(54, 77);
INSERT INTO product_admin(company_id,product_id) VALUES(54, 78);
INSERT INTO product_admin(company_id,product_id) VALUES(55, 79);
INSERT INTO product_admin(company_id,product_id) VALUES(55, 80);
INSERT INTO product_admin(company_id,product_id) VALUES(56, 81);
INSERT INTO product_admin(company_id,product_id) VALUES(56, 82);
INSERT INTO product_admin(company_id,product_id) VALUES(57, 83);
INSERT INTO product_admin(company_id,product_id) VALUES(57, 84);
INSERT INTO product_admin(company_id,product_id) VALUES(58, 85);
INSERT INTO product_admin(company_id,product_id) VALUES(58, 86);
INSERT INTO product_admin(company_id,product_id) VALUES(59, 87);
INSERT INTO product_admin(company_id,product_id) VALUES(59, 88);
INSERT INTO product_admin(company_id,product_id) VALUES(60, 89);
INSERT INTO product_admin(company_id,product_id) VALUES(60, 90);


INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17",2,1);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-18",2,1);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-19",2,1);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-20",2,1);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-21",2,1);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-22",2,1);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-23",2,1);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17",2,2);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-18",2,2);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-19",2,2);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-20",2,2);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-21",2,2);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-22",2,2);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-23",2,2);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17",1,31);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-18",0,31);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-19",1,31);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-20",1,31);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-21",1,31);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-22",0,31);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-23",1,31);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 1, 46);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-18", 1, 46);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-19", 1, 46);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-20", 1, 46);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-21", 1, 46);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-22", 1, 46);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-23", 1, 46);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 47);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 48);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 49);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 50);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 51);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 52);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 53);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 54);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 55);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 56);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 57);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 58);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 59);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 100, 60);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-17", 1, 61);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-18", 2, 61);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-19", 1, 61);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-20", 1, 61);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-21", 3, 61);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-22", 1, 61);
INSERT INTO product_manager(sale_date, count , product_id) VALUES("2018-10-23", 1, 61);




INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(1,1);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(1,2);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(1,3);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(2,2);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(2,3);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(2,1);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(31,30);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(31,25);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(31,24);
INSERT INTO product_image_admin(product_id , image_info_id) VALUES(46, 31);
INSERT INTO product_image_admin(product_id , image_info_id) VALUES(46, 32);
INSERT INTO product_image_admin(product_id , image_info_id) VALUES(46, 33);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(61, 47);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(61, 48);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(61, 49);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(62, 50);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(62, 51);
INSERT INTO product_image_admin(product_id ,image_info_id) VALUES(62, 52);

/*Comment*/
/* 숙박 */
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('완전쨩쨩쨩', '공주공주풍 한 느낌도 괜찮구 깨끗하고 조용하고 좋아요!', 3.3, now(),  61, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('너무좋아요', '대실시간 엄청길어서 가성비 개굿', 4.2, now(), 62, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('완전 인생 숙소', '프런트직원분도 친절하셔서 기분좋게 갑니당 뿅', 5.0, now(), 63, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('가격대비 짱짱', '좋았습니다! 방도 깨끗하고 화장실도 깨끗했어요', 2.1, now(),  64, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('완소 나만 알고 싶은 곳', '특실에는 스팀 기능도 있어서 같이 사우나도 했습니다.', 3.5, now(),  65, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('언제나 항상', '아늑하니 좋았습니다 두번째 들리는거였는데 좋았어요', 3.4, now(),  66, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('좋아요', '공주공주풍 한 느낌도 괜찮구 깨끗하고 조용하고 좋아요!', 4.3, now(),  67, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('가격대비 이만한 곳이 없어요', '공주공주풍 한 느낌도 괜찮구 깨끗하고 조용하고 좋아요!', 2.7, now(),  68, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('비품 때문에 재방문하겠어요', '비품과 용품이 생각했던 것보다 퀄리티가 높아서 좋았습니다~ 객실도 살짝 낡긴했지만 깔끔했습니다ㅎㅎ', 3.2, now(),  69, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('너무 좋았어요', '넓고 쾌적하고 좋았어요! 다만 배게가 너무 높아서 불편했다는 거ㅠㅠㅠㅠ그 것 빼곤 욕조도 샤워하는 것도 침대두 다 좋았네용!', 4.1, now(),  70, 1);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('기념일에 갔는데 완전 만족', '깔끔하고요 심플합니다!욕조도 있고요 금고도 있네요ㅋㅋㅋ직원분들 친절하시고요 음료가 콜라랑 이온음료에요 굿~', 5.0, now(),  71, 1);

/* 식당 */
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('깐쇼새우 짱짱맨입니다 ㅎ ㅎ ㅎ', '굿굿이에용 양도 많고 배달하시는분이 친절해서 기분이 좋았네요', 3.3, now(),  61, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('무난무난한 전형적인 볶음밥이네요', '새우볶음밥 맛있었어요 양도 많고 굿굿 ^^', 4.6, now(),  62, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('맛있습니다~!!!!!!', '맛있게 잘먹었어요ㅎㅎ 오늘은 짜장보다 짬뽕이 맛있네요 그냥 짬뽕 한그릇 시킬걸그랬네영ㅠㅠㅋㅋ', 5.0, now(),  63, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('전보다 좀 매워졋네요 ㅠ', '정말 맛있네요~~배달도 빠르고~~~쿠폰도 주고 최소 배달 금액도 강남 최고입니다~~^^', 5.0, now(),  64, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('굴짬뽕은 첨 시켜봤는데 괜찮네요', '맛있어요 ㅎㅎ 근데 짬뽕국물은 주는건지 마는건짘..ㅋㅋ좀 아쉬움!', 5.0, now(),  65, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('짱맛나야ㅏㅏㅏㅏㅏㅏㅏ', '탕수육 튀겨놓은거 전자렌지 돌려서 보내셨나봅니다건조하고 딱딱하고 질기고 ㅎㅎㅎ', 2.9, now(),  66, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('맛잇어요. 잘먹엇습니다', '맛있었습니다! 마파두부밥에 고추 많아요 ㅎ 참고하세요!', 2.7, now(),  67, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('콩나물.홍합.북어 끝그외해물 없음', '잡탕밥에 해물 많고 맛있네요 쟁반짜장도 괜찮았습니다', 3.3, now(),  68, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('맛나게잘먹었어요 해장짱', '리뷰 늦었네요..늘 맛있게 먹습니다.수고하세요', 4.7, now(),  69, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('맛있음. 먹어보면 알아요', '네 맛있게 먹었습니다 진짜!', 3.5, now(),  70, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('맛있음 ㅎㅎㅎㅎㅎㅎㅎㅎ', '조금 비싼듯 하지만 먹을만은 합니다초밥 나름 괜춘 우동은 걍 먹을만한정도가격이 좀 비싼듯한 느낌은 사라지지가 않음', 5.0, now(),  71, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('나름 괜춘', '나름 괜춘 우동은 걍 먹을만한정도가격이 좀 비싼듯한 느낌은 사라지지가 않음', 1.0, now(),  63, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('나름 괜춘2', '나름 괜춘 우동은 걍 먹을만한정도가격이 좀 비싼듯한 느낌은 사라지지가 않음', 2.0, now(),  64, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('나름 괜춘3', '나름 괜춘 우동은 걍 먹을만한정도가격이 좀 비싼듯한 느낌은 사라지지가 않음', 3.0, now(),  65, 16);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('나름 괜춘3', '나름 괜춘 우동은 걍 먹을만한정도가격이 좀 비싼듯한 느낌은 사라지지가 않음', 4.0, now(),  66, 16);
/* 문화 */
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('연기짱 멋있어요 ㅎㅎ두배우역시', '김윤석, 주지훈 두 배우의 연기. 말이 필요없음', 3.7, now(),  61, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('돟앗어요ㅠㅠㅠㅠㅠㅠㅠㅠㅠ', '그냥 아쉽습니다. 저예산 치면 괜찮고 진지하게 생각하면 베놈이 너무 아쉽고 특히 여주는 리얼 무의미한 역활 인듯...', 3.3, now(),  62, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('배우 연기에 집중됐어요~', '만화영화임..... 외계생물이 지구에 남는 이유도 개연성도 없구...아깝다 시간,돈', 4.8, now(),  63, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('다들 연기력들 대단해요~~', '액션이 좀 짧은거 같지만 내용이 재미있네요', 2.1, now(),  64, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('사건의 전개와 심리적 긴장감을 잘 표현 했음.', '평이 안좋은 이유를 모르겠는 1인. 쿠키영상은 속편스포라면 감사합니다', 1.3, now(),  65, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('재미있었어요 좋아요 다음에 또 볼게요', '소니라서 그런지 기생수를 카피한. 느낌.마블아 정신차리자 디씨가 간다', 3.3, now(),  66, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('별 기대 않하고 봤는데 재밌네요', '재미있게봤에요!다음편도기대되네요!', 2.3, now(),  67, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('시간가는줄 모르고 봤습니다. 연기력 쩔었어요', '개연성은 밥말아먹었지만 베놈이가 그렇게 하고싶다니까 모..', 4.2, now(),  68, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('연기력이 너무 좋았습니다.', '후속이 기다려지는영화', 3.1, now(),  69, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('두분 연기 진짜 좋았어요', '사라진 30분만 있었다면 완벽했을듯', 5.0, now(),  70, 31);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('시간가는줄 모르고 봤습니다. 연기력 쩔었어요', '기대를 많이 안하고 봤는데 볼만했다. 새로운 캐릭터 등장물이라 재밌었음.', 1.8, now(),  71, 31);

/* 차량 */
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('신형 스파크^^', '일본으로 가야되서 서울에서 인천공항까지 편도로 사용했네요^^', 3.6, now(),  61, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('편도 처음 이용해 보는데 오늘도 역시', '편도가 되어서 정말 편하게 갈 수 있을 것 같아요^^', 4.4, now(),  62, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('편도핫딜 이용해 출장 다녀왔습니다.', '출근길에 들러야 할 곳이 있어서 쏘카 이용했어요^^', 1.1, now(),  63, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('친절하게해주셔서고맙습니다.항상애용하겠습니다', '도착시간이 너무 빠듯해 주유도 못하고 다음 쏘친에게 불쾌함이 전달되지 않길 빌어봅니다.', 2.2, now(),  64, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('가성비 굿이네요', '가격적인 부분이나 거리적인 부분에서 정말 이만한 서비스가 없을 것이라고 장담합니다', 5.0, now(),  65, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('큰불편함 없었던거같아요', '집 주차장에서 쏘카를 사용하고 있어 편리하게 이용하고 있습니다. ', 4.3, now(),  66, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('차 상태 좋았습니다', '정기적으로 차량관리까지 해줘서 관리부담이 전혀 없습니다.', 3.7, now(),  67, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('히터에서 냄새가 나네요', '집 주차장에 쏘카가 있으니까 엘리베이터 타고 내려오기만 하면 이용할 수 있다는게 너무 좋아요!', 4.1, now(),  68, 46);
INSERT INTO comment (`title`, `content`, `score`, `mod_date`, `user_id`, `company_id`) VALUES ('최대한 저렴한걸루 찾아 무탈하게 잘 사용하고 돌아왔습니다.', '차량 상태 진짜 별로였습니다 뒷타이어 얼마 안남아있었고 얼라이먼트도 안맞아서 운전하는동안 진짜 피곤했습니다.', 1.1, now(),  69, 46);


INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 200000,'2018-01-01',2,'2018-01-01',1,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 200000,'2018-01-01',2,'2018-01-01',1,2,62);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 80000,'2018-01-01',2,'2018-01-01',16,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 80000,'2018-01-01',2,'2018-01-01',17,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 80000,'2018-01-01',2,'2018-01-01',18,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 20000,'2018-01-01',2,'2018-01-01',31,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 300000,'2018-02-01',2,'2018-02-01',1,1,63);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 300000,'2018-02-01',2,'2018-02-01',1,2,64);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 10000,'2018-02-01',2,'2018-02-01',1,1,65);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 80000,'2018-02-01',2,'2018-02-01',16,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 38000,'2018-02-01',2,'2018-02-01',17,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 18000,'2018-02-01',2,'2018-02-01',18,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 10000,'2018-02-01',2,'2018-02-01',31,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 16000,'2018-02-01',2,'2018-02-01',32,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 14000,'2018-02-01',2,'2018-02-01',33,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 6000,'2018-02-01',2,'2018-02-01',34,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 20000,'2018-02-01',2,'2018-02-01',46,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 25000,'2018-03-01',2,'2018-03-01',1,2,66);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 33000,'2018-03-01',2,'2018-03-01',1,1,67);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 30000,'2018-03-01',2,'2018-03-01',1,2,68);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 42000,'2018-03-01',2,'2018-03-01',1,1,69);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 7000,'2018-03-01',2,'2018-03-01',1,2,70);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 10000,'2018-03-01',2,'2018-03-01',1,1,71);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 5000,'2018-03-01',2,'2018-03-01',19,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 2000,'2018-03-01',2,'2018-03-01',38,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 10000,'2018-03-01',2,'2018-03-01',46,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 16000,'2018-03-01',2,'2018-03-01',47,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 28000,'2018-04-01',2,'2018-04-01',19,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 138000,'2018-04-01',2,'2018-04-01',20,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 31000,'2018-04-01',2,'2018-04-01',21,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 36000,'2018-04-01',2,'2018-04-01',22,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 33000,'2018-04-01',2,'2018-04-01',39,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 14000,'2018-04-01',2,'2018-04-01',49,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 6000,'2018-04-01',2,'2018-04-01',50,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 2000,'2018-04-01',2,'2018-04-01',51,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 98000,'2018-05-01',2,'2018-05-01',22,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 58000,'2018-05-01',2,'2018-05-01',23,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 68000,'2018-05-01',2,'2018-05-01',24,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 78000,'2018-05-01',2,'2018-05-01',25,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 30000,'2018-05-01',2,'2018-05-01',31,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 33000,'2018-05-01',2,'2018-05-01',46,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 30000,'2018-05-01',2,'2018-05-01',46,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 42000,'2018-05-01',2,'2018-05-01',46,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 51250,'2018-06-01',2,'2018-06-01',1,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 22354,'2018-06-01',2,'2018-06-01',1,1,62);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 678970,'2018-06-01',2,'2018-06-01',1,2,63);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 34444,'2018-06-01',2,'2018-06-01',1,1,64);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 68000,'2018-06-01',2,'2018-06-01',16,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 78000,'2018-06-01',2,'2018-06-01',16,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 42000,'2018-06-01',2,'2018-06-01',31,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 7000,'2018-06-01',2,'2018-06-01',31,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 7000,'2018-06-01',2,'2018-06-01',46,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 10000,'2018-06-01',2,'2018-06-01',46,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 51250,'2018-06-01',2,'2018-06-01',46,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 111111,'2018-07-01',2,'2018-07-01',1,2,65);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 10000,'2018-07-01',2,'2018-07-01',41,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 51250,'2018-07-01',2,'2018-07-01',40,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 22354,'2018-07-01',2,'2018-07-01',52,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '차량대여', 678970,'2018-07-01',2,'2018-07-01',46,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '식당', 23000,'2018-08-01',2,'2018-08-01',28,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 22354,'2018-08-01',2,'2018-08-01',44,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '문화', 678970,'2018-08-01',2,'2018-08-01',31,2,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 23422,'2018-08-01',2,'2018-08-01',1,1,66);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 28000,'2018-08-01',2,'2018-08-01',1,2,67);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 64000,'2018-08-01',2,'2018-08-01',1,1,68);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 80000,'2018-08-01',2,'2018-08-01',1,2,69);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 10000,'2018-09-01',2,'2018-09-01',1,1,70);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 20000,'2018-09-01',2,'2018-09-01',1,2,71);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 30000,'2018-09-01',2,'2018-09-01',8,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 420000,'2018-09-01',2,'2018-09-01',1,2,62);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 32000,'2018-09-01',2,'2018-09-01',6,1,61);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 3800,'2018-09-01',2,'2018-09-01',1,2,63);
INSERT INTO reservation (state, product_type, total_price, res_date, product_count,reg_date, company_id, product_id,user_id)
VALUES('성공', '숙박', 380000,'2018-09-01',2,'2018-09-01',1,1,64);

/*공지사항*/
insert into notice (title, content, user_id) values ("공지사항입니다","공지사항 내용입니다","museum01@aaa.com");
insert into notice (title, content, user_id) values ("공지사항","공지사항 내용입니다","museum02@aaa.com");
insert into notice (title, content, user_id) values ("공-지","공지사항 내용입니다","museum03@aaa.com");
insert into notice (title, content, user_id) values ("공지공지","공지사항 내용입니다","museum04@aaa.com");
insert into notice (title, content, user_id) values ("공지","공지사항 내용입니다","museum05@aaa.com");
insert into notice (title, content, user_id) values ("공지글","공지사항 내용입니다","museum06@aaa.com");
insert into notice (title, content, user_id) values ("공지사항 제목","공지사항 내용입니다","museum07@aaa.com");
insert into notice (title, content, user_id) values ("공지 이야아아아아","공지사항 내용입니다","museum08@aaa.com");

insert into notice (title, content, user_id) (select title, content, user_id from notice);
insert into notice (title, content, user_id) (select title, content, user_id from notice);
insert into notice (title, content, user_id) (select title, content, user_id from notice);
insert into notice (title, content, user_id) (select title, content, user_id from notice);

insert into qna (title, content, user_id) values ("취소질문","취소질문 내용입니다","abcde61@rent.com");
insert into qna (title, content, user_id) values ("변경질문","변경질문 내용입니다","abcde62@rent.com");
insert into qna (title, content, user_id) values ("추가질문","추가질문 내용입니다","abcde63@rent.com");
insert into qna (title, content, user_id) values ("예약질문","예약질문 내용입니다","abcde64@rent.com");
insert into qna (title, content, user_id) values ("취소질문","취소질문 내용입니다","abcde65@rent.com");
insert into qna (title, content, user_id) values ("변경질문","변경질문 내용입니다","abcde66@rent.com");
insert into qna (title, content, user_id) values ("추가질문","추가질문 내용입니다","abcde67@rent.com");
insert into qna (title, content, user_id) values ("예약질문","예약질문 내용입니다","abcde68@rent.com");
insert into qna (title, content, user_id) values ("변경질문","변경질문 내용입니다","abcde69@rent.com");
insert into qna (title, content, user_id) values ("예약질문","예약질문 내용입니다","abcde70@rent.com");
insert into qna (title, content, user_id) values ("취소질문","취소질문 내용입니다","abcde71@rent.com");

insert into qna (title, content, user_id) (select title, content, user_id from qna);
insert into qna (title, content, user_id) (select title, content, user_id from qna);
insert into qna (title, content, user_id) (select title, content, user_id from qna);

   
INSERT INTO message( title, content, read_check, user_id, receiver_id) 
VALUES("판매자가 사용자에게 쪽지 ", "쪽지 내용", 0, "abcde61@rent.com","abc1@gmail.com");
INSERT INTO message( title, content, read_check, user_id, receiver_id) 
VALUES("사용자가 판매자에게 쪽지", "쪽지 내용", 0, "abc1@gmail.com" ,"abcde61@rent.com");
INSERT INTO message( title, content, read_check, user_id, receiver_id) 
VALUES("판매자가 사용자에게 쪽지 ", "쪽지 내용", 0, "abcde61@rent.com","abc1@gmail.com");
INSERT INTO message( title, content, read_check, user_id, receiver_id) 
VALUES("사용자가 판매자에게 쪽지", "쪽지 내용", 0, "abc1@gmail.com" ,"abcde61@rent.com");
INSERT INTO message( title, content, read_check, user_id, receiver_id) 
VALUES("판매자가 사용자에게 쪽지 ", "쪽지 내용", 0, "abcde61@rent.com","abc1@gmail.com");
INSERT INTO message( title, content, read_check, user_id, receiver_id) 
VALUES("사용자가 판매자에게 쪽지", "쪽지 내용", 0, "abc1@gmail.com" ,"abcde61@rent.com");

insert into message (title, content, read_check, user_id, receiver_id) (select title, content, read_check, user_id, receiver_id from message);
insert into message (title, content, read_check, user_id, receiver_id) (select title, content, read_check, user_id, receiver_id from message);
insert into message (title, content, read_check, user_id, receiver_id) (select title, content, read_check, user_id, receiver_id from message);

/* update문 에러 뜰시  SET SQL_SAFE_UPDATES = 0; */
/* 상품 날짜 입력해야 결제 가능 */
SET SQL_SAFE_UPDATES = 0;
update product
set sale_start_date = "2019-05-30", sale_end_date = "2019-06-30";
