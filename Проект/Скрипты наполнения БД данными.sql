# Добавление пользователей в таблицу Users
begin transaction

insert into users (first_name, last_name, email, phone, birthday, hometown, gender) values 
('Георгий', 'Пластинин', 'testmail1@yandex.ru', '+73214432323', '2000-01-01', 'Moscow', 'M'),
('Валерия', 'Лященко', 'testmail2@mail.ru', '+7824493221', '2000-02-02', 'Simferopol', 'F'),
('Иван', 'Иванов', 'testmail3@mail.ru', '+72324421919', '2001-02-03', 'Dagestan', 'M')

# Добавление настроек в таблицу User_account
insert into user_account (user_id, pass) values #не смог вставить данные из-за требований хеша (запись в таблицу я бы сделал через API питон
('1','6XeAA%6aZOl#81wMQwkC#bsXTEOvy8'),
('2','eB}mwt$W3}JVNhxA0QYtj3ppdkVj~g'),
('3','|grMO*hMBOy4lzraeEBfKa@*rNTK?H')

# Добавление пользовательских соглашений в таблицу User_agreements
insert into user_agreements (user_id) select id from users 

insert into music (name, author, release_date, file_store, music_category, album_id) values
('Беспечный Ангел', 'Ария', '1989-02-23', 'http://filestore/sfasfasgasllgsdh', 2, 3),
('Музыка 1', 'Бэтмен', '2017-01-23', 'http://filestore/sfasfasgasgsdh', 1, 2),
('Лабутены', 'Ленинград', '2015-06-16', 'http://filestore/asasfasfasf', 3, 1),
('Потеряный рай', 'Ария', '1989-06-16', 'http://filestore/asasfaasfgasf', 2, 3),
('Музыка 2', 'Пончик', '2011-07-16', 'http://filestore/asasfasjjsf', 4, 2)

# Категории музыки
insert into music_categories (name) values
('Шансон'), 
('Рок'), 
('Поп'), 
('Классическая музыка'), 
('Реп'), 
('Джаз')

# Альбомы
insert into music_albums (album_name, annotation, release_date) values
('Ленинград', 'Шнуров поет песни', '2015-01-01'),
('Музыка', 'Так себе альбом', '2015-01-01'),
('Ария', 'Хороший альбом', '1989-01-01')

# Плейлисты

insert into playlists (playlist_name, user_id) values 
('Плейлист 1', 1),
('Плейлист 2', 1),
('Плейлист три', 2)

#Музыка в плейлистах

insert into playlist_music (music_id, playlist_id) values
(1, 1),
(3, 1),
(4, 1),
(2, 2),
(5, 2),
(2, 3),
(5, 3),
(1, 3)

# Промокоды

insert into user_promocode set
promocode = 'whsk12sf', user_id = 1, end_date = '2020-12-31'

# Транзакции
insert into transactions set
price = 2000, settlement = '1425967819275647', user_id = 1

commit 
