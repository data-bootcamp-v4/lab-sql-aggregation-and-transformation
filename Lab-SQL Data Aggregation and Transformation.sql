USE sakila;
-- 1 You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;
-- 1.2 
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) - FLOOR(AVG(length) / 60) * 60) AS minutes
FROM film;

-- 2rental
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

SELECT COUNT(*) AS total_films
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

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration_minutes
FROM film
GROUP BY rating
ORDER BY mean_duration_minutes DESC;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration_minutes
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration_minutes DESC;

SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;
