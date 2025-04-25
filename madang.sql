drop database if exists madang; -- 있으면 지우기drop database if exists madang; 크리에이트 하기
create database madang;-- 크리에이트 자료 마당;
use madang;-- 작업을 위해 마당을 선택하자
-- (떨어뜨려 데이타 만약 있으면 지우기,만들기 데이타베이스 이름, 쓰기 이름)이 3가지는 처음에 한다.

--  (만들기, 테이블, 이름) 3가지
create table booktbl(
bookid int auto_increment primary key,
bookname varchar(20) not null,
publisher varchar(20) not null,
price int not null
);

create table customertbl(
custid int auto_increment primary key,
name varchar(20) not null,
address varchar(20) not null,
phone varchar(20)
);

create table orderstbl(
orderid int auto_increment primary key,
custid int not null,
bookid int not null,
saleprice int not null,
orderdate date not null,
FOREIGN KEY (bookid) REFERENCES booktbl(bookid),
FOREIGN KEY (custid) REFERENCES customertbl(custid)
);

INSERT INTO booktbl VALUES
(null, '축구의 역사','굿스포츠',7000),
(null, '축구아는 여자','나무수',13000),
(null, '축구의 이해','대한미디어',22000),
(null, '골프 바이블','대한미디어',35000),
(null, '피겨 교본','굿스포츠',8000),
(null, '역도 단계별기술','이상미디어',20000),
(null, '야구의 추억','이상미디어',20000),
(null, '야구를 부탁해','이상미디어',13000),
(null, '올림픽 이야기','삼성당',7500),
(null, 'Olympic champions','pearson',13000);

insert into customertbl values
(null, '박지성','영국 맨체스터',000-5000-0001),
(null, '김연아','대한민국 서울',000-6000-0001),
(null, '장미란','대한민국 강원도',000-7000-0001),
(null, '추신수','미국 클리블랜드',000-8000-0001),
(null, '박세리','대한민국 대전',null);

insert into orderstbl values
(null,1,1,6000,'2014-07-01'),
(null,1,3,21000,'2014-07-03'),
(null,2,5,8000,'2014-07-03'),
(null,3,6,6000,'2014-07-04'),
(null,4,7,20000,'2014-07-05'),
(null,1,2,12000,'2014-07-07'),
(null,4,8,13000,'2014-07-07'),
(null,3,10,12000,'2014-07-08'),
(null,2,10,7000,'2014-07-09'),
(null,3,8,13000,'2014-07-10');




