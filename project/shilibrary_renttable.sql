use shlibrary;


drop table if exists renttbl;
create table renttbl(
number int auto_increment primary key,
personid varchar(10) not null,
bookid int not null,
renttbldate date not null,
duedate date not null,
prolong boolean not null,
overduedate int not null,
turnin boolean not null,
prepared int default 0 not null
);

desc renttbl;
-- 등급별 대출 가능 권수 신입:2/일반:3/우수:5/모범:7/(장기연체 1권)
-- 회원 등급기준: 신입 처음 / 일반 1y & 10b(장기연체x) / 우수  2y & 15b(장기연체x) / 모범 3y & 20b(장기연체x) /연체가 4w 이상(반납일로부터 1년간 장기연체자 등급이며 그 기간에 장기연체 없으면->일반)
-- 1년 기준일 일단 오늘 기준으로 1년 계산하여 확인-> 1. 오늘로부터 1년 안에 10권 이상인지-> 일단 이렇게 하고 한번 올라간 등급은 장기 연체없으면 안떨어짐. 일년안에 n권 밖에 2권 정도 두기.
-- 현재 cccc 1일 연체중 (두권)

* 일반 

-- (null, 'aaaa', 1000, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1001, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1010, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1011, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1012, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1013, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1014, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1020, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1021, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1030, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1031, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1032, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1033, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1034, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1040, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1041, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1042, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1043, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1044, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1045, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1046, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 1050, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 2001, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 2002, '2024-06-03','2024-06-16', false, 0, false),
-- (null, 'aaaa', 2003, '2024-06-03','2024-06-16', false, 0, false),


* 우수 

-- (null, 'aaaa', 1000, '2023-04-03','2023-04-16', false, 0, false),
-- (null, 'aaaa', 1001, '2023-03-03','2023-03-16', false, 0, false);

-- (null, 'aaaa', 1010, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1011, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1012, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1013, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1014, '2023-03-03','2023-03-16', false, 0, false);
-- (null, 'aaaa', 1020, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1021, '2023-03-03','2023-03-16', false, 0, false);
-- (null, 'aaaa', 1030, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1031, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'dddd', 1032, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1033, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1034, '2023-03-03','2023-03-16', false, 0, false);
-- (null, 'eeee', 1040, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1041, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1042, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1043, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1044, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1045, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 1046, '2023-03-03','2023-03-16', false, 0, false);
-- (null, 'aaaa', 1050, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 2001, '2023-03-03','2023-03-16', false, 0, false),
-- (null, 'aaaa', 2002, '2023-03-03','2023-03-16', false, 0, false);
-- (null, 'aaaa', 2003, '2023-03-03','2023-03-16', false, 0, false);

-- id: 'aaaa'의 2건의 대출이력/신입!
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'aaaa', 1000, '2025-05-03','2025-05-16', false, 0, false),
(null, 'aaaa', 1001, '2025-05-03','2025-05-16', false, 0, false);

select * from renttbl;
-- id: 'bbbb'의 5건의 대출이력/우수!
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'bbbb', 1030, '2023-05-03', '2023-05-16', false, 0, false),
(null, 'bbbb', 1031, '2023-05-17', '2023-05-30', false, 0, false),
(null, 'bbbb', 1032, '2023-05-31', '2023-06-13', false, 0, false),
(null, 'bbbb', 1033, '2023-06-14', '2023-06-27', false, 0, false),
(null, 'bbbb', 1034, '2023-06-28', '2023-07-11', false, 0, false),
(null, 'bbbb', 1035, '2023-07-12', '2023-07-25', false, 0, false),
(null, 'bbbb', 1036, '2023-07-26', '2023-08-08', false, 0, false),
(null, 'bbbb', 1037, '2023-08-09', '2023-08-22', false, 0, false),
(null, 'bbbb', 1038, '2023-08-23', '2023-09-05', false, 0, false),
(null, 'bbbb', 1039, '2023-09-06', '2023-09-19', false, 0, false),
(null, 'bbbb', 1040, '2023-09-20', '2023-10-03', false, 0, false),
(null, 'bbbb', 1041, '2023-10-04', '2023-10-17', false, 0, false),
(null, 'bbbb', 1042, '2023-10-18', '2023-10-31', false, 0, false),
(null, 'bbbb', 1043, '2023-11-01', '2023-11-14', false, 0, false),
(null, 'bbbb', 1044, '2023-11-15', '2023-11-28', false, 0, false),

(null, 'bbbb', 1030, '2024-05-03', '2024-05-16', false, 0, false),
(null, 'bbbb', 1031, '2024-05-17', '2024-05-30', false, 0, false),
(null, 'bbbb', 1032, '2024-05-31', '2024-06-13', false, 0, false),
(null, 'bbbb', 1033, '2024-06-14', '2024-06-27', false, 0, false),
(null, 'bbbb', 1034, '2024-06-28', '2024-07-11', false, 0, false),
(null, 'bbbb', 1035, '2024-07-12', '2024-07-25', false, 0, false),
(null, 'bbbb', 1036, '2024-07-26', '2024-08-08', false, 0, false),
(null, 'bbbb', 1037, '2024-08-09', '2024-08-22', false, 0, false),
(null, 'bbbb', 1038, '2024-08-23', '2024-09-05', false, 0, false),
(null, 'bbbb', 1039, '2024-09-06', '2024-09-19', false, 0, false),
(null, 'bbbb', 1040, '2024-09-20', '2024-10-03', false, 0, false),
(null, 'bbbb', 1041, '2024-10-04', '2024-10-17', false, 0, false),
(null, 'bbbb', 1042, '2024-10-18', '2024-10-31', false, 0, false),
(null, 'bbbb', 1043, '2024-11-01', '2024-11-14', false, 0, false),
(null, 'bbbb', 1044, '2024-11-15', '2024-11-28', false, 0, false),

(null, 'bbbb', 1010, '2025-05-03','2025-05-16', false, 0, false),
(null, 'bbbb', 1011, '2025-05-03','2025-05-16', false, 0, false),
(null, 'bbbb', 1012, '2025-05-03','2025-05-16', false, 0, false),
(null, 'bbbb', 1013, '2025-05-03','2025-05-16', false, 0, false),
(null, 'bbbb', 1014, '2025-05-03','2025-05-16', false, 0, false);

-- id: 연체자 'cccc'의 2건의 대출이력/신입(현재 연체중)!
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'cccc', 1020, '2025-04-18','2025-05-01', false, 1, false),
(null, 'cccc', 1021, '2025-04-18','2025-05-01', false, 1, false);

-- id: 'dddd'의 5건의 대출이력/우수!
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'bbbb', 1030, '2024-05-03', '2024-05-16', false, 0, false),
(null, 'bbbb', 1031, '2024-05-17', '2024-05-30', false, 0, false),
(null, 'bbbb', 1032, '2024-05-31', '2024-06-13', false, 0, false),
(null, 'bbbb', 1033, '2024-06-14', '2024-06-27', false, 0, false),
(null, 'bbbb', 1034, '2024-06-28', '2024-07-11', false, 0, false),
(null, 'bbbb', 1035, '2024-07-12', '2024-07-25', false, 0, false),
(null, 'bbbb', 1036, '2024-07-26', '2024-08-08', false, 0, false),
(null, 'bbbb', 1037, '2024-08-09', '2024-08-22', false, 0, false),
(null, 'bbbb', 1038, '2024-08-23', '2024-09-05', false, 0, false),
(null, 'bbbb', 1039, '2024-09-06', '2024-09-19', false, 0, false),
(null, 'bbbb', 1040, '2024-09-20', '2024-10-03', false, 0, false),
(null, 'bbbb', 1041, '2024-10-04', '2024-10-17', false, 0, false),
(null, 'bbbb', 1042, '2024-10-18', '2024-10-31', false, 0, false),
(null, 'bbbb', 1043, '2024-11-01', '2024-11-14', false, 0, false),
(null, 'bbbb', 1044, '2024-11-15', '2024-11-28', false, 0, false),

(null, 'bbbb', 1030, '2023-05-03', '2023-05-16', false, 0, false),
(null, 'bbbb', 1031, '2023-05-17', '2023-05-30', false, 0, false),
(null, 'bbbb', 1032, '2023-05-31', '2023-06-13', false, 0, false),
(null, 'bbbb', 1033, '2023-06-14', '2023-06-27', false, 0, false),
(null, 'bbbb', 1034, '2023-06-28', '2023-07-11', false, 0, false),
(null, 'bbbb', 1035, '2023-07-12', '2023-07-25', false, 0, false),
(null, 'bbbb', 1036, '2023-07-26', '2023-08-08', false, 0, false),
(null, 'bbbb', 1037, '2023-08-09', '2023-08-22', false, 0, false),
(null, 'bbbb', 1038, '2023-08-23', '2023-09-05', false, 0, false),
(null, 'bbbb', 1039, '2023-09-06', '2023-09-19', false, 0, false),
(null, 'bbbb', 1040, '2023-09-20', '2023-10-03', false, 0, false),
(null, 'bbbb', 1041, '2023-10-04', '2023-10-17', false, 0, false),
(null, 'bbbb', 1042, '2023-10-18', '2023-10-31', false, 0, false),
(null, 'bbbb', 1043, '2023-11-01', '2023-11-14', false, 0, false),
(null, 'bbbb', 1044, '2023-11-15', '2023-11-28', false, 0, false);

(null, 'dddd', 1030, '2025-05-03','2025-05-16', false, 0, false),
(null, 'dddd', 1031, '2025-05-03','2025-05-16', false, 0, false),
(null, 'dddd', 1032, '2025-05-03','2025-05-16', false, 0, false),
(null, 'dddd', 1033, '2025-05-03','2025-05-16', false, 0, false),
(null, 'dddd', 1034, '2025-05-03','2025-05-16', false, 0, false);

-- id: 'eeee'의 7건의 대출이력/모범
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values







(null, 'eeee', 1040, '2025-05-03','2025-05-16', false, 0, false),
(null, 'eeee', 1041, '2025-05-03','2025-05-16', false, 0, false),
(null, 'eeee', 1042, '2025-05-03','2025-05-16', false, 0, false),
(null, 'eeee', 1043, '2025-05-03','2025-05-16', false, 0, false),
(null, 'eeee', 1044, '2025-05-03','2025-05-16', false, 0, false),
(null, 'eeee', 1045, '2025-05-03','2025-05-16', false, 0, false),
(null, 'eeee', 1046, '2025-05-03','2025-05-16', false, 0, false);

-- id: 'ffff'의 3건의 대출이력/일반!
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'bbbb', 1000, '2024-05-03', '2024-05-16', false, 0, false),
(null, 'bbbb', 1001, '2024-05-17', '2024-05-30', false, 0, false),
(null, 'bbbb', 1002, '2024-05-31', '2024-06-13', false, 0, false),
(null, 'bbbb', 1003, '2024-06-14', '2024-06-27', false, 0, false),
(null, 'bbbb', 1004, '2024-06-28', '2024-07-11', false, 0, false),
(null, 'bbbb', 1005, '2024-07-12', '2024-07-25', false, 0, false),
(null, 'bbbb', 1006, '2024-07-26', '2024-08-08', false, 0, false),
(null, 'bbbb', 1007, '2024-08-09', '2024-08-22', false, 0, false),
(null, 'bbbb', 1008, '2024-08-23', '2024-09-05', false, 0, false),
(null, 'bbbb', 1009, '2024-09-06', '2024-09-19', false, 0, false),
(null, 'bbbb', 1010, '2024-09-20', '2024-10-03', false, 0, false),
(null, 'bbbb', 1011, '2024-10-04', '2024-10-17', false, 0, false),
(null, 'bbbb', 1012, '2024-10-18', '2024-10-31', false, 0, false),
(null, 'bbbb', 1013, '2024-11-01', '2024-11-14', false, 0, false),
(null, 'bbbb', 1014, '2024-11-15', '2024-11-28', false, 0, false),


(null, 'ffff', 1050, '2025-05-03','2025-05-16', false, 0, false),
(null, 'ffff', 1051, '2025-05-03','2025-05-16', false, 0, false),
(null, 'ffff', 1052, '2025-05-03','2025-05-16', false, 0, false);

-- id: 'gggg'의 1건의 대출이력/일반!
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'bbbb', 1015, '2024-05-03', '2024-05-16', false, 0, false),
(null, 'bbbb', 1016, '2024-05-17', '2024-05-30', false, 0, false),
(null, 'bbbb', 1017, '2024-05-31', '2024-06-13', false, 0, false),
(null, 'bbbb', 1018, '2024-06-14', '2024-06-27', false, 0, false),
(null, 'bbbb', 1019, '2024-06-28', '2024-07-11', false, 0, false),
(null, 'bbbb', 1020, '2024-07-12', '2024-07-25', false, 0, false),
(null, 'bbbb', 1021, '2024-07-26', '2024-08-08', false, 0, false),
(null, 'bbbb', 1022, '2024-08-09', '2024-08-22', false, 0, false),
(null, 'bbbb', 1023, '2024-08-23', '2024-09-05', false, 0, false),
(null, 'bbbb', 1024, '2024-09-06', '2024-09-19', false, 0, false),
(null, 'bbbb', 1025, '2024-09-20', '2024-10-03', false, 0, false),
(null, 'bbbb', 1026, '2024-10-04', '2024-10-17', false, 0, false),
(null, 'bbbb', 1027, '2024-10-18', '2024-10-31', false, 0, false),
(null, 'bbbb', 1028, '2024-11-01', '2024-11-14', false, 0, false),
(null, 'bbbb', 1029, '2024-11-15', '2024-11-28', false, 0, false),

(null, 'gggg', 1060, '2025-05-03','2025-05-16', false, 0, false);

-- id: 'hhhh'의 1건의 대출이력/장기연체자
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'hhhh', 1070, '2025-05-03','2025-05-16', false, 0, false);

-- id: 'iiii'의 1건의 대출이력/장기연체자
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'iiii', 1080, '2025-05-03','2025-05-16', false, 0, false);

-- id: 'jjjj'의 1건의 대출이력/신입
insert into renttbl
(number, personid, bookid, renttbldate, duedate, prolong, overduedate, turnin) values
(null, 'jjjj', 1090, '2025-05-03','2025-05-16', false, 0, false);


select * from renttbl;