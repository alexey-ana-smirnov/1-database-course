select concat(u1.firstname," ",u1.lastname) from_user, count(m.id) msg_cnt from users u
join friend_requests fr on (u.id=fr.initiator_user_id or u.id=fr.target_user_id ) and fr.status="approved"
join messages m on m.to_user_id = u.id
join users u1 on m.from_user_id=u1.id
where u.id=1
group by from_user
order by 2 desc limit 1;