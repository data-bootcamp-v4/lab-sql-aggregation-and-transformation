USE sakila;
## Challenge 1
-- 1.
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.
SELECT * FROM rental;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;


SELECT
	rental_id,
	inventory_id,
	customer_id,
	return_date,
	staff_id, 
	last_update,
	MONTHNAME(rental_date) AS month,
	DAYNAME(rental_date) AS weekday,
	CASE 
		WHEN DAYOFWEEK(rental_date) in (1,7) THEN 'WEEKEND'
		ELSE 'WORKDAY'
    END AS day_type 
FROM rental
LIMIT 20;

-- 3.
SELECT * 
FROM film
WHERE rental_duration IS NULL;
SELECT title,
rental_duration,
IFNULL(rental_duration, 'not_avilable') AS duration
FROM film
ORDER BY title ASC;

-- 4.
SELECT 
	CONCAT(first_name, ' ',last_name) AS name,
    LEFT(email,3) AS email_starts
FROM customer
ORDER BY last_name ASC;    

## Challenge 2
-- 1.
SELECT COUNT(title) FROM film; 
 
SELECT COUNT(title), rating
FROM film
GROUP BY rating;  

SELECT COUNT(title), rating
FROM film
GROUP BY rating
ORDER BY COUNT(TITLE) DESC;  

-- 2.
SELECT ROUND(AVG(length),2), rating
FROM film
GROUP BY rating
ORDER BY ROUND(AVG(length),2) DESC;

SELECT ROUND(AVG(length),2), rating
FROM film
GROUP BY rating
HAVING ROUND(AVG(length),2) > 120;

-- 3.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;



