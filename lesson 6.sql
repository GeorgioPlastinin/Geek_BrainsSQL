select 
	distinct(concat(first_name, ' ',	last_name)) 'name',
	(select concat(first_name, ' ',	last_name) as name from users where id = fr.initiator_user_id and fr.status = 'approved') 'friends',
	(select count(id) from messages m where from_user_id = fr.initiator_user_id )  'CountMessage'
from users u
join friend_requests fr on u.id = fr.target_user_id 
where u.id = 33 
order by CountMessage desc, friends desc
#где NULL - это запросы в друзья, которые отличаются от стутса approved, без join почему то запрос на работал


select 
	concat(first_name, ' ',	last_name) 'name',
	timestampdiff(year, u.birthday, now()) 'age',
	(select count(*) from likes where user_id = u.id) as likeCount
from users u 
order by age asc limit 10
#лайки по постам комментам и тд отдельно не учитывал


select 
	gender,
	count(l.id)
from users u
left join likes l on u.id = l.user_id 
group by gender 
#самое простое опять же с join



select 
	concat(first_name, ' ',	last_name) 'name',
	timestampdiff(year, u.birthday, now()) 'age',
	(select count(*) from likes where user_id = u.id) as likeCount,
	(select count(*) from messages m where from_user_id = u.id) as MsgCount
from users u 
order by likeCount asc, MsgCount asc limit 10

