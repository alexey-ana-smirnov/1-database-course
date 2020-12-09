-- 1.	Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
drop function if exists hello;
DELIMITER //

CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC
begin
	declare message varchar(15);
	declare timecur time default time(now());
	set message = case 
		when timecur between '00:01' and '06:00' then 'Доброй ночи'
		when timecur between '06:01' and '12:00' then 'Доброе утро'
		when timecur between '12:01' and '18:00' then 'Добрый день'
		when timecur between '18:01' and '24:00' then 'Добрый вечер'
	end;
	RETURN message;
end//

DELIMITER ;

-- 2.	В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
drop trigger if exists check_insert_null;
DELIMITER //

create trigger check_insert_null before insert on products for each row
begin 
	if new.name is null and new.description is null then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NULL values not allowed, insert canceled';
	end if; 
end//

DELIMITER ;

-- 3.	(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
drop function if exists fibonacci;
DELIMITER //

CREATE FUNCTION fibonacci(x INT)
RETURNS INT DETERMINISTIC
begin
	declare a int default 0;
	declare fib,b,i int default 1;

	if x=0 then set fib=0;
	elseif x=1 then set fib=1;
	else
		while i<x do
			set fib=a+b;
			set a=b;
			set b=fib;
			set i=i+1;
		end while;
	end if;
	return fib;
end//

DELIMITER ;