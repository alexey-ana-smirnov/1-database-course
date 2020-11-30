select 
	case(gender)
		when 'm' then 'Мужчины'
		when 'f' then 'Женщины'
	end as 'gender',
count(id1)  from (
select u.id id1, u.gender from users u
join photo_likes phl on phl.from_user_id=u.id 
union all
select u.id id1,u.gender from users u
join post_likes pl on pl.from_user_id=u.id 
union all
select u.id id1,u.gender from users u
join user_likes ul on ul.from_user_id=u.id 
) t 
group by gender;