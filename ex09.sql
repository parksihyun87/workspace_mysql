use madang;
alter table orderstbl add column ordamount int default 1;
-- 문항 1

select * from orderstbl;
alter table orderstbl drop column ordamount;

select * from booktbl;
alter table booktbl add column bookamount int default 100;
alter table booktbl drop column bookamount;

select * from customertbl;
alter table customertbl add column custrate varchar(20) default 'bronze';
alter table customertbl drop column custrate;

drop table if exists ratealtertbl;
create table ratealtertbl(
cnumber int auto_increment primary key,
custid varchar(20),
cdate date,
beforerate varchar(20),
aftererate varchar(20)  
);

[문항5] 총 구입액을 기준(기준액 자유)으로 고객등급을 일괄처리하는 프로시저를 생성한다

desc ratealtertbl;
select * from ratealtertbl;
select * from orderstbl;
desc orderstbl; -- orderid int/ custid int/ bookid int/ saleprice int/ orderrate date/ orderamount int
desc customertbl; -- custid auto/name varchar/ address varchar/ phone varchar/ custrate varchar


-- (0/ 10000/ 30000) cursor를 사용
drop procedure if exists ratealter;
delimiter $$
create procedure ratealter()
begin
	declare id int;
    declare hap int;
    declare finalrate varchar(40);
    
    declare endofrow boolean default false; 
    
	declare usercursor cursor for
	select custid,sum(saleprice*ordamount) as 총구매액
    from orderstbl
    group by custid;
    
    declare continue handler
    for not found set endofrow = true; 
          
	open usercursor;
		lb_loop:loop 
		fetch usercursor into id,hap;
        
        if endofrow then
        leave lb_loop;
        end if;
        
        case            
			when (hap>=30000) then
				set finalrate="gold";
			when (hap>=10000) then
				set finalrate="silver";
			else set finalrate="bronze";
		end case;
        
		update customertbl set custrate = finalrate where custid= id;
        end loop lb_loop; 
    close usercursor;    
end $$ 
delimiter ; 

select * from customertbl;

call ratealter();

-- [문항6] 고객등급이 변경되면 변경정보를 고객등급변경내역 테이블에 추가하는 트리거를 생성한다.
-- (인,테,밸)
-- 트리거는 프로시져나 함수처럼 ()소 발동 아니고, (온 , 테이블) 은 연동시켜줄 테이블임
drop trigger if exists updatetrg ;
delimiter $$
create trigger updatetrg
after update
on customertbl
for each row
begin
	insert into ratealtertbl values
    ( null, old.custid, curdate(), old.custrate, new.custrate);
end $$
delimiter ;

desc customertbl;

select * from ratealtertbl;

-- [문항7] order 테이블에 주문 내역이 입력되면 book테이블에 서적 개수를 감소시키는 트리거를 생성한다
desc booktbl;
select * from orderstbl;

drop trigger if exists amounttrg; 
delimiter $$
create trigger amounttrg
after insert
on orderstbl
for each row
begin
	update booktbl set bookamount = bookamount-new.ordamount where bookid=new.bookid;
end $$
delimiter ;

-- [문항8] 구매실적이 생길 때마다 해당 고객의 등급을 다시 계산하여 업데이트하는 트리거를 생성한다.

desc orderstbl;

select * from orderstbl;

drop trigger if exists reupdatetrg;
delimiter $$
create trigger reupdatetrg
after insert
on orderstbl
for each row
begin
	declare hap int;
    declare finalrate varchar(20);
    
	select sum(saleprice*ordamount) into hap
    from orderstbl where custid=new.custid;
    
	case            
			when (hap>=30000) then
				set finalrate="gold";
			when (hap>=10000) then
				set finalrate="silver";
			else set finalrate="bronze";
		end case;
        
		update customertbl set custrate = finalrate where custid= new.custid;
end $$
delimiter ;


