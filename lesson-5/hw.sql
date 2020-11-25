--Подготовка данных
INSERT INTO storehouses 
  (name)
values 
 ('Автозаводская, 11'),
 ('Строителей, 25'),
 ('Кирова, 215'),
 ('Роторная, 2');

INSERT INTO storehouses_products
  (storehouse_id,product_id,value)
values 
(1,1,300),
(1,2,100),
(1,3,150),
(1,4,120),
(1,5,100),
(1,6,90),
(1,7,200),
(2,1,105),
(2,2,220),
(2,3,50),
(2,4,70),
(2,5,130),
(2,6,290),
(2,7,0),
(3,1,0),
(3,2,0),
(3,3,150),
(3,4,270),
(3,5,10),
(3,6,0),
(3,7,120),
(4,1,165),
(4,2,0),
(4,3,12),
(4,4,25),
(4,5,67),
(4,6,0),
(4,7,98);

--1.	Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
update users set created_at=now(), updated_at=now();
--2.	Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
alter table users change created_at created_at datetime;
alter table users change updated_at updated_at datetime;
--3.	В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
select * from storehouses_products order by if(value = 0 or value is null,1,0),value;
--4.	(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
select * from users where monthname(birthday_at) in ('May','August');
--5.	(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by field(id,5,1,2);

--1.	Подсчитайте средний возраст пользователей в таблице users.
select avg(timestampdiff(year,birthday_at,curdate())) from users;
--2.	Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
select dayname(DATE_FORMAT(birthday_at,'2020-%m-%d')) as `weekday`,count(id) from users group by weekday;
--3.	(по желанию) Подсчитайте произведение чисел в столбце таблицы. (на примере столбца value таблицы storehouses_products)
select round(exp(sum(ln(value)))) as `prod` from storehouses_products where value<>0 and product_id=2;
