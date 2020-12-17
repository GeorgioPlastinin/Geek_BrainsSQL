# ���������� ������������� � ������� Users
begin transaction

insert into users (first_name, last_name, email, phone, birthday, hometown, gender) values 
('�������', '���������', 'testmail1@yandex.ru', '+73214432323', '2000-01-01', 'Moscow', 'M'),
('�������', '�������', 'testmail2@mail.ru', '+7824493221', '2000-02-02', 'Simferopol', 'F'),
('����', '������', 'testmail3@mail.ru', '+72324421919', '2001-02-03', 'Dagestan', 'M')

# ���������� �������� � ������� User_account
insert into user_account (user_id, pass) values #�� ���� �������� ������ ��-�� ���������� ���� (������ � ������� � �� ������ ����� API �����
('1','6XeAA%6aZOl#81wMQwkC#bsXTEOvy8'),
('2','eB}mwt$W3}JVNhxA0QYtj3ppdkVj~g'),
('3','|grMO*hMBOy4lzraeEBfKa@*rNTK?H')

# ���������� ���������������� ���������� � ������� User_agreements
insert into user_agreements (user_id) select id from users 

insert into music (name, author, release_date, file_store, music_category, album_id) values
('��������� �����', '����', '1989-02-23', 'http://filestore/sfasfasgasllgsdh', 2, 3),
('������ 1', '������', '2017-01-23', 'http://filestore/sfasfasgasgsdh', 1, 2),
('��������', '���������', '2015-06-16', 'http://filestore/asasfasfasf', 3, 1),
('��������� ���', '����', '1989-06-16', 'http://filestore/asasfaasfgasf', 2, 3),
('������ 2', '������', '2011-07-16', 'http://filestore/asasfasjjsf', 4, 2)

# ��������� ������
insert into music_categories (name) values
('������'), 
('���'), 
('���'), 
('������������ ������'), 
('���'), 
('����')

# �������
insert into music_albums (album_name, annotation, release_date) values
('���������', '������ ���� �����', '2015-01-01'),
('������', '��� ���� ������', '2015-01-01'),
('����', '������� ������', '1989-01-01')

# ���������

insert into playlists (playlist_name, user_id) values 
('�������� 1', 1),
('�������� 2', 1),
('�������� ���', 2)

#������ � ����������

insert into playlist_music (music_id, playlist_id) values
(1, 1),
(3, 1),
(4, 1),
(2, 2),
(5, 2),
(2, 3),
(5, 3),
(1, 3)

# ���������

insert into user_promocode set
promocode = 'whsk12sf', user_id = 1, end_date = '2020-12-31'

# ����������
insert into transactions set
price = 2000, settlement = '1425967819275647', user_id = 1

commit 
