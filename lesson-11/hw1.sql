-- 1.	Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

drop table if exists logs;

CREATE TABLE `logs` (
   `inserted_at` DATETIME NOT NULL,
   `table_name` varchar(8) not NULL,
   `pri_key` bigint unsigned NOT NULL,
   `name` varchar(255)
 ) ENGINE=ARCHIVE COMMENT='Логгирование операций вставки';


DELIMITER //

drop trigger if exists users_insert_log//
create trigger users_insert_log after insert on users for each row
begin 
	insert into logs values (now(),'users',new.id,new.name);
end//

drop trigger if exists products_insert_log//
create trigger products_insert_log after insert on products for each row
begin 
	insert into logs values (now(),'products',new.id,new.name);
end//

drop trigger if exists catalogs_insert_log//
create trigger catalogs_insert_log after insert on catalogs for each row
begin 
	insert into logs values (now(),'catalogs',new.id,new.name);
end//

DELIMITER ;

insert into catalogs (name) values ('SSD накопители');
insert into products (id,catalog_id,name,description,price) values (8,6,'KINGSTON A400 SA400S37/480G','KINGSTON A400 SA400S37/480G 480ГБ, 2.5", SATA III',4190);