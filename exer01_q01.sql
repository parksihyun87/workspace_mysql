use cookdb;
create table testtbl4 (id int, Fname varchar(50), Lname varchar(50));
insert into testtbl4
select emp_no, first_name, last_name from employees.employees;
-- 필드명 특이하게 쓸때는 백틱이 원칙이지만 따옴표해도 괜찮음
select * from testtbl4 limit 4;

create table testtbl5
(select emp_no, first_name, last_name from employees.employees);
select *from testtbl5 limit 3;
CREATE TABLE testTBL6
 (SELECT emp_no AS id, first_name AS Fname, last_name AS Lname
 FROM employees.employees);
 SELECT * FROM testTBL6 LIMIT 3;
 
 use cookdb;
 select * from testtbl6 where Fname='Kyoichi';
 update testtbl6
 set Lname='없음'
 where Fname='Kyoichi';
 
 update buytbl
 set price = price * 1.5;
 select * from buytbl;
 
 use cookdb;
 delete from testtbl6 where Fname='Kyoichi' limit 5;
 
 use cookdb;
 create table bigtbl1 (select * from employees.employees);
 create table bigtbl2 (select * from employees.employees);
 create table bigtbl3 (select * from employees.employees);
 
 delete from bigtbl1;
 drop table bigtbl2;
 truncate table bigtbl3;
 
SELECT buyTBL.userid,usertbl.username,buytbl.prodname,usertblusertbl.addr,
 CONCAT(userTBL.mobile1,userTBL.mobile2) as 연락처
 from buytbl
 inner join usetbl
 on buytbl.uesrid=usertbl.userid;
 
 desc buytbl;
 
 
 SELECT 
    buytbl.userid, 
    userTBL.username, 
    buyTBL.prodname, 
    userTBL.addr,
    CONCAT(userTBL.mobile1, userTBL.mobile2) AS 연락처
FROM userTBL
INNER JOIN buyTBL
ON buyTBL.userid = userTBL.userid;


select
b.userid,
u.username,
b.prodname,
u.addr,
concat(u.mobile1, u.mobile2) as '연락처'
from buytbl b
inner join usertbl u
on b.userid=u.userid;

-- 박지성의 고객아이디 이름, 주소, 구매액, 구매 날짜 조회 //마당
use madang;
select * from customertbl;
desc customertbl;
select * from orderstbl;
desc orderstbl;

select
c.name,
c.address,
o.saleprice,
o.orderdate
from customertbl c
inner join orderstbl o
on c.custid=o.custid
where c.name="박지성";

-- 고객별로 이름과 주소와 총 구매액을 조회//마당
select * from customertbl;
desc customertbl;
select * from orderstbl;
desc orderstbl;

select
c.name,
c.address,
sum(o.saleprice)

from customertbl c 
inner join orderstbl o
on c.custid=o.custid
group by c.custid; 
-- 커스트 아이디가 기준이 되어야 그룹이 이루어지는데 반대로 그 외의 것들이 그룹이 안되야 하는 이유는 타 필드가 일치하는 지 컴퓨터가 모름.
-- 유저들의 아이디, 이름, 구매물품, 주소, 연락처를 이름순으로 조회
use cookdb;
show tables;
desc buytbl;
desc usertbl;

use cookdb;

select
u.userid,
u.username,
b.prodname,
u.addr,
concat(u.mobile1, u.mobile2)
from usertbl u
inner join buytbl b
on u.userid=b.userid
order by u.username;
-- 경북에 거주하는 유저들의 아이디, 이름, 구매물품, 구매액을 조회
desc usertbl;
desc buytbl;
select
b.userid,
u.username,
b.prodname
from usertbl u
inner join buytbl b
on u.userid=b.userid
where u.addr='경북'; 
-- where 

-- 경북에 거주하거나 물품 분류가 없는(group name is null) 물건을 구입한 유저들의 아이디, 이름, 구매물품, 주소를 조회
select
u.userid,
u.username,
b.prodname,
u.addr
from usertbl u
join buytbl b
on u.userid=b.userid
where u.addr= "경북" or b.groupname is null;

-- 각 지역 별로 평균키보다 큰 사람들의 주소, 이름, 키를 조회
; 
select *
from usertbl u1
join (select addr, avg(height) as 평균키 from usertbl group by addr) u2
on u1.addr= u2.addr
where u1.height> u2.평균키;
-- 둘이 조인하였다. 계산식은 as로 별칭으로 필드를 넣어야 웨어에서 지칭이 가능해 진다.
