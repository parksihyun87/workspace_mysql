use cookdb;
prepare myquery from 'select * from usertbl where userid= "NHS"';
execute myquery;
deallocate prepare myquery;

use cookdb;
drop table if exists mytable;
create table mytable (id int auto_increment primary key, mdate datetime);

set @curdate = current_timestamp(); -- 내장함수 현 날짜,시간

prepare myquery from 'insert into mytable values(null,?)';
execute myquery using @curdate;
deallocate prepare myquery;

select * from mytable;

set @min =180;
set @max =190;
prepare myquery from 'select * from usertbl where height between ? and ?';
execute myquery using @min, @max;

use cookdb;
drop procedure if exists userproc1; -- 딜라이미터는 전후로 $$를 씀, 전체 비긴 엔드는 딜라이마이터가 ;를 가져감.
delimiter $$
create procedure userproc1(in uname varchar(10)) -- in 쓰고 변수 씀
begin 
select * from usertbl where username = uname;
end $$
delimiter ;

call userproc1('이경규');
-- 안됨

drop procedure if exists userproc2;
delimiter $$
create procedure userproc2(
in userbirth int,
in userheight int
)
begin
select * from usertbl
where birthyear > userbirth and height > userheight;
end $$
delimiter ;

call userproc2(1970,178);


drop procedure if exists userproc3;
delimiter $$
create procedure userproc3(
	in txtvalue char(10),
    out outvalue int
)
begin
	insert into testtbl values(null, txtvalue);
    select max(id) into outvalue from testtbl;-- 셀렉트 하나의 값 into 원하는 변수 from 원하는 테이블
end $$
delimiter ;

create table if not exists testtbl(
	id int auto_increment primary key,
    txt char(10)
);

call userproc3('테스트값', @myvalue);
select concat('현재 입력된 id 값==>',@myvalue);

drop procedure if exists ifelseproc;
delimiter $$
create procedure ifelseproc(
	in uname varchar(10),
    out 
)
begin
	declare byear int;
    select birthyear into byear from usertbl
    where username = uname;
    if(byear>=1970) then
		select '아직 젊군요..';
    else
		select '나이가 지긋하네요..';
	end if;
end $$
delimiter ;
 
call ifelseproc('김국진'); -- 딜라이는 항상 끝에는 한칸 띄운다.
    
drop procedure if exists caseproc;
delimiter $$
create procedure caseproc(
	in uname varchar(10),
    out tti char(3) -- 변수 선언도 함수 생성부에서 한다.
)
begin
	declare byear int;
    -- declare tti char(3);-- 
    select birthyear into byear from usertbl
		where username = uname;
	case
		 WHEN (bYear%12 = 0) THEN SET tti = '원숭이';
		 WHEN (bYear%12 = 1) THEN SET tti = '닭';
		 WHEN (bYear%12 = 2) THEN SET tti = '개';
		 WHEN (bYear%12 = 3) THEN SET tti = '돼지';
		 WHEN (bYear%12 = 4) THEN SET tti = '쥐';
		 WHEN (bYear%12 = 5) THEN SET tti = '소';
		 WHEN (bYear%12 = 6) THEN SET tti = '호랑이';
		 WHEN (bYear%12 = 7) THEN SET tti = '토끼';
		 WHEN (bYear%12 = 8) THEN SET tti = '용';
		 WHEN (bYear%12 = 9) THEN SET tti = '뱀';
		 WHEN (bYear%12 = 10) THEN SET tti = '말';
		else set tti = '양';
        -- tti의 값이 설정된다.
end case;
-- select concat(uname, '의 띠 ==>', tti);이걸 없애고 아웃풋으로 

end $$
delimiter ;
 
call caseproc('박수홍',@tti);-- 이걸 넣어줘야 띠에 값이 들어간다.
select @tti; -- 따로 출력해본다.

drop table if exists gugutbl;
create table gugutbl (txt varchar(100));

drop procedure if exists whileproc;
delimiter $$
create procedure whileproc()
begin 
declare str varchar(100);
declare i int;
declare k int;

set i = 2; -- 2단부터 계산
while(i < 10) do -- 바깥 반복문(2-9단 반복)
set str = ''; -- 초기화

set k = 1; -- 각단의 문자열 초기화, 구구단의 뒷자리
while (k < 10) do
set str = concat (str, ' ', i, 'x', k, '=', i*k);
set k = k+1;
end while;

set i =  i+1;
insert into gugutbl values(str);
end while;
end $$
delimiter ; 

call whileproc();
select * from gugutbl;

-- 플로우 오류를 사용한다.
drop procedure if exists errorproc;

delimiter $$
create procedure errorproc()
begin
	declare i int;
    declare hap int;
    declare savehap int;
    
    declare exit handler for 1264
		begin
		select concat('int 오버플로 직전의 합계-->',savehap);
        select concat('1+2+3+4+...+',i,'=오버플로');
		end;
	set i = 1; 
    set hap = 0;
    
    while (true) do
		set savehap = hap;
        set hap = hap + i;
        set i = i + 1;
	end while;
    end $$
    delimiter ;

call errorproc();

drop procedure if exists nameproc;

delimiter $$
create procedure nameproc(
in tablename varchar(20)
)
begin
	set @sqlquery= concat('select * from ',tablename, ' where username=?');
    prepare myquery from @sqlquery;
    execute myquery using @username;
    deallocate prepare myquery;
end $$
delimiter ; 
set @username= "유재석";
call nameproc('usertbl');
select @sqlquery;
-- 프리페어문의 적절한 활용



