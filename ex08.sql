use mysql;
drop database if exists tabledb;
create database if not exists tabledb;
 
 -- foreign key(userid) userbuytbl2

use tabledb;
drop table if exists usertbl;
create table usertbl
(userid char(8) not null primary key,
username varchar(10) not null,
birthyear int not null default -1,
addr char(2) not null default '서울',
mobile1 char(3) null,
mobile2 char(8) null,
height smallint null default 170,
mdate date null
); 

insert into usertbl values
('YBJ','유병재', default, default, '010', '12345678', default, '2019,12.12');
insert into usertbl
(userid, username) values ('PNR','박나래');
insert into usertbl values('WB','원빈',1982, '대전', '010', '98765432', 176, '2020.5.5');

select * from usertbl;
 
use tabledb; 
alter table usertbl
add column homepage varchar(30)
default 'http어쩌고'
null;

select * from usertbl;

alter table usertbl
drop column mobile1;

alter table usertbl
change column username uname varchar(20) null;



 
 
 

