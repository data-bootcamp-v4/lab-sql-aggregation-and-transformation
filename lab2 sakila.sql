USE sakila;
-- 1 
SELECT 
MIN(length) as min_duration, 
MAX(length) as max_duration 
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS hours, 
    ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2
SELECT 
DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;

SELECT 
*,
MONTH(rental_date) as Month,
WEEKDAY(rental_date) as Day
FROM rental;

SELECT
*,
CASE
	WHEN WEEKDAY(rental_date) < 5 THEN 'Workday'
    ELSE 'Weekend'
    END AS day_type
FROM rental;

-- 3
SELECT 
title,
IFNULL(rental_duration, 'Not available') AS rental_duration_notnull
FROM film
ORDER BY
title ASC; 

-- 4
SELECT 
customer_id,
CONCAT(first_name,' ',last_name,' ', SUBSTRING(email, 1, 3)) AS mail_mkt
FROM customer
ORDER BY 
last_name ASC;

/* CHALLENGE 2 */
-- 1
SELECT 
COUNT(title) AS total_films 
FROM film;

SELECT
rating,
COUNT(title) as total_films
FROM film
GROUP BY
rating; 

SELECT
rating,
COUNT(title) as total_films
FROM film
GROUP BY
rating
ORDER BY COUNT(title) DESC;

SELECT 
rating, 
ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT 
rating, 
ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;

SELECT 
last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
