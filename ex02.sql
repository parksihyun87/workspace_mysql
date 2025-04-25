use cookdb;
create table stdtbl(
stdname varchar(10) not null primary key,
addr char(4) not null
);
create table clubtbl(
clubname varchar(10) not null primary key,
roomno char(4) not null
);
create table stdclubtbl(
num int auto_increment not null primary key,
stdname varchar(10) not null,
clubname varchar(10) not null,
foreign key(stdname) references stdtbl(stdname),
-- 현 테이블 외래 키는 외부 참조
foreign key(clubname) references clubtbl(clubname)
--  현 테이블 외래 키는 외부 참조
);

insert into stdtbl values
('강호동','경북'),
('김제동','경남'),
('김용만','서울'),
('이휘재','경기'),
('박수홍','서울');

insert into clubtbl values
('수영','101호'),
('바둑','102호'),
 ('축구', '103호'), ('봉사', '104호');
 
  INSERT INTO stdclubtbl VALUES
(NULL, '강호동', '바둑'), (NULL, '강호동', '축구'),
 (NULL, '김용만', '축구'), (NULL, '이휘재', '축구'),
 (NULL, '이휘재', '봉사'), (NULL, '박수홍', '봉사');

 select * from stdtbl ;
 select * from clubtbl ;
 select * from stdclubtbl ;
 
 select s.stdname, s.addr, c.clubname, c.roomno
 from stdtbl s
 inner join stdclubtbl sc
 on s.stdname=sc.stdname
 inner join clubtbl c
 on sc.clubname=c.clubname
 order by s.stdname;
 -- 여기서 이 조인은 from 첫번째 부터 시작하여 연쇄적으로 이어지는 조인이다.
 -- 즉 1-2, 하며 1과2의 온 상에서 조인키를 만들고 다시 이너 조인해서
 -- 온 상에서 2-3 해서 만든다.
 -- 외래키는 관계적 연결의 의미만 있다.
 
-- 각 고객이 주문한 도서의 이름들을 조회(고객이름, 주문도서 이름)

use madang; 
desc customertbl;
desc orderstbl;
desc booktbl;

select b.bookname, c.name
from booktbl b
inner join orderstbl o
on b.bookid=o.bookid
inner join customertbl c
on o.custid=c.custid; 

-- 가격이 20,000원 이상인 도서를 주문한 고객의 이름과 도서의 이름 조회
select b.bookname, c.name
from booktbl b
inner join orderstbl o
on b.bookid=o.bookid
inner join customertbl c
on o.custid=c.custid
where o.saleprice>=20000;

desc booktbl;

-- 정가보다 싸게 산 고객의 아이디, 이름, 구매가격을 조회
select c.custid, c.name, b.price, o.saleprice
from booktbl b
inner join orderstbl o
on b.bookid=o.bookid
inner join customertbl c
on o.custid=c.custid
where b.price>o.saleprice;
-- 3테이블 이너 조인의 순서: 첫째로 이너조인은 대표문자가 필요하다. 셀렉 (문자, . , 필드명)3가지/ 프롬 (시작하는 테이블,문자)2가지/
-- inner join 연결1 (연결1 테이블, 문자) on 시테문자+.+시테필드= 1테문자+.+2테필드/
-- inner join 연결2 (연결2 테이블, 문자) on 시테문자+.+시테필드= 2테문자+.+3테필드/

-- 외부조인
use cookdb;
desc stdtbl;

select s.stdname, s.addr, c.clubname, c.roomno
from stdtbl s
left outer join stdclubtbl sc
-- 왼쪽 기준 즉 stdtbl 기준으로 모두 포함하여 스튜던트는 무조건 나옴
on s.stdname=sc.stdname
left outer join clubtbl c
-- 다시 유지하며 모두 왼쪽인 기준으로 포함하여 진행하여 클럽이 없어도 스튜던트가 나왔다.
on sc.clubname=c.clubname
order by s.stdname;

SELECT c.clubname, c.roomno, c.stdname, c.addr
FROM stdtbl s 
LEFT OUTER JOIN stdclubtbl sc 
ON sc.stdname= s.stdname
RIGHT OUTER JOIN clubtbl c 
ON sc.clubname= c.clubname
ORDER BY c.clubname;
-- 안나옴

USE cookDB;
CREATE TABLE empTBL(emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));
 INSERT INTO empTBL VALUES ('나사장', NULL, '0000');
 INSERT INTO empTBL VALUES ('김재무', '나사장', '2222');
 INSERT INTO empTBL VALUES ('김부장', '김재무', '2222-1');
 INSERT INTO empTBL VALUES ('이부장', '김재무', '2222-2');
 INSERT INTO empTBL VALUES ('우대리', '이부장', '2222-2-1');
 INSERT INTO empTBL VALUES ('지사원', '이부장', '2222-2-2');
 INSERT INTO empTBL VALUES ('이영업', '나사장', '1111');
 INSERT INTO empTBL VALUES ('한과장', '이영업', '1111-1');
 INSERT INTO empTBL VALUES ('최정보', '나사장', '3333');
 INSERT INTO empTBL VALUES ('윤차장', '최정보', '3333-1');
 INSERT INTO empTBL VALUES ('이주임', '윤차장', '3333-1-1');
 
 select A.emp as '부하직원', B.emp as'직속상관', B.empTel as'직속상관연락처'
 -- 찾는 조건이자 on의 줄과 연계해 employees나타낼 출력이다.
from empTBL A 
INNER JOIN empTBL B 
ON A.manager = B.emp
 WHERE A.emp = '우대리';







