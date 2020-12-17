# Кол-во добавленной музыки без учета плейлистов
set transaction level read uncommitted 

select 
concat(first_name, ' ', last_name) as fio,
count(m.id) as 'Количество музыки' # Если заменить на p.id, то получим тоже самое с кол-вом плейлистов
from users u
join playlists p on u.id = p.user_id 
join playlist_music pm on p.id = pm.playlist_id
join music m on pm.music_id = m.id
group by fio having count(m.id) > 2 # дополнительное условие, в котором можно выбрать кол-во композиций


# Музыка, которая относиться к категории по имени
select * from music m 
where id in (select id from music_categories mc where name like '%Рок%')


# Не совсем понятно, как используется union в проекте spotify, может в аналитических центрах, но здесь просто выборка, чтобы показать, 
# что я знаю как работает этот оператор
select * from users u 
union all # если уберу "all", то выведет совпадения
select * from users u2 where email like '%mail.ru'

#Соглашения пользователей
select count(user_id) as agg from user_agreements ua where ua.conditions = 1
union
select count(id) from users u 

# У выборки таже функция что и выше - показывает средний возраст с округлением без знаков после запятой
select 
round(avg(year(birthday)))
from users
where gender = 'M' # можно выбрать пол

# пример на case when, но как правило на бою редко использую
select concat(first_name, ' ', last_name) as 'ФИО',
(case (u.gender) 
when 'M'
then 'Мужчина'
when 'F'
then 'Женщина'
else 'Без пола'
end) as 'Пол' 
from users u 

#А можно например соединить запросы и вывести название плейлистов, у кого есть музыка из какого-нибудь нужного альбома
select 
distinct(concat(first_name, ' ', last_name)) as fio,
p.playlist_name
from users u 
join playlists p on u.id = p.user_id 
join playlist_music pm on p.id = pm.playlist_id
join music m on pm.music_id = m.id
where m.album_id in (select id from music_albums ma where album_name like '%Музыка%')

# ну и что-нибудь на формат даты, пусть будет что-то простое, в таблице, которую я не использовал
select 
price 'Сумма',
(select concat(first_name, ' ', last_name) from users u where u.id = t.user_id) as 'ФИО' ,
date_format(t.operation_date, '%Y-%m-%d' ) as 'Дата платежа'
from transactions t 

