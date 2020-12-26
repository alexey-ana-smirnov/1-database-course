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
-- Temporary view structure for view `online_timetable`
--

DROP TABLE IF EXISTS `online_timetable`;
/*!50001 DROP VIEW IF EXISTS `online_timetable`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `online_timetable` AS SELECT 
 1 AS `Направление`,
 1 AS `Номер рейса`,
 1 AS `Время отправления`,
 1 AS `Время прибытия`,
 1 AS `Статус`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `traffic_stat`
--

DROP TABLE IF EXISTS `traffic_stat`;
/*!50001 DROP VIEW IF EXISTS `traffic_stat`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `traffic_stat` AS SELECT 
 1 AS `Направление`,
 1 AS `Число рейсов`,
 1 AS `Общее число пассажиров`,
 1 AS `Среднее число пассажиров на борту`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `online_timetable`
--

/*!50001 DROP VIEW IF EXISTS `online_timetable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `online_timetable` AS select `a`.`city` AS `Направление`,`f`.`num` AS `Номер рейса`,concat(convert(date_format(`d`.`scheduled_at`,'%H:%i') using utf8mb4),`f`.`tz_out`) AS `Время отправления`,concat(convert(date_format(convert_tz(addtime(`d`.`scheduled_at`,cast(`f`.`duration` as datetime)),`f`.`tz_out`,`f`.`tz_in`),'%Y-%m-%d %H:%i') using utf8mb4),`f`.`tz_in`) AS `Время прибытия`,`d`.`status` AS `Статус` from ((((`departures` `d` join `flights` `f` on(((`f`.`num` = `d`.`flight_number`) and (cast(`d`.`scheduled_at` as time) = `f`.`localtime_out`)))) join `airframes` `af` on((`af`.`regnum` = `d`.`board_number`))) join `aircrafts` `ac` on(((`ac`.`id` = `af`.`type`) and regexp_like(`ac`.`name`,`f`.`aircraft`)))) join `airports` `a` on((`a`.`apcode` = `f`.`airport_in`))) where ((`d`.`status` = 'Запланирован') or (`d`.`status` = 'Регистрация') or (`d`.`status` = 'Посадка') or (`d`.`status` = 'Отбыл') or (`d`.`scheduled_at` > (now() - interval 6 hour))) order by `d`.`scheduled_at` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `traffic_stat`
--

/*!50001 DROP VIEW IF EXISTS `traffic_stat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `traffic_stat` AS select `a`.`city` AS `Направление`,count(distinct `d`.`departure_id`) AS `Число рейсов`,count(`r`.`ticket_id`) AS `Общее число пассажиров`,round((count(`r`.`ticket_id`) / count(distinct `d`.`departure_id`)),1) AS `Среднее число пассажиров на борту` from (((((`registration` `r` join `departures` `d` on((`d`.`departure_id` = `r`.`departure_id`))) join `flights` `f` on(((`f`.`num` = `d`.`flight_number`) and (`f`.`localtime_out` = cast(`d`.`scheduled_at` as time))))) join `airframes` `af` on((`af`.`regnum` = `d`.`board_number`))) join `aircrafts` `ac` on(((`ac`.`id` = `af`.`type`) and regexp_like(`ac`.`name`,`f`.`aircraft`)))) join `airports` `a` on((`a`.`apcode` = `f`.`airport_in`))) where ((cast(`d`.`scheduled_at` as date) = cast((now() - interval 1 day) as date)) and (0 <> (`f`.`schedule` & ('1000000' >> (dayofweek(cast((now() - interval 1 day) as date)) - 2)))) and (`d`.`status` = 'Прибыл')) group by `a`.`city` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'aero'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `call_boarding_init` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `call_boarding_init` ON SCHEDULE EVERY 1 SECOND STARTS '2020-12-25 06:40:54' ON COMPLETION NOT PRESERVE ENABLE DO call boarding_init() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `call_create_archive` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `call_create_archive` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-26 01:00:00' ON COMPLETION NOT PRESERVE ENABLE DO call create_departure_archive() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `call_departure_init` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `call_departure_init` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-12-25 06:38:50' ON COMPLETION NOT PRESERVE ENABLE DO call departure_init() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `call_registration_init` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `call_registration_init` ON SCHEDULE EVERY 1 SECOND STARTS '2020-12-25 06:38:59' ON COMPLETION NOT PRESERVE ENABLE DO call registration_init() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'aero'
--
/*!50003 DROP PROCEDURE IF EXISTS `boarding_init` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `boarding_init`()
begin

	select departure_id into @did from departures where status='Посадка' order by rand() limit 1;

	insert into boarding (ticket_id,departure_id)
	select ticket_id,departure_id from registration r
	where r.departure_id=@did and 
	ticket_id not in (select ticket_id from boarding where departure_id=@did)
	order by rand() limit 1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_archive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_archive`()
begin 
	
	insert into departure_history (departure_id,
		flight_number,
		scheduled_at,
		departured_at,
		board_number )
	select departure_id,
		flight_number,
		scheduled_at,
		departured_at,
		board_number 
	from departures 
	where scheduled_at < date(now()-interval 3 day);
	
	insert into registration_history (ticket_id,
		departure_id,
		registrated_at,
		firstname,
		lastname,
		birthday,
		passport,
		fathername,
		gender,
		seat)
	select ticket_id,
		departure_id,
		registrated_at,
		firstname,
		lastname,
		birthday,
		passport,
		fathername,
		gender,
		seat 
	from registration 
	where registrated_at < date(now()-interval 3 day);

	delete from departures where scheduled_at < date(now()-interval 3 day);
	delete from registration where registrated_at < date(now()-interval 3 day);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `departure_init` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `departure_init`()
begin
	insert into departures (flight_number,scheduled_at,board_number,business_seats,comfort_seats,econom_seats,status)
	select t1.num,t1.localtime_out,af.regnum,ac.business_seats, ac.comfort_seats ,ac.econom_seats,'Запланирован' 
	from 
	(select f.num,f.localtime_out,f.aircraft from flights f 
	where ((timestamp(date(now()),f.localtime_out)> now()+interval 120 minute and timestamp(date(now()),f.localtime_out) < now()+interval 6 hour)
	or (timestamp(date(now()+interval 6 hour),f.localtime_out)> now()+interval 120 minute and timestamp(date(now()+interval 6 hour),f.localtime_out) < now()+interval 6 hour))
	and f.schedule&'1000000'>>dayofweek(now())-2
	and f.num not in (select d.flight_number from departures d where status='Запланирован' or status='Посадка' or status='Отбыл')
	order by f.localtime_out asc,rand() limit 1) t1
	join aircrafts ac on ac.name rlike t1.aircraft 
	join airframes af on af.`type`=ac.id and af.status='active' and af.`usage`='свободен'
	order by rand() limit 1;
	update departures set status='Регистрация' where status='Запланирован' and scheduled_at < now()+ interval 120 minute and scheduled_at > now() - interval 40 minute;
	update departures set status='Посадка' where status='Регистрация' and scheduled_at < now()+interval 40 minute and scheduled_at > now()+interval 20 minute;
	update departures set status='Отбыл',departured_at=now() where status='Посадка' and scheduled_at < now()+interval 20 minute and scheduled_at > now();
	update departures set status='Прибыл' where departure_id in (select t.departure_id from (
	select d.departure_id 
	from departures d 
	join flights f on f.num = d.flight_number 
	where addtime(d.scheduled_at,timestamp(f.duration))<now() and d.status='Отбыл') t);
	update airframes set `usage`='занят' where regnum in (select board_number from departures where status in ('Запланирован','Регистрация','Посадка','Отбыл'));
	update airframes set `usage`='свободен' where regnum in (select board_number from departures where status='Прибыл');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registration_init` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registration_init`()
begin
	select d.departure_id, d.business_seats,d.comfort_seats,d.econom_seats, d.business_seats_free,d.comfort_seats_free,d.econom_seats_free
	into @departure_id,@business_seats_array,@comfort_seats_array,@econom_seats_array,@business_seats_free,@comfort_seats_free,@econom_seats_free
	from departures d where status = 'Регистрация' 
	and (d.econom_seats_free>0 or d.business_seats_free>0 or d.comfort_seats_free>0)	
	order by rand() limit 1;
if @econom_seats_free>0 then
	set @i=floor(rand()*json_length(@econom_seats_array));
	select json_unquote(json_extract(@econom_seats_array,concat('$[',@i,']'))) into @seat;
	select json_remove(@econom_seats_array, concat('$[',@i,']')) into @econom_seats_array;
	insert into registration (departure_id,firstname,lastname,passport,gender,birthday,fathername,seat)
	select @departure_id,c.firstname,c.lastname,c.passport,c.gender,c.birthday,c.fathername,@seat from clients c order by rand() limit 1;
	update departures set econom_seats=@econom_seats_array where departure_id=@departure_id;
elseif @comfort_seats_free>0 then
	set @i=floor(rand()*json_length(@econom_seats_array));
	select json_unquote(json_extract(@comfort_seats_array,concat('$[',@i,']'))) into @seat;
	select json_remove(@comfort_seats_array, concat('$[',@i,']')) into @comfort_seats_array;
	insert into registration (departure_id,firstname,lastname,passport,gender,birthday,fathername,seat)
	select @departure_id,c.firstname,c.lastname,c.passport,c.gender,c.birthday,c.fathername,@seat from clients c order by rand() limit 1;
	update departures set comfort_seats=@comfort_seats_array where departure_id=@departure_id;
 elseif @business_seats_free>0 then
	set @i=floor(rand()*json_length(@business_seats_array));
	select json_unquote(json_extract(@business_seats_array,concat('$[',@i,']'))) into @seat;
	select json_remove(@business_seats_array, concat('$[',@i,']')) into @business_seats_array;
	insert into registration (departure_id,firstname,lastname,passport,gender,birthday,fathername,seat)
	select @departure_id,c.firstname,c.lastname,c.passport,c.gender,c.birthday,c.fathername,@seat from clients c order by rand() limit 1;
	update departures set business_seats=@business_seats_array where departure_id=@departure_id;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-26  4:57:25
