USE sakila;

-- Chelenge 1
-- 1.1
SELECT * FROM film;
SELECT 
	MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- 1.2
SELECT 
	FLOOR(AVG(length)/60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film; 

-- 2.1
SELECT * FROM rental;
SELECT DATEDIFF(
	MAX(rental_date),
    MIN(rental_date)
)
FROM rental;

-- 2.2
SELECT *,
	MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_day
FROM rental
LIMIT 20;

-- 2.3
SELECT *,
	MONTHNAME(rental_date) AS rental_month,
	DAYNAME(rental_date) AS rental_day,
	CASE
		WHEN DAYNAME(rental_date) IN ("Saturday", "Sunday") THEN "Weekend"
		ELSE "Workday"
    END AS day_type
FROM rental;

-- 3
SELECT 
    title,
    IFNULL(rental_duration, 'Not avvaliable') AS rental_duration
FROM
    film
ORDER BY title ASC;

-- 4
SELECT * FROM customer;
SELECT
	CONCAT(first_name, " ", last_name),
	LEFT(email, 3)
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1
SELECT * FROM film;
SELECT COUNT(title) FROM film;

-- 1.2 - 1.3
SELECT rating, COUNT(title)
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- 2.1 - 2.2
SELECT rating, ROUND(AVG(length), 2)
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY ROUND(AVG(length), 2) DESC;

-- 3
SELECT * FROM actor;
SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;






















