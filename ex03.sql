use cookdb;
drop procedure if exists ifproc;

delimiter $$
create procedure ifproc()
begin -- 중괄호 열고의 뜻
declare var1 int;
set var1 = 100;

if var1= 100 then
select '100입니다.'; -- 출력 용도임.
else
select '100이 아닙니다.';
end if;
end $$ -- end는 중괄호 닫고.
delimiter ;

call ifproc();

use employees;

drop procedure if exists ifproc2;-- 델리 미터 옆 주석은 망가짐

delimiter $$ 
create procedure ifproc2()  -- 구획문자. 델리미터 하고 쌍달러 (크리에이트,프로시져,함수이름)3가지
begin -- 비긴(시작)
declare hiredate date; -- 선언할때는 (declare, 변수명, 자료형) 3가지이며 자료형은 mysql의 형식을 따름.
declare curdate date;
declare days int;

select hire_date into hiredate -- 이렇게 셀렉트 해서 인투로 변수에저장 가능.
from employees.employees
where emp_no = 10001;

set curdate = current_date(); -- 셋으로 변수에 값들을 저장한다.
set days = datediff(curdate,hiredate);

if (days/365) >=5 then
select concat('입사한지',days,'일이나 지났습니다. 축하합니다.!')as '메시지';
else
select '입사한지'+days+ '일밖에 안되었네요, 열심히 일하세요.'as '메시지';
end if;
end $$ -- 셀렉트마다 세미콜론, 엔드 이프꼭 쓰고 거기도 세미콜론.델리미터는 꼭 한칸 띄고 세미콜론.
delimiter ;
call ifproc2();

drop procedure if exists ifproc3; -- 지울때는 ()안붙여도 됨
delimiter $$
create procedure ifproc3()
begin
declare point int;
declare credit char(1);
set point = 77;

if point >= 90 then
set credit ='a';
elseif point >= 80 then
set credit = 'b';
elseif point >= 70 then
set credit = 'c';
elseif point >= 60 then
set credit = 'd';
else
set credit = 'f';
end if;
select concat('취득점수==>',point),concat('학점==>',credit);
end $$
delimiter ;
call ifproc3();

-- drop procedure if exists caseproc;
-- delimiter $$
-- create procedure caseproc()
-- begin
-- declare point int;
-- declare credit char(1);
-- set point = 77;

-- case
-- 	when point >= 90 then
--     set credit='a'
--     when point >= 80 then
--     set credit='b' 
-- 마저 작성
    
-- 변수의 선언은 반드시 앞에서 선언하고 사용해야 한다.

drop procedure if exists whileproc;
delimiter $$
create procedure whileproc() -- 딜달, 크프이
begin --  비긴
	declare i int;
	declare hap int; -- 디클레어
	set i =1;
	set hap=0;

	while(i<=100)do
	set hap = hap + i;
	set i = i + 1;
	end while;

	select hap; -- 나타내기 위해 필요
end $$
delimiter ;
call whileproc();

drop procedure if exists whileproc2;
delimiter $$
create procedure whileproc2() -- 
begin 
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    mywhile:while(i<=100)do -- 와일에 두가 필요함, (라벨명,:)2가지로 라벨적용함
    if (i % 7 = 0) then -- 다시 같다가 = 하나가 되었다.
    set i = i+1; 
    iterate mywhile; -- (이터레이터,라벨) 2가지로 돌아간다.
    end if;
    
    set hap = hap + i;
    if(hap >1000) then
    leave mywhile;
    end if;
    set i = i+1;
    end while;
    
    select hap;
    end $$
    delimiter ;
    call whileproc2();
    
    drop procedure if exists errorproc;
    delimiter $$
    create procedure errorproc()
    
    begin
		declare continue handler for 1146 select '테이블이 없어요 ㅠㅠ'as '메시지';
        select * from notable;
	end $$
    delimiter ;
    call errorproc();
    
    use cookdb;
    drop procedure if exists errorproc2;
    delimiter $$
    create procedure errorproc2()
    begin 
		declare exit handler for sqlexception
		begin
		show errors;
		select '오류가 발생했네요. 작업은 취소시켰습니다.' as '메시지';
        rollback;
		end;
		insert into usertbl values('YJS','윤정수', 1988, ‘서울’, NULL, NULL, 170, CURRENT_DATE());
        select * from stdtbl;
	end $$
    delimiter ;
    call errorproc2();
    
        
    


    








