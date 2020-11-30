-- персональная страница пользователя
-- можно упростить запрос заменой подзапроса для количества друзей
select 
	firstname,
	lastname,
	hometown,
	(select filename from photos where id = u.photo_id) as 'personal_photo',
	(select count(*) from friend_requests where (target_user_id = u.id or initiator_user_id = u.id) and status = 'approved') as 'friends',
	(select count(*) from friend_requests where target_user_id = u.id and status ='requested') as 'followers',
	(select count(*) from photos where user_id = u.id) 'photos'
from users as u 
where id = 1;

