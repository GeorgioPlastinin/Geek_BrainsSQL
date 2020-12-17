use project_spotify;
drop table users;
create table users(
	id serial primary key, 
	first_name varchar(50) comment 'Имя пользователя',
	last_name varchar(50) comment 'Фамилия пользователя',
	email varchar(120) unique comment 'Электронная почта',
	phone varchar(20) unique comment 'Телефон в формате +7',
	birthday date comment 'День рождения',
	hometown varchar(100) comment 'Родной город',
	gender char(1) comment 'Пол, может быть пустым',
	created_at datetime default now() comment 'Время добавления пользователя',
);

alter table users add index(email, phone);

drop table user_account;
create table user_account(
	user_id bigint unsigned not null,
	IsPremial bool default false comment 'Статус аккаунта',
	facebook_connection char(40) default null comment 'Если пользователь использовал регистарцию через facebook, то здесь
будет храниться хеш данных',
	pass char(30) not null comment 'Хэш пароля',
	foreign key (user_id) references users(id)
);

drop table user_agreements;
create table user_agreements(
	user_id bigint unsigned not null,
	receive_advertising bool default true comment 'Получать уведомления на email, если не стоит согласие, то некоторые соглашения могут отрабатывать не так как требуется',
	receive_promo_advertising bool default false comment 'Получать рекламные уведомления на email',
	confirm_registy_to_partnets bool default false comment 'Согласие на передачу данных регистрации в целях рекламы',
	conditions bool not null default true comment 'Соглашение конфиденциальности, не пустое, так как обязательное условие пользования сервисом',
	facebook_data bool default false comment 'Передача данных с фейсбук',
	recommendations bool default true comment 'Получать реккомендации',
	new_music bool default true comment 'Получать информацию о новых поступлениях',
	playlists_refresh bool default false comment 'Обновление плейлистов',
	concert bool default false comment 'Получать приглашения на концерты',
	last_update datetime default current_timestamp on update current_timestamp comment 'Последнее изменение в настройках',
	foreign key (user_id) references users(id)
);

drop table music;
create table music(
	id serial primary key,
	name varchar(150) not null default 'unknown' comment 'Название произведения',
	author varchar(150) not null default 'unknown' comment 'Автор произведения',
	music_category bigint unsigned not null,
	album_id  bigint unsigned not null,
	release_date date comment 'Дата выхода произведения',
	annotation text comment 'Описание музыки',
	file_store varchar(100) unique comment 'Ссылка на скачивание файла/проигрывание объекта',
	foreign key (music_category) references music_categories(id),
	foreign key (album_id) references music_albums(id)
);


drop table music_categories;
create table music_categories(
	id serial primary key,
	name varchar(100) unique not null comment 'Жанры музыки' #-- не стал делать вариант varchar, поскольку жанры строго определены.
);

drop table music_albums;
create table music_albums(
	id serial primary key,
	album_name varchar(100) comment 'Название альбома',
	release_date date comment 'Дата выхода альбома',
	annotation text comment 'Описание альбома'
);


drop table user_promocode;
create table user_promocode(
	id serial primary key,
	user_id bigint unsigned not null,
	promocode varchar(10) comment 'Введенный промокод из пула промокодов',
	activation_date datetime default current_timestamp comment 'Время активации промокода',
	end_date datetime comment 'Время окончания действия промокода',
	foreign key (user_id) references users(id)
);

drop table playlists;
create table playlists(
	id serial primary key,
	playlist_name varchar(50) not null comment 'Название плейлиста',
	user_id bigint unsigned not null,
	IsActive bool default true comment 'Если не удален, то true', 
	create_date datetime default current_timestamp comment 'Дата создания плейлиста',
	definition varchar(200) default null comment 'Краткое описание плейлиста',
	foreign key (user_id) references users(id)
);

drop table playlist_music;
create table playlist_music(
	playlist_id bigint unsigned not null,
	music_id bigint unsigned not null,
	date_add datetime default current_timestamp comment 'Дата добавления музыки в плейлист',
	foreign key (playlist_id) references playlists(id),
	foreign key (music_id) references music(id)
);


drop table transactions;
create table transactions(
	id serial primary key,
	price bigint not null comment 'Цена за подписку',
	user_id bigint unsigned not null comment 'Пользователь', 
	operation_date datetime default current_timestamp comment 'Дата операции',
	settlement char(16) not null comment 'Номер карты, с которой был произведен платеж',
	foreign key (user_id) references users(id)
); #более подробно не стал расписывать платежный сервис, так как он может быть организован совсем не так как я думаю.