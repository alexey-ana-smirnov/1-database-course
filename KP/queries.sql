-- 1)	Выборка исходящих рейсов по интересующему маршруту на заданную дату
select a1.city 'Направление',
f.num 'Номер рейса',
f.localtime_out 'Время' 
from flights f
join airports a1 on a1.apcode = f.airport_in
where f.schedule&'1000000'>>dayofweek(str_to_date('28-12-2020','%d-%m-%Y'))-2
and a1.City='Санкт-Петербург';

-- 2) Получение данных о пассажире на заданном рейсе и занимающим заданное место

select a.City 'маршрут',
f.num 'номер рейса',
r.seat 'место',
r.firstname 'имя',
r.fathername 'отчество',
r.lastname 'фамилия',
case r.gender
when 'm' then 'мужчина'
when 'f' then 'женщина'
end 'пол',
r.passport 'номер паспорта' 
from registration r 
join departures d on d.departure_id = r.departure_id 
join flights f on f.num = d.flight_number
join airports a on a.APCode = f.airport_in 
join airframes af on af.regnum = d.board_number 
join aircrafts ac on ac.id = af.`type` and ac.name rlike f.aircraft 
where a.City = 'Анапа' 
and r.seat='10B' 
and date_format(d.scheduled_at,'%d-%m-%Y')='23-12-2020';

-- 3) Отсутствующие пассажиры на борту

select d.flight_number 'Номер рейса', 
d.departure_id 'Код отправления',
count(r.ticket_id) 'Число отсуствующих пассажиров на борту'
from registration r 
join departures d on d.departure_id = r.departure_id 
left join boarding b on b.ticket_id =r.ticket_id
where d.status = 'Посадка' and b.boarded_at is null
group by d.flight_number,d.departure_id 
