USE sakila;

-- 1.You need to use SQL built-in functions to gain insights relating to the duration of movies:

SHOW TABLES;

SELECT max(length) AS max_duration,
min(length) AS min_duration
FROM film;

WITH average_calc AS(
	SELECT AVG(length) as average_length
    FROM film
)	
SELECT 
    FLOOR(average_length / 60) AS hours,
    round(average_length % 60) AS min
    FROM average_calc;


SELECT * FROM rental ORDER BY rental_date DESC LIMIT 10;

SELECT max(rental_date) from rental;
SELECT min(rental_date) from rental;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) + 1 AS operating_days
FROM rental;

SELECT 
    *, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
    *, 
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'WEEKEND'
        ELSE 'WORK_DAY'
    END AS DAY_TYPE
FROM rental;

SELECT 
    title, 
    COALESCE(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


