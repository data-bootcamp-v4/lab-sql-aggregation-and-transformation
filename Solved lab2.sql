USE sakila;
-- Challenge 1--
-- 1--
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;
-- 2--
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT 
    rental_id, 
    rental_date, 
    MONTH(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- Bonus 2.3--
SELECT 
    rental_id, 
    rental_date, 
    MONTH(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
        ELSE 'workday' 
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3--

SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
-- Bonus 3--
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
-- Challenge 2--
-- 1--
SELECT 
    COUNT(*) AS total_films
FROM film;

SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;
-- 2 --
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
 -- Bonus --
 
 SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;


