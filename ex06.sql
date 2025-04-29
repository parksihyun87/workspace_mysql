set global log_bin_trust_function_creators = 1;

use cookdb;
drop function if exists userfunc;
delimiter $$
create function userfunc(value1 int, value2 int)
returns int -- 여기 ;없다.
begin
	return value1+value2;
end $$
delimiter ;

select userfunc(100,200);

-- drop function if exists getagefunc;-- (드+종+입익+이름+;)5가지
-- delimiter $$
-- create function getagefunc(byear int)
-- returns int
-- begin 
-- 	declare age int;
--     set age = year(curdate()) - byear; -- 컬데이트 현재 날짜
--     return age;
-- end $$ 큰 엔드는 달러 요구
-- delimiter ;-- 마지막 딜라이는 큰 세미콜론 요구
	
delimiter $$
create function getagefunc(byear int)
returns int
begin
	declare age int;
    set age = year(curdate()) - byear;
    return age; -- 비긴 부에 내용 적어줌.
end $$
delimiter ;	

select getagefunc(1979) into @age1979;
select getagefunc(1997) into @age1997;

SELECT CONCAT('1997년과 1979년의 나이차 ==> ', (@age1979-@age1997));
 
SELECT userID, userName, getAgeFunc(birthYear) AS '만 나이' FROM userTBL;

show create function getagefunc;

use madang;
-- 판매된 도서에 대한 이익을 계산하는 함수
-- (가격이 30,000원 이상이면 10%, 3만원 미만은 5%가 이익)

select bookname,price, fnc_profit(price) as 이익 from booktbl; -- 집계 함수는 필드들과 섞여도 값을 다 보여주게 한다.

set global log_bin_trust_function_creators = 1;

drop function if exists fnc_profit;
delimiter $$
create function fnc_profit(number int) -- 크종이변
returns double -- 리자
begin
	declare profit double;    
	if number>=30000 then set profit = number * 0.1;
    -- return number * 0.1;
    else set profit = number * 0.05;
    -- return number * 0.05;
    end if; -- 엔입 꼭 써줄것
    return profit;
end $$ -- (엔드,$$) 두가지
delimiter ;

select bookname,price,fnc_profit(price) as 이익 from booktbl;

drop procedure if exists order_profit;
delimiter $$
create procedure order_profit()
begin
	select custid, saleprice, fnc_profit(saleprice) as 이익 from ordertbl;
end $$
delimiter ;

call order_profit();
-- 실행안됨2

-- 커서 
use cookdb;
drop procedure if exists cursorproc;
delimiter $$
create procedure cursorproc()
begin
	declare userheight int;
    declare cnt int default 0;
    declare totalheight int default 0;
    
    declare endofrow boolean default false;
    
    declare usercursor cursor for
    select height from usertbl;
    
    declare continue handler for not found set endofrow = true;
    
    open usercursor;
    
    cursor_loop: loop -- 루프 문 확인
		fetch usercursor into userheight; -- 유저커서가 가져온걸 유저헤잇에 넣음
        
        if endofrow then
			leave cursor_loop;
        end if;
        
        set cnt= cnt + 1;
        set totalheight= totalheight+userheight;
	end loop cursor_loop;
    
    select concat('고객 키의 평균 ==>',(totalheight/cnt));
    
    close usercursor;
end $$
delimiter ;

call cursorproc();
-- 실행 어디서?

use cookdb;
ALTER TABLE userTBL ADD grade VARCHAR(20); 

drop procedure if exists gradeproc;
delimiter $$
create procedure gradeproc()
begin 
	declare id varchar(10);
    declare hap bigint;
    declare usergrade char(5);
    
    declare endofrow boolean default false;
    
    declare usercursor cursor for
		select u.userid, sum(price*amount)
		from buytbl b
        right outer join usertbl u
        on b.userid = u.userid
        group by u.userid, u.username;
        
	declare continue handler
    for not found set endofrow = true;
    
    open usercursor;
    grade_loop: loop
		fetch usercursor into id, hap;
		if endofrow then
			leave grade_loop;
		end if;
		
		case 
			when(hap >= 1500) then set usergrade='최우수고객';
			when(hap >= 1000) then set usergrade= '우수고객';
			when(hap >= 1) then set usergrade='일반고객';
			else 
				set usergrade='유령고객';
		end case;
		
		update usertbl set grade = usergrade where userid = id;
	end loop grade_loop;
    
    close usercursor;
end $$
delimiter ;

CALL gradeProc();
 SELECT * FROM userTBL






 
 
 
