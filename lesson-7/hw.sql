-- 1.	Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select u.name,
	o.id 
from users u
join orders o on o.user_id =u.id;

-- 2.	Выведите список товаров products и разделов catalogs, который соответствует товару.
select p.name,p.description,c.name 
from products p 
join catalogs c on c.id = p.catalog_id 

-- 3.	(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
create database aero;
create table `flights` (
	`id` SERIAL PRIMARY KEY, 
	`from` VARCHAR(50), 
	`to` VARCHAR(50)
);

create table cities(
`label` varchar(50),
`name` varchar(50)
);

insert into cities 
(label,name)
values
('Moscow','Москва'),
('London','Лондон'),
('NewYork','Нью-Йорк'),
('Paris','Париж'),
('Tokio','Токио'),
('Neapol','Неаполь'),
('Rome','Рим');

insert into flights 
(`from`,`to`)
values
('London','NewYork'),
('London','Tokio'),
('London','Paris'),
('London','Neapol'),
('London','Rome');

select f.id as `flight_id`,
	c1.name as `from`, 
	c2.name as `to`
from flights f 
join cities c1 on c1.`label` = f.`from`
join cities c2 on c2.`label` = f.`to`