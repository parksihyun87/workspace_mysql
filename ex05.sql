-- book table에 저장된 도서들의 평균 값을 out용 매개변수로 
-- 전달하는 프로시저
use madang;

desc booktbl;
select * from booktbl;

drop procedure if exists avgproc;-- 일단 딜라이미터 하고 크리에이트 프로시져부터,변수 설정

delimiter $$
create procedure avgproc(
out avgprice double   
)-- (인앤아웃, 변수명, 자료명)3가지 써준다.
-- (인앤아웃, 변수명, 자료명)
begin -- (비긴-> 디클레어, 셋, 그리고 각종 수식부)4 기록해줌.
	select avg(price) into avgprice from booktbl; 
end $$ -- 비긴, 엔드 사이에 적고 엔드는 $$로 마친다.
delimiter ;

call avgproc(@avgprice);
select @avgprice;

select avg(price) from booktbl;   

-- 동일한 도서가 있는지 점검한 후 삽입하는 프로시저
-- 책이름 출판사 가격 책이 있으면 가격과 출판사를 업데이트하고 
-- 없으면 인서트를 하는 프로시져 만들기

desc booktbl;
call book_insert_update('sns','나무수',20000);-- 
-- 인풋용 함수

drop procedure if exists book_insert_update; -- (떨어뜨린다+기능명칭+프로시져+괄호없음) 2가지 필요함

delimiter $$
create procedure book_insert_update(
	in inputbn varchar(20), inputpb varchar(20), inputpr int
)
begin 
declare ifnum int;
		select count(*) into ifnum from booktbl where bookname=inputbn;
        if (ifnum = 0) then
			insert into booktbl values(null, inputbn, inputpb, inputpr);
		else 
			update booktbl set publisher=inputpb, price=inputpr where bookname=inputbn;
        end if;
end $$
delimiter ;

call book_insert_update('sns','나무수',20000);
select * from booktbl;


--  각 출판사와 최고가(max),최저가(min)중 하나를 입력하면 그에 해당하는 책의
-- 가격을 아웃 매개변수로 전달하는 프로시저 구현
call getbookprice('나무수', 'MAX', @bkprice);

drop procedure if exists getbookprice;

delimiter $$
create procedure getbookprice(
	in npublisher varchar(20), ncondition varchar(20), out nprice int
)
begin
	declare nnum int;       
    declare nbook varchar(20);      
  
select ncondition(price) into nnum from booktbl group by publisher having publisher=npublisher;
  
    
end $$
delimiter ;

call getbookprice('나무수', 'MAX', @bkprice);

select max(price) from booktbl group by publisher having publisher='나무수';

select * from booktbl;






    