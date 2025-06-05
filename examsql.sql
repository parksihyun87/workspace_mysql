drop database if exists post;
create database post;

use post;

drop table if exists authentbl;
create table authentbl
(username varchar(20) primary key not null,
password varchar(100),
writer varchar(20)
);

drop table if exists posttbl;
create table posttbl
( postnumber int auto_increment not null primary key,
username varchar(20),
title varchar(20),
writer varchar(20),
body text,
pdate date,
foreign key (username) references authentbl(username)
);



