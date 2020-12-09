-- 1.	Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.
create user shop_read identified by 'Qwertyu11';
grant select on shop.* to 'shop_read'@'%';
create user shop identified by 'Qwertyu22';
grant ALL on shop.* to 'shop'@'%';

-- 2.	(по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.
use example;
CREATE TABLE `accounts` (
  id SERIAL PRIMARY KEY,
  name varchar(50) NOT NULL,
  pass char(40) DEFAULT NULL
);

INSERT INTO `accounts` VALUES ('1','Frederick Parker','fdc852a7ac6dc8601b61f7ad6fe913adbde16745'),
('2','Coy Abshire','0ada39282a799a59e92aef371cb263a7fc196c6c'),
('3','Ms. Rhianna Mayer','1ecf8c8f57bf803678132a6035ec04de44cd1dd0'),
('4','Prof. Genesis Konopelski','4e69dffd0682c502078fadb27bf84b6501c9c533'),
('5','Prof. Joy Wilkinson','d1bb39ef1be6e6ae875610776739e118216c2b89'),
('6','Prof. Gloria O\'Hara I','37526e810314d85e3154924a58baf48cfac574a2'),
('7','Clifton Marquardt','169381ae03ae64a108358a88997e3a32af721f75'),
('8','Mr. Guy Fisher','8f444ad0897eb549cf0faa622ae11e16b90f2dc6'),
('9','Mr. Gaetano Tillman','bd81a5f2da728b3812214a10a636ad1ca735f6bf'),
('10','Magdalena Turner DVM','74965b78841c1c72006b7a62742c7b983fd9a035'); 

create view example.accounts_view (id,name) as select id,name from example.accounts;
select * from accounts_view;
create user user_read identified by 'Qwertyu11';
grant select on example.accounts_view to 'user_read'@'%';
