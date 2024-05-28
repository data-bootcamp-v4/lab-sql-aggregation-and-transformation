-- Challenge 1
-- 1
USE sakila;

SELECT 
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

SELECT 
ROUND(AVG(length)/60) AS duration_hours,
ROUND(AVG(length)) AS duration_minutes
FROM film;

-- 2
SELECT datediff(MAX(rental_date),MIN(rental_date))
FROM rental;

SELECT *,
       MONTH(rental_date) as rental_month,
       WEEKDAY(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT *,
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS day_type
FROM rental;

-- 3
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4
SELECT CONCAT(first_name, ' ', last_name) AS full_name, 
       LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1
SELECT COUNT(film_id) FROM film;

SELECT rating, COUNT(film_id) AS number_films
FROM film
GROUP BY rating;

SELECT rating, ROUND(AVG(length),2) AS film_duratiion
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

SELECT rating, ROUND(AVG(length),2) AS film_duratiion
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY AVG(length) DESC;

-- 3
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
