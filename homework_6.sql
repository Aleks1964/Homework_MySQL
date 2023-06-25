CREATE DATABASE IF NOT EXISTS homework_6;
USE homework_6;

-- DROP TABLE IF EXISTS `cars`;

/* 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'
*/

delimiter $$
DROP FUNCTION IF EXISTS sec;
CREATE FUNCTION sec(seconds INT)
RETURNS VARCHAR(60)
DETERMINISTIC
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE secs INT;

    SET days = FLOOR(seconds / (24 * 60 * 60));
    SET seconds = seconds - (days * 24 * 60 * 60);
    SET hours = FLOOR(seconds / (60 * 60));
    SET seconds = seconds - (hours * 60 * 60);
    SET minutes = FLOOR(seconds / 60);
    SET seconds = seconds - (minutes * 60);

	RETURN CONCAT(
        IF(days > 0, CONCAT(days, ' days '), ''),
        IF(hours > 0, CONCAT(hours, ' hours '), ''),
        IF(minutes > 0, CONCAT(minutes, ' minutes '), ''),
        CONCAT(seconds, ' seconds')
	);
END $$
delimiter ;

SELECT sec(123456);

/* 2. Создайте процедуру которая, выводит только четные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

-- 1 вариант: чётные числа выводятся постепенно (через 1 сек.)
DELIMITER //
DROP PROCEDURE IF EXISTS even_numbers;
CREATE PROCEDURE even_numbers()
BEGIN

    DECLARE i INT DEFAULT 1;
    WHILE i <= 10 DO
        IF i % 2 = 0 THEN 
            SELECT i;
            SET @delay = SLEEP(1);
        END IF;
        SET i = i + 1;
    END WHILE;

END //
DELIMITER ;

CALL even_numbers();

-- 2 вариант: чётные числа выводятся сразу
DELIMITER //
CREATE PROCEDURE print_even_numbers()
BEGIN
    DECLARE i INT DEFAULT 2;
    DECLARE result TEXT DEFAULT '';
    WHILE i <= 10 DO
        IF i%2 = 0 THEN
            SET result = CONCAT(result, i, ' ');
        END IF;
        SET i = i + 1;
    END WHILE;
    SELECT result;
END//
DELIMITER ;

CALL print_even_numbers();

-- 3 вариант: чётные числа выводятся сразу в заданном нами диапазоне
DELIMITER //
CREATE PROCEDURE range_even_numbers(start_number INT, end_number INT)
BEGIN
    DECLARE current_number INT DEFAULT start_number;
    DECLARE result VARCHAR(200) DEFAULT '';
    
    WHILE current_number <= end_number DO
        IF current_number % 2 = 0 THEN
            SET result = CONCAT(result, current_number, ' ');
        END IF;
        SET current_number = current_number + 1;
    END WHILE;
    
    SELECT result;
END //
DELIMITER ;

CALL range_even_numbers(5, 25);