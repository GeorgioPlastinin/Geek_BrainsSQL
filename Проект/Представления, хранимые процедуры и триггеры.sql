# Триггеры

use project_spotify

delimiter //

create trigger check_user_age before update on users
for each row 
begin 
	if new.birthday >= current_date() then 
		signal sqlstate '45000' set message_text = 'Неверная дата рождения';
	end if;
end//


create trigger user_conditions before update on user_agreements
for each row 
begin 
if new.conditions <> 1 then 
		signal sqlstate '45000' set message_text = 'Пользователь не согласен с условиями пользования платформы';
	end if;
end//


create trigger check_insert_age before insert on users
for each row 
begin 
	if new.birthday > current_date() then 
		set new.birthday = current_date();
	end if;
end//

delimiter ;
# Представления

create view users_contact
as select
id,
concat(first_name, ' ', last_name) as 'ФИО',
phone 'Телефон',
email 'Почта'
from users u 


create view users_count_music
as select
concat(first_name, ' ', last_name) as fio,
count(m.id) as 'Количество музыки' 
from users u
join playlists p on u.id = p.user_id 
join playlist_music pm on p.id = pm.playlist_id
join music m on pm.music_id = m.id
group by fio 

# Хранимые процедуры 
delimiter //


create procedure users_playlists (in for_user_id INT)
begin
	select 
	concat(first_name, ' ', last_name) as fio,
	p.playlist_name
	from users u 
	join playlists p on u.id = p.user_id 
	join playlist_music pm on p.id = pm.playlist_id
	join music m on pm.music_id = m.id
	where u.id = for_user_id;
end//


delimiter ;