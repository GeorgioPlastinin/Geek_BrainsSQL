use project_spotify;
drop table users;
create table users(
	id serial primary key, 
	first_name varchar(50) comment '��� ������������',
	last_name varchar(50) comment '������� ������������',
	email varchar(120) unique comment '����������� �����',
	phone varchar(20) unique comment '������� � ������� +7',
	birthday date comment '���� ��������',
	hometown varchar(100) comment '������ �����',
	gender char(1) comment '���, ����� ���� ������',
	created_at datetime default now() comment '����� ���������� ������������',
);

alter table users add index(email, phone);

drop table user_account;
create table user_account(
	user_id bigint unsigned not null,
	IsPremial bool default false comment '������ ��������',
	facebook_connection char(40) default null comment '���� ������������ ����������� ����������� ����� facebook, �� �����
����� ��������� ��� ������',
	pass char(30) not null comment '��� ������',
	foreign key (user_id) references users(id)
);

drop table user_agreements;
create table user_agreements(
	user_id bigint unsigned not null,
	receive_advertising bool default true comment '�������� ����������� �� email, ���� �� ����� ��������, �� ��������� ���������� ����� ������������ �� ��� ��� ���������',
	receive_promo_advertising bool default false comment '�������� ��������� ����������� �� email',
	confirm_registy_to_partnets bool default false comment '�������� �� �������� ������ ����������� � ����� �������',
	conditions bool not null default true comment '���������� ������������������, �� ������, ��� ��� ������������ ������� ����������� ��������',
	facebook_data bool default false comment '�������� ������ � �������',
	recommendations bool default true comment '�������� �������������',
	new_music bool default true comment '�������� ���������� � ����� ������������',
	playlists_refresh bool default false comment '���������� ����������',
	concert bool default false comment '�������� ����������� �� ��������',
	last_update datetime default current_timestamp on update current_timestamp comment '��������� ��������� � ����������',
	foreign key (user_id) references users(id)
);

drop table music;
create table music(
	id serial primary key,
	name varchar(150) not null default 'unknown' comment '�������� ������������',
	author varchar(150) not null default 'unknown' comment '����� ������������',
	music_category bigint unsigned not null,
	album_id  bigint unsigned not null,
	release_date date comment '���� ������ ������������',
	annotation text comment '�������� ������',
	file_store varchar(100) unique comment '������ �� ���������� �����/������������ �������',
	foreign key (music_category) references music_categories(id),
	foreign key (album_id) references music_albums(id)
);


drop table music_categories;
create table music_categories(
	id serial primary key,
	name varchar(100) unique not null comment '����� ������' #-- �� ���� ������ ������� varchar, ��������� ����� ������ ����������.
);

drop table music_albums;
create table music_albums(
	id serial primary key,
	album_name varchar(100) comment '�������� �������',
	release_date date comment '���� ������ �������',
	annotation text comment '�������� �������'
);


drop table user_promocode;
create table user_promocode(
	id serial primary key,
	user_id bigint unsigned not null,
	promocode varchar(10) comment '��������� �������� �� ���� ����������',
	activation_date datetime default current_timestamp comment '����� ��������� ���������',
	end_date datetime comment '����� ��������� �������� ���������',
	foreign key (user_id) references users(id)
);

drop table playlists;
create table playlists(
	id serial primary key,
	playlist_name varchar(50) not null comment '�������� ���������',
	user_id bigint unsigned not null,
	IsActive bool default true comment '���� �� ������, �� true', 
	create_date datetime default current_timestamp comment '���� �������� ���������',
	definition varchar(200) default null comment '������� �������� ���������',
	foreign key (user_id) references users(id)
);

drop table playlist_music;
create table playlist_music(
	playlist_id bigint unsigned not null,
	music_id bigint unsigned not null,
	date_add datetime default current_timestamp comment '���� ���������� ������ � ��������',
	foreign key (playlist_id) references playlists(id),
	foreign key (music_id) references music(id)
);


drop table transactions;
create table transactions(
	id serial primary key,
	price bigint not null comment '���� �� ��������',
	user_id bigint unsigned not null comment '������������', 
	operation_date datetime default current_timestamp comment '���� ��������',
	settlement char(16) not null comment '����� �����, � ������� ��� ���������� ������',
	foreign key (user_id) references users(id)
); #����� �������� �� ���� ����������� ��������� ������, ��� ��� �� ����� ���� ����������� ������ �� ��� ��� � �����.