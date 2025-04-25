use madang;
-- ①가격이 20,000원 미만인 도서를 검색 / 가격 선택하고 웨어로 조건 확인
select bookname, price from booktbl where price < 20000;
-- ②가격이 10,000원 이상 20,000 이하인 도서를 검색
select bookname,publisher,price from booktbl where price>=10000 and price<=20000;
select bookname,publisher,price from booktbl where price between 10000 and 20000;-- 비트윈은 상하
-- ③출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색
select bookname,publisher,price from booktbl where publisher in('굿스포츠',"대한미디어");
-- ④출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’가 아닌 도서를 검색
select * from booktbl where publisher not in ('굿스포츠','대한미디어');
-- ⑤‘축구의 역사’를 출간한 출판사를 검색
select publisher from booktbl where bookname='축구의 역사';
-- ⑥도서이름에 ‘축구’가 포함된 출판사를 검색
select bookname,publisher from booktbl where bookname like '%축구%';
-- 퍼센트는 한 글자 이상 모두 포함하는 와일드 케릭터
-- ⑦도서이름이 여섯글자인 도서를 검색
select * from booktbl where bookname like '______';
-- ⑧도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색?
select bookname,publisher from booktbl where bookname like '_구%';
-- _는 1칸에 연관되고 %는 직선적으로 연관한다.
-- 필드 라이크 (필,라,'')3가지가 연관함
-- ⑨축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색/ 축구
select bookname,publisher,price from booktbl where price>=20000 and bookname like '%축구%';
-- ⑩야구에 관한 책을 모두 구입하려면 필요한 금액을 계산
select sum(price) as '야구관련책 금액합계' from booktbl where bookname like '야구%';
-- 필드 자리에 수식을 대체 가능
-- ⑪도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색// 두개 쓰는것 확인
select bookname,price from booktbl order by price desc, bookname; 
-- ⑫도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 오름차순으로 검색
select * from booktbl order by price desc,publisher ;
-- 오더는 필오
-- 기본적으로 a 오름차순임
-- ⑬고객의 주소가 영국이거나 대한민국인 사람들만 검색// 연산자에서 두개 이상일시 필라는 반복
select name,address from customertbl where address like '%대한민국%' or address like '%영국%';
-- 인이 나 낫인은 같다가 작용해야 씀.
-- ⑭ 고객이 주문한 도서의 총 판매액 조회
select sum(saleprice)as '총 판매액' from orderstbl;
-- ⑮ 2번 김연아 고객이 주문한 도서의 총 판매액 조회
select * from customertbl;
select sum(saleprice) as '김연아 구매액 합계'  from orderstbl where custid=2;
-- 16) 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가 조회
select sum(saleprice) as '합계액',avg(saleprice) as '평균액',min(saleprice) as '최소액',max(saleprice) as '최고액' from orderstbl;
-- 17) 마당서점의 도서 판매 건수 조회
select count(*) as 도서판매건수 from orderstbl;
-- 18) 고객별로 주문한 도서의 총 수량과 총 판매액 조회
select custid, count(saleprice) as 총수량, sum(saleprice) as 총판매액 from orderstbl group by custid;
-- 19) 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 조회 
select custid, count(*) as 구매건수 from orderstbl where saleprice>=8000 group by custid having 구매건수 >= 2;
-- 별칭을 검은색으로 쓰면 필드가 된다.