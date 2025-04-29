-- 고객 할인률이 입력될 새로운 테이블을 만든다. (고객id, 할인율) 해당이 프라이머리 키,
-- 가입한지 15년 이상이거나 총구매액이 1000을 넘으면, 0.15 가입한지 12년이상이거나
--  총구매액이 500을 넘으면 0.10, 가입한지 10년 이상이거나 총구매액이 100을 넘으면 0.05
--  나머지는 0.0
--  cust_dis_rate

-- 크리에이트 종류 이름 괄호
-- 프로시져는 여러 작업이 묶인 실행체이다.
-- 함수는 select 문과 묶인다.
use cookdb;

desc usertbl;
desc buytbl;

drop procedure if exists cust_dis_rate; -- 디 리미터임
delimiter $$ 
create procedure cust_dis_rate() -- 괄호 닫은채로 시작함
begin
	declare memid varchar(20);    
    declare memdate date;
    declare memsum int;
    declare years double; -- 추가
    declare memdis double; -- 추가
    declare endofrow boolean default false; -- 추가
	
     declare usercursor cursor for -- 커서 변수 와 커서자체 선언(declare,커변, cursor, for) 4가지, 해당 테이블의 모든 레코드 칸의 값에 간섭함. 디클레어 커서가 변수 밑쪽으로 위에 있어야 함.
		select u.userid, sum(b.price * b.amount), u.mdate -- 
        from usertbl u
        left outer join buytbl b
        on u.userid=b.userid
        group by u.userid;
    
    declare continue handler for not found 
    set endofrow = true; -- 컨티뉴 핸들러는 계속하고, 엑시트 핸들러는 강제 탈출한다. -- 컨티뉴 핸들러는 계속하고, 엑시트 핸들러는 강제 탈출한다.
            
    -- 그룹바이는 더하기
    
   drop table if exists userdiscount; 
   create table userdiscount(
	userid varchar(20) primary key, -- 변수명 자료형 항상 적용/변널프
	disrate double
	); 
    -- 크리에이트도 ; 해줘야 함.
    open usercursor; -- 값을 원본의 모든 칸마다 갖고 오는 커서를 호출 및 저장, (open + 커서변수+;)3가지
    cust_loop:loop-- (라벨 붙인: 루프) 2가지
		fetch usercursor into memid, memsum, memdate; -- (fetch,커서이름, into ,첫행 값들)4가지
		
        if endofrow then -- (if then으로 리브함)
			leave cust_loop;
        end if;
		-- 조건문은 end로 끝을 알림
        
        -- set years= datediff(curdate(), memdate)/365;
        
        case -- (case, when,then,end, case, ;)6가지 씀. 
			when memsum >= 1000 or (year(curdate())-year(memdate))>=15 then
				set memdis= 0.15;
            when memsum >= 500 or (year(curdate())-year(memdate))>=12 then
				set memdis= 0.10;
            when memsum >= 100 or (year(curdate())-year(memdate))>=10 then
				set memdis= 0.05;
            else 
				set memdis=0.00;
		end case;
	
		insert into userdiscount values
		(memid, memdis);
    -- (업데이트, 테이블, 셋 , 필드, 필드 바꿀내용)5가지
    -- ((insert into, 테이블, values)3가지,(소괄호에 필드내용))4가지;
    end loop cust_loop;-- 루프는 명령을 내릴때는 뒤에 라벨을 붙임. (end + 끝낼 개체)2가지
    
    close usercursor; -- 커서도 닫기는, (클+커서변수) 2가지
end $$
delimiter ;

call cust_dis_rate();

USE cookDB;
 CREATE TABLE IF NOT EXISTS testTBL7(id INT, txt VARCHAR(10));
 INSERT INTO testTBLVALUES (1, '이엑스아이디');
 INSERT INTO testTBLVALUES (2, '블랙핑크');
 INSERT INTO testTBLVALUES (3, '에이핑크');

drop trigger if exists testtrg; -- 테스트 트리거
delimiter $$
create trigger testtrg -- (크리에이트, 동작, 온테, 포이로)
	after delete -- (after/before)2가지
	on testtbl7
    for each row -- 각 행마다 적용
begin
	set @msg ='가수그룹이 삭제됨';
end $$
delimiter ;
-- 실습 못해봄

USE cookDB;
DROP TABLE buyTBL3; 
CREATE TABLE backup_userTBL3
 (userID char(8) NOT NULL, 
userNamevar char(10) NOT NULL, 
birthYear int NOT NULL, 
addr char(2) NOT NULL, 
mobile1 char(3), 
mobile2 char(8), 
height smallint, 
mDate date, 
modType char(2), 
modDate date, 
modUser varchar(256) 
);

drop trigger if exists backusertbl_updatetrg;
delimiter $$
create trigger backusertbl_updatetrg
	after update -- 에프터
    on usertbl -- 온대상
    for each row -- 포 이 로 42로우
begin
	insert into backup_usertbl values
     (OLD.userID, OLD.userName, OLD.birthYear, OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
	'수정', CURDATE(), current_user()); -- 올드의 자료들, 실행명, 커데이터 2개(커데이트(), 커런트_유저())를 넣는다.
end $$
delimiter ;
-- 다 못해봄.

update usertbl set addr= '제주' where userid='KJD';
-- update 옵션 체크? 했는데.

drop trigger if exists usertbl_inserttrg;
delimiter $$
create trigger usertbl_inserttrg
	after insert
    on usertbl
    for each row
begin
	signal sqlstate'45000'
    set message_text ='데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었다.';
end $$
delimiter ;
desc usertbl;
INSERT INTO userTBL VALUES ('ABC', '에비씨', 1977, '서울', '011', '1111111', 181, '2019-12-25', null);

drop trigger if exists usertbl_beforeinserttrg;
DELIMITER // 
CREATE TRIGGER userTBL_BeforeInsertTrg
 BEFORE INSERT  
 ON userTBL
 FOR EACH ROW 
BEGIN 
 IF NEW.birthYear< 1900 THEN 
 SET NEW.birthYear= 0;
ELSEIF NEW.birthYear> YEAR(CURDATE()) THEN 
 SET NEW.birthYear= YEAR(CURDATE());
 END IF;
END // 
delimiter ;

INSERT INTO userTBL VALUES 
('AAA', '에이', 1877, '서울', '011', '11112222', 181, '2019-12-25',null);
 INSERT INTO userTBL VALUES 
('BBB', '비이', 2977, '경기', '011', '11113333', 171, '2011-3-25', null);
        
select * from usertbl;

    







	
 
