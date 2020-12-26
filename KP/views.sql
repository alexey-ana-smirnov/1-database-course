-- 1) Статистика по перевозке пассажиров за прошедшие сутки
create or replace
view `aero`.`traffic_stat` as
select
    `a`.`city` as `Направление`,
    count(distinct `d`.`departure_id`) as `Число рейсов`,
    count(`r`.`ticket_id`) as `Общее число пассажиров`,
    round((count(`r`.`ticket_id`) / count(distinct `d`.`departure_id`)), 1) as `Среднее число пассажиров на борту`
from
    (((((`aero`.`registration` `r`
join `aero`.`departures` `d` on
    ((`d`.`departure_id` = `r`.`departure_id`)))
join `aero`.`flights` `f` on
    (((`f`.`num` = `d`.`flight_number`)
    and (`f`.`localtime_out` = cast(`d`.`scheduled_at` as time)))))
join `aero`.`airframes` `af` on
    ((`af`.`regnum` = `d`.`board_number`)))
join `aero`.`aircrafts` `ac` on
    (((`ac`.`id` = `af`.`type`)
    and regexp_like(`ac`.`name`, `f`.`aircraft`))))
join `aero`.`airports` `a` on
    ((`a`.`APCode` = `f`.`airport_in`)))
where
    ((cast(`d`.`scheduled_at` as date) = cast((now() - interval 1 day) as date))
    and (0 <> (`f`.`schedule` & ('1000000' >> (dayofweek(cast((now() - interval 1 day) as date)) - 2))))
    and (`d`.`status` = 'Прибыл'))
group by
    `a`.`city`


-- 2) Онлайн-табло отправляемых рейсов

create or replace
view `aero`.`online_timetable` as
select
    `a`.`city` as `Направление`,
    `f`.`num` as `Номер рейса`,
    concat(date_format(`d`.`scheduled_at`, '%H:%i'), `f`.`tz_out`) as `Время отправления`,
    concat(date_format(convert_tz(addtime(`d`.`scheduled_at`, cast(`f`.`duration` as datetime)), `f`.`tz_out`, `f`.`tz_in`), '%Y-%m-%d %H:%i'), `f`.`tz_in`) as `Время прибытия`,
    `d`.`status` as `Статус`
from
    ((((`aero`.`departures` `d`
join `aero`.`flights` `f` on
    (((`f`.`num` = `d`.`flight_number`)
    and (cast(`d`.`scheduled_at` as time) = `f`.`localtime_out`))))
join `aero`.`airframes` `af` on
    ((`af`.`regnum` = `d`.`board_number`)))
join `aero`.`aircrafts` `ac` on
    (((`ac`.`id` = `af`.`type`)
    and regexp_like(`ac`.`name`, `f`.`aircraft`))))
join `aero`.`airports` `a` on
    ((`a`.`APCode` = `f`.`airport_in`)))
where
    ((`d`.`status` = 'Запланирован')
    or (`d`.`status` = 'Регистрация')
    or (`d`.`status` = 'Посадка')
    or (`d`.`status` = 'Отбыл')
    or (`d`.`scheduled_at` > (now() - interval 6 hour)))
order by d.scheduled_at