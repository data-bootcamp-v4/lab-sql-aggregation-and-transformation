
/*
You need to use SQL built-in functions to gain insights relating to the duration of movies:

1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

1.2. Express the average movie duration in hours and minutes. Don't use decimals.

Hint: Look for floor and round functions.

*/

USE sakila;
-- To test table
SELECT * FROM film as f;

-- 1.1
SELECT MIN(f.length) AS 'Minimum_amount', MAX(f.length) AS 'Maximum_amount'
FROM film as f;
-- 1.2
SELECT 
    FLOOR(AVG(f.length) / 60) AS horas,
    ROUND(AVG(f.length) % 60) AS minutos
FROM film AS f;
-- 2.1
SELECT 
    MIN(rental_date) AS primera_fecha,
    MAX(rental_date) AS ultima_fecha,
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS dias_operando
FROM rental;
-- 2.2
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    return_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;
-- 2.3
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
ORDER BY rental_date
LIMIT 20;
-- 1.1
SELECT 
    COUNT(*) AS total_films
FROM film;
-- 1.2
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
-- 1.3
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;
-- 2.1
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- 2.2
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;





