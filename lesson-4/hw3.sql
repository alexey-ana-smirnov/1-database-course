use vk;
CREATE TABLE `users_temp` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `hometown` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `pass` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `phone_2` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
);

INSERT INTO users_temp 
(id, firstname,lastname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) 
VALUES 
(3,'Сергей','Сергеев','qwe@asdf.qw',123123123,'m','1983-03-21','Саратов',NULL,
'fdkjgsdflskdjfgsdfg142356214','2020-09-25 22:09:27.0');

INSERT INTO users_temp (id,firstname,lastname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
(6,'Дмитрий','Тимашов','segginton4@cam.ac.uk',4513359033,'m','1984-06-19','Казань',NULL,'e6ab5f555555fb26c7c60ddd23c8118307804330','2020-09-25 22:09:27.0')
,(7,'Владислав','Авраменко','aswaddle5@altervista.org',1874462339,'m','1987-07-07','Москва',NULL,'b25e49362b83833eece7d225717f2e285213bf25','2020-09-25 22:09:27.0')
,(8,'Алексей','Величко','fleahey6@ftc.gov',2951798252,'m','1984-11-27','Казань',NULL,'07521436ef4b4ad464ed04cdceb99f422bbbd9c5','2020-09-25 22:09:27.0')
,(9,'Артем','Филипцов','rcasley7@exblog.jp',3237322265,'m','1984-08-04','Краснодар',NULL,'5aac7b105729d4ad431db6a4e73604ecec132fa8','2020-09-25 22:09:27.0')
,(10,'Елена','Колдаева','rlantry8@pen.io',3731144657,'f','1989-08-07','Тюмень',NULL,'ba6c51c3064c20f9de84d4ed69733d9dd408e504','2020-09-25 22:09:27.0')
,(11,'Андрей','Антипов','egoatcher9@behance.net',8774858608,'m','1984-09-04','Красноярск',NULL,'16f4e6ac1aedd2d9707b56d767f452f3246e67f7','2020-09-25 22:09:27.0');

INSERT INTO users_temp 
set
	firstname='Евгений',
	lastname='Грачев',
	email='dcolquita@ucla.edu',
	phone=9744906651,
	gender='m',
	birthday='1987-11-26',
	hometown='Омск',
	pass='1487c1cf7c24df739fc97460a2c791a2432df062';

insert into users_temp (firstname, lastname, email, phone, birthday, hometown, gender, pass)
select firstname, lastname, email, phone, birthday, hometown, gender, pass from users
order by birthday desc limit 10;

select * from users_temp;
select * from users_temp limit 10;
select * from users_temp limit 10 offset 10;
select * from users_temp limit 3,8;
select lastname, firstname, phone from users_temp;
select lastname, firstname, phone from users_temp order by lastname desc;
select hometown, lastname, firstname, phone from users_temp order by hometown desc, lastname asc;
select 'hello!';
select 3*8;
select concat(lastname, ' ', firstname) as persons from users_temp;
select concat(lastname,' ', substring(firstname, 1,1), '.') persons from users_temp;
select distinct hometown from users_temp;
select * from users_temp where hometown = 'Омск';
select lastname, firstname, hometown from users_temp 
	where hometown = 'Москва' or hometown ='Санкт-Петербург' or hometown ='Нижний Новгород';
select lastname, firstname, hometown, gender from users_temp 
	where hometown = 'Москва' or gender = 'm';
select lastname, firstname, hometown, gender from users_temp 
	where hometown = 'Москва' and gender = 'm';
select lastname, firstname, hometown from users_temp where hometown in ('Москва', 'Санкт-Петербург', 'Нижний Новгород');
select lastname, firstname, hometown from users_temp where hometown != 'Москва';
select lastname, firstname, hometown from users_temp where hometown <> 'Москва';
select lastname, firstname, birthday from users_temp where birthday >= '1985-01-01';
select lastname, firstname, birthday from users_temp where birthday >= '1985-01-01' and birthday <= '1990-01-01';
select lastname, firstname, birthday from users_temp where birthday between '1985-01-01' and '1990-01-01';
select lastname, firstname from users_temp where lastname like 'С%';
select lastname, firstname from users_temp where lastname like '%ко';
select lastname, firstname from users_temp where lastname like 'Вел_чко';
select lastname, firstname from users_temp where lastname like '_____'; 
select count(*) from users_temp;
select count(hometown) from users_temp;
select count(distinct hometown) from users_temp;
select hometown, count(*) from users_temp group by hometown;
select hometown, count(*) from users_temp group by hometown having count(*) >= 2;

update users_temp 
set 
	hometown = 'Москва',
	gender = 'f'
where hometown rlike '[a-z]+';

CREATE TABLE `communities_temp` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
);

insert into communities_temp (name)
select name from communities
order by id desc limit 10;

delete from communities_temp where id between 1 and 5;
delete from communities_temp;
insert into communities_temp (name)
select name from communities
order by id desc limit 5;
truncate table communities_temp;

drop table communities_temp;
drop table users_temp;