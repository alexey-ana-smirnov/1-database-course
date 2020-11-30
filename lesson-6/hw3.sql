select sum(likes) as total_likes 
from 
(select u.id,
timestampdiff(year, u.birthday, now()) as age,
count(t1.id2) as likes from users u
join 
(select u.id id1, ph.id id2 from users u
join photos ph on u.id = ph.user_id 
join photo_likes phl on phl.photo_id=ph.id
union all
select u.id id1,p.id id2 from users u
join posts p on p.user_id =u.id 
join post_likes pl on pl.post_id =p.id 
union all
select u.id id1,ul.from_user_id id2 from users u
join user_likes ul on ul.user_id = u.id) t1 on t1.id1=u.id
group by u.id,age
order by age asc limit 10) t2;
