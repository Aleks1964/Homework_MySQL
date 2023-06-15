DROP DATABASE IF EXISTS homework_3;
CREATE DATABASE IF NOT EXISTS homework_3;

USE homework_3;

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`firstname` VARCHAR(15),
`lastname` VARCHAR(15),
`post` VARCHAR(15), 
`seniority` INT,
`salary` INT,
`age` INT);

INSERT INTO `staff` (`firstname`, `lastname`, `post`,`seniority`,`salary`, `age`)
VALUES
('Вася', 'Петров', 'Начальник', 40, 100000, 60), 
('Петр', 'Власов', 'Начальник', 8, 70000, 30),
('Катя', 'Катина', 'Инженер', 2, 70000, 25),
('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

-- 1. Отсортируйте данные по полю заработная плата (salary) в порядке:
-- * убывания;
SELECT * FROM staff
ORDER BY salary DESC;

-- * возрастания
SELECT * FROM staff
ORDER BY salary ASC;

-- 2. Выведите 5 максимальных заработных плат (salary)
SELECT DISTINCT salary "Максимальные зарплаты", firstname "Имя", lastname "Фамилия"
FROM staff
ORDER BY salary DESC
LIMIT 5;

-- 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post "Специальность", SUM(salary) "Суммарная зарплата по специальности"
FROM staff
GROUP BY post;

-- 4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно
SELECT COUNT(lastname) "Кол-во рабочих",
GROUP_CONCAT(lastname) "Фамилии рабочих"
FROM staff
WHERE post = "Рабочий"  AND (age > 23 AND age < 50);

-- 5. Найдите количество специальностей
SELECT COUNT(DISTINCT(post)) "Кол-во специальностей",
GROUP_CONCAT(DISTINCT(post)) "Перечень специальностей"
FROM staff;

-- 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет 
SELECT post "Специальность", firstname "Имя", lastname "Фамилия"
FROM staff
WHERE age < 30;