USE sakila;
-- CHALLENGE 1 
-- 1 
SELECT MIN(length) AS min_duration FROM sakila.film;
SELECT MAX(length) AS max_duration FROM sakila.film;

-- 1.2 

SELECT AVG(length) FROM sakila.film;

SELECT SEC_TO_TIME(ROUND(AVG(length))*60) as avg_movie_duration
FROM sakila.film;

-- 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating 
FROM sakila.rental;

-- 2.2 
SELECT *, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday 
FROM rental
LIMIT 20;

-- 2.3 
SELECT *,
	CASE WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'WEEKEND'
    ELSE 'WORKDAY'
    END AS DAY_TYPE
FROM rental
LIMIT 20; 

-- 3 
SELECT title, COALESCE(CONCAT(rental_duration, ' days'), 'Not Available') AS rental_duration
FROM film
ORDER BY rental_duration ASC;

-- 4 

SELECT CONCAT(first_name,' ', last_name) AS name,
SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- CHALLANGE 2 
-- 1.1
SELECT COUNT(film_id) FROM film;

-- 1.2 
SELECT rating, COUNT(rating) 
FROM film
GROUP BY rating;

-- 1.3 
SELECT rating, COUNT(rating) as count
FROM film
GROUP BY rating
ORDER BY count DESC;

-- 2 
SELECT staff_id, COUNT(staff_id) 
FROM rental
GROUP BY staff_id;

-- 3.1
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating 
ORDER BY avg_duration DESC;

-- 3.2
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating 
HAVING avg_duration> 120
ORDER BY avg_duration DESC;

-- 3.3 
SELECT COUNT(last_name), last_name
FROM actor
GROUP BY last_name 
HAVING COUNT(*) = 1;


