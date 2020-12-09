-- 1.	В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
set autocommit=0; -- отключаем автокоммит
start transaction; -- начинаем транзакцию 
insert into example.users (name,birthday_at) select name,birthday_at from shop.users where id=1; -- копируем запись в таблицу example.users
delete from shop.users where id=1; -- удалеяем запись из таблицы shop.users
commit; -- завершаем транзакцию

-- 2.	Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
create view shop.products_info (product_name, catalog_name)
as select p.name,c.name from shop.products p
join shop.catalogs c on c.id = p.catalog_id; 

-- 3.	(по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
-- реализация для версий 8.+
select dd, 
case 
	when count(day(birthday))>0 then 1
	when count(day(birthday))=0 then 0
end
as is_there
from (WITH RECURSIVE seq AS (SELECT 0 AS dd UNION ALL SELECT dd + 1 FROM seq WHERE dd < 31) SELECT * FROM seq) t 
left join vk.users u on t.dd=day(u.birthday) and month(birthday)=8
group by dd
order by 1;

-- 4.	(по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
delete from shop.products_test 
where id not in (
	select id from (
		select id from shop.products_test p order by created_at desc limit 5
	) x
);