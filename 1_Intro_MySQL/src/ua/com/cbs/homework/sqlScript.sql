USE MyDB;

#------------------------
# Завдання 2
#    Створити базу даних під назвою “MyDB”.

# Завдання 3
#    У створеній базі даних (із завдання 2) створити 3 таблиці:
#    1-а містить імена та номери телефонів співробітників певної компанії,
#    2-а містить відомості про їхню зарплату, та посади,
#    3-тя містить інформацію про сімейне становище, дату народження та місце проживання.
#------------------------

DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS Employee_Info;
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
	employee_id int auto_increment not null,
	employee_first_name varchar(100),
	employee_last_name varchar(100),
	employee_phone_number varchar(250),
	PRIMARY KEY(employee_id)
);

CREATE TABLE Job (
	job_id int auto_increment not null,
	job_name varchar(100),
	job_salary double(7,2),
	job_employee_id int,
	PRIMARY KEY(job_id),
	CONSTRAINT fk_job
		FOREIGN KEY(job_employee_id)
		REFERENCES Employee(employee_id)
);

CREATE TABLE Employee_Info (
	employee_info_id int auto_increment not null,
	employee_info_marital_status varchar(100),
	employee_info_birthday date,
	employee_info_address varchar(500),
	employee_info_employee_id int,
	PRIMARY KEY(employee_info_id),
	CONSTRAINT fk_employee_info
		FOREIGN KEY(employee_info_employee_id)
		REFERENCES Employee(employee_id)
);

INSERT INTO Employee (employee_first_name, employee_last_name)
VALUE 	('Bruce','Willice'),
		('John','Travolta'),
		('John','Biden'),
		('Donald','Tramp');

INSERT INTO Job (job_name, job_salary, job_employee_id)
VALUE   ('Main actor', 9999.99, (select employee_id from Employee where (employee_first_name = 'Bruce' and employee_last_name = 'Willice'))),
		('Super star', 10000.00, (select employee_id from Employee where (employee_first_name = 'John' and employee_last_name = 'Travolta'))),
		('President', 10000.01, (select employee_id from Employee where (employee_first_name = 'John' and employee_last_name = 'Biden'))),
		('Former President', 15000.00, (select employee_id from Employee where (employee_first_name = 'Donald' and employee_last_name = 'Tramp')));

INSERT INTO Employee_Info (employee_info_marrital_status, employee_info_birthday, employee_info_address, employee_info_employee_id)
VALUE ('single', '1955-03-19', '305 - 14th Ave. S. Suite 3B, USA', (select employee_id from Employee where(employee_first_name = 'Bruce' and employee_last_name = 'Willice'))),
      ('married', '1954-02-18', 'CANADA', (select employee_id from Employee where(employee_first_name = 'John' and employee_last_name = 'Travolta'))),
      ('divorced', '1942-11-20', 'WASHINGTON', (select employee_id from Employee where(employee_first_name = 'John' and employee_last_name = 'Biden'))),
      ('widower', '1946-06-14', 'MEXICO', (select employee_id from Employee where(employee_first_name = 'Donald' and employee_last_name = 'Tramp')));

#------------------------
# Завдання 4
#      З завдання 3 таблиці 2 отримати id співробітників, зарплата яких більша за 10000.
#------------------------
SELECT * FROM Job;
SELECT job_employee_id FROM Job where job_salary > 10000;
SELECT job_employee_id, job_salary FROM Job where job_salary > 10000;

#------------------------
# Завдання 5
#      З завдання 3 співробітник по id 1 був неодружений, одружився. Змінити дані у третій таблиці про сімейне становище.
#------------------------

SELECT * FROM Employee_Info;

UPDATE Employee_Info
SET employee_info_marital_status = 'married'
WHERE employee_info_id = 1;

SELECT * FROM Employee_Info;

#------------------------
# Завдання 7
#    Створити порожню таблицю даних автомобілів.
#    Заповнити таблицю даними (id(Autoincrement), марка, модель, об'єм двигуна, ціна, макс. швидкість).
#------------------------

DROP TABLE IF EXISTS Cars;

CREATE TABLE Cars(
	id int auto_increment not null,
	brand varchar(75),
	country varchar(50),
	model varchar(75),
	engine_capacity double(7,2),
	price double(12,2),
	max_speed double(7,2),
	PRIMARY KEY(id)
);

INSERT INTO Cars (brand,country,model,engine_capacity,price,max_speed)
VALUE ("AC","UK","378 GT Zagato",6162,0,298),
("AC","UK","Ace",2900,0,0),
("AC","UK","Cobra",6162,0,278),
("Acura","Japan","CL",3195,850000,215),
(("Acura","Japan","CSX",1998,0,200),
("Acura","Japan","EL",1668,0,0),
(("Acura","Japan","ILX",2354,2190000,0),
("Acura","Japan","Integra",1834,0,0),
(("Acura","Japan","Legend",3206,0,0),
("Acura","Japan","MDX",2997,8500000,0),
("Acura","Japan","NSX",3179,0,270),
("Acura","Japan","RDX",2300,0,209),
("Acura","Japan","RL",3664,0,215),
("Acura","Japan","RLX",3476,0,0),
("Acura","Japan","RSX",1998,0,218),
("Acura","Japan","SLX",3494,0,175),
(("Acura","Japan","TL",3206,0,223),
(("Acura","Japan","TLX",3471,0,0),
("Acura","Japan","TSX",2354,1150000,228),
("Acura","Japan","ZDX",3664,1950000,0),
("Adler","Germany","Diplomat",2916,0,100),
("Adler","Germany","Trumpf Junior",995,3500000,0),
("GAC Aion","China","S",0,0,130),
("GAC Aion","China","S Plus",0,0,130),
("GAC Aion","China","V",0,0,0),
("GAC Aion","China","Y",0,0,130),
("Alfa Romeo","Italy","105/115",1290,0,170),
("Aston Martin","UK","Virage",5340,0,250),
("Aston Martin","UK","Vulcan",6999,0,360);