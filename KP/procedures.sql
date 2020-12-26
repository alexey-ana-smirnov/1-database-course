
CREATE PROCEDURE `aero`.`create_archive`()
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
end


CREATE PROCEDURE `aero`.`departure_init`()
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
end

CREATE PROCEDURE `aero`.`registration_init`()
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
end

CREATE PROCEDURE `aero`.`boarding_init`()
begin

	select departure_id into @did from departures where status='Посадка' order by rand() limit 1;

	insert into boarding (ticket_id,departure_id)
	select ticket_id,departure_id from registration r
	where r.departure_id=@did and 
	ticket_id not in (select ticket_id from boarding where departure_id=@did)
	order by rand() limit 1;

end