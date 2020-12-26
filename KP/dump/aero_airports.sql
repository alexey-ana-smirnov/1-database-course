-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: aero
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `apcode` char(3) NOT NULL,
  `apname` varchar(100) DEFAULT NULL,
  `city` varchar(30) NOT NULL,
  PRIMARY KEY (`apcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Аэропорты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES ('AAQ','Витязево','Анапа'),('ABA','','Абакан'),('AER','Адлер','Сочи'),('AMS','Схипхол','Амстердам'),('ARH','Талаги','Архангельск'),('ASF','','Астрахань'),('ATH','Елефтериос Венизелос','Афины'),('AYT','','Анталья'),('BAX','','Барнаул'),('BCN','','Барселона'),('BEG','','Белград'),('BER','Бранденбург','Берлин'),('BHK','','Бухара'),('BRU','Брюссель Националь','Брюссель'),('BUD','Международный аэропорт им. Ференца Листа','Будапешт'),('CAI','','Каир'),('CDG','Шарль-де-Голль','Париж'),('CEK','','Челябинск'),('CRC','Cartago Airport','Картаго'),('DEL','Международный аэропорт Индиры Ганди','Дели'),('DUS','','Дюссельдорф'),('DXB','','Дубай'),('EGO','','Белгород'),('EVN','Международный аэропорт Звартноц','Ереван'),('FCO','Фьюмичино','Рим'),('FRA','Франкфурт/Майн','Франкфурт'),('FRU','Манас','Бишкек'),('GDX','Магадан Сокол','Магадан'),('GOJ','Стригино','Нижний Новгород'),('GRV','Аэропорт Грозный','Грозный'),('GSV','Международный аэропорт \"Гагарин\"','Саратов'),('GVA','','Женева'),('GYD','','Баку'),('HEL','Вантаа','Хельсинки'),('HMA','','Ханты-Мансийск'),('HND','Ханэда','Токио'),('IAR','Аэропорт Туношна','Ярославль'),('ICN','Сеул/Инчон','Сеул'),('IJK','Аэропорт Ижевск','Ижевск'),('IKA','Аэропорт Имам Хомейни','Тегеран'),('IKT','','Иркутск'),('IST','','Стамбул'),('JFK','Кеннеди','Нью-Йорк'),('KEJ','','Кемерово'),('KGD','Храброво','Калининград'),('KHV','Международный аэропорт Хабаровск Новый им. Г. И. Невельского','Хабаровск'),('KIV','','Кишинев'),('KJA','Емельяново','Красноярск'),('KRR','Пашковский','Краснодар'),('KUF','Курумоч','Самара'),('KZN','','Казань'),('LAX','','Лос-Анджелес'),('LCA','','Ларнака'),('LED','Пулково','Санкт-Петербург'),('LHR','Хитроу','Лондон'),('MCX','','Махачкала'),('MIA','','Майами'),('MLE','','Мале'),('MMK','','Мурманск'),('MQF','','Магнитогорск'),('MRV','','Минеральные Воды'),('MSQ','Минск-2','Минск'),('MUC','','Мюнхен'),('MXP','Малпенса','Милан'),('NAL','Международный аэропорт Нальчик','Нальчик'),('NBC','Набережные Челны Аэропорт Бегишево','Нижнекамск'),('NCE','','Ницца'),('NJC','','Нижневартовск'),('NOZ','Новокузнецк-Спиченково','Новокузнецк'),('NUX','','Новый Уренгой'),('OGZ','Международный аэропорт Владикавказ','Владикавказ'),('OMS','','Омск'),('OSS','','Ош'),('OSW','Аэропорт Орск','Орск'),('OVB','Толмачево','Новосибирск'),('PEE','Большое Савино','Пермь'),('PEZ','Аэропорт Пенза','Пенза'),('PKC','Елизово','Петропавловск-Камчатский'),('PRG','Аэропорт Вацлава Гавела','Прага'),('PVG','Пудонг','Шанхай'),('REN','','Оренбург'),('ROV','Аэропорт «Платов»','Ростов-на-Дону'),('SCW','','Сыктывкар'),('SGC','','Сургут'),('SIP','','Симферополь'),('SKD','','Самарканд'),('SKX','Аэропорт Саранск','Саранск'),('STW','','Ставрополь'),('SVO','Шереметьево','Москва'),('SVX','Кольцово','Екатеринбург'),('TAS','Южный','Ташкент'),('TJM','Рощино','Тюмень'),('TLV','','Тель-Авив'),('TOF','Томск Богашево','Томск'),('UFA','','Уфа'),('ULV','Баратаевка','Ульяновск'),('UUS','','Южно-Сахалинск'),('VIE','Швехат','Вена'),('VOG','','Волгоград'),('VOZ','Чертовицкое','Воронеж'),('VVO','','Владивосток'),('WAW','Фредерика Шопена','Варшава');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-26  4:57:21
