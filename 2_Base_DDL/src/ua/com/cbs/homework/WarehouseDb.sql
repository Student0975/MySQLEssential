/*
Спроектируйте базу данных для оптового склада,
у которого есть поставщики товаров, персонал, постоянные заказчики.
Поля таблиц продумать самостоятельно.
*/

CREATE DATABASE warehouse13;
USE warehouse13;

CREATE TABLE department(
   id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(20),
    PRIMARY KEY(id)
);
INSERT INTO department
(name)
VALUE ('Computers'),('Sweets'),('Beauty'),('Managment');

CREATE TABLE suppliers(
    id INT AUTO_INCREMENT NOT NULL,
    organization_name VARCHAR(20),
    site VARCHAR(25),
    contact_person VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(50),
    city VARCHAR(15),
    department_id INT,
    FOREIGN KEY(department_id) REFERENCES department(id),
    PRIMARY KEY(id)
);
INSERT INTO suppliers
(organization_name, site, contact_person, phone, email, city, department_id)
VALUES  ('Yummy shop','yummyshop.com','John Doe','+380970000001','john_Doe@Yummyshop.com','London', 2),
	    ('Comp shop','compshop.com','Jane Dolle','+380550000025','jane_Dolle@compshop.com','Milan', 1),
        ('Beauty shop','bs.com','Ola Smith','+380900088401','ola_smith@bs.com','Kyiv', 3),
        ('Candy shop','c-shop.com','Sunny Funny','+380660000001','sf@c-shop.com','Kharhiv', 2);

CREATE TABLE clients(
    id INT AUTO_INCREMENT NOT NULL,
    organization_name VARCHAR(20),
    site VARCHAR(25),
    contact_person VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(50),
    city VARCHAR(15),
    department_id INT,
    FOREIGN KEY(department_id) REFERENCES department(id),
    PRIMARY KEY(id)
);
INSERT INTO clients
(organization_name, site, contact_person, phone, email, city, department_id)
VALUES  ('Shop 1','blabla.com','Serg Drew','+38085222001','milashka@blabla.com','Mukachevo', 1),
        ('EVA','eva.com.ua','Olga Vorkova','+38019846527','o_vork@eva.com.ua','Kyiv', 3),
	('ABC',NULL,'Marichka Ivanko','+380561591597',NULL,'Svaliava', 2);

CREATE TABLE staff(
    id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(20),
    last_name  VARCHAR(20),
    sex VARCHAR(7),
    phone VARCHAR(15),
    email VARCHAR(50),
    city VARCHAR(15),
    birth_date DATE,
    position VARCHAR(25),
    date_of_hiring DATE,
    date_of_dismissal DATE,
    department_id INT,
    FOREIGN KEY(department_id) REFERENCES department(id),
    PRIMARY KEY(id)
);
INSERT INTO staff
(first_name, last_name, sex, phone, email, city, birth_date, position, date_of_hiring, date_of_dismissal, department_id )
VALUES  ('Angelina','Vovk','female','+380952020121','milashka_lkj@gmail.com','Lviv', '1999-01-01', 'Storekeeper','2022-04-02',NULL,1),
        ('Alex','Petrenko','male','+380552025521','dfsjf@gmail.com','Kyiv', '1997-01-01', 'Storekeeper','2022-04-30','2022-06-30',2),
        ('Ivan','Docenko','male','+38095464221','asfkj@gmail.com','Uman', '1985-05-01', 'Storekeeper','2004-12-02',NULL,2),
        ('Olga','Finko','female','+380952050121','sdd@gmail.com','Dnipro', '1998-01-09', 'Storekeeper','2020-04-02',NULL,1),
        ('Lina','Likova','female','+380954020121','lina@gmail.com','Lviv', '2000-12-15', 'Storekeeper','2012-02-02',NULL,3),
	    ('Anton','Inov','male','+380504020121','ant_in@gmail.com','Chernigiv', '1960-12-12', 'Director','2000-01-02',NULL,4);

SELECT * FROM staff;
SELECT * FROM clients;
SELECT * FROM suppliers;
SELECT * FROM department;

-- Проверка связи таблиц. Вывести названия поставщиков, клиентов и работающих работников склада по каждому отделу.

SELECT department.name AS department,
       suppliers.organization_name AS suppliers,
       clients.organization_name AS clients,
       staff.first_name AS first_name,
       staff.last_name AS last_name
FROM
     department
LEFT JOIN suppliers
     ON department.id = suppliers.department_id
LEFT JOIN clients
     ON department.id = clients.department_id
LEFT JOIN staff
     ON department.id = staff.department_id
WHERE
     staff.date_of_dismissal IS NULL
ORDER
     BY department;