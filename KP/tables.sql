CREATE TABLE `aircrafts` (
  `id` char(9) NOT NULL,
  `name` varchar(30) NOT NULL,
  `seat_config` char(10) NOT NULL,
  `business_seats` json DEFAULT NULL,
  `comfort_seats` json DEFAULT NULL,
  `econom_seats` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT='Типы воздушных судов';

CREATE TABLE `airframes` (
  `regnum` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `seat_config` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `delivered_at` date DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `status` enum('active','parked') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active',
  `usage` enum('занят','свободен') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'свободен',
  PRIMARY KEY (`regnum`),
  KEY `airframes_FK` (`type`),
  CONSTRAINT `airframes_FK` FOREIGN KEY (`type`) REFERENCES `aircrafts` (`id`)
) COMMENT='Парк самолетов';

CREATE TABLE `airports` (
  `apcode` char(3) NOT NULL,
  `apname` varchar(100) DEFAULT NULL,
  `city` varchar(30) NOT NULL,
  PRIMARY KEY (`apcode`)
) COMMENT='Аэропорты';

CREATE TABLE `boarding` (
  `departure_id` bigint unsigned NOT NULL,
  `ticket_id` bigint unsigned NOT NULL,
  `boarded_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `boarding_FK` (`departure_id`),
  KEY `boarding_FK_1` (`ticket_id`),
  CONSTRAINT `boarding_FK` FOREIGN KEY (`departure_id`) REFERENCES `departures` (`departure_id`),
  CONSTRAINT `boarding_FK_1` FOREIGN KEY (`ticket_id`) REFERENCES `registration` (`ticket_id`)
) COMMENT='Посадка на борт';

CREATE TABLE `clients` (
  `firstname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lastname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `birthday` date NOT NULL,
  `passport` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fathername` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Gender` enum('m','f') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`passport`)
) COMMENT='Клиенты аэропорта';

CREATE TABLE `departure_history` (
  `departure_id` bigint unsigned NOT NULL,
  `flight_number` char(7) NOT NULL,
  `scheduled_at` datetime NOT NULL,
  `board_number` varchar(8) NOT NULL,
  `departured_at` datetime DEFAULT NULL,
  `status` enum('Запланирован','Посадка','Отбыл','Прибыл') DEFAULT NULL
) ENGINE=ARCHIVE DEFAULT COMMENT='История отправления рейсов';

CREATE TABLE `departures` (
  `departure_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `flight_number` char(7) NOT NULL,
  `scheduled_at` datetime NOT NULL,
  `board_number` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `departured_at` datetime DEFAULT NULL,
  `business_seats` json NOT NULL,
  `comfort_seats` json DEFAULT NULL,
  `econom_seats` json DEFAULT NULL,
  `business_seats_free` int unsigned GENERATED ALWAYS AS (json_length(`business_seats`)) VIRTUAL,
  `comfort_seats_free` int unsigned GENERATED ALWAYS AS (json_length(`comfort_seats`)) VIRTUAL,
  `econom_seats_free` int unsigned GENERATED ALWAYS AS (json_length(`econom_seats`)) VIRTUAL,
  `status` enum('Запланирован','Регистрация','Посадка','Отбыл','Прибыл') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`departure_id`),
  KEY `board_number` (`board_number`),
  KEY `flight_number` (`flight_number`),
  CONSTRAINT `departures_FK` FOREIGN KEY (`board_number`) REFERENCES `airframes` (`regnum`) ON UPDATE CASCADE,
  CONSTRAINT `departures_ibfk_1` FOREIGN KEY (`flight_number`) REFERENCES `flights` (`num`) ON UPDATE CASCADE
) COMMENT='отправление рейсов';

CREATE TABLE `flights` (
  `num` char(6) NOT NULL,
  `airport_out` char(3) DEFAULT NULL,
  `airport_in` char(3) DEFAULT NULL,
  `localtime_out` time DEFAULT NULL,
  `tz_out` char(6) DEFAULT NULL,
  `localtime_in` time DEFAULT NULL,
  `tz_in` char(6) DEFAULT NULL,
  `schedule` bit(7) NOT NULL,
  `aircraft` varchar(20) NOT NULL,
  `duration` time DEFAULT NULL,
  PRIMARY KEY (`num`,`aircraft`,`schedule`),
  KEY `flights_FK` (`airport_in`),
  CONSTRAINT `flights_FK` FOREIGN KEY (`airport_in`) REFERENCES `airports` (`apcode`) ON UPDATE CASCADE
) COMMENT='расписание рейсов';

CREATE TABLE `registration` (
  `ticket_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `departure_id` bigint unsigned NOT NULL,
  `registrated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `birthday` date NOT NULL,
  `passport` char(11) NOT NULL,
  `fathername` varchar(50) DEFAULT NULL,
  `gender` enum('m','f') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `seat` char(3) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  UNIQUE KEY `ticket_id` (`ticket_id`),
  KEY `registration_FK` (`departure_id`),
  KEY `registration_FK_1` (`passport`),
  CONSTRAINT `registration_FK` FOREIGN KEY (`departure_id`) REFERENCES `departures` (`departure_id`) ON UPDATE CASCADE,
  CONSTRAINT `registration_FK_1` FOREIGN KEY (`passport`) REFERENCES `clients` (`passport`)
) COMMENT='Регистрация на рейсы';

CREATE TABLE `registration_history` (
  `ticket_id` bigint unsigned NOT NULL,
  `departure_id` bigint unsigned NOT NULL,
  `registrated_at` datetime NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `birthday` date NOT NULL,
  `passport` char(11) NOT NULL,
  `fathername` varchar(50) DEFAULT NULL,
  `gender` enum('m','f') DEFAULT NULL,
  `seat` char(3) NOT NULL
) ENGINE=ARCHIVE COMMENT='История регистраций на рейсы';