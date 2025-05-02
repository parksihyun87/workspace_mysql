-- MySQL dump 10.13  Distrib 8.0.11, for Win64 (x86_64)
--
-- Host: localhost    Database: shlibrary
-- ------------------------------------------------------
-- Server version	8.0.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `usertbl`
--

DROP TABLE IF EXISTS `usertbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usertbl` (
  `userid` char(4) NOT NULL,
  `userpw` char(4) NOT NULL,
  `username` varchar(5) NOT NULL,
  `userdate` date DEFAULT NULL,
  `userage` int(11) DEFAULT NULL,
  `userinterest` varchar(6) DEFAULT NULL,
  `usergrade` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertbl`
--

LOCK TABLES `usertbl` WRITE;
/*!40000 ALTER TABLE `usertbl` DISABLE KEYS */;
INSERT INTO `usertbl` VALUES ('aaaa','1111','김정태','2025-03-23',27,NULL,'신입회원'),('adm1','adm1','장희용','2015-07-23',NULL,NULL,'관리자'),('adm2','adm2','박시현','2015-06-12',NULL,NULL,'관리자'),('bbbb','2222','조주언','2022-07-12',NULL,'철학','우수회원'),('cccc','3333','김민규','2024-12-04',NULL,NULL,'신입회원'),('dddd','4444','박준홍','2023-01-22',21,'자연과학','우수회원'),('eeee','5555','최서영','2018-05-15',28,'기술과학','모범회원'),('ffff','6666','임현범','2024-02-27',30,'예술','일반회원'),('gggg','7777','장창현','2024-04-30',19,'문학','일반회원'),('hhhh','8888','지재호','2020-09-12',34,NULL,'장기연체자'),('iiii','9999','장선아','2023-11-05',28,NULL,'장기연체자'),('jjjj','0000','최세령','2024-10-02',NULL,'총류','신입회원');
/*!40000 ALTER TABLE `usertbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-01 17:40:19
