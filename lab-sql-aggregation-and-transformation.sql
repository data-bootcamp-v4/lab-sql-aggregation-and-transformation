USE sakila;

-- Challenge 1

-- 1.1
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

-- 1.2
SELECT FLOOR(AVG(length)/60) AS average_hours, ROUND(MOD(AVG(length),60)) AS average_minutes FROM film;

-- 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days FROM rental;

-- 2.2
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday FROM rental LIMIT 20;

-- 2.3 Bonus
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday, CASE WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend' ELSE 'workday' END AS DAY_TYPE FROM rental LIMIT 20;

-- 3
SELECT title, IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration FROM film ORDER BY title;

-- Bonus
SELECT CONCAT(first_name, ' ', last_name) AS customer_name, SUBSTRING(email,1,3) AS email_prefix FROM customer ORDER BY last_name;

-- Challenge 2

-- 1.1
SELECT COUNT(*) AS total_films FROM film;

-- 1.2
SELECT rating, COUNT(*) AS total_films FROM film GROUP BY rating;

-- 1.3
SELECT rating, COUNT(*) AS total_films FROM film GROUP BY rating ORDER BY total_films DESC;

-- 2.1
SELECT rating, ROUND(AVG(length),2) AS average_duration FROM film GROUP BY rating ORDER BY average_duration DESC;

-- 2.2
SELECT rating, ROUND(AVG(length),2) AS average_duration FROM film GROUP BY rating HAVING AVG(length) > 120 ORDER BY average_duration DESC;

-- Bonus
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1 ORDER BY last_name;