/* 1. Используя операторы языка SQL, 
создайте таблицу “sales”. Заполните ее данными. */

-- Создаём базу данных homework_2
CREATE DATABASE IF NOT EXISTS homework_2;
USE homework_2;

-- DDL (определение данных) Создаем таблицу sales
CREATE TABLE IF NOT EXISTS sales
(
id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE NOT NULL,
count_product INT
);

-- Заполняем таблицу данными
INSERT INTO sales (order_date, count_product)
VALUES 
	('2022-01-01', 156),
	('2022-01-02', 180),
	('2022-01-03', 21),
	('2022-01-04', 124),
	('2022-01-05', 341);
    
SELECT * FROM sales;

/* 2.  Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва: 
	* меньше 100	- Маленький заказ;
	* от 100 до 300	- Средний заказ;
	* больше 300	- Большой заказ. */
    
-- DDL ALTER Добавим столбец, в котором будет указан Тип заказа
ALTER TABLE sales
ADD COLUMN Тип_заказа text;

-- Вариант CASE
SELECT id,
CASE
	WHEN count_product < 100
		THEN "Маленький заказ"
	WHEN count_product > 300
		THEN "Большой заказ"
	ELSE "Средний заказ"
END AS Тип_заказа
FROM sales;

-- Вариант IF c переименованием столбцов
SELECT
id AS "id заказа",
count_product AS "Статус заказа",
IF(count_product<100, "Маленький заказ",
	IF(count_product>300, "Большой заказ", "Средний заказ")) AS Тип_заказа
FROM sales;

/* 3. Создайте таблицу “orders”, заполните ее значениями. */
-- Создаем таблицу orders
CREATE TABLE IF NOT EXISTS orders
(
id INT PRIMARY KEY AUTO_INCREMENT,
employee_id VARCHAR(5) NOT NULL,
amount DECIMAL NOT NULL,
order_status text
);

-- Заполняем таблицу данными
INSERT INTO orders (employee_id, amount, order_status)
VALUES 
	('e03', 15.00, 'OPEN'),
	('e01', 25.50, 'OPEN'),
	('e05', 100.70, 'CLOSED'),
	('e02', 22.18, 'OPEN'),
	('e04', 9.50, 'CANCELLED');
 
-- Выберите все заказы.
SELECT * FROM orders;

/* В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled» */
ALTER TABLE orders
ADD COLUMN full_order_status text;

-- Вариант CASE
SELECT id, order_status,
CASE
	WHEN order_status = "OPEN"
		THEN "Order is in open state"
	WHEN order_status = "CLOSED"
		THEN "Order is closed"
	ELSE "Order is cancelled"
END AS full_order_status
FROM orders;

-- Вариант IF и переименованием столбцов
SELECT
id,
order_status AS "Статус заказа",
IF(order_status = "OPEN", "Order is in open state",
	IF(order_status = "CLOSED", "Order is closed", "Order is cancelled")) AS "Полный статус заказа"
FROM orders;