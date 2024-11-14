/*
Используя базу данных ShopDB и страницу Customers
(удалите таблицу, если есть и создайте заново первый раз без первичного ключа затем – с первичным)
и затем добавьте индексы и проанализируйте выборку данных.
*/

--USE ShopDB;

DROP TABLE IF EXISTS Customers_new;

CREATE TABLE Customers_new
	(
	CustomerNo int NOT NULL,
	FName varchar(15) NOT NULL,
	LName varchar(15) NOT NULL,
	MName varchar(15) NULL,
	Address1 varchar(50) NOT NULL,
	Address2 varchar(50) NULL,
	City char(10) NOT NULL,
	Phone char(12) NULL,
	DateInSystem date NULL
	);

INSERT INTO Customers_new
(CustomerNo, LName, FName, MName, Address1, Address2, City, Phone,DateInSystem)
VALUES
(4, 'Круковский','Анатолий','Петрович','Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
(5, 'Дурнев','Виктор','Викторович','Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
(3, 'Унакий','Зигмунд','федорович','Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
(1, 'Левченко','Виталий','Викторович','Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
(2, 'Выжлецов','Олег','Евстафьевич','Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');

/* в случае кучи без PK
	- без индексов
		при выводе всей таблицы столбцы выводятся в порядке ввода в таблицу
		анализируются все строки rows = 5,
		процент строк таблицы, которые будут фильтроваться по табличному условию filtred = 20;
	- при задании вручную некластиризированных индексов поля LName
		при выводе всей таблицы столбцы сортируются по полю LName
		анализируется только 1 строка rows = 1,
        процент строк таблицы, которые будут фильтроваться по табличному условию filtred = 100;
*/
-- вся таблица для просмотра сортировки
SELECT * FROM Customers_new;

-- некластиризированные индексы, созданные с помощью CREATE INDEX
EXPLAIN SELECT * FROM Customers_new
WHERE LName = 'Выжлецов';

CREATE INDEX index_LName ON Customers_new(LName);

DROP TABLE Customers_new;

CREATE TABLE Customers_new
	(
	CustomerNo SERIAL,
	FName varchar(15) /*UNIQUE*/ NOT NULL,
	LName varchar(15) NOT NULL,
	MName varchar(15) NULL,
	Address1 varchar(50) NOT NULL,
	Address2 varchar(50) NULL,
	City char(10) NOT NULL,
	Phone char(12) NULL,
	DateInSystem date NULL
	);

ALTER TABLE Customers_new ADD PRIMARY KEY (CustomerNo);

INSERT INTO Customers_new
(LName, FName, MName, Address1, Address2, City, Phone,DateInSystem)
VALUES
('Круковский','Анатолий','Петрович','Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
('Дурнев','Виктор','Викторович','Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
('Унакий','Зигмунд','федорович','Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
('Левченко','Виталий','Викторович','Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
('Выжлецов','Олег','Евстафьевич','Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');

/* в случае наличия PK
	- поиск по полю PK, которое является кластеризированным ключем
		при выводе всей таблицы столбцы сортируются по возрастанию
		анализируется только 1 строка rows = 1,
                процент строк таблицы, которые будут фильтроваться по табличному условию filtred = 100;
    - поиск по полю без индексов
		при выводе всей таблицы столбцы выводятся в порядке ввода в таблицу
		анализируются все строки rows = 5,
		процент строк таблицы, которые будут фильтроваться по табличному условию filtred = 20;
	- при задании вручную некластиризированных индексов поля LName
		при выводе всей таблицы столбцы сортируются по полю CustomerNo
		анализируется только 1 строка rows = 1,
        процент строк таблицы, которые будут фильтроваться по табличному условию filtred = 100;
*/
-- вся таблица для просмотра сортировки
SELECT * FROM Customers_new;

-- кластеризированные индексы, созданные с помощью PRIMARY KEY
SELECT * FROM Customers_new
WHERE CustomerNo = 2;

EXPLAIN SELECT * FROM Customers_new
WHERE CustomerNo = 2;

-- некластиризированные индексы, созданные с помощью CREATE INDEX
EXPLAIN SELECT * FROM Customers_new
WHERE LName = 'Выжлецов';

CREATE INDEX index_LName ON Customers_new(LName);

-- некластиризированные индексы, созданные с помощью UNIQUE

EXPLAIN SELECT * FROM Customers_new
WHERE FName = 'Олег';