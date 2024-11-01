/*
Задание 2
Создайте базу данных с именем “MySubqueriesDB”.

Задание 3
В данной базе данных создайте 3 таблицы,
В 1-й таблице содержатся имена и номера телефонов сотрудников компании.
Во 2-й таблице содержатся ведомости о зарплате и должностях сотрудников:
главный директор, менеджер, рабочий.
В 3-й таблице содержится информация о семейном положении, дате рождения, и месте проживания.

Задание 4
Сделайте выборку при помощи вложенных запросов для таких заданий:
1) Получите контактные данные сотрудников (номера телефонов, место жительства).
2) Получите информацию о дате рождения всех холостых сотрудников и их номера.
3) Получите информацию обо всех менеджерах компании: дату рождения и номер телефона.
*/

drop table if exists personalInfo;
drop table if exists serviceInfo;
drop table if exists staff;

create table staff(
    id int generated always as identity, 
	name varchar(50),
	phone varchar(30),
	primary key(id)
);

create table serviceInfo(
	id int generated always as identity,
	salary float,
	position varchar(20),
	staff_id int,
	primary key(id),
	constraint fk_staff_serviceinfo
	  foreign key(staff_id)
	  references staff(id)
	  on update cascade
	  on delete cascade
);

create table personalInfo(
    id int generated always as identity,
    maritalStatus varchar(10),
    birth_day date,
    adress varchar(50),
    staff_id int,
    primary key(id),
    constraint fk_personalInfo_staff
    	foreign key(staff_id)
    	references staff(id)
    	on update cascade
    	on delete cascade
);

INSERT INTO staff
	(name, phone)
VALUES
	('Андрей','+380971112233'),
	('Евгений','+380952226661'),
	('Александр','+380975556644'),
	('Василий','+380509994466'),
	('Татьяна','+380961326459'),
	('Олег','+380995461245');

INSERT INTO serviceInfo
	(staff_id, position, salary)
VALUES
	(1, 'Главный директор', 30000),
	(2, 'Менеджер', 20000),
	(3, 'Менеджер', 22000),
	(4, 'Рабочий', 10000),
	(5, 'Менеджер', 20000),
	(6, 'Рабочий', 12000);

INSERT INTO personalInfo
	(staff_id, maritalStatus, birth_day, adress)
VALUES
	(1, 'женат', '1990-01-02','г. Харьков, ул. Радостная, 23'),
	(2, 'женат', '2000-12-22','г. Харьков, ул. Счастливая, 25'),
	(3, 'не женат', '1995-04-16','г. Харьков, ул. Цветочная, 564'),
	(4, 'женат', '1991-06-12','г. Харьков, ул. Умников, 16, кв. 55'),
	(5, 'не замужем', '1987-01-14','г. Харьков, ул. Лентяев, 231'),
	(6, 'не женат', '1990-01-02','г. Харьков, ул. Обнимашек, 123');