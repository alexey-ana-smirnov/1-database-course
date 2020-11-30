--Учитываются все показатели активности пользователя, публикации постов и участие в сообществах учитываются с весовым множителем, зависящим от длины поста 
select concat(u.firstname,' ',u.lastname) as username,
	sum(counter) as activity 
from users u
join (
select from_user_id as id,count(*) as counter from user_likes ul group by from_user_id 
	union all
select from_user_id as id,count(*) as counter from photo_likes phl group by from_user_id 
	union all 
select from_user_id as id,count(*) as counter from post_likes pl group by from_user_id 
	union all 
select user_id as id,5*count(community_id) as counter from users_communities uc group by user_id 
	union all 
select user_id as id,length(post)/50+10*count(id) as counter from posts p group by user_id 
	union all 
select user_id as id,count(id) as counter from comments c group by user_id 
	union all 
select from_user_id as id,count(id) as counter from messages m group by from_user_id 
	union all 
select user_id as id,count(id) as counter from photos ph group by user_id
	union all 
select initiator_user_id as id,count(target_user_id) as counter from friend_requests fr group by initiator_user_id 
	union all 
select target_user_id as id, count(initiator_user_id) as counter from friend_requests fr where status='approved' group by target_user_id ) t on t.id=u.id
	group by username
	order by activity asc limit 10