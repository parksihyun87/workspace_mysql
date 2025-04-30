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





