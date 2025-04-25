DROP DATABASE IF EXISTS cookdb;
CREATE DATABASE cookdb;
USE cookdb;

CREATE TABLE usertbl (
    userid CHAR(8) PRIMARY KEY,
    username VARCHAR(10) NOT NULL,
    birthyear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mdate DATE
);


CREATE TABLE buytbl (
    num INT AUTO_INCREMENT PRIMARY KEY,
    userid CHAR(8) NOT NULL,
    prodname CHAR(6) NOT NULL,
    groupname CHAR(4),
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    FOREIGN KEY (userid) REFERENCES usertbl(userid)
);
-- 
INSERT INTO usertbl VALUES -- into 뒤에 ()를 넣고 필드를 넣을 수도 있다.
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8'),
('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7'),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9'),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5'),
('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-3-3'),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4'),
('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4'),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

INSERT INTO buytbl VALUES 
(NULL, 'KHD', '운동화', NULL, 30, 2),
(NULL, 'KHD', '노트북', '전자', 1000, 1),
(NULL, 'KYM', '모니터', '전자', 200, 1),
(NULL, 'PSH', '모니터', '전자', 200, 5),
(NULL, 'KHD', '청바지', '의류', 50, 3),
(NULL, 'PSH', '메모리', '전자', 80, 10),
(NULL, 'KJD', '책', '서적', 15, 5),
(NULL, 'LHJ', '책', '서적', 15, 2),
(NULL, 'LHJ', '청바지', '의류', 50, 1),
(NULL, 'PSH', '운동화', NULL, 30, 2),
(NULL, 'LHJ', '책', '서적', 15, 1),
(NULL, 'PSH', '운동화', NULL, 30, 2);
