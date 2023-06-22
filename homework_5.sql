CREATE DATABASE IF NOT EXISTS homework_5;
USE homework_5;

DROP TABLE IF EXISTS `cars`;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT * FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
DROP VIEW IF EXISTS cars_under_25000;

CREATE VIEW cars_under_25000 AS
SELECT id, name, cost
FROM cars
WHERE cost < 25000;

SELECT * FROM cars_under_25000;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW cars_under_25000 AS
SELECT id, name, cost
FROM cars
WHERE cost < 30000;

SELECT * FROM cars_under_25000;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

DROP VIEW IF EXISTS skoda_audi;

CREATE VIEW skoda_audi AS
SELECT *
FROM cars
WHERE name IN ('Skoda', 'Audi');

SELECT * FROM skoda_audi;

-- Доп задания:
-- 1* Получить ранжированный список автомобилей по цене в порядке возрастания
SELECT id, name, cost
FROM cars
ORDER BY cost;

-- 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
-- 21. топ-3 самых дорогих автомобилей:
SELECT name, cost
FROM cars
ORDER BY cost DESC
LIMIT 3;

-- 2.2. Общая стоимость 3-х самых дорогих автомобилей:
SELECT SUM(cost) AS "Общая стоимость 3-х самых дорогих автомобилей"
FROM (
    SELECT cost
    FROM cars
    ORDER BY cost DESC
    LIMIT 3
) AS top_cars;

-- Добавил названия 3-х самых дорогих автомобилей
SELECT SUM(cost) AS "Общая стоимость 3-х самых дорогих автомобилей", GROUP_CONCAT(name) AS "Марки 3-х самых дорогих автомобилей"
FROM (
  SELECT id, name, cost
  FROM cars
  ORDER BY cost DESC
  LIMIT 3
) AS top_3_cars;

-- 3* Получить список автомобилей, у которых цена больше предыдущей цены (т.е. у которых произошло повышение цены)
-- 3.1. Используем подзапрос для выбора большей цены используя индексы столбца id
SELECT name
FROM cars
WHERE cost > (
    SELECT cost 
    FROM cars AS c2 
    WHERE c2.id = cars.id - 1
);

-- 3.2 Используем подзапрос с функцией LAG(), обращающейся к данным из предыдущей строки окна
SELECT id, name
FROM (
    SELECT id, name, cost, LAG(cost) OVER (ORDER BY id) AS prev_cost
    FROM cars
) AS t
WHERE cost > prev_cost;

-- 4* Получить список автомобилей, у которых цена меньше следующей цены (т.е. у которых произойдет снижение цены)
-- Используем подзапрос с функцией LESD(), обращающейся к данным из следующей строки окна
SELECT id, name
FROM (
    SELECT id, name, cost, LEAD(cost) OVER (ORDER BY id) AS next_cost
    FROM cars
) AS t
WHERE next_cost IS NOT NULL AND cost > next_cost;     -- (next_cost IS NOT NULL) - для исключения последней строки таблицы, т.к. у неё нет следующей строки

-- 5* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля
SELECT id, name, cost,
IFNULL(LEAD(cost) OVER (ORDER BY cost) - cost, '-') AS price_difference  -- для красоты 'NULL' (в последней строке) заменён на '-'
FROM cars
ORDER BY cost ASC;