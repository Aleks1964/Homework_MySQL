-- Создаём базу данных homework_1
CREATE DATABASE homework_1;
USE homework_1;

-- 1. Создаём в БД таблицу phone
CREATE TABLE phone
(
id INT PRIMARY KEY NOT NULL,
ProductName VARCHAR(15) NOT NULL,
Manufacturer VARCHAR(15) NOT NULL,
ProductCount INT,
Price INT
);

-- Заполняем таблицу данными
INSERT phone(id, ProductName, Manufacturer, ProductCount, Price)
VALUES
(1, 'iPhone X', 'Apple', 3, 76000),
(2, 'iPhone 8', 'Apple', 2, 51000),
(3, 'Galaxy S9', 'Samsung', 2, 56000),
(4, 'Galaxy S8', 'Samsung', 1, 41000),
(5, 'P20 Pro', 'Huawei', 5, 36000);

SELECT * FROM phone;

/* 2. Выводим название, производителя и цену для товаров,
количество которых превышает 2. */
SELECT ProductName, Manufacturer, ProductCount FROM phone
WHERE ProductCount > 2;

-- 3. Выводим весь ассортимент товаров марки “Samsung”
SELECT * FROM phone
WHERE Manufacturer = 'Samsung';

/* 4.*** С помощью регулярных выражений найти:
	4.1. Товары, в которых есть упоминание "Iphone";*/
SELECT ProductName, Manufacturer, ProductCount, Price FROM phone
WHERE ProductName LIKE '%iphone%';

SELECT * FROM phone
WHERE ProductName REGEXP 'iPhone';

--  4.2. "Samsung";
SELECT * FROM phone
WHERE Manufacturer LIKE '%Samsung%';

SELECT ProductName, Manufacturer, ProductCount, Price FROM phone
WHERE Manufacturer REGEXP 'Samsung';

--  4.3.  Товары, в которых есть ЦИФРА "8".
SELECT * FROM phone
WHERE ProductName LIKE '%8%';

SELECT ProductName, Manufacturer, ProductCount, Price FROM phone
WHERE ProductName REGEXP '[[8]]' = 1;