# ���-�� ����������� ������ ��� ����� ����������
set transaction level read uncommitted 

select 
concat(first_name, ' ', last_name) as fio,
count(m.id) as '���������� ������' # ���� �������� �� p.id, �� ������� ���� ����� � ���-��� ����������
from users u
join playlists p on u.id = p.user_id 
join playlist_music pm on p.id = pm.playlist_id
join music m on pm.music_id = m.id
group by fio having count(m.id) > 2 # �������������� �������, � ������� ����� ������� ���-�� ����������


# ������, ������� ���������� � ��������� �� �����
select * from music m 
where id in (select id from music_categories mc where name like '%���%')


# �� ������ �������, ��� ������������ union � ������� spotify, ����� � ������������� �������, �� ����� ������ �������, ����� ��������, 
# ��� � ���� ��� �������� ���� ��������
select * from users u 
union all # ���� ����� "all", �� ������� ����������
select * from users u2 where email like '%mail.ru'

#���������� �������������
select count(user_id) as agg from user_agreements ua where ua.conditions = 1
union
select count(id) from users u 

# � ������� ���� ������� ��� � ���� - ���������� ������� ������� � ����������� ��� ������ ����� �������
select 
round(avg(year(birthday)))
from users
where gender = 'M' # ����� ������� ���

# ������ �� case when, �� ��� ������� �� ��� ����� ���������
select concat(first_name, ' ', last_name) as '���',
(case (u.gender) 
when 'M'
then '�������'
when 'F'
then '�������'
else '��� ����'
end) as '���' 
from users u 

#� ����� �������� ��������� ������� � ������� �������� ����������, � ���� ���� ������ �� ������-������ ������� �������
select 
distinct(concat(first_name, ' ', last_name)) as fio,
p.playlist_name
from users u 
join playlists p on u.id = p.user_id 
join playlist_music pm on p.id = pm.playlist_id
join music m on pm.music_id = m.id
where m.album_id in (select id from music_albums ma where album_name like '%������%')

# �� � ���-������ �� ������ ����, ����� ����� ���-�� �������, � �������, ������� � �� �����������
select 
price '�����',
(select concat(first_name, ' ', last_name) from users u where u.id = t.user_id) as '���' ,
date_format(t.operation_date, '%Y-%m-%d' ) as '���� �������'
from transactions t 

